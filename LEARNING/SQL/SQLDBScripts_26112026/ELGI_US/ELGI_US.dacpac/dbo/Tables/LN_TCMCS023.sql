CREATE TABLE [dbo].[LN_TCMCS023] (
    [compnr]          BIGINT        NULL,
    [citg]            NVARCHAR (6)  NULL,
    [dsca]            NVARCHAR (30) NULL,
    [ccur]            NVARCHAR (3)  NULL,
    [spec]            BIGINT        NULL,
    [spec_kw]         NVARCHAR (20) NULL,
    [spco]            BIGINT        NULL,
    [spco_kw]         NVARCHAR (20) NULL,
    [ccur_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCMCS023_lookup]
    ON [dbo].[LN_TCMCS023]([compnr] ASC, [citg] ASC);


GO

