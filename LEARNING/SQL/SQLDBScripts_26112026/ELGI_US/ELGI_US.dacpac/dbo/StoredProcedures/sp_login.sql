CREATE PROCEDURE [dbo].[sp_login]
	-- Add the parameters for the stored procedure here
	@username nvarchar(50),@password nvarchar(50)
AS
BEGIN
	SELECT [id]
      ,[username]
      ,[password]
      ,[isactive]
      ,[customercode]
      ,[companycode]
  FROM [acr_login] WHERE username = @username and password = @password and isactive = 'true'


end

GO

