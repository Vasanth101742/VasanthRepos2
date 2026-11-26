CREATE TABLE [dbo].[LN_TFGLD450] (
    [compnr]         BIGINT        NULL,
    [indt]           NVARCHAR (40) NULL,
    [dsca]           NVARCHAR (50) NULL,
    [sern]           BIGINT        NULL,
    [hdoc]           BIGINT        NULL,
    [hdoc_kw]        NVARCHAR (23) NULL,
    [htyp]           BIGINT        NULL,
    [htyp_kw]        NVARCHAR (24) NULL,
    [pnop]           BIGINT        NULL,
    [pnop_kw]        NVARCHAR (20) NULL,
    [acsq]           BIGINT        NULL,
    [asei]           BIGINT        NULL,
    [upei]           BIGINT        NULL,
    [upei_kw]        NVARCHAR (20) NULL,
    [dtrt]           NVARCHAR (3)  NULL,
    [dtts]           BIGINT        NULL,
    [dlep]           BIGINT        NULL,
    [dlep_kw]        NVARCHAR (20) NULL,
    [clha]           BIGINT        NULL,
    [clha_kw]        NVARCHAR (26) NULL,
    [pech]           BIGINT        NULL,
    [pech_kw]        NVARCHAR (24) NULL,
    [umsa]           BIGINT        NULL,
    [umsa_kw]        NVARCHAR (20) NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFGLD450_lookup]
    ON [dbo].[LN_TFGLD450]([compnr] ASC, [indt] ASC);


GO

