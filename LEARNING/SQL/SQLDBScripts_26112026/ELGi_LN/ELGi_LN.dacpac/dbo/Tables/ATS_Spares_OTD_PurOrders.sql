CREATE TABLE [dbo].[ATS_Spares_OTD_PurOrders] (
    [COMPANY]            NVARCHAR (38) NULL,
    [ODAT]               DATETIME      NULL,
    [ORNO]               NVARCHAR (18) NULL,
    [PONO]               NVARCHAR (38) NULL,
    [ITEM]               NVARCHAR (94) NULL,
    [Itemdesc]           NVARCHAR (60) NULL,
    [CWAR]               NVARCHAR (12) NULL,
    [PlannedReceiptDt]   DATETIME      NULL,
    [ActualReceiptDt]    DATETIME      NULL,
    [OrderQty]           FLOAT (53)    NULL,
    [ReceiptQty]         FLOAT (53)    NULL,
    [OrderAmt]           NVARCHAR (38) NULL,
    [SupplierCode]       NVARCHAR (18) NULL,
    [SupplierName]       INT           NULL,
    [DelvQty_before_Due] FLOAT (53)    NULL,
    [DelvQty_over_Due]   FLOAT (53)    NULL,
    [status]             VARCHAR (20)  NULL
);


GO

