-- 1. INNER JOIN: List of employees with their department names
SELECT 
    e.EmployeeID,
    e.Name,
    d.DepartmentName
FROM 
    Employees e
INNER JOIN 
    Departments d ON e.DepartmentID = d.DepartmentID;

-- 2. LEFT JOIN: All employees including those not assigned to any department
SELECT 
    e.EmployeeID,
    e.Name,
    d.DepartmentName
FROM 
    Employees e
LEFT JOIN 
    Departments d ON e.DepartmentID = d.DepartmentID;

-- 3. RIGHT JOIN: All departments including those without employees
SELECT 
    e.EmployeeID,
    e.Name,
    d.DepartmentName
FROM 
    Employees e
RIGHT JOIN 
    Departments d ON e.DepartmentID = d.DepartmentID;

-- 4. FULL OUTER JOIN: All employees and all departments
-- Note: Use UNION of LEFT and RIGHT JOIN if FULL OUTER JOIN is not supported
SELECT 
    e.EmployeeID,
    e.Name,
    d.DepartmentName
FROM 
    Employees e
LEFT JOIN 
    Departments d ON e.DepartmentID = d.DepartmentID

UNION

SELECT 
    e.EmployeeID,
    e.Name,
    d.DepartmentName
FROM 
    Employees e
RIGHT JOIN 
    Departments d ON e.DepartmentID = d.DepartmentID;

-- 5. JOIN with Aggregation: Total salary expense for each department
SELECT 
    d.DepartmentName,
    SUM(e.Salary) AS TotalSalary
FROM 
    Employees e
INNER JOIN 
    Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY 
    d.DepartmentName;

-- 6. CROSS JOIN: All combinations of departments and projects
SELECT 
    d.DepartmentName,
    p.ProjectName
FROM 
    Departments d
CROSS JOIN 
    Projects p;

-- 7. MULTIPLE JOINS: Employees with department and project names (include all employees)
SELECT 
    e.EmployeeID,
    e.Name AS EmployeeName,
    d.DepartmentName,
    p.ProjectName
FROM 
    Employees e
LEFT JOIN 
    Departments d ON e.DepartmentID = d.DepartmentID
LEFT JOIN 
    Projects p ON e.EmployeeID = p.EmployeeID;

