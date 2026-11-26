CREATE TABLE [dbo].[LN_TCMCS041] (
    [compnr]          BIGINT        NULL,
    [cdec]            NVARCHAR (3)  NULL,
    [dsca]            NVARCHAR (30) NULL,
    [cdyn]            BIGINT        NULL,
    [cdyn_kw]         NVARCHAR (20) NULL,
    [crpd]            BIGINT        NULL,
    [crpd_kw]         NVARCHAR (20) NULL,
    [cptp]            BIGINT        NULL,
    [cptp_kw]         NVARCHAR (20) NULL,
    [fcba]            NVARCHAR (9)  NULL,
    [potp]            BIGINT        NULL,
    [potp_kw]         NVARCHAR (20) NULL,
    [tdgp]            BIGINT        NULL,
    [tdgp_kw]         NVARCHAR (20) NULL,
    [spec]            BIGINT        NULL,
    [spec_kw]         NVARCHAR (26) NULL,
    [txta]            BIGINT        NULL,
    [fcba_ref_compnr] BIGINT        NULL,
    [txta_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCMCS041_lookup]
    ON [dbo].[LN_TCMCS041]([compnr] ASC, [cdec] ASC);


GO

