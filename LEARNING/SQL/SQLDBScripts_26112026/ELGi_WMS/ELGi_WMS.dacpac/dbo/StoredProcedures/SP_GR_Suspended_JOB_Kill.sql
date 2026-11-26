
CREATE proc [dbo].[SP_GR_Suspended_JOB_Kill]
as
begin

DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql = @sql + 'KILL ' + CAST(r.session_id AS NVARCHAR(10)) + '; '
FROM sys.dm_exec_requests r
JOIN sys.dm_exec_sessions s ON r.session_id = s.session_id
WHERE r.status = 'suspended'
  AND s.login_name NOT IN ('sa')       -- exclude system/admin logins
  AND DATEDIFF(MINUTE, s.login_time, GETDATE()) > 5
  and r.database_id='33'


EXEC sp_executesql @sql;

end

GO

