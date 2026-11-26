CREATE TABLE [dbo].[GateEntry_Recipt] (
    [ID]                    INT             NOT NULL,
    [Gateentrynumber]       NVARCHAR (100)  NULL,
    [Gateentrydate]         NVARCHAR (50)   NULL,
    [BPCode]                NVARCHAR (80)   NULL,
    [SupplierinvoiceNo]     NVARCHAR (100)  NULL,
    [Supplierinvoicedate]   NVARCHAR (50)   NULL,
    [Purchaseorder]         NVARCHAR (80)   NULL,
    [Itemcode]              NVARCHAR (254)  NULL,
    [Quantity]              NVARCHAR (100)  NULL,
    [CreatedDate]           DATETIME        NULL,
    [Recip_Qty]             NUMERIC (19, 2) NULL,
    [P_Status]              NVARCHAR (3)    NULL,
    [SupName]               NVARCHAR (254)  NULL,
    [CompanyCode]           NVARCHAR (10)   NULL,
    [WhsLoc]                NVARCHAR (30)   NULL,
    [inspection]            NVARCHAR (50)   NULL,
    [Itemdesc]              NVARCHAR (50)   NULL,
    [PurchaseOrderPos]      NVARCHAR (50)   NULL,
    [VehicleNO]             NVARCHAR (50)   NULL,
    [PurchaseOrderPrice]    NVARCHAR (50)   NULL,
    [PostStatus]            NVARCHAR (3)    NULL,
    [LineNum]               INT             NULL,
    [UOM]                   NVARCHAR (10)   NULL,
    [GeneratedUser]         NVARCHAR (50)   NULL,
    [GeneratedReceiptnum]   NVARCHAR (50)   NULL,
    [location]              VARCHAR (30)    NULL,
    [serial]                NVARCHAR (5)    NULL,
    [serialized]            NVARCHAR (5)    NULL,
    [GeneratedReciptStatus] NVARCHAR (10)   NULL,
    [GeneratedDate]         DATETIME        NULL
);


GO

