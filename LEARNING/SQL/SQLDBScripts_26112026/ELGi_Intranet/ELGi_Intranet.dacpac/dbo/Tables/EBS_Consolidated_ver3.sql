CREATE TABLE [dbo].[EBS_Consolidated_ver3] (
    [MarketID]       INT           NULL,
    [Market]         VARCHAR (20)  NULL,
    [linevalue]      VARCHAR (20)  NULL,
    [line]           NVARCHAR (10) NULL,
    [Date1]          DATETIME      NULL,
    [ctod]           INT           NULL,
    [MonthNo]        INT           NULL,
    [yyyy]           SMALLINT      NULL,
    [metric]         VARCHAR (5)   NULL,
    [efdt]           DATETIME      NULL,
    [ALC_inTime]     INT           NULL,
    [Total]          INT           NULL,
    [FTR]            INT           NULL,
    [FTR_Total]      INT           NULL,
    [ason]           DATETIME      NULL,
    [wip_counts]     INT           NULL,
    [Pend_counts]    INT           NULL,
    [india_target]   INT           NULL,
    [subs_target]    INT           NULL,
    [overall_target] INT           NULL,
    [india_cl]       INT           NULL,
    [subs_cl]        INT           NULL,
    [overall_cl]     INT           NULL,
    [Targets]        INT           NULL,
    [Climits]        INT           NULL,
    [plinename]      VARCHAR (100) NULL,
    [pline]          INT           NULL,
    [finmonthno]     INT           NULL,
    [finyear]        INT           NULL,
    [justify]        VARCHAR (250) NULL,
    [justify_month]  VARCHAR (250) NULL,
    [Withintime]     INT           NULL
);


GO

