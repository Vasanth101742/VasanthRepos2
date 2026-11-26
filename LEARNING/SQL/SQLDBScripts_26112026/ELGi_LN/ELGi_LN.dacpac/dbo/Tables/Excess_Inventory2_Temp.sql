CREATE TABLE [dbo].[Excess_Inventory2_Temp] (
    [COMPANY]         NVARCHAR (38) NULL,
    [ITEM]            NVARCHAR (94) NULL,
    [Itemdesc]        NVARCHAR (60) NULL,
    [LeanType]        VARCHAR (20)  NULL,
    [CATEGORY]        VARCHAR (20)  NULL,
    [AllocationType]  VARCHAR (10)  NULL,
    [sloq]            FLOAT (53)    NULL,
    [BINQTY]          FLOAT (53)    NULL,
    [ProdAllocation]  FLOAT (53)    NULL,
    [SalesAllocation] FLOAT (53)    NULL,
    [BinAllocation]   FLOAT (53)    NULL,
    [RegAllocation]   FLOAT (53)    NULL,
    [StockAllocation] FLOAT (53)    NULL,
    [TotalAllocation] FLOAT (53)    NULL,
    [StockQty]        FLOAT (53)    NULL,
    [StockValue]      FLOAT (53)    NULL,
    [ExcessQty]       FLOAT (53)    NULL,
    [ExcessValue]     FLOAT (53)    NULL,
    [LatestRecptDate] DATE          NULL,
    [SUPPCODE]        NVARCHAR (18) NULL,
    [SuppName]        NVARCHAR (70) NULL,
    [BUYRCODE]        NVARCHAR (18) NULL,
    [BuyerName]       NVARCHAR (50) NULL,
    [EntryDate]       DATE          NULL,
    [ExcessType]      VARCHAR (25)  NULL
);


GO

