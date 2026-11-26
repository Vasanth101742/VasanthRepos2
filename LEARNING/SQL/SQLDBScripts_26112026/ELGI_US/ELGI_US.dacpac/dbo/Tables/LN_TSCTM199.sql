CREATE TABLE [dbo].[LN_TSCTM199] (
    [compnr]         BIGINT        NULL,
    [item]           NVARCHAR (47) NULL,
    [sern]           NVARCHAR (30) NULL,
    [term]           BIGINT        NULL,
    [wttp]           BIGINT        NULL,
    [wttp_kw]        NVARCHAR (20) NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM199_lookup]
    ON [dbo].[LN_TSCTM199]([compnr] ASC, [item] ASC, [sern] ASC, [term] ASC);


GO

