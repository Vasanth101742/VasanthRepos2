CREATE TABLE [dbo].[LN_TCMCS022] (
    [compnr]         BIGINT        NULL,
    [csel]           NVARCHAR (3)  NULL,
    [dsca]           NVARCHAR (30) NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCMCS022_lookup]
    ON [dbo].[LN_TCMCS022]([compnr] ASC, [csel] ASC);


GO

