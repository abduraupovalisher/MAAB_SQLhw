-- ===============================================
-- 1. DELETE vs TRUNCATE vs DROP (with IDENTITY)
-- ===============================================

-- STEP 1: Create table and insert 5 rows
IF OBJECT_ID('dbo.test_identity', 'U') IS NOT NULL DROP TABLE dbo.test_identity;

CREATE TABLE test_identity (
    id INT IDENTITY(1,1),
    name VARCHAR(50)
);

INSERT INTO test_identity (name)
VALUES ('Alice'), ('Bob'), ('Charlie'), ('Diana'), ('Evan');

SELECT 'Initial Data' AS Phase, * FROM test_identity;

-- DELETE Test
DELETE FROM test_identity;
INSERT INTO test_identity (name) VALUES ('Frank (After DELETE)');
SELECT 'After DELETE' AS Phase, * FROM test_identity;

-- Reset
DROP TABLE test_identity;
CREATE TABLE test_identity (
    id INT IDENTITY(1,1),
    name VARCHAR(50)
);
INSERT INTO test_identity (name)
VALUES ('Alice'), ('Bob'), ('Charlie'), ('Diana'), ('Evan');

-- TRUNCATE Test
TRUNCATE TABLE test_identity;
INSERT INTO test_identity (name) VALUES ('Grace (After TRUNCATE)');
SELECT 'After TRUNCATE' AS Phase, * FROM test_identity;

-- DROP Test
DROP TABLE test_identity;

-- ===============================================
-- 2. Common Data Types
-- ===============================================

IF OBJECT_ID('dbo.data_types_demo', 'U') IS NOT NULL DROP TABLE dbo.data_types_demo;

CREATE TABLE data_types_demo (
    id INT,
    name VARCHAR(50),
    dob DATE,
    salary DECIMAL(10, 2),
    is_active BIT,
    data_time DATETIME,
    guid UNIQUEIDENTIFIER,
    profile_image VARBINARY(MAX)
);

INSERT INTO data_types_demo
VALUES (
    1,
    'John Doe',
    '1990-01-01',
    75000.50,
    1,
    GETDATE(),
    NEWID(),
    NULL
);

SELECT * FROM data_types_demo;

-- ===============================================
-- 3. Inserting an Image (requires file access)
-- ===============================================

IF OBJECT_ID('dbo.photos', 'U') IS NOT NULL DROP TABLE dbo.photos;

CREATE TABLE photos (
    id INT PRIMARY KEY,
    image VARBINARY(MAX)
);

-- ⚠️ Modify the path to an actual image on your disk
-- INSERT INTO photos (id, image)
-- SELECT 1, *
-- FROM OPENROWSET(BULK 'C:\images\sample.jpg', SINGLE_BLOB) AS img;

-- SELECT * FROM photos;

-- ===============================================
-- 4. Computed Columns
-- ===============================================

IF OBJECT_ID('dbo.student', 'U') IS NOT NULL DROP TABLE dbo.student;

CREATE TABLE student (
    id INT,
    name VARCHAR(50),
    classes INT,
    tuition_per_class DECIMAL(10, 2),
    total_tuition AS (classes * tuition_per_class)
);

INSERT INTO student (id, name, classes, tuition_per_class)
VALUES 
(1, 'John', 4, 250.00),
(2, 'Emma', 5, 300.00),
(3, 'Noah', 3, 200.00);

SELECT * FROM student;

-- ===============================================
-- 5. CSV to SQL Server (BULK INSERT)
-- ===============================================

IF OBJECT_ID('dbo.worker', 'U') IS NOT NULL DROP TABLE dbo.worker;

CREATE TABLE worker (
    id INT,
    name VARCHAR(100)
);

-- ⚠️ Adjust the path to your CSV file
-- BULK INSERT worker
-- FROM 'C:\path\to\workers.csv'
-- WITH (
--     FIELDTERMINATOR = ',',
--     ROWTERMINATOR = '\n',
--     FIRSTROW = 2
-- );

-- SELECT * FROM worker;

