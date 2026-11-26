CREATE TABLE [dbo].[Excess_Tmp1] (
    [COMPANY]         NVARCHAR (38) NULL,
    [ITEM]            NVARCHAR (94) NULL,
    [Itemdesc]        INT           NULL,
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
    [SuppName]        INT           NULL,
    [BUYRCODE]        NVARCHAR (18) NULL,
    [BuyerName]       INT           NULL
);


GO

