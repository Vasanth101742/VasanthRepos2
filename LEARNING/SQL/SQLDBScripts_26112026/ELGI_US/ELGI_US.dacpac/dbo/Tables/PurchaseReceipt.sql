CREATE TABLE [dbo].[PurchaseReceipt] (
    [compnr]                 BIGINT         NULL,
    [PurchaseOrder]          NVARCHAR (9)   NULL,
    [otbp]                   NVARCHAR (9)   NULL,
    [BusinessPartnerName]    NVARCHAR (35)  NULL,
    [Item]                   NVARCHAR (47)  NULL,
    [ItemDesc]               NVARCHAR (60)  NULL,
    [Receipt_number]         NVARCHAR (9)   NULL,
    [ReceiptLogDate]         DATETIME       NULL,
    [ReceiptQty]             FLOAT (53)     NULL,
    [RecptDate]              NVARCHAR (40)  NULL,
    [pric]                   FLOAT (53)     NULL,
    [packing slip number]    NVARCHAR (30)  NULL,
    [ClosingDate]            DATE           NULL,
    [PositionNumber]         BIGINT         NULL,
    [ReceiptSeqNo]           BIGINT         NULL,
    [OrderSeqNo]             BIGINT         NULL,
    [APDocNo]                NVARCHAR (27)  NOT NULL,
    [LoginUser]              NVARCHAR (8)   NULL,
    [TransactionEnteredDate] DATETIME       NULL,
    [PaymentDocNo]           NVARCHAR (27)  NOT NULL,
    [PaidDate]               DATETIME       NULL,
    [DocumentDate]           DATETIME       NULL,
    [AgeingDays]             INT            NULL,
    [Ageing]                 VARCHAR (14)   NULL,
    [ItemExtDescr]           NVARCHAR (255) NULL,
    [StandardItemDesc]       NVARCHAR (255) NULL,
    [Warehouse]              NVARCHAR (255) NULL,
    [ApprAmnt]               FLOAT (53)     NULL,
    [InvAmt]                 FLOAT (53)     NULL,
    [TotalValue]             FLOAT (53)     NULL,
    [Variance]               FLOAT (53)     NULL
);


GO

