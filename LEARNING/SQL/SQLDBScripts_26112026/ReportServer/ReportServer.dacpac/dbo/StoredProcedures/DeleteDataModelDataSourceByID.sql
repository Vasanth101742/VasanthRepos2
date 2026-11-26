CREATE PROCEDURE [dbo].[DeleteDataModelDataSourceByID]
    @DataSourceID UNIQUEIDENTIFIER  
AS

BEGIN
DELETE FROM [dbo].[DataModelDataSource] WHERE [DataSourceID] = @DataSourceID
END

GO

