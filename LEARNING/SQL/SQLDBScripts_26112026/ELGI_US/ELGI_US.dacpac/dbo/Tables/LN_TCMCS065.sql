CREATE TABLE [dbo].[LN_TCMCS065] (
    [compnr]          BIGINT        NULL,
    [cwoc]            NVARCHAR (6)  NULL,
    [dsca]            NVARCHAR (30) NULL,
    [typd]            BIGINT        NULL,
    [typd_kw]         NVARCHAR (22) NULL,
    [comp]            BIGINT        NULL,
    [ccal]            NVARCHAR (9)  NULL,
    [cadr]            NVARCHAR (9)  NULL,
    [city]            NVARCHAR (30) NULL,
    [casi]            NVARCHAR (3)  NULL,
    [emno]            NVARCHAR (9)  NULL,
    [ract]            NVARCHAR (6)  NULL,
    [clrt]            NVARCHAR (6)  NULL,
    [site]            NVARCHAR (9)  NULL,
    [ccal_ref_compnr] BIGINT        NULL,
    [cadr_ref_compnr] BIGINT        NULL,
    [casi_ref_compnr] BIGINT        NULL,
    [emno_ref_compnr] BIGINT        NULL,
    [ract_ref_compnr] BIGINT        NULL,
    [clrt_ref_compnr] BIGINT        NULL,
    [site_ref_compnr] BIGINT        NULL,
    [cwoc_eunt]       NVARCHAR (6)  NULL,
    [eunt_rcmp]       BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCMCS065_lookup]
    ON [dbo].[LN_TCMCS065]([compnr] ASC, [cwoc] ASC);


GO

