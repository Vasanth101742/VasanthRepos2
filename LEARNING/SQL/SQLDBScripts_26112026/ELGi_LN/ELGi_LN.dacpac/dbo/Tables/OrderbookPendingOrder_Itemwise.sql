CREATE TABLE [dbo].[OrderbookPendingOrder_Itemwise] (
    [Company]       NVARCHAR (150) NULL,
    [MonthYear_P]   NVARCHAR (100) NULL,
    [OrderDate]     DATE           NULL,
    [Sales]         FLOAT (53)     NULL,
    [ItemCode]      NVARCHAR (250) NULL,
    [Item_category] NVARCHAR (250) NULL,
    [Product_group] NVARCHAR (250) NULL
);


GO

