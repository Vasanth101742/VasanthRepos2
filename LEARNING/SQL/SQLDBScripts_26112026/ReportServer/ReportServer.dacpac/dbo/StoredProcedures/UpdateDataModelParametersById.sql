CREATE PROCEDURE [dbo].[UpdateDataModelParametersById]
    @CatalogItemID UNIQUEIDENTIFIER,
    @Parameters ntext
AS
BEGIN
    UPDATE
        [dbo].[Catalog]
    SET
        [Parameter] = @Parameters
    WHERE
        [ItemID] = @CatalogItemID
END

GO

