
CREATE PROCEDURE [dbo].[sp_TruncateTable]
    @TableName nvarchar(150)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SQL NVARCHAR(MAX);

    SET @SQL = N'TRUNCATE TABLE ' + QUOTENAME(@TableName);

    EXEC sp_executesql @SQL;
END;

GO

