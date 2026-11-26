CREATE TABLE [dbo].[LN_TCMCS003] (
    [compnr]          BIGINT        NULL,
    [cwar]            NVARCHAR (6)  NULL,
    [dsca]            NVARCHAR (30) NULL,
    [cadr]            NVARCHAR (9)  NULL,
    [typw]            BIGINT        NULL,
    [typw_kw]         NVARCHAR (22) NULL,
    [cprj]            NVARCHAR (9)  NULL,
    [bpid]            NVARCHAR (9)  NULL,
    [comp]            BIGINT        NULL,
    [wmsc]            BIGINT        NULL,
    [wmsc_kw]         NVARCHAR (20) NULL,
    [mesc]            BIGINT        NULL,
    [mesc_kw]         NVARCHAR (20) NULL,
    [casi]            NVARCHAR (3)  NULL,
    [inep]            BIGINT        NULL,
    [inep_kw]         NVARCHAR (20) NULL,
    [imgt]            BIGINT        NULL,
    [imgt_kw]         NVARCHAR (20) NULL,
    [imbp]            NVARCHAR (9)  NULL,
    [xsit]            BIGINT        NULL,
    [xsit_kw]         NVARCHAR (20) NULL,
    [xsbp]            NVARCHAR (9)  NULL,
    [sfbp]            NVARCHAR (9)  NULL,
    [otbp]            NVARCHAR (9)  NULL,
    [stbp]            NVARCHAR (9)  NULL,
    [ofbp]            NVARCHAR (9)  NULL,
    [clan]            NVARCHAR (3)  NULL,
    [pwip]            BIGINT        NULL,
    [pwip_kw]         NVARCHAR (20) NULL,
    [swhu]            BIGINT        NULL,
    [swhu_kw]         NVARCHAR (20) NULL,
    [duns]            BIGINT        NULL,
    [cdf_itsl]        BIGINT        NULL,
    [cdf_itsl_kw]     NVARCHAR (20) NULL,
    [cdf_otyp]        NVARCHAR (3)  NULL,
    [cadr_ref_compnr] BIGINT        NULL,
    [cprj_ref_compnr] BIGINT        NULL,
    [casi_ref_compnr] BIGINT        NULL,
    [imbp_ref_compnr] BIGINT        NULL,
    [xsbp_ref_compnr] BIGINT        NULL,
    [sfbp_ref_compnr] BIGINT        NULL,
    [otbp_ref_compnr] BIGINT        NULL,
    [stbp_ref_compnr] BIGINT        NULL,
    [ofbp_ref_compnr] BIGINT        NULL,
    [clan_ref_compnr] BIGINT        NULL,
    [cwar_eunt]       NVARCHAR (6)  NULL,
    [eunt_rcmp]       BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCMCS003_lookup]
    ON [dbo].[LN_TCMCS003]([compnr] ASC, [cwar] ASC);


GO

