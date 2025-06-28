-- ================================================
-- Send Index Metadata Report via Database Mail
-- ================================================

-- STEP 1: Declare variable to hold HTML
DECLARE @HTMLTable NVARCHAR(MAX);

-- STEP 2: Start building the HTML structure
SET @HTMLTable = 
N'<html>
<head>
<style>
table {
  border-collapse: collapse;
  width: 100%;
  font-family: Arial, sans-serif;
}
th, td {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}
th {
  background-color: #f2f2f2;
}
</style>
</head>
<body>
<h2>Index Metadata Report</h2>
<table>
<tr>
  <th>Table Name</th>
  <th>Index Name</th>
  <th>Index Type</th>
  <th>Column Name</th>
  <th>Column Type</th>
</tr>';

-- STEP 3: Append rows dynamically from system views
SELECT @HTMLTable = @HTMLTable + 
    '<tr>' +
    '<td>' + QUOTENAME(s.name) + '.' + QUOTENAME(t.name) + '</td>' +
    '<td>' + ISNULL(i.name, '(No Name)') + '</td>' +
    '<td>' + i.type_desc + '</td>' +
    '<td>' + c.name + '</td>' +
    '<td>' + ty.name + '</td>' +
    '</tr>'
FROM sys.indexes i
INNER JOIN sys.tables t ON i.object_id = t.object_id
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
INNER JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
INNER JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
INNER JOIN sys.types ty ON c.user_type_id = ty.user_type_id
WHERE i.is_primary_key = 0 AND i.is_unique_constraint = 0
ORDER BY s.name, t.name, i.name;

-- STEP 4: Close the HTML
SET @HTMLTable = @HTMLTable + '</table></body></html>';

-- STEP 5: Send the Email using Database Mail
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'YourDatabaseMailProfile',     -- 🔁 Replace with your mail profile name
    @recipients = 'recipient@example.com',         -- 🔁 Replace with the recipient email
    @subject = 'SQL Server Index Metadata Report',
    @body = @HTMLTable,
    @body_format = 'HTML';

-- ================================================
-- End of Script
-- ================================================
