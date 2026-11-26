CREATE TABLE [dbo].[P_Job_Log] (
    [ID_JOB]           INT            NULL,
    [CHANNEL_ID]       NVARCHAR (255) NULL,
    [JOBNAME]          NVARCHAR (255) NULL,
    [STATUS]           NVARCHAR (15)  NULL,
    [LINES_READ]       INT            NULL,
    [LINES_WRITTEN]    INT            NULL,
    [LINES_UPDATED]    INT            NULL,
    [LINES_INPUT]      INT            NULL,
    [LINES_OUTPUT]     INT            NULL,
    [LINES_REJECTED]   INT            NULL,
    [ERRORS]           INT            NULL,
    [STARTDATE]        DATETIME       NULL,
    [ENDDATE]          DATETIME       NULL,
    [LOGDATE]          DATETIME       NULL,
    [DEPDATE]          DATETIME       NULL,
    [REPLAYDATE]       DATETIME       NULL,
    [LOG_FIELD]        NVARCHAR (MAX) NULL,
    [EXECUTING_SERVER] NVARCHAR (255) NULL,
    [EXECUTING_USER]   NVARCHAR (255) NULL,
    [START_JOB_ENTRY]  NVARCHAR (255) NULL,
    [CLIENT]           NVARCHAR (255) NULL
);


GO

CREATE NONCLUSTERED INDEX [IDX_P_Job_Log_1]
    ON [dbo].[P_Job_Log]([ID_JOB] ASC);


GO

CREATE NONCLUSTERED INDEX [IDX_P_Job_Log_2]
    ON [dbo].[P_Job_Log]([ERRORS] ASC, [STATUS] ASC, [JOBNAME] ASC);


GO

