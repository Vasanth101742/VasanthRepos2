CREATE TABLE [dbo].[subscription_log_Status] (
    [LogID]      INT          IDENTITY (1, 1) NOT NULL,
    [jobID]      VARCHAR (25) NULL,
    [JobName]    VARCHAR (50) NULL,
    [Status]     VARCHAR (25) NULL,
    [START_DATE] DATETIME     NULL,
    [END_DATE]   DATETIME     NULL
);


GO

