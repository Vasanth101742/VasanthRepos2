CREATE TABLE [dbo].[alc_metrics] (
    [pline]          SMALLINT      NULL,
    [assembly]       NVARCHAR (7)  NULL,
    [metric]         NVARCHAR (3)  NULL,
    [month]          NVARCHAR (3)  NULL,
    [year]           SMALLINT      NULL,
    [fdate]          DATETIME2 (0) NULL,
    [tdate]          DATETIME2 (0) NULL,
    [india_target]   FLOAT (53)    NULL,
    [subs_target]    FLOAT (53)    NULL,
    [overall_target] FLOAT (53)    NULL,
    [india_cl]       FLOAT (53)    NULL,
    [subs_cl]        FLOAT (53)    NULL,
    [overall_cl]     FLOAT (53)    NULL
);


GO

