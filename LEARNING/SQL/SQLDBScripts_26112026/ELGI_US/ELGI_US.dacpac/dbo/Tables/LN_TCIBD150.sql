CREATE TABLE [dbo].[LN_TCIBD150] (
    [compnr]               BIGINT          NULL,
    [item]                 NVARCHAR (47)   NULL,
    [site]                 NVARCHAR (9)    NULL,
    [uidt]                 BIGINT          NULL,
    [uidt_kw]              NVARCHAR (20)   NULL,
    [prdg]                 NVARCHAR (9)    NULL,
    [srce]                 BIGINT          NULL,
    [srce_kw]              NVARCHAR (20)   NULL,
    [efpr]                 BIGINT          NULL,
    [efpr_kw]              NVARCHAR (20)   NULL,
    [dscb]                 NVARCHAR (30)   NULL,
    [dscc]                 NVARCHAR (30)   NULL,
    [dscd]                 NVARCHAR (30)   NULL,
    [wght]                 DECIMAL (12, 6) NULL,
    [cwun]                 NVARCHAR (3)    NULL,
    [ctyp]                 NVARCHAR (3)    NULL,
    [cpcl]                 NVARCHAR (6)    NULL,
    [cpln]                 NVARCHAR (6)    NULL,
    [cmnf]                 NVARCHAR (6)    NULL,
    [csel]                 NVARCHAR (3)    NULL,
    [csig]                 NVARCHAR (3)    NULL,
    [rdpt]                 NVARCHAR (6)    NULL,
    [ctyo]                 NVARCHAR (3)    NULL,
    [envc]                 BIGINT          NULL,
    [envc_kw]              NVARCHAR (20)   NULL,
    [cean]                 NVARCHAR (14)   NULL,
    [ccde]                 NVARCHAR (25)   NULL,
    [icsi]                 BIGINT          NULL,
    [icsi_kw]              NVARCHAR (20)   NULL,
    [fstk]                 BIGINT          NULL,
    [fstk_kw]              NVARCHAR (20)   NULL,
    [txta]                 BIGINT          NULL,
    [item_ref_compnr]      BIGINT          NULL,
    [site_prdg_ref_compnr] BIGINT          NULL,
    [site_ref_compnr]      BIGINT          NULL,
    [cwun_ref_compnr]      BIGINT          NULL,
    [ctyp_ref_compnr]      BIGINT          NULL,
    [cpcl_ref_compnr]      BIGINT          NULL,
    [cpln_ref_compnr]      BIGINT          NULL,
    [cmnf_ref_compnr]      BIGINT          NULL,
    [csel_ref_compnr]      BIGINT          NULL,
    [csig_ref_compnr]      BIGINT          NULL,
    [rdpt_ref_compnr]      BIGINT          NULL,
    [ctyo_ref_compnr]      BIGINT          NULL,
    [ccde_ref_compnr]      BIGINT          NULL,
    [txta_ref_compnr]      BIGINT          NULL,
    [deleted]              NCHAR (1)       NULL,
    [username]             NVARCHAR (8)    NULL,
    [timestamp]            DATETIME        NULL,
    [sequencenumber]       BIGINT          NULL,
    [dlDocumentDate]       NVARCHAR (40)   NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCIBD150_lookup]
    ON [dbo].[LN_TCIBD150]([compnr] ASC, [item] ASC, [site] ASC);


GO

