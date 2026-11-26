
create proc [SP_GR_TableCount]
as
begin

DECLARE @sql NVARCHAR(MAX) = '';
DECLARE @tableName NVARCHAR(256);

-- Cursor to loop through all user tables
DECLARE table_cursor CURSOR FOR
SELECT t.name
FROM sys.tables t
INNER JOIN sys.columns c ON t.object_id = c.object_id
WHERE c.name = 'DLDocumentDate';

OPEN table_cursor;
FETCH NEXT FROM table_cursor INTO @tableName;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @sql += '
    SELECT 
        ''' + @tableName + ''' AS TableName,
        MAX(DLDocumentDate) AS MaxDLDocumentDate,
        COUNT(*) AS NumberOfLines
    FROM [' + @tableName + '] 
    UNION ALL';

    FETCH NEXT FROM table_cursor INTO @tableName;
END

CLOSE table_cursor;
DEALLOCATE table_cursor;

-- Remove last UNION ALL
SET @sql = LEFT(@sql, LEN(@sql) - 10);

-- Execute the dynamic SQL
EXEC sp_executesql @sql;
end

GO

