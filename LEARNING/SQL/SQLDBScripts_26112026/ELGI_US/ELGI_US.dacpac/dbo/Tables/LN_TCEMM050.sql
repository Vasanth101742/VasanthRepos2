CREATE TABLE [dbo].[LN_TCEMM050] (
    [compnr]          BIGINT         NULL,
    [site]            NVARCHAR (9)   NULL,
    [desc]            NVARCHAR (50)  NULL,
    [stat]            BIGINT         NULL,
    [stat_kw]         NVARCHAR (26)  NULL,
    [lcmp]            BIGINT         NULL,
    [cadr]            NVARCHAR (9)   NULL,
    [admo]            BIGINT         NULL,
    [admo_kw]         NVARCHAR (20)  NULL,
    [clus]            NVARCHAR (3)   NULL,
    [ccal]            NVARCHAR (9)   NULL,
    [ract]            NVARCHAR (6)   NULL,
    [eunt]            NVARCHAR (6)   NULL,
    [cwar]            NVARCHAR (6)   NULL,
    [xsit]            BIGINT         NULL,
    [xsit_kw]         NVARCHAR (20)  NULL,
    [subs]            BIGINT         NULL,
    [subs_kw]         NVARCHAR (20)  NULL,
    [bpid]            NVARCHAR (9)   NULL,
    [sfbp]            NVARCHAR (9)   NULL,
    [cust]            BIGINT         NULL,
    [cust_kw]         NVARCHAR (20)  NULL,
    [ofbp]            NVARCHAR (9)   NULL,
    [stbp]            NVARCHAR (9)   NULL,
    [expl]            BIGINT         NULL,
    [expl_kw]         NVARCHAR (20)  NULL,
    [scat]            NVARCHAR (9)   NULL,
    [psit]            NVARCHAR (9)   NULL,
    [crdt]            NVARCHAR (40)  NULL,
    [crby]            NVARCHAR (16)  NULL,
    [inf1]            NVARCHAR (100) NULL,
    [inf2]            NVARCHAR (100) NULL,
    [imag]            NVARCHAR (22)  NULL,
    [txta]            BIGINT         NULL,
    [cdf_fgrc]        BIGINT         NULL,
    [cdf_fgrc_kw]     NVARCHAR (20)  NULL,
    [lcmp_ref_compnr] BIGINT         NULL,
    [cadr_ref_compnr] BIGINT         NULL,
    [clus_ref_compnr] BIGINT         NULL,
    [ccal_ref_compnr] BIGINT         NULL,
    [ract_ref_compnr] BIGINT         NULL,
    [eunt_ref_compnr] BIGINT         NULL,
    [cwar_ref_compnr] BIGINT         NULL,
    [bpid_ref_compnr] BIGINT         NULL,
    [sfbp_ref_compnr] BIGINT         NULL,
    [ofbp_ref_compnr] BIGINT         NULL,
    [stbp_ref_compnr] BIGINT         NULL,
    [scat_ref_compnr] BIGINT         NULL,
    [psit_ref_compnr] BIGINT         NULL,
    [txta_ref_compnr] BIGINT         NULL,
    [deleted]         NCHAR (1)      NULL,
    [username]        NVARCHAR (8)   NULL,
    [timestamp]       DATETIME       NULL,
    [sequencenumber]  BIGINT         NULL,
    [dlDocumentDate]  NVARCHAR (40)  NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCEMM050_lookup]
    ON [dbo].[LN_TCEMM050]([compnr] ASC, [site] ASC);


GO

