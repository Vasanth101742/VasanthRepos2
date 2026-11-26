CREATE TABLE [dbo].[ReversalSalesOrders] (
    [Company]              INT            NULL,
    [OriginalInvDate]      DATETIME       NULL,
    [OriginalInvoice]      NVARCHAR (36)  NULL,
    [ReversalAODate]       DATETIME       NULL,
    [ReversalOrderNo]      NVARCHAR (18)  NULL,
    [PONO]                 NVARCHAR (38)  NULL,
    [SQNB]                 NVARCHAR (38)  NULL,
    [CreditNote]           NVARCHAR (82)  NULL,
    [ReversalInvoiceDate]  DATE           NULL,
    [ReversalInvoice]      VARCHAR (50)   NULL,
    [custcode]             NVARCHAR (9)   NULL,
    [custname]             NVARCHAR (100) NULL,
    [Item]                 NVARCHAR (47)  NULL,
    [Item_desc]            NVARCHAR (30)  NULL,
    [DeliveryQty]          FLOAT (53)     NULL,
    [UnitPrice]            FLOAT (53)     NULL,
    [Sales_amount]         FLOAT (53)     NULL,
    [DiscPercent]          REAL           NULL,
    [DiscAmnt]             FLOAT (53)     NULL,
    [Sales_After_Discount] INT            NULL,
    [Taxcode]              NVARCHAR (9)   NULL,
    [TaxAmnt]              FLOAT (53)     NULL,
    [TotalValue]           INT            NULL
);


GO

