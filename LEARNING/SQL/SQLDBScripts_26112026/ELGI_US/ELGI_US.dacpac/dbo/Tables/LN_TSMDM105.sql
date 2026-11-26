CREATE TABLE [dbo].[LN_TSMDM105] (
    [compnr]          BIGINT        NULL,
    [csar]            NVARCHAR (3)  NULL,
    [desc]            NVARCHAR (30) NULL,
    [artp]            BIGINT        NULL,
    [artp_kw]         NVARCHAR (20) NULL,
    [cmsa]            NVARCHAR (3)  NULL,
    [cwoc]            NVARCHAR (6)  NULL,
    [cwar]            NVARCHAR (6)  NULL,
    [trti]            FLOAT (53)    NULL,
    [dist]            FLOAT (53)    NULL,
    [ccha]            FLOAT (53)    NULL,
    [ccur]            NVARCHAR (3)  NULL,
    [clrt]            NVARCHAR (6)  NULL,
    [cmsa_ref_compnr] BIGINT        NULL,
    [cwoc_ref_compnr] BIGINT        NULL,
    [cwar_ref_compnr] BIGINT        NULL,
    [ccur_ref_compnr] BIGINT        NULL,
    [clrt_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSMDM105_lookup]
    ON [dbo].[LN_TSMDM105]([compnr] ASC, [csar] ASC);


GO

