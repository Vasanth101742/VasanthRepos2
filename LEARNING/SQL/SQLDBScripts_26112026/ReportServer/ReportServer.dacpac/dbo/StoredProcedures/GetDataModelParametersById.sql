CREATE PROCEDURE [dbo].[GetDataModelParametersById]
    @CatalogItemID uniqueidentifier
AS
SELECT Parameter
FROM Catalog
WHERE ItemID = @CatalogItemID

GO

