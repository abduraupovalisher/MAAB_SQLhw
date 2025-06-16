-- ========================================
-- 1. Count Consecutive Status Values
-- ========================================

WITH Grouped AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Step Number]) -
           ROW_NUMBER() OVER (PARTITION BY Status ORDER BY [Step Number]) AS grp
    FROM Groupings
),
Aggregated AS (
    SELECT 
        MIN([Step Number]) AS [Min Step Number],
        MAX([Step Number]) AS [Max Step Number],
        Status,
        COUNT(*) AS [Consecutive Count]
    FROM Grouped
    GROUP BY Status, grp
)
SELECT * FROM Aggregated
ORDER BY [Min Step Number];

-- ========================================
-- 2. Find Year-Based Gaps in Hiring (1975 - Present)
-- ========================================

-- Make sure the EMPLOYEES_N table exists before running this

WITH AllYears AS (
    SELECT YEAR(DATEADD(YEAR, n, '1975-01-01')) AS Year
    FROM (
        SELECT TOP (YEAR(GETDATE()) - 1975 + 1)
               ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS n
        FROM master.dbo.spt_values
    ) AS numbers
),
HireYears AS (
    SELECT DISTINCT YEAR(HIRE_DATE) AS Year
    FROM EMPLOYEES_N
),
MissingYears AS (
    SELECT y.Year
    FROM AllYears y
    LEFT JOIN HireYears h ON y.Year = h.Year
    WHERE h.Year IS NULL
),
Grouped AS (
    SELECT *,
           Year - ROW_NUMBER() OVER (ORDER BY Year) AS grp
    FROM MissingYears
),
Final AS (
    SELECT 
        MIN(Year) AS StartYear,
        MAX(Year) AS EndYear
    FROM Grouped
    GROUP BY grp
)
SELECT CONCAT(StartYear, ' - ', EndYear) AS [Years]
FROM Final
ORDER BY StartYear;

