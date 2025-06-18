-- ==============================
-- TASK 1: Employee Depth
-- ==============================

-- Create Employees table
DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
    EmployeeID  INTEGER PRIMARY KEY,
    ManagerID   INTEGER NULL,
    JobTitle    VARCHAR(100) NOT NULL
);

-- Insert sample data
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
    (1001, NULL, 'President'),
    (2002, 1001, 'Director'),
    (3003, 1001, 'Office Manager'),
    (4004, 2002, 'Engineer'),
    (5005, 2002, 'Engineer'),
    (6006, 2002, 'Engineer');

-- Recursive CTE to find employee depth from the President
WITH RECURSIVE EmployeeDepth AS (
    SELECT 
        EmployeeID,
        ManagerID,
        JobTitle,
        0 AS Depth
    FROM Employees
    WHERE ManagerID IS NULL

    UNION ALL

    SELECT 
        e.EmployeeID,
        e.ManagerID,
        e.JobTitle,
        ed.Depth + 1
    FROM Employees e
    JOIN EmployeeDepth ed ON e.ManagerID = ed.EmployeeID
)
SELECT 'TASK 1 - Employee Depth' AS Section, *
FROM EmployeeDepth
ORDER BY EmployeeID;

-- ==============================
-- TASK 2: Factorials up to N
-- ==============================

-- Set N for factorial
WITH RECURSIVE Factorials AS (
    SELECT 1 AS Num, 1 AS Factorial
    UNION ALL
    SELECT Num + 1, Factorial * (Num + 1)
    FROM Factorials
    WHERE Num < 10
)
SELECT 'TASK 2 - Factorials' AS Section, *
FROM Factorials;

-- ==============================
-- TASK 3: Fibonacci numbers up to N
-- ==============================

-- Set N for Fibonacci
WITH RECURSIVE Fibonacci AS (
    SELECT 1 AS n, 1 AS Fibonacci_Number, 1 AS prev
    UNION ALL
    SELECT n + 1, Fibonacci_Number + prev, Fibonacci_Number
    FROM Fibonacci
    WHERE n < 10
)
SELECT 'TASK 3 - Fibonacci' AS Section, n, Fibonacci_Number
FROM Fibonacci;
