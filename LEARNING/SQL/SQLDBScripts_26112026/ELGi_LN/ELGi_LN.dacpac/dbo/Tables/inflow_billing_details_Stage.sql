CREATE TABLE [dbo].[inflow_billing_details_Stage] (
    [Organ]         VARCHAR (50)  NULL,
    [Vertical1]     VARCHAR (100) NULL,
    [dpst]          NVARCHAR (6)  NULL,
    [DpstName]      VARCHAR (100) NULL,
    [AreaCode]      VARCHAR (5)   NULL,
    [AreaName]      VARCHAR (50)  NULL,
    [CalYear]       INT           NULL,
    [CalMonth]      INT           NULL,
    [Wk_Month]      INT           NULL,
    [OrderDate]     DATE          NULL,
    [inflowOrders]  NVARCHAR (50) NULL,
    [company]       INT           NULL,
    [SaleOrderType] NVARCHAR (6)  NULL,
    [OrderNo]       NVARCHAR (9)  NULL,
    [OrderQty]      FLOAT (53)    NULL,
    [Inflow]        FLOAT (53)    NULL,
    [Invoice_Date]  DATE          NULL,
    [Trantype]      NVARCHAR (6)  NULL,
    [Invoice]       INT           NULL,
    [DeliveryQty]   FLOAT (53)    NULL,
    [Sales]         FLOAT (53)    NULL,
    [SalesOrders]   NVARCHAR (50) NULL
);


GO

