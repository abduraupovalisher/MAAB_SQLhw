-- PUZZLE 1: The Shifting Employees
--------------------------------------------------------
-- 1.1 Temporary table yaratish
CREATE TABLE #EmployeeTransfers (
    EmployeeID INT,
    Name NVARCHAR(50),
    Department NVARCHAR(50),
    Salary INT
);

-- 1.2 Department aylantirish va kiritish
INSERT INTO #EmployeeTransfers (EmployeeID, Name, Department, Salary)
SELECT 
    EmployeeID,
    Name,
    CASE 
        WHEN Department = 'HR' THEN 'IT'
        WHEN Department = 'IT' THEN 'Sales'
        WHEN Department = 'Sales' THEN 'HR'
        ELSE Department
    END AS Department,
    Salary
FROM Employees;

-- 1.3 Natijani ko‘rsatish
SELECT 'Puzzle 1 Result' AS Section, * FROM #EmployeeTransfers;


-- PUZZLE 2: The Missing Orders
--------------------------------------------------------
-- 2.1 Table variable e'lon qilish
DECLARE @MissingOrders TABLE (
    OrderID INT,
    CustomerName NVARCHAR(100),
    Product NVARCHAR(100),
    Quantity INT
);

-- 2.2 Yetishmayotgan buyurtmalarni topish
INSERT INTO @MissingOrders (OrderID, CustomerName, Product, Quantity)
SELECT OrderID, CustomerName, Product, Quantity
FROM Orders_DB1
WHERE OrderID NOT IN (
    SELECT OrderID FROM Orders_DB2
);

-- 2.3 Natijani ko‘rsatish
SELECT 'Puzzle 2 Result' AS Section, * FROM @MissingOrders;


-- PUZZLE 3: The Unbreakable View
--------------------------------------------------------
-- 3.1 Eski view bo‘lsa, uni o‘chirish
IF OBJECT_ID('vw_MonthlyWorkSummary', 'V') IS NOT NULL
    DROP VIEW vw_MonthlyWorkSummary;

-- 3.2 View yaratish
CREATE VIEW vw_MonthlyWorkSummary AS
WITH EmployeeHours AS (
    SELECT 
        EmployeeID,
        EmployeeName,
        Department,
        SUM(HoursWorked) AS TotalHoursWorked
    FROM WorkLog
    GROUP BY EmployeeID, EmployeeName, Department
),
DepartmentSummary AS (
    SELECT 
        Department,
        SUM(HoursWorked) AS TotalHoursDepartment,
        AVG(HoursWorked * 1.0) AS AvgHoursDepartment
    FROM WorkLog
    GROUP BY Department
)
SELECT 
    e.EmployeeID,
    e.EmployeeName,
    e.Department,
    e.TotalHoursWorked,
    d.TotalHoursDepartment,
    d.AvgHoursDepartment
FROM EmployeeHours e
JOIN DepartmentSummary d
    ON e.Department = d.Department;

-- 3.3 Natijani ko‘rsatish
SELECT 'Puzzle 3 Result' AS Section, * FROM vw_MonthlyWorkSummary;

