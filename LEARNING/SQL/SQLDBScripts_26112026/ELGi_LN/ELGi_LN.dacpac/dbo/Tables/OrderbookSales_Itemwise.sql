CREATE TABLE [dbo].[OrderbookSales_Itemwise] (
    [Company]       NVARCHAR (150) NULL,
    [OrderDate]     DATE           NULL,
    [Invoice_Date]  DATE           NULL,
    [Sales_Amount]  FLOAT (53)     NULL,
    [BookandBill]   NVARCHAR (30)  NULL,
    [MonthYear_S]   NVARCHAR (100) NULL,
    [Itemcode]      NVARCHAR (250) NULL,
    [Product_group] NVARCHAR (250) NULL,
    [Item_Category] NVARCHAR (250) NULL,
    [UpdatedDate]   DATETIME       NULL
);


GO

