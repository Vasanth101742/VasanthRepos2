CREATE TABLE [dbo].[mc_sales] (
    [dpst]          NVARCHAR (12) NULL,
    [areacode]      VARCHAR (5)   NULL,
    [year]          INT           NULL,
    [month]         INT           NULL,
    [Item]          NVARCHAR (47) NULL,
    [Sales]         FLOAT (53)    NULL,
    [DeliveryQty]   FLOAT (53)    NULL,
    [sales_Mc]      INT           NOT NULL,
    [sales_bud]     INT           NOT NULL,
    [sales_bud_Qty] INT           NOT NULL,
    [mc_budget]     INT           NOT NULL
);


GO

