CREATE PROCEDURE [dbo].[DeleteUserDataModelRole]
    @UserID uniqueidentifier,
    @DataModelRoleID bigint
AS
BEGIN
    DELETE FROM 
        [dbo].[UserDataModelRole]
    WHERE
        [UserID] =  @UserID AND
        [DataModelRoleID] = @DataModelRoleID
END

GO

