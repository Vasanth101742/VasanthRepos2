CREATE TABLE [dbo].[LN_TFFST000] (
    [compnr]         BIGINT        NULL,
    [indt]           NVARCHAR (40) NULL,
    [dsca]           NVARCHAR (50) NULL,
    [relb]           NVARCHAR (3)  NULL,
    [nyrh]           BIGINT        NULL,
    [babd]           BIGINT        NULL,
    [babd_kw]        NVARCHAR (20) NULL,
    [erpt]           BIGINT        NULL,
    [erpt_kw]        NVARCHAR (20) NULL,
    [dtln]           BIGINT        NULL,
    [mstt]           BIGINT        NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFFST000_lookup]
    ON [dbo].[LN_TFFST000]([compnr] ASC, [indt] ASC);


GO

