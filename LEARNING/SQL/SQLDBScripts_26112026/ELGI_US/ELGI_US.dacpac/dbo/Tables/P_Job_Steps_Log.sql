CREATE TABLE [dbo].[P_Job_Steps_Log] (
    [ID_BATCH]        INT            NULL,
    [CHANNEL_ID]      NVARCHAR (255) NULL,
    [LOG_DATE]        DATETIME       NULL,
    [TRANSNAME]       NVARCHAR (255) NULL,
    [STEPNAME]        NVARCHAR (255) NULL,
    [LINES_READ]      INT            NULL,
    [LINES_WRITTEN]   INT            NULL,
    [LINES_UPDATED]   INT            NULL,
    [LINES_INPUT]     INT            NULL,
    [LINES_OUTPUT]    INT            NULL,
    [LINES_REJECTED]  INT            NULL,
    [ERRORS]          INT            NULL,
    [RESULT]          NCHAR (1)      NULL,
    [NR_RESULT_ROWS]  INT            NULL,
    [NR_RESULT_FILES] INT            NULL,
    [LOG_FIELD]       NVARCHAR (MAX) NULL,
    [COPY_NR]         INT            NULL
);


GO

CREATE NONCLUSTERED INDEX [IDX_P_Job_Steps_Log_1]
    ON [dbo].[P_Job_Steps_Log]([ID_BATCH] ASC);


GO

