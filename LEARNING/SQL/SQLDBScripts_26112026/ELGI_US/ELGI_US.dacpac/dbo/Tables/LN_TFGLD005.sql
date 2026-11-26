CREATE TABLE [dbo].[LN_TFGLD005] (
    [compnr]          BIGINT        NULL,
    [ptyp]            BIGINT        NULL,
    [year]            BIGINT        NULL,
    [prno]            BIGINT        NULL,
    [ptyp_kw]         NVARCHAR (20) NULL,
    [stdt]            NVARCHAR (10) NULL,
    [desc]            NVARCHAR (15) NULL,
    [corr]            BIGINT        NULL,
    [corr_kw]         NVARCHAR (20) NULL,
    [year_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFGLD005_lookup]
    ON [dbo].[LN_TFGLD005]([compnr] ASC, [ptyp] ASC, [year] ASC, [prno] ASC);


GO

