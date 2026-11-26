CREATE TABLE [dbo].[P_STEPS_LOG] (
    [ID_BATCH]       INT            NULL,
    [CHANNEL_ID]     NVARCHAR (255) NULL,
    [LOG_DATE]       DATETIME       NULL,
    [TRANSNAME]      NVARCHAR (255) NULL,
    [STEPNAME]       NVARCHAR (255) NULL,
    [STEP_COPY]      INT            NULL,
    [LINES_READ]     BIGINT         NULL,
    [LINES_WRITTEN]  BIGINT         NULL,
    [LINES_UPDATED]  BIGINT         NULL,
    [LINES_INPUT]    BIGINT         NULL,
    [LINES_OUTPUT]   BIGINT         NULL,
    [LINES_REJECTED] BIGINT         NULL,
    [ERRORS]         BIGINT         NULL,
    [LOG_FIELD]      NVARCHAR (MAX) NULL
);


GO

