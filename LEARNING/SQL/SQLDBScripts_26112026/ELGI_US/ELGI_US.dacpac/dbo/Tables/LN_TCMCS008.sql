CREATE TABLE [dbo].[LN_TCMCS008] (
    [compnr]          BIGINT        NULL,
    [bcur]            NVARCHAR (3)  NULL,
    [ccur]            NVARCHAR (3)  NULL,
    [rtyp]            NVARCHAR (3)  NULL,
    [stdt]            NVARCHAR (40) NULL,
    [rate]            FLOAT (53)    NULL,
    [ratf]            BIGINT        NULL,
    [excb]            BIGINT        NULL,
    [excb_kw]         NVARCHAR (20) NULL,
    [rapr]            BIGINT        NULL,
    [rapr_kw]         NVARCHAR (20) NULL,
    [apdt]            NVARCHAR (40) NULL,
    [endt]            NVARCHAR (40) NULL,
    [bcur_ref_compnr] BIGINT        NULL,
    [ccur_ref_compnr] BIGINT        NULL,
    [rtyp_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCMCS008_lookup]
    ON [dbo].[LN_TCMCS008]([compnr] ASC, [bcur] ASC, [ccur] ASC, [rtyp] ASC, [stdt] ASC);


GO

