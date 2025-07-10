-- 1. Retrieve All Customers With Their Orders (Include Customers Without Orders)
SELECT 
    c.CustomerID, 
    c.CustomerName, 
    o.OrderID, 
    o.OrderDate
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.CustomerID = o.CustomerID;


-- 2. Find Customers Who Have Never Placed an Order
SELECT 
    c.CustomerID, 
    c.CustomerName
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.CustomerID = o.CustomerID
WHERE 
    o.OrderID IS NULL;


-- 3. List All Orders With Their Products
SELECT 
    o.OrderID, 
    p.ProductName, 
    od.Quantity
FROM 
    Orders o
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
JOIN 
    Products p ON od.ProductID = p.ProductID;


-- 4. Find Customers With More Than One Order
SELECT 
    c.CustomerID, 
    c.CustomerName, 
    COUNT(o.OrderID) AS OrderCount
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID, c.CustomerName
HAVING 
    COUNT(o.OrderID) > 1;


-- 5. Find the Most Expensive Product in Each Order
SELECT 
    od.OrderID, 
    p.ProductName, 
    od.Price
FROM 
    OrderDetails od
JOIN 
    Products p ON od.ProductID = p.ProductID
WHERE 
    (od.OrderID, od.Price) IN (
        SELECT 
            OrderID, 
            MAX(Price)
        FROM 
            OrderDetails
        GROUP BY 
            OrderID
    );


-- 6. Find the Latest Order for Each Customer
SELECT 
    o.CustomerID, 
    MAX(o.OrderDate) AS LatestOrderDate
FROM 
    Orders o
GROUP BY 
    o.CustomerID;


-- 7. Find Customers Who Ordered Only 'Electronics' Products
SELECT 
    c.CustomerID, 
    c.CustomerName
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
JOIN 
    Products p ON od.ProductID = p.ProductID
GROUP BY 
    c.CustomerID, c.CustomerName
HAVING 
    COUNT(DISTINCT CASE WHEN p.Category != 'Electronics' THEN p.ProductID END) = 0;


-- 8. Find Customers Who Ordered at Least One 'Stationery' Product
SELECT DISTINCT 
    c.CustomerID, 
    c.CustomerName
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
JOIN 
    Products p ON od.ProductID = p.ProductID
WHERE 
    p.Category = 'Stationery';


-- 9. Find Total Amount Spent by Each Customer
SELECT 
    c.CustomerID, 
    c.CustomerName, 
    COALESCE(SUM(od.Quantity * od.Price), 0) AS TotalSpent
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
GROUP BY 
    c.CustomerID, c.CustomerName;
