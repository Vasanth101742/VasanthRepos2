CREATE TABLE [dbo].[LN_TFFBS001] (
    [compnr]         BIGINT        NULL,
    [disb]           NVARCHAR (3)  NULL,
    [desc]           NVARCHAR (50) NULL,
    [dism]           BIGINT        NULL,
    [dism_kw]        NVARCHAR (21) NULL,
    [ndpr]           BIGINT        NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFFBS001_lookup]
    ON [dbo].[LN_TFFBS001]([compnr] ASC, [disb] ASC);


GO

