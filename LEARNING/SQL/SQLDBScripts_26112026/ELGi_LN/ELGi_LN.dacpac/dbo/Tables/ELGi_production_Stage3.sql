CREATE TABLE [dbo].[ELGi_production_Stage3] (
    [Description]        VARCHAR (50)  NULL,
    [company]            NVARCHAR (38) NULL,
    [warehouse]          NVARCHAR (12) NULL,
    [item]               NVARCHAR (94) NULL,
    [itemdescr]          VARCHAR (50)  NULL,
    [Ordernum]           INT           NULL,
    [Date1]              DATE          NULL,
    [Planned_qty]        INT           NULL,
    [Released_qty]       INT           NULL,
    [WIP_qty]            INT           NULL,
    [MonthPlanQty]       INT           NULL,
    [Actual_qty]         INT           NULL,
    [LineNum]            INT           NULL,
    [Line]               VARCHAR (25)  NULL,
    [SubLineNum]         INT           NULL,
    [SubLine]            VARCHAR (25)  NULL,
    [RegionNum]          INT           NULL,
    [Region]             VARCHAR (25)  NULL,
    [ProductionLine]     VARCHAR (50)  NULL,
    [FG_qty]             FLOAT (53)    NULL,
    [Rnk]                INT           NULL,
    [Actual_qty_Advance] FLOAT (53)    NULL,
    [Actual_qty_Backlog] FLOAT (53)    NULL
);


GO

