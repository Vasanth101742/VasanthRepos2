CREATE TABLE [dbo].[alc_abnormality] (
    [alc_id]   INT             NULL,
    [pline]    DECIMAL (38)    NULL,
    [assembly] NVARCHAR (15)   NULL,
    [metrics]  NVARCHAR (10)   NULL,
    [redt]     DATETIME2 (0)   NULL,
    [justify]  NVARCHAR (1000) NULL,
    [updateby] NVARCHAR (10)   NULL,
    [updateon] DATETIME2 (0)   NULL
);


GO

