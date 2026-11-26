CREATE TABLE [dbo].[production_plan_vs_actual] (
    [date1]         DATE          NULL,
    [company]       NVARCHAR (38) NULL,
    [Prodorderno]   NVARCHAR (18) NULL,
    [Warehouse]     NVARCHAR (12) NULL,
    [Item]          NVARCHAR (94) NULL,
    [Planned_qty]   INT           NULL,
    [Released_qty]  INT           NULL,
    [Actual_qty]    FLOAT (53)    NULL,
    [WIP_qty]       INT           NULL,
    [avg_bud_price] INT           NULL,
    [sls_price]     INT           NULL,
    [Dispatch_qty]  FLOAT (53)    NULL
);


GO

