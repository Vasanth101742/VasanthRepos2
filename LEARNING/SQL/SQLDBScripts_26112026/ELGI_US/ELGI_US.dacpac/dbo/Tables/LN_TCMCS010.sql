CREATE TABLE [dbo].[LN_TCMCS010] (
    [compnr]          BIGINT        NULL,
    [ccty]            NVARCHAR (3)  NULL,
    [dsca]            NVARCHAR (30) NULL,
    [ictc]            NVARCHAR (3)  NULL,
    [tfcd]            NVARCHAR (6)  NULL,
    [txcd]            NVARCHAR (6)  NULL,
    [fxcd]            NVARCHAR (6)  NULL,
    [ssgn]            NVARCHAR (1)  NULL,
    [esgn]            NVARCHAR (1)  NULL,
    [xsgn]            NVARCHAR (1)  NULL,
    [meec]            BIGINT        NULL,
    [meec_kw]         NVARCHAR (20) NULL,
    [geoc]            NVARCHAR (3)  NULL,
    [pltx]            BIGINT        NULL,
    [pltx_kw]         NVARCHAR (20) NULL,
    [ptta]            BIGINT        NULL,
    [ptta_kw]         NVARCHAR (20) NULL,
    [txmp]            BIGINT        NULL,
    [txmp_kw]         NVARCHAR (20) NULL,
    [coaf]            NVARCHAR (3)  NULL,
    [afal]            NVARCHAR (3)  NULL,
    [zmsk]            NVARCHAR (10) NULL,
    [ppcd]            BIGINT        NULL,
    [cgp1]            NVARCHAR (3)  NULL,
    [cgp2]            NVARCHAR (3)  NULL,
    [vnch]            BIGINT        NULL,
    [vnch_kw]         NVARCHAR (20) NULL,
    [bnch]            BIGINT        NULL,
    [bnch_kw]         NVARCHAR (22) NULL,
    [awtn]            BIGINT        NULL,
    [awtn_kw]         NVARCHAR (20) NULL,
    [tzid]            NVARCHAR (3)  NULL,
    [clan]            NVARCHAR (3)  NULL,
    [ict2]            NVARCHAR (2)  NULL,
    [ccur]            NVARCHAR (3)  NULL,
    [natl]            NVARCHAR (40) NULL,
    [ivrc]            NVARCHAR (3)  NULL,
    [uarc]            BIGINT        NULL,
    [uarc_kw]         NVARCHAR (20) NULL,
    [coaf_ref_compnr] BIGINT        NULL,
    [afal_ref_compnr] BIGINT        NULL,
    [cgp1_ref_compnr] BIGINT        NULL,
    [cgp2_ref_compnr] BIGINT        NULL,
    [tzid_ref_compnr] BIGINT        NULL,
    [clan_ref_compnr] BIGINT        NULL,
    [ccur_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCMCS010_lookup]
    ON [dbo].[LN_TCMCS010]([compnr] ASC, [ccty] ASC);


GO

