CREATE TABLE [dbo].[Triggers_Inventory_Production] (
    [company]          NVARCHAR (38) NULL,
    [warehouse]        NVARCHAR (12) NULL,
    [item]             NVARCHAR (94) NULL,
    [itemdescr]        VARCHAR (50)  NULL,
    [Description]      VARCHAR (50)  NULL,
    [prodorderno]      NVARCHAR (18) NULL,
    [date1]            DATE          NULL,
    [planned_Qty]      INT           NULL,
    [Lot_No]           VARCHAR (25)  NULL,
    [PendingQty]       FLOAT (53)    NULL,
    [StockQty]         FLOAT (53)    NULL,
    [StockValue]       FLOAT (53)    NULL,
    [CalYear]          INT           NULL,
    [CalMonth]         INT           NULL,
    [Month_Name]       VARCHAR (25)  NULL,
    [CalPeriod]        INT           NULL,
    [MonthType]        VARCHAR (25)  NULL,
    [PendingValue]     FLOAT (53)    NULL,
    [PriceSource]      VARCHAR (25)  NULL,
    [Planned_Value]    FLOAT (53)    NULL,
    [Description_ordr] INT           NULL,
    [Remarks]          VARCHAR (25)  NULL,
    [Category]         VARCHAR (50)  NULL,
    [SuppCode]         VARCHAR (50)  NULL,
    [SuppName]         VARCHAR (50)  NULL,
    [BuyerCode]        VARCHAR (50)  NULL,
    [BuyerName]        VARCHAR (50)  NULL,
    [DueSlabOrdr]      INT           NULL,
    [DueSlab]          VARCHAR (50)  NULL,
    [DueTypeOrdr]      INT           NULL,
    [DueType]          VARCHAR (50)  NULL
);


GO

