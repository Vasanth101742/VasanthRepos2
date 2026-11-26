CREATE TABLE [dbo].[LN_TFGLD001] (
    [compnr]         BIGINT        NULL,
    [ncmp]           BIGINT        NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFGLD001_lookup]
    ON [dbo].[LN_TFGLD001]([compnr] ASC, [ncmp] ASC);


GO

