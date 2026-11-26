CREATE TABLE [dbo].[LN_TFGLD025] (
    [compnr]         BIGINT        NULL,
    [susr]           NVARCHAR (16) NULL,
    [fown]           BIGINT        NULL,
    [fown_kw]        NVARCHAR (20) NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFGLD025_lookup]
    ON [dbo].[LN_TFGLD025]([compnr] ASC, [susr] ASC);


GO

