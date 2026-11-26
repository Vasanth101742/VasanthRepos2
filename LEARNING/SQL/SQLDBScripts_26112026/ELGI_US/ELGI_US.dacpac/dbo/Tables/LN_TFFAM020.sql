CREATE TABLE [dbo].[LN_TFFAM020] (
    [compnr]         BIGINT        NULL,
    [srnb]           BIGINT        NULL,
    [sbok]           NVARCHAR (10) NULL,
    [dcmp]           BIGINT        NULL,
    [dbok]           NVARCHAR (10) NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFFAM020_lookup]
    ON [dbo].[LN_TFFAM020]([compnr] ASC, [srnb] ASC);


GO

