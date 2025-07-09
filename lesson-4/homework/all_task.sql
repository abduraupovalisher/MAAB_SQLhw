
-- Task 1: Show only rows where not all columns are zero
CREATE TABLE [dbo].[TestMultipleZero]
(
    [A] [int] NULL,
    [B] [int] NULL,
    [C] [int] NULL,
    [D] [int] NULL
);
GO

INSERT INTO [dbo].[TestMultipleZero](A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

-- Query for Task 1
SELECT * 
FROM TestMultipleZero
WHERE NOT (ISNULL(A, 0) = 0 AND ISNULL(B, 0) = 0 AND ISNULL(C, 0) = 0 AND ISNULL(D, 0) = 0);



-- Task 2: Find max value from multiple columns
CREATE TABLE TestMax
(
    Year1 INT,
    Max1 INT,
    Max2 INT,
    Max3 INT
);
GO

INSERT INTO TestMax 
VALUES
    (2001,10,101,87),
    (2002,103,19,88),
    (2003,21,23,89),
    (2004,27,28,91);

-- Query for Task 2 (for SQL Server prior to 2022)
SELECT Year1,
       (SELECT MAX(v) 
        FROM (VALUES (Max1), (Max2), (Max3)) AS value(v)) AS MaxValue
FROM TestMax;



-- Task 3: Find employees with birthdays between May 7 and May 15
CREATE TABLE EmpBirth
(
    EmpId INT IDENTITY(1,1),
    EmpName VARCHAR(50),
    BirthDate DATETIME
);

INSERT INTO EmpBirth(EmpName,BirthDate)
SELECT 'Pawan', '1983-12-04'
UNION ALL
SELECT 'Zuzu', '1986-11-28'
UNION ALL
SELECT 'Parveen', '1977-05-07'
UNION ALL
SELECT 'Mahesh', '1983-01-13'
UNION ALL
SELECT 'Ramesh', '1983-05-09';

-- Query for Task 3
SELECT EmpId, EmpName, BirthDate
FROM EmpBirth
WHERE MONTH(BirthDate) = 5 AND DAY(BirthDate) BETWEEN 7 AND 15;



-- Task 4: Letter ordering
CREATE TABLE letters
(letter CHAR(1));

INSERT INTO letters
VALUES ('a'), ('a'), ('a'), 
       ('b'), ('c'), ('d'), ('e'), ('f');

-- A. Order letters with 'b' first
SELECT letter
FROM letters
ORDER BY CASE WHEN letter = 'b' THEN 0 ELSE 1 END, letter;

-- B. Order letters with 'b' last
SELECT letter
FROM letters
ORDER BY CASE WHEN letter = 'b' THEN 1 ELSE 0 END, letter;

-- C. Order letters with 'b' in 3rd position
WITH OrderedLetters AS (
    SELECT letter,
           ROW_NUMBER() OVER (ORDER BY letter) AS rn
    FROM letters
    WHERE letter <> 'b'
)
SELECT letter FROM OrderedLetters WHERE rn < 2
UNION ALL
SELECT 'b'
UNION ALL
SELECT letter FROM OrderedLetters WHERE rn >= 2;

