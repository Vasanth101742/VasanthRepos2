CREATE TABLE [dbo].[InventoryData] (
    [company]     NVARCHAR (255)  NULL,
    [compnr]      BIGINT          NULL,
    [Item]        NVARCHAR (255)  NULL,
    [descr]       NVARCHAR (255)  NULL,
    [OnHand]      NVARCHAR (76)   NULL,
    [Differ]      BIGINT          NULL,
    [Ageing]      NVARCHAR (255)  NULL,
    [dsca]        NVARCHAR (255)  NULL,
    [ProductLine] NVARCHAR (255)  NULL,
    [Supplier]    NVARCHAR (255)  NULL,
    [Model]       NVARCHAR (255)  NULL,
    [cwar]        NVARCHAR (6)    NULL,
    [StVal]       DECIMAL (28, 9) NULL
);


GO

