CREATE TABLE [dbo].[Inventory_vs_Allocation] (
    [COMPANY]              NVARCHAR (38)  NULL,
    [ITEM]                 NVARCHAR (94)  NULL,
    [DueDate]              DATE           NULL,
    [AllocationType]       VARCHAR (21)   NULL,
    [AllocatedQty]         FLOAT (53)     NULL,
    [ItemDescr]            VARCHAR (100)  NULL,
    [StockQty]             FLOAT (53)     NULL,
    [OverDueTriggerQty]    FLOAT (53)     NULL,
    [TotalTriggerQty]      FLOAT (53)     NULL,
    [BuyerCode]            NVARCHAR (18)  NULL,
    [SupplierCode]         NVARCHAR (18)  NULL,
    [BuyerName]            NVARCHAR (100) NULL,
    [SupplierName]         NVARCHAR (100) NULL,
    [ProcurementType]      VARCHAR (25)   NULL,
    [DueWeek]              INT            NULL,
    [Allocation_Consider]  VARCHAR (10)   NULL,
    [First_Trg_GenDate]    DATE           NULL,
    [First_Trg_DueDate]    DATE           NULL,
    [TrgStatus]            VARCHAR (50)   NULL,
    [OverDue_AllocQty]     FLOAT (53)     NULL,
    [Allocation_Consider2] VARCHAR (10)   NULL,
    [DueWeek2]             INT            NULL,
    [DueMonth]             VARCHAR (20)   NULL,
    [Allocation_Consider3] VARCHAR (10)   NULL
);


GO

