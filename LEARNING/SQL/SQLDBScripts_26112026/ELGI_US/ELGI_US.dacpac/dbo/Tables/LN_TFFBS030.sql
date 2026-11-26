CREATE TABLE [dbo].[LN_TFFBS030] (
    [compnr]               BIGINT        NULL,
    [dtyp]                 BIGINT        NULL,
    [dimx]                 NVARCHAR (9)  NULL,
    [refu]                 NVARCHAR (3)  NULL,
    [desc]                 NVARCHAR (50) NULL,
    [rtyp]                 BIGINT        NULL,
    [rtyp_kw]              NVARCHAR (20) NULL,
    [ptyp]                 BIGINT        NULL,
    [ptyp_kw]              NVARCHAR (22) NULL,
    [llog]                 BIGINT        NULL,
    [llog_kw]              NVARCHAR (26) NULL,
    [rasu]                 BIGINT        NULL,
    [rasu_kw]              NVARCHAR (20) NULL,
    [quni]                 NVARCHAR (3)  NULL,
    [rlaq]                 BIGINT        NULL,
    [rlaq_kw]              NVARCHAR (20) NULL,
    [slea]                 NVARCHAR (12) NULL,
    [eqfa]                 BIGINT        NULL,
    [pdpa]                 BIGINT        NULL,
    [pdpa_kw]              NVARCHAR (20) NULL,
    [dtyp_dimx_ref_compnr] BIGINT        NULL,
    [dtyp_ref_compnr]      BIGINT        NULL,
    [quni_ref_compnr]      BIGINT        NULL,
    [slea_ref_compnr]      BIGINT        NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFFBS030_lookup]
    ON [dbo].[LN_TFFBS030]([compnr] ASC, [dtyp] ASC, [dimx] ASC, [refu] ASC);


GO

