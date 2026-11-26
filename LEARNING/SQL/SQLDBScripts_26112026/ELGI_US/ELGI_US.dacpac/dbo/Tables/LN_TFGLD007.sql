CREATE TABLE [dbo].[LN_TFGLD007] (
    [compnr]                    BIGINT        NULL,
    [ptyp]                      BIGINT        NULL,
    [year]                      BIGINT        NULL,
    [prno]                      BIGINT        NULL,
    [ptyp_kw]                   NVARCHAR (20) NULL,
    [sacp]                      BIGINT        NULL,
    [sacp_kw]                   NVARCHAR (25) NULL,
    [dacp]                      NVARCHAR (40) NULL,
    [uacp]                      NVARCHAR (16) NULL,
    [sacr]                      BIGINT        NULL,
    [sacr_kw]                   NVARCHAR (25) NULL,
    [dacr]                      NVARCHAR (40) NULL,
    [uacr]                      NVARCHAR (16) NULL,
    [scmg]                      BIGINT        NULL,
    [scmg_kw]                   NVARCHAR (25) NULL,
    [dcmg]                      NVARCHAR (40) NULL,
    [ucmg]                      NVARCHAR (16) NULL,
    [sgld]                      BIGINT        NULL,
    [sgld_kw]                   NVARCHAR (25) NULL,
    [dgld]                      NVARCHAR (40) NULL,
    [ugld]                      NVARCHAR (16) NULL,
    [sint]                      BIGINT        NULL,
    [sint_kw]                   NVARCHAR (25) NULL,
    [dint]                      NVARCHAR (40) NULL,
    [uint]                      NVARCHAR (16) NULL,
    [ptyp_year_prno_ref_compnr] BIGINT        NULL,
    [year_ref_compnr]           BIGINT        NULL,
    [deleted]                   NCHAR (1)     NULL,
    [username]                  NVARCHAR (8)  NULL,
    [timestamp]                 DATETIME      NULL,
    [sequencenumber]            BIGINT        NULL,
    [dlDocumentDate]            NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFGLD007_lookup]
    ON [dbo].[LN_TFGLD007]([compnr] ASC, [ptyp] ASC, [year] ASC, [prno] ASC);


GO

