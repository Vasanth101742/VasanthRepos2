CREATE TABLE [dbo].[LN_TSCLM350] (
    [compnr]               BIGINT         NULL,
    [orig]                 BIGINT         NULL,
    [orno]                 NVARCHAR (9)   NULL,
    [acln]                 BIGINT         NULL,
    [ccll]                 NVARCHAR (9)   NULL,
    [hidt]                 NVARCHAR (40)  NULL,
    [orig_kw]              NVARCHAR (20)  NULL,
    [sigr]                 NVARCHAR (6)   NULL,
    [csgr]                 NVARCHAR (6)   NULL,
    [cgrp]                 NVARCHAR (3)   NULL,
    [scgr]                 NVARCHAR (3)   NULL,
    [ofbp]                 NVARCHAR (9)   NULL,
    [desc]                 NVARCHAR (50)  NULL,
    [clst]                 NVARCHAR (9)   NULL,
    [item]                 NVARCHAR (47)  NULL,
    [sern]                 NVARCHAR (30)  NULL,
    [rprl]                 NVARCHAR (10)  NULL,
    [expr]                 NVARCHAR (10)  NULL,
    [espr]                 NVARCHAR (10)  NULL,
    [exsl]                 NVARCHAR (10)  NULL,
    [sltn]                 NVARCHAR (10)  NULL,
    [crac]                 NVARCHAR (16)  NULL,
    [sear]                 NVARCHAR (132) NULL,
    [ccll_ref_compnr]      BIGINT         NULL,
    [sigr_ref_compnr]      BIGINT         NULL,
    [csgr_ref_compnr]      BIGINT         NULL,
    [cgrp_ref_compnr]      BIGINT         NULL,
    [scgr_ref_compnr]      BIGINT         NULL,
    [ofbp_ref_compnr]      BIGINT         NULL,
    [clst_ref_compnr]      BIGINT         NULL,
    [item_sern_ref_compnr] BIGINT         NULL,
    [item_ref_compnr]      BIGINT         NULL,
    [rprl_ref_compnr]      BIGINT         NULL,
    [expr_ref_compnr]      BIGINT         NULL,
    [espr_ref_compnr]      BIGINT         NULL,
    [exsl_ref_compnr]      BIGINT         NULL,
    [sltn_ref_compnr]      BIGINT         NULL,
    [crac_ref_compnr]      BIGINT         NULL,
    [deleted]              NCHAR (1)      NULL,
    [username]             NVARCHAR (8)   NULL,
    [timestamp]            DATETIME       NULL,
    [sequencenumber]       BIGINT         NULL,
    [dlDocumentDate]       NVARCHAR (40)  NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCLM350_lookup]
    ON [dbo].[LN_TSCLM350]([compnr] ASC, [orig] ASC, [orno] ASC, [acln] ASC, [ccll] ASC, [hidt] ASC);


GO

