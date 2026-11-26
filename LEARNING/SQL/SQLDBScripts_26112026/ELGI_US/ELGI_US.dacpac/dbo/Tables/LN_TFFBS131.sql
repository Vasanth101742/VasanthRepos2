CREATE TABLE [dbo].[LN_TFFBS131] (
    [compnr]                    BIGINT        NULL,
    [lcmp]                      BIGINT        NULL,
    [leac]                      NVARCHAR (12) NULL,
    [dtyp]                      BIGINT        NULL,
    [dimx]                      NVARCHAR (9)  NULL,
    [refu]                      NVARCHAR (3)  NULL,
    [vaco]                      BIGINT        NULL,
    [vaco_kw]                   NVARCHAR (20) NULL,
    [cpcp]                      NVARCHAR (8)  NULL,
    [orty]                      BIGINT        NULL,
    [orty_kw]                   NVARCHAR (21) NULL,
    [sccp]                      NVARCHAR (8)  NULL,
    [lcmp_ref_compnr]           BIGINT        NULL,
    [leac_ref_compnr]           BIGINT        NULL,
    [dtyp_dimx_ref_compnr]      BIGINT        NULL,
    [dtyp_dimx_refu_ref_compnr] BIGINT        NULL,
    [dtyp_ref_compnr]           BIGINT        NULL,
    [deleted]                   NCHAR (1)     NULL,
    [username]                  NVARCHAR (8)  NULL,
    [timestamp]                 DATETIME      NULL,
    [sequencenumber]            BIGINT        NULL,
    [dlDocumentDate]            NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFFBS131_lookup]
    ON [dbo].[LN_TFFBS131]([compnr] ASC, [lcmp] ASC, [leac] ASC, [dtyp] ASC, [dimx] ASC, [refu] ASC, [vaco] ASC);


GO

