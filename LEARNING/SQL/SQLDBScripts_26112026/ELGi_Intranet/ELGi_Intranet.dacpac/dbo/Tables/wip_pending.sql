CREATE TABLE [dbo].[wip_pending] (
    [pdno]      NVARCHAR (9)  NULL,
    [mitem]     NVARCHAR (16) NULL,
    [efdt]      DATETIME2 (0) NULL,
    [ostat]     SMALLINT      NULL,
    [cmp]       SMALLINT      NULL,
    [cmdt]      DATETIME2 (0) NULL,
    [shortage]  NVARCHAR (1)  NULL,
    [warehouse] NVARCHAR (3)  NULL,
    [ason]      DATETIME2 (0) NULL
);


GO

