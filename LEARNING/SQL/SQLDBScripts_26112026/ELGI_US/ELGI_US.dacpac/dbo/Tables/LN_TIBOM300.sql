CREATE TABLE [dbo].[LN_TIBOM300] (
    [compnr]               BIGINT          NULL,
    [site]                 NVARCHAR (9)    NULL,
    [mitm]                 NVARCHAR (47)   NULL,
    [bmdl]                 NVARCHAR (9)    NULL,
    [bmrv]                 NVARCHAR (6)    NULL,
    [rouc]                 NVARCHAR (9)    NULL,
    [unom]                 DECIMAL (12, 6) NULL,
    [ubun]                 BIGINT          NULL,
    [ubun_kw]              NVARCHAR (20)   NULL,
    [afpl]                 BIGINT          NULL,
    [afpl_kw]              NVARCHAR (20)   NULL,
    [ufpl]                 BIGINT          NULL,
    [ufpl_kw]              NVARCHAR (20)   NULL,
    [ufcs]                 BIGINT          NULL,
    [ufcs_kw]              NVARCHAR (20)   NULL,
    [bmst]                 BIGINT          NULL,
    [bmst_kw]              NVARCHAR (20)   NULL,
    [efdt]                 DATETIME        NULL,
    [exdt]                 DATETIME        NULL,
    [bmsc]                 BIGINT          NULL,
    [bmsc_kw]              NVARCHAR (22)   NULL,
    [scmi]                 NVARCHAR (47)   NULL,
    [smdl]                 NVARCHAR (9)    NULL,
    [scrv]                 NVARCHAR (6)    NULL,
    [cron]                 DATETIME        NULL,
    [crby]                 NVARCHAR (12)   NULL,
    [apon]                 DATETIME        NULL,
    [apby]                 NVARCHAR (12)   NULL,
    [exon]                 DATETIME        NULL,
    [exby]                 NVARCHAR (12)   NULL,
    [daon]                 DATETIME        NULL,
    [daby]                 NVARCHAR (12)   NULL,
    [chnt]                 NVARCHAR (9)    NULL,
    [txta]                 BIGINT          NULL,
    [site_ref_compnr]      BIGINT          NULL,
    [mitm_site_ref_compnr] BIGINT          NULL,
    [mitm_ref_compnr]      BIGINT          NULL,
    [chnt_ref_compnr]      BIGINT          NULL,
    [txta_ref_compnr]      BIGINT          NULL,
    [deleted]              NCHAR (1)       NULL,
    [username]             NVARCHAR (8)    NULL,
    [timestamp]            DATETIME        NULL,
    [sequencenumber]       BIGINT          NULL,
    [dlDocumentDate]       NVARCHAR (40)   NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TIBOM300_lookup]
    ON [dbo].[LN_TIBOM300]([compnr] ASC, [site] ASC, [mitm] ASC, [bmdl] ASC, [bmrv] ASC);


GO

