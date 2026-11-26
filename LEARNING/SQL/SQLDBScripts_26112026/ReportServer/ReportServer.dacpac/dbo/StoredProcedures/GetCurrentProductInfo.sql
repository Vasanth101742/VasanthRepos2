CREATE PROCEDURE [dbo].[GetCurrentProductInfo]
AS
    SELECT TOP 1 [DbSchemaHash], [Sku], [BuildNumber]
    FROM [dbo].[ProductInfoHistory]
    ORDER BY DateTime DESC

GO

