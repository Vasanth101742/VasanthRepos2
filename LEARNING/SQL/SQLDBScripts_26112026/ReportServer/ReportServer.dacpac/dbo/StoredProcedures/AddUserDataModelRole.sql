CREATE PROCEDURE [dbo].[AddUserDataModelRole]
    @UserID uniqueidentifier,
    @DataModelRoleID bigint
AS
BEGIN
    INSERT INTO 
        [dbo].[UserDataModelRole]([UserID], [DataModelRoleID])
    VALUES
        (@UserID, @DataModelRoleID)
END

GO

