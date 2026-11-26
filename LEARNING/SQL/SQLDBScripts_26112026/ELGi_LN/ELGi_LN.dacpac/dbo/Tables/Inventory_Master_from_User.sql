CREATE TABLE [dbo].[Inventory_Master_from_User] (
    [COMPANY]       NVARCHAR (255) NULL,
    [CWAR]          NVARCHAR (255) NULL,
    [ITEM]          NVARCHAR (255) NULL,
    [ItemDescr]     NVARCHAR (MAX) NULL,
    [OrderType]     INT            NULL,
    [OrderTypeDesc] NVARCHAR (255) NULL,
    [ReceiptType]   NVARCHAR (255) NULL,
    [ItemType]      NVARCHAR (255) NULL,
    [InvType]       NVARCHAR (255) NULL
);


GO

