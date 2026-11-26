CREATE TABLE [dbo].[prod_tmp] (
    [Description]           VARCHAR (50)  NULL,
    [company]               NVARCHAR (38) NULL,
    [warehouse]             NVARCHAR (12) NULL,
    [item]                  NVARCHAR (94) NULL,
    [itemdescr]             VARCHAR (50)  NULL,
    [Ordernum]              VARCHAR (25)  NULL,
    [Date1]                 DATE          NULL,
    [Planned_qty]           INT           NULL,
    [Released_qty]          INT           NULL,
    [WIP_qty]               INT           NULL,
    [PlanPullQty]           INT           NULL,
    [Actual_qty]            INT           NULL,
    [Backlog_Qty]           INT           NULL,
    [BacklogPlanned_qty]    INT           NULL,
    [BacklogReleased_qty]   INT           NULL,
    [BacklogWIP_qty]        INT           NULL,
    [This_mnth_ReleasedQty] INT           NULL,
    [This_mnth_WIPQty]      INT           NULL,
    [This_mnth_ActualQty]   INT           NULL,
    [Day1]                  INT           NULL,
    [Day2]                  INT           NULL,
    [Day3]                  INT           NULL,
    [Day4]                  INT           NULL,
    [Day5]                  INT           NULL
);


GO

