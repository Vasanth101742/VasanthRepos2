CREATE proc [dbo].[SP_GR_DISKSPACE]
as
begin

DECLARE @UsedPercent DECIMAL(5,2);
declare @Body nvarchar(max)


SELECT @body =
    'System Drive Storage Report

Drive: ' + vs.volume_mount_point + '
Total Size: ' + CAST(vs.total_bytes / 1024 / 1024 / 1024 AS VARCHAR) + ' GB
Free Space: ' + CAST(vs.available_bytes / 1024 / 1024 / 1024 AS VARCHAR) + ' GB
Used Space: ' + CAST((vs.total_bytes - vs.available_bytes) / 1024 / 1024 / 1024 AS VARCHAR) + ' GB
Used %: ' +convert(nvarchar(30),convert(decimal(19,2),
CAST(
    ((vs.total_bytes - vs.available_bytes) * 100.0 / vs.total_bytes)
    AS VARCHAR
) ))+ ' %'
FROM sys.master_files mf
CROSS APPLY sys.dm_os_volume_stats(mf.database_id, mf.file_id) vs

GROUP BY vs.volume_mount_point, vs.total_bytes, vs.available_bytes;



SELECT @UsedPercent =
CAST(
    ((vs.total_bytes - vs.available_bytes) * 100.0 / vs.total_bytes)
    AS DECIMAL(5,2)
)
FROM sys.master_files mf
CROSS APPLY sys.dm_os_volume_stats(mf.database_id, mf.file_id) vs

GROUP BY vs.total_bytes, vs.available_bytes;

IF @UsedPercent >= 80
BEGIN
--set @Body= 'System Drive usage is above 80%. Current Usage: ' + CAST(@UsedPercent AS VARCHAR) + ' %';
    EXEC msdb.dbo.sp_send_dbmail
	   @profile_name = 'BIS',
	  @recipients = 'vasanthk@elgi.com;gokulnath@elgi.com;krishna.raha@elgi.com',
        @subject = 'ALERT:BIS System Drive 80% Full',
        @body = @Body
END


end

GO

