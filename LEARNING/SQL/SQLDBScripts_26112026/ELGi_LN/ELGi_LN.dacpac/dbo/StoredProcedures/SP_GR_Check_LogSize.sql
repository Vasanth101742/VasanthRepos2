CREATE PROCEDURE [dbo].[SP_GR_Check_LogSize]
AS
BEGIN
set NOCOUNT ON


DECLARE @dbname NVARCHAR(128)
DECLARE @startid INT
DECLARE @endid INT 

SET @startid = 1

CREATE TABLE #TEMPLog(
    ID INT IDENTITY(1,1),
    DBName NVARCHAR(128)
)

INSERT INTO #TEMPLog (DBName)
SELECT  DB_NAME(database_id)
FROM sys.master_files
WHERE type_desc = 'LOG'
GROUP BY database_id
HAVING SUM(size) * 8.0 / 1024 / 1024 > 1

SET @endid = (SELECT COUNT(*) FROM #TEMPLog)

WHILE (@startid <= @endid)
BEGIN

    SELECT @dbname = DBName 
    FROM #TEMPLog 
    WHERE ID = @startid

    DECLARE @SqlStatement NVARCHAR(MAX)
    DECLARE @LogFileLogicalName SYSNAME

    SET @SqlStatement = '
        USE ' + QUOTENAME(@dbname) + ';
        SELECT @LogFileLogicalNameOUT = name 
        FROM sys.database_files 
        WHERE type = 1;
    '

    EXEC sp_executesql 
        @SqlStatement,
        N'@LogFileLogicalNameOUT SYSNAME OUTPUT',
        @LogFileLogicalName OUTPUT

    SET @SqlStatement = 
        'ALTER DATABASE ' + QUOTENAME(@dbname) + ' SET RECOVERY SIMPLE'
    EXEC (@SqlStatement)

    SET @SqlStatement = 
        'USE ' + QUOTENAME(@dbname) + ';
         DBCC SHRINKFILE (' + QUOTENAME(@LogFileLogicalName) + ', 1);'
    EXEC (@SqlStatement)

    SET @SqlStatement = 
        'ALTER DATABASE ' + QUOTENAME(@dbname) + ' SET RECOVERY FULL'
    EXEC (@SqlStatement)

    SET @startid = @startid + 1

END

-----------------------------------------------




DECLARE @MAIL_BODY NVARCHAR(MAX);
DECLARE @SUBJECT NVARCHAR(200);

SET @SUBJECT = 'ALERT : Log Size Increased More Than 10 GB';


IF EXISTS (
    SELECT 1
    FROM sys.master_files
    WHERE type_desc = 'LOG'
    GROUP BY database_id
    HAVING SUM(size) * 8.0 / 1024 / 1024 > 10
)
BEGIN

    SET @MAIL_BODY = 
    '<body style="font-family: Arial; font-size:14px;">' +
    '<p>Below are the databases where log size exceeded 10GB:</p>' +
    '<table border="1" cellpadding="5" cellspacing="0">' +
    '<tr>
        <th>Database Name</th>
        <th>Log Size (GB)</th>
     </tr>';

    SELECT @MAIL_BODY = @MAIL_BODY +
        '<tr>
            <td>' + DB_NAME(database_id) + '</td>
            <td>' + 
            CAST(CAST(SUM(size) * 8.0 / 1024 / 1024 AS DECIMAL(18,2)) AS NVARCHAR(20)) 
            + '</td>
         </tr>'
    FROM sys.master_files
    WHERE type_desc = 'LOG'
    GROUP BY database_id
    HAVING SUM(size) * 8.0 / 1024 / 1024 > 10


    SET @MAIL_BODY = @MAIL_BODY + '</table></body>';

    EXEC msdb.dbo.sp_send_dbmail
        @profile_name = 'BIS',
        @recipients = 'vasanthk@elgi.com;gokulnath@elgi.com;krishna.raha@elgi.com',
        @subject = @SUBJECT,
        @body = @MAIL_BODY,
        @body_format = 'HTML';

END;


END

GO

