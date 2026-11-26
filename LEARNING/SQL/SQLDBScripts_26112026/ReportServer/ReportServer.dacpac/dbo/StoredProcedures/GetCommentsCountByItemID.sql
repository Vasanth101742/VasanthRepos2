CREATE PROCEDURE [dbo].[GetCommentsCountByItemID]
@ItemID uniqueidentifier
AS
BEGIN
    SELECT count(*)
    FROM [Comments] as C
    WHERE C.[ItemID] = @ItemID
END

GO

