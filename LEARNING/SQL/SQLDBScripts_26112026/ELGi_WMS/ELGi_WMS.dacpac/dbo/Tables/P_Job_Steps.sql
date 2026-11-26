CREATE TABLE [dbo].[P_Job_Steps] (
    [ID_BATCH]        INT            NULL,
    [CHANNEL_ID]      NVARCHAR (255) NULL,
    [LOG_DATE]        DATETIME       NULL,
    [TRANSNAME]       NVARCHAR (255) NULL,
    [STEPNAME]        NVARCHAR (255) NULL,
    [LINES_READ]      BIGINT         NULL,
    [LINES_WRITTEN]   BIGINT         NULL,
    [LINES_UPDATED]   BIGINT         NULL,
    [LINES_INPUT]     BIGINT         NULL,
    [LINES_OUTPUT]    BIGINT         NULL,
    [LINES_REJECTED]  BIGINT         NULL,
    [ERRORS]          BIGINT         NULL,
    [RESULT]          NCHAR (1)      NULL,
    [NR_RESULT_ROWS]  BIGINT         NULL,
    [NR_RESULT_FILES] BIGINT         NULL,
    [LOG_FIELD]       NVARCHAR (MAX) NULL,
    [COPY_NR]         INT            NULL
);


GO

CREATE NONCLUSTERED INDEX [IDX_P_Job_Steps_1]
    ON [dbo].[P_Job_Steps]([ID_BATCH] ASC);


GO

