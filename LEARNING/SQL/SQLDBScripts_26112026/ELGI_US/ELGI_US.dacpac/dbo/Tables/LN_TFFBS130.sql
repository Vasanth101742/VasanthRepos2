CREATE TABLE [dbo].[LN_TFFBS130] (
    [compnr]                    BIGINT        NULL,
    [lcmp]                      BIGINT        NULL,
    [dtyp]                      BIGINT        NULL,
    [dimx]                      NVARCHAR (9)  NULL,
    [refu]                      NVARCHAR (3)  NULL,
    [sern]                      BIGINT        NULL,
    [oprc]                      NVARCHAR (6)  NULL,
    [citg]                      NVARCHAR (6)  NULL,
    [item]                      NVARCHAR (47) NULL,
    [cprj]                      NVARCHAR (9)  NULL,
    [cwar]                      NVARCHAR (6)  NULL,
    [remo]                      BIGINT        NULL,
    [remo_kw]                   NVARCHAR (20) NULL,
    [lcmp_ref_compnr]           BIGINT        NULL,
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

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFFBS130_lookup]
    ON [dbo].[LN_TFFBS130]([compnr] ASC, [lcmp] ASC, [dtyp] ASC, [dimx] ASC, [refu] ASC, [sern] ASC);


GO

