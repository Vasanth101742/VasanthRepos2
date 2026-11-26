CREATE TABLE [dbo].[LN_TSCTM003] (
    [compnr]               BIGINT        NULL,
    [soff]                 NVARCHAR (6)  NULL,
    [site]                 NVARCHAR (9)  NULL,
    [ugsp]                 BIGINT        NULL,
    [ugsp_kw]              NVARCHAR (20) NULL,
    [cgmc]                 BIGINT        NULL,
    [cgmc_kw]              NVARCHAR (20) NULL,
    [lwgm]                 FLOAT (53)    NULL,
    [upgm]                 FLOAT (53)    NULL,
    [gmba]                 BIGINT        NULL,
    [gmba_kw]              NVARCHAR (20) NULL,
    [grcq]                 NVARCHAR (3)  NULL,
    [sncq]                 NVARCHAR (8)  NULL,
    [grnr]                 NVARCHAR (3)  NULL,
    [snsc]                 NVARCHAR (8)  NULL,
    [ssqt]                 BIGINT        NULL,
    [ssct]                 BIGINT        NULL,
    [nrcp]                 BIGINT        NULL,
    [nrcc]                 BIGINT        NULL,
    [qvdy]                 BIGINT        NULL,
    [rvrc]                 BIGINT        NULL,
    [rvrc_kw]              NVARCHAR (25) NULL,
    [rvmd]                 BIGINT        NULL,
    [rvmd_kw]              NVARCHAR (25) NULL,
    [rrcr]                 BIGINT        NULL,
    [rrcr_kw]              NVARCHAR (20) NULL,
    [rccg]                 BIGINT        NULL,
    [rccg_kw]              NVARCHAR (20) NULL,
    [ccrv]                 BIGINT        NULL,
    [ccrv_kw]              NVARCHAR (20) NULL,
    [sscc]                 BIGINT        NULL,
    [sscq]                 BIGINT        NULL,
    [ssin]                 BIGINT        NULL,
    [upsc]                 BIGINT        NULL,
    [upsc_kw]              NVARCHAR (20) NULL,
    [ditc]                 BIGINT        NULL,
    [ditc_kw]              NVARCHAR (20) NULL,
    [ctin]                 NVARCHAR (3)  NULL,
    [ctyn]                 BIGINT        NULL,
    [ctyn_kw]              NVARCHAR (20) NULL,
    [ccte]                 NVARCHAR (16) NULL,
    [ctpc]                 NVARCHAR (3)  NULL,
    [soff_ref_compnr]      BIGINT        NULL,
    [site_ref_compnr]      BIGINT        NULL,
    [grcq_sncq_ref_compnr] BIGINT        NULL,
    [grcq_ref_compnr]      BIGINT        NULL,
    [grnr_snsc_ref_compnr] BIGINT        NULL,
    [grnr_ref_compnr]      BIGINT        NULL,
    [ctin_ref_compnr]      BIGINT        NULL,
    [ccte_ref_compnr]      BIGINT        NULL,
    [ctpc_ref_compnr]      BIGINT        NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM003_lookup]
    ON [dbo].[LN_TSCTM003]([compnr] ASC, [soff] ASC, [site] ASC);


GO

