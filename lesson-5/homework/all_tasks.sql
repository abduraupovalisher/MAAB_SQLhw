-- 1. Assign a Unique Rank to Each Employee Based on Salary
SELECT *, 
       RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees;

-- 2. Find Employees Who Have the Same Salary Rank
SELECT *, 
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees;

-- 3. Identify the Top 2 Highest Salaries in Each Department
SELECT *
FROM (
    SELECT *, 
           DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS DeptSalaryRank
    FROM Employees
) AS Ranked
WHERE DeptSalaryRank <= 2;

-- 4. Find the Lowest-Paid Employee in Each Department
SELECT *
FROM (
    SELECT *, 
           RANK() OVER (PARTITION BY Department ORDER BY Salary ASC) AS SalaryRank
    FROM Employees
) AS Ranked
WHERE SalaryRank = 1;

-- 5. Calculate the Running Total of Salaries in Each Department
SELECT *, 
       SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM Employees;

-- 6. Find the Total Salary of Each Department Without GROUP BY
SELECT *, 
       SUM(Salary) OVER (PARTITION BY Department) AS DeptTotalSalary
FROM Employees;

-- 7. Calculate the Average Salary in Each Department Without GROUP BY
SELECT *, 
       AVG(Salary) OVER (PARTITION BY Department) AS DeptAvgSalary
FROM Employees;

-- 8. Find the Difference Between an Employee’s Salary and Their Department’s Average
SELECT *, 
       Salary - AVG(Salary) OVER (PARTITION BY Department) AS SalaryDiffFromDeptAvg
FROM Employees;

-- 9. Calculate the Moving Average Salary Over 3 Employees (Current, Previous, Next)
SELECT *, 
       AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvgSalary
FROM Employees;

-- 10. Find the Sum of Salaries for the Last 3 Hired Employees
SELECT SUM(Salary)
FROM (
    SELECT Salary
    FROM Employees
    ORDER BY HireDate DESC
    LIMIT 3
) AS Last3;

-- 11. Calculate the Running Average of Salaries Over All Previous Employees
SELECT *, 
       AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningAvg
FROM Employees;

-- 12. Find the Maximum Salary Over a Sliding Window of 2 Employees Before and After
SELECT *, 
       MAX(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS MaxSlidingSalary
FROM Employees;

-- 13. Determine the Percentage Contribution of Each Employee’s Salary to Their Department’s Total Salary
SELECT *, 
       100.0 * Salary / SUM(Salary) OVER (PARTITION BY Department) AS SalaryPercentage
FROM Employees;

