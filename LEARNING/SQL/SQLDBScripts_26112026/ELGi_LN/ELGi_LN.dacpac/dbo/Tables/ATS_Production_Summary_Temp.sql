CREATE TABLE [dbo].[ATS_Production_Summary_Temp] (
    [COMPANY]          NVARCHAR (38)  NULL,
    [CWAR]             NVARCHAR (12)  NULL,
    [ITEM]             NVARCHAR (100) NULL,
    [OnHandStk]        FLOAT (53)     NULL,
    [ActualAvlStk]     FLOAT (53)     NULL,
    [PendingQty]       FLOAT (53)     NULL,
    [ClearedQty]       FLOAT (53)     NULL,
    [date1]            DATE           NULL,
    [WIP_Qty]          FLOAT (53)     NULL,
    [Actual_Qty]       FLOAT (53)     NULL,
    [PlannedQty]       FLOAT (53)     NULL,
    [ToBeCompletedQty] FLOAT (53)     NULL,
    [Monthly_Plan]     FLOAT (53)     NULL,
    [ProductGroup_MRP] VARCHAR (50)   NULL,
    [Price]            FLOAT (53)     NULL,
    [MonthlyPlanValue] FLOAT (53)     NULL
);


GO

