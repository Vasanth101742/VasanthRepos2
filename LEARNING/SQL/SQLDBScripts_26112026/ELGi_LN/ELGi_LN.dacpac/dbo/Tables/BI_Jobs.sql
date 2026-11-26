CREATE TABLE [dbo].[BI_Jobs] (
    [LogID]     INT          IDENTITY (1, 1) NOT NULL,
    [jobID]     VARCHAR (25) NULL,
    [JobName]   VARCHAR (50) NULL,
    [Status]    VARCHAR (25) NULL,
    [Load_date] DATETIME     NULL
);


GO

