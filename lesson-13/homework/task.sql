DECLARE @Year INT = 2025;
DECLARE @Month INT = 6;

-- Determine the first and last date of the month
DECLARE @StartDate DATE = DATEFROMPARTS(@Year, @Month, 1);
DECLARE @EndDate DATE = EOMONTH(@StartDate);

-- Generate numbers to represent days (you can increase the range if needed)
;WITH Numbers AS (
    SELECT TOP (DAY(@EndDate) + DATEPART(WEEKDAY, @StartDate) - 1) 
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS n
    FROM master.dbo.spt_values -- any large rowset (for number generation)
),
Dates AS (
    SELECT 
        DATEADD(DAY, n - DATEPART(WEEKDAY, @StartDate), @StartDate) AS CalendarDate
    FROM Numbers
),
Calendar AS (
    SELECT 
        CalendarDate,
        DATENAME(WEEKDAY, CalendarDate) AS WeekdayName,
        DATEPART(WEEK, CalendarDate) - DATEPART(WEEK, @StartDate) + 1 AS WeekNumber,
        DATENAME(WEEKDAY, CalendarDate) AS DayName,
        CASE DATENAME(WEEKDAY, CalendarDate)
            WHEN 'Sunday' THEN 1
            WHEN 'Monday' THEN 2
            WHEN 'Tuesday' THEN 3
            WHEN 'Wednesday' THEN 4
            WHEN 'Thursday' THEN 5
            WHEN 'Friday' THEN 6
            WHEN 'Saturday' THEN 7
        END AS DayOfWeek
    FROM Dates
    WHERE CalendarDate BETWEEN @StartDate AND @EndDate
),
PivotReady AS (
    SELECT 
        WeekNumber,
        FORMAT(CalendarDate, 'dd') AS Day,
        DayOfWeek
    FROM Calendar
),
Final AS (
    SELECT 
        WeekNumber,
        [1] AS [Sunday],
        [2] AS [Monday],
        [3] AS [Tuesday],
        [4] AS [Wednesday],
        [5] AS [Thursday],
        [6] AS [Friday],
        [7] AS [Saturday]
    FROM (
        SELECT WeekNumber, DayOfWeek, Day FROM PivotReady
    ) AS SourceTable
    PIVOT (
        MAX(Day)
        FOR DayOfWeek IN ([1], [2], [3], [4], [5], [6], [7])
    ) AS PivotTable
)
SELECT * FROM Final
ORDER BY WeekNumber;
