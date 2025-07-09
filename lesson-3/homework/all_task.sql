-- DDL: Create Tables

IF OBJECT_ID('dbo.Employees', 'U') IS NOT NULL DROP TABLE dbo.Employees;
IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL DROP TABLE dbo.Orders;
IF OBJECT_ID('dbo.Products', 'U') IS NOT NULL DROP TABLE dbo.Products;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

-- Task 1: Employee Salary Report

WITH TopEarners AS (
    SELECT *,
           NTILE(10) OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
),
Top10Percent AS (
    SELECT *
    FROM TopEarners
    WHERE SalaryRank = 1
),
DepartmentAvgSalary AS (
    SELECT 
        Department,
        AVG(Salary) AS AverageSalary,
        IIF(Salary > 80000, 'High', 
            IIF(Salary BETWEEN 50000 AND 80000, 'Medium', 'Low')) AS SalaryCategory
    FROM Top10Percent
    GROUP BY Department, Salary
)
SELECT *
FROM DepartmentAvgSalary
ORDER BY AverageSalary DESC
OFFSET 2 ROWS FETCH NEXT 5 ROWS ONLY;

-- Task 2: Customer Order Insights

SELECT 
    CASE 
        WHEN Status IN ('Shipped', 'Delivered') THEN 'Completed'
        WHEN Status = 'Pending' THEN 'Pending'
        WHEN Status = 'Cancelled' THEN 'Cancelled'
    END AS OrderStatus,
    COUNT(*) AS TotalOrders,
    SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE OrderDate BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY 
    CASE 
        WHEN Status IN ('Shipped', 'Delivered') THEN 'Completed'
        WHEN Status = 'Pending' THEN 'Pending'
        WHEN Status = 'Cancelled' THEN 'Cancelled'
    END
HAVING SUM(TotalAmount) > 5000
ORDER BY TotalRevenue DESC;

-- Task 3: Product Inventory Check

WITH RankedProducts AS (
    SELECT *,
           RANK() OVER (PARTITION BY Category ORDER BY Price DESC) AS PriceRank
    FROM Products
)
SELECT 
    Category,
    ProductName,
    Price,
    Stock,
    IIF(Stock = 0, 'Out of Stock', 
        IIF(Stock BETWEEN 1 AND 10, 'Low Stock', 'In Stock')) AS InventoryStatus
FROM RankedProducts
WHERE PriceRank = 1
ORDER BY Price DESC
OFFSET 5 ROWS;

