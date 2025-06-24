-- TASK 1: Get all table/column metadata across user databases
PRINT '--- Task 1: Tables and Columns Across All Databases ---';

DECLARE @sqlTask1 NVARCHAR(MAX) = N'';

SELECT @sqlTask1 += '
USE [' + name + '];
SELECT 
    ''' + name + ''' AS DatabaseName,
    s.name AS SchemaName,
    t.name AS TableName,
    c.name AS ColumnName,
    ty.name AS DataType
FROM 
    sys.tables t
    INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
    INNER JOIN sys.columns c ON t.object_id = c.object_id
    INNER JOIN sys.types ty ON c.user_type_id = ty.user_type_id;
'
FROM sys.databases
WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb')
  AND state_desc = 'ONLINE';

-- Execute the SQL for Task 1
EXEC sp_executesql @sqlTask1;


-- TASK 2: Create procedure to get routine (SP & function) metadata

PRINT '--- Task 2: Creating Stored Procedure GetAllRoutinesAndParameters ---';

IF OBJECT_ID('tempdb..#DropProc') IS NOT NULL
    DROP TABLE #DropProc;

-- Drop the procedure if it exists (across databases)
IF OBJECT_ID('dbo.GetAllRoutinesAndParameters', 'P') IS NOT NULL
    DROP PROCEDURE dbo.GetAllRoutinesAndParameters;
GO

CREATE PROCEDURE dbo.GetAllRoutinesAndParameters
    @DatabaseName SYSNAME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX) = N'';

    -- Generate dynamic SQL for all or specific databases
    SELECT @sql += '
USE [' + name + '];
SELECT 
    ''' + name + ''' AS DatabaseName,
    s.name AS SchemaName,
    o.name AS RoutineName,
    o.type_desc AS RoutineType,
    p.name AS ParameterName,
    t.name AS DataType,
    p.max_length AS MaxLength
FROM 
    sys.objects o
    INNER JOIN sys.schemas s ON o.schema_id = s.schema_id
    LEFT JOIN sys.parameters p ON o.object_id = p.object_id
    LEFT JOIN sys.types t ON p.user_type_id = t.user_type_id
WHERE 
    o.type IN (''P'', ''FN'', ''IF'', ''TF'');
'
    FROM sys.databases
    WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb')
      AND state_desc = 'ONLINE'
      AND (@DatabaseName IS NULL OR name = @DatabaseName);

    -- Execute combined SQL
    EXEC sp_executesql @sql;
END;
GO

