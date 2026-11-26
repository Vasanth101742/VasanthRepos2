CREATE TABLE [dbo].[Lean_Allocation_Tmp] (
    [COMPANY]         NVARCHAR (38) NULL,
    [DIVI]            NVARCHAR (38) NULL,
    [DEPT]            NVARCHAR (38) NULL,
    [LeanType]        VARCHAR (4)   NOT NULL,
    [AllocationType]  VARCHAR (10)  NULL,
    [ITEM]            NVARCHAR (94) NULL,
    [CATEGORY]        VARCHAR (13)  NULL,
    [SLOQ]            FLOAT (53)    NULL,
    [BINQTY]          FLOAT (53)    NULL,
    [ProdAllocation]  INT           NOT NULL,
    [SalesAllocation] INT           NOT NULL,
    [BinAllocation]   INT           NOT NULL,
    [RegAllocation]   INT           NOT NULL,
    [StockAllocation] INT           NOT NULL,
    [SUPPCODE]        NVARCHAR (18) NULL,
    [BUYRCODE]        NVARCHAR (18) NULL
);


GO

