CREATE TABLE [dbo].[LN_TCIBD250] (
    [compnr]               BIGINT        NULL,
    [item]                 NVARCHAR (47) NULL,
    [site]                 NVARCHAR (9)  NULL,
    [omth]                 BIGINT        NULL,
    [omth_kw]              NVARCHAR (20) NULL,
    [cwar]                 NVARCHAR (6)  NULL,
    [oqmf]                 FLOAT (53)    NULL,
    [mioq]                 FLOAT (53)    NULL,
    [maoq]                 FLOAT (53)    NULL,
    [fioq]                 FLOAT (53)    NULL,
    [ecoq]                 FLOAT (53)    NULL,
    [reop]                 FLOAT (53)    NULL,
    [oint]                 FLOAT (53)    NULL,
    [oivu]                 BIGINT        NULL,
    [oivu_kw]              NVARCHAR (20) NULL,
    [ocst]                 FLOAT (53)    NULL,
    [sftm]                 FLOAT (53)    NULL,
    [tuni]                 BIGINT        NULL,
    [tuni_kw]              NVARCHAR (20) NULL,
    [serv]                 BIGINT        NULL,
    [sfst]                 FLOAT (53)    NULL,
    [maxs]                 FLOAT (53)    NULL,
    [csps]                 NVARCHAR (3)  NULL,
    [cspd]                 NVARCHAR (3)  NULL,
    [fodt]                 NVARCHAR (40) NULL,
    [auso]                 BIGINT        NULL,
    [auso_kw]              NVARCHAR (20) NULL,
    [rpoq]                 FLOAT (53)    NULL,
    [poqa]                 FLOAT (53)    NULL,
    [uaoq]                 BIGINT        NULL,
    [uaoq_kw]              NVARCHAR (20) NULL,
    [cplb]                 NVARCHAR (9)  NULL,
    [plpl]                 BIGINT        NULL,
    [plpl_kw]              NVARCHAR (20) NULL,
    [lodt]                 NVARCHAR (40) NULL,
    [ugio]                 BIGINT        NULL,
    [ugio_kw]              NVARCHAR (20) NULL,
    [iacs]                 BIGINT        NULL,
    [iacs_kw]              NVARCHAR (20) NULL,
    [item_site_ref_compnr] BIGINT        NULL,
    [item_ref_compnr]      BIGINT        NULL,
    [site_ref_compnr]      BIGINT        NULL,
    [cwar_ref_compnr]      BIGINT        NULL,
    [csps_ref_compnr]      BIGINT        NULL,
    [cspd_ref_compnr]      BIGINT        NULL,
    [cplb_ref_compnr]      BIGINT        NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCIBD250_lookup]
    ON [dbo].[LN_TCIBD250]([compnr] ASC, [item] ASC, [site] ASC);


GO

