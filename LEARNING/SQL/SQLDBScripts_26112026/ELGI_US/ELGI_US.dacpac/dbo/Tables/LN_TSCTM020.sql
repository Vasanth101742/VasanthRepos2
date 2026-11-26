CREATE TABLE [dbo].[LN_TSCTM020] (
    [compnr]          BIGINT        NULL,
    [cwte]            NVARCHAR (16) NULL,
    [desc]            NVARCHAR (30) NULL,
    [sear]            NVARCHAR (16) NULL,
    [term]            BIGINT        NULL,
    [srep]            NVARCHAR (9)  NULL,
    [wttp]            BIGINT        NULL,
    [wttp_kw]         NVARCHAR (20) NULL,
    [cwoc]            NVARCHAR (6)  NULL,
    [bfbp]            NVARCHAR (9)  NULL,
    [ccur]            NVARCHAR (3)  NULL,
    [wdtp]            BIGINT        NULL,
    [wdtp_kw]         NVARCHAR (25) NULL,
    [cdtp]            BIGINT        NULL,
    [cdtp_kw]         NVARCHAR (25) NULL,
    [wsdb]            BIGINT        NULL,
    [wsdb_kw]         NVARCHAR (25) NULL,
    [eset]            NVARCHAR (9)  NULL,
    [nrpe]            BIGINT        NULL,
    [peru]            BIGINT        NULL,
    [peru_kw]         NVARCHAR (20) NULL,
    [nrpp]            BIGINT        NULL,
    [perp]            BIGINT        NULL,
    [perp_kw]         NVARCHAR (20) NULL,
    [pwyn]            BIGINT        NULL,
    [pwyn_kw]         NVARCHAR (20) NULL,
    [apwr]            BIGINT        NULL,
    [apwr_kw]         NVARCHAR (20) NULL,
    [acws]            BIGINT        NULL,
    [acws_kw]         NVARCHAR (20) NULL,
    [swps]            BIGINT        NULL,
    [swps_kw]         NVARCHAR (20) NULL,
    [eftm]            NVARCHAR (10) NULL,
    [extm]            NVARCHAR (10) NULL,
    [txta]            BIGINT        NULL,
    [srep_ref_compnr] BIGINT        NULL,
    [cwoc_ref_compnr] BIGINT        NULL,
    [bfbp_ref_compnr] BIGINT        NULL,
    [ccur_ref_compnr] BIGINT        NULL,
    [eset_ref_compnr] BIGINT        NULL,
    [txta_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM020_lookup]
    ON [dbo].[LN_TSCTM020]([compnr] ASC, [cwte] ASC);


GO

