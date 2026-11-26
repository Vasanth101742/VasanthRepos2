CREATE TABLE [dbo].[ATS_ClearanceOrder] (
    [Item]             NVARCHAR (150) NULL,
    [TPLDescription]   NVARCHAR (250) NULL,
    [ProductGroup]     NVARCHAR (100) NULL,
    [ItemType]         NVARCHAR (50)  NULL,
    [StockOnHND]       FLOAT (53)     NULL,
    [StockAct]         FLOAT (53)     NULL,
    [PendingAOTotal]   FLOAT (53)     NULL,
    [PendingAOClear]   FLOAT (53)     NULL,
    [POPlanned]        FLOAT (53)     NULL,
    [POWIP]            FLOAT (53)     NULL,
    [POUnderPacking]   FLOAT (53)     NULL,
    [MonthlyPlanQty]   FLOAT (53)     NULL,
    [Price]            FLOAT (53)     NULL,
    [MonthlyPlanValue] FLOAT (53)     NULL,
    [CLDT]             DATETIME       NULL,
    [company]          INT            NULL,
    [CWAR]             NVARCHAR (10)  NULL,
    [ClearedQty]       FLOAT (53)     NULL,
    [rnk]              INT            NULL
);


GO

