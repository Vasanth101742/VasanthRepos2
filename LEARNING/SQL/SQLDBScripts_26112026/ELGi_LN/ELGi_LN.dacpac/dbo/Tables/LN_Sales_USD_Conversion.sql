CREATE TABLE [dbo].[LN_Sales_USD_Conversion] (
    [Company]        INT           NULL,
    [OrderDate]      DATETIME      NULL,
    [SaleOrderType]  NVARCHAR (6)  NULL,
    [OrderNo]        NVARCHAR (9)  NULL,
    [PositionNo]     INT           NULL,
    [InvoiceDate]    DATETIME      NULL,
    [Trantype]       NVARCHAR (3)  NULL,
    [Invoice]        INT           NULL,
    [DeliveryQty]    FLOAT (53)    NULL,
    [Sales_amount]   FLOAT (53)    NULL,
    [BCUR]           NVARCHAR (6)  NULL,
    [CCUR]           NVARCHAR (6)  NULL,
    [STDT]           DATETIME      NULL,
    [RATE]           FLOAT (53)    NULL,
    [DaysDiff]       INT           NULL,
    [Rnk]            BIGINT        NULL,
    [Sales_in_USD]   FLOAT (53)    NULL,
    [estimated_date] DATETIME      NULL,
    [indent]         VARCHAR (100) NULL
);


GO

