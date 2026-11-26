CREATE TABLE [dbo].[LN_TSMDM140] (
    [compnr]          BIGINT        NULL,
    [emno]            NVARCHAR (9)  NULL,
    [csar]            NVARCHAR (3)  NULL,
    [ccar]            NVARCHAR (10) NULL,
    [mopd]            FLOAT (53)    NULL,
    [pgen]            BIGINT        NULL,
    [pgen_kw]         NVARCHAR (20) NULL,
    [asmc]            NVARCHAR (3)  NULL,
    [nots]            NVARCHAR (50) NULL,
    [lsdt]            NVARCHAR (40) NULL,
    [ucts]            BIGINT        NULL,
    [ucts_kw]         NVARCHAR (20) NULL,
    [frmn]            NVARCHAR (9)  NULL,
    [emno_ref_compnr] BIGINT        NULL,
    [csar_ref_compnr] BIGINT        NULL,
    [ccar_ref_compnr] BIGINT        NULL,
    [asmc_ref_compnr] BIGINT        NULL,
    [frmn_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSMDM140_lookup]
    ON [dbo].[LN_TSMDM140]([compnr] ASC, [emno] ASC);


GO

