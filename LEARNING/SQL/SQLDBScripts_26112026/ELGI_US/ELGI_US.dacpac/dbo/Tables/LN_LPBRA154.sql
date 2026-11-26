CREATE TABLE [dbo].[LN_LPBRA154] (
    [compnr]         BIGINT        NULL,
    [fire]           NVARCHAR (9)  NULL,
    [ttyp]           NVARCHAR (3)  NULL,
    [ninv]           BIGINT        NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_LPBRA154_lookup]
    ON [dbo].[LN_LPBRA154]([compnr] ASC, [fire] ASC, [ttyp] ASC, [ninv] ASC);


GO

