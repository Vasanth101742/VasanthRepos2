CREATE TABLE [dbo].[Inventory_stock] (
    [COMPANY]      INT           NULL,
    [CWAR]         NVARCHAR (12) NULL,
    [Item]         NVARCHAR (94) NULL,
    [STOCK]        FLOAT (53)    NULL,
    [VALUE]        FLOAT (53)    NULL,
    [Issue_Date]   DATETIME      NULL,
    [Receipt_Date] DATETIME      NULL,
    [Category]     VARCHAR (100) NULL
);


GO

