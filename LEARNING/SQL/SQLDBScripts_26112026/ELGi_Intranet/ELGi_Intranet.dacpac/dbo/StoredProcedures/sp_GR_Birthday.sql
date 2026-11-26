
CREATE proc [sp_GR_Birthday]
as
begin

DECLARE @subject NVARCHAR(100) = 'Happy Birthday';

SELECT 
    emp_name as name,
    email as email,
    'Hi.,

Wishing you a wonderful birthday filled with happiness and success.

May this year bring you great achievements and joy.

Regards,
Gokulnath R' AS email_body
INTO #temp_birthdays
from employee_detail where  settledate='' and isnull(email,'')<>'' and employee_status='Live' and  left(band,2) in ('M1','M2','M3','M4')  and 
 DAY(convert(date,birthdate ,103)) = DAY(GETDATE())
AND MONTH(convert(date,birthdate ,103)) = MONTH(GETDATE());

DECLARE @name NVARCHAR(100),
        @email NVARCHAR(100),
        @body NVARCHAR(MAX);

WHILE EXISTS (SELECT 1 FROM #temp_birthdays)
BEGIN
    SELECT TOP 1 
        @name = name,
        @email = email,
        @body = email_body
    FROM #temp_birthdays;

    EXEC msdb.dbo.sp_send_dbmail
	
        @profile_name = 'mail',
        @recipients = 'nagaveni.selvaraj@elgi.com',
        @subject = @SUBJECT,
        @body = @body


    DELETE FROM #temp_birthdays WHERE email = @email;
END;

DROP TABLE #temp_birthdays;

end

GO

