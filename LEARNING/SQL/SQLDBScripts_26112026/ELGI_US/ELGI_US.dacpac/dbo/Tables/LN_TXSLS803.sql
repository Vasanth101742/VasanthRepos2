CREATE TABLE [dbo].[LN_TXSLS803] (
    [compnr]          BIGINT        NULL,
    [ccty]            NVARCHAR (3)  NULL,
    [cste]            NVARCHAR (3)  NULL,
    [dsca]            NVARCHAR (30) NULL,
    [teri]            BIGINT        NULL,
    [teri_kw]         NVARCHAR (20) NULL,
    [emno]            NVARCHAR (9)  NULL,
    [logn]            NVARCHAR (20) NULL,
    [updt]            NVARCHAR (40) NULL,
    [exno]            NVARCHAR (9)  NULL,
    [ccty_ref_compnr] BIGINT        NULL,
    [emno_ref_compnr] BIGINT        NULL,
    [exno_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TXSLS803_lookup]
    ON [dbo].[LN_TXSLS803]([compnr] ASC, [ccty] ASC, [cste] ASC);


GO

