CREATE TABLE [dbo].[LN_TSCTM005] (
    [compnr]         BIGINT        NULL,
    [ctpc]           NVARCHAR (3)  NULL,
    [desc]           NVARCHAR (30) NULL,
    [txin]           BIGINT        NULL,
    [txin_kw]        NVARCHAR (20) NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM005_lookup]
    ON [dbo].[LN_TSCTM005]([compnr] ASC, [ctpc] ASC);


GO

