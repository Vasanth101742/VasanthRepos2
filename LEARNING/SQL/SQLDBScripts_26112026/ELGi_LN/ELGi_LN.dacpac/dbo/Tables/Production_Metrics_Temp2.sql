CREATE TABLE [dbo].[Production_Metrics_Temp2] (
    [Description]        VARCHAR (50)  NULL,
    [company]            NVARCHAR (38) NULL,
    [warehouse]          NVARCHAR (12) NULL,
    [item]               NVARCHAR (94) NULL,
    [itemdescr]          VARCHAR (50)  NULL,
    [Ordernum]           VARCHAR (20)  NULL,
    [Date1]              DATE          NULL,
    [MonthPlanQty]       FLOAT (53)    NULL,
    [Actual_qty]         INT           NULL,
    [WIP_qty]            INT           NULL,
    [Planned_qty]        INT           NULL,
    [Future_Planned_qty] INT           NULL,
    [FG_qty]             FLOAT (53)    NULL,
    [AssemblyLine]       VARCHAR (20)  NULL,
    [CurrentDate]        DATE          NULL,
    [weekNo]             INT           NULL,
    [CalMonth]           INT           NULL,
    [CalYear]            INT           NULL
);


GO

