CREATE TABLE [dbo].[LN_LPBRA001] (
    [compnr]         BIGINT        NULL,
    [fdtc]           NVARCHAR (10) NULL,
    [dsca]           NVARCHAR (30) NULL,
    [tror]           BIGINT        NULL,
    [tror_kw]        NVARCHAR (20) NULL,
    [rfdt]           BIGINT        NULL,
    [rfdt_kw]        NVARCHAR (26) NULL,
    [ifdt]           BIGINT        NULL,
    [ifdt_kw]        NVARCHAR (26) NULL,
    [fdtr]           NVARCHAR (10) NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_LPBRA001_lookup]
    ON [dbo].[LN_LPBRA001]([compnr] ASC, [fdtc] ASC);


GO

