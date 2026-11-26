CREATE TABLE [dbo].[EBS_Tgts_Clmts] (
    [ASSEMBLY] NVARCHAR (20) NULL,
    [PLINE]    SMALLINT      NULL,
    [METRIC]   NVARCHAR (3)  NULL,
    [MONTH]    NVARCHAR (3)  NULL,
    [YEAR]     SMALLINT      NULL,
    [FDATE]    DATETIME      NULL,
    [TDATE]    DATETIME      NULL,
    [Market]   VARCHAR (20)  NULL,
    [Targets]  FLOAT (53)    NULL,
    [CLimits]  FLOAT (53)    NULL
);


GO

