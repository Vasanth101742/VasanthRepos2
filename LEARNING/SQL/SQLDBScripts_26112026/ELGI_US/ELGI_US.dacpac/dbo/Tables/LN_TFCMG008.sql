CREATE TABLE [dbo].[LN_TFCMG008] (
    [compnr]               BIGINT        NULL,
    [vatc]                 NVARCHAR (3)  NULL,
    [cvat]                 NVARCHAR (9)  NULL,
    [vtyp]                 BIGINT        NULL,
    [vtyp_kw]              NVARCHAR (25) NULL,
    [diac]                 NVARCHAR (12) NULL,
    [lpac]                 NVARCHAR (12) NULL,
    [pdac]                 NVARCHAR (12) NULL,
    [vatc_cvat_ref_compnr] BIGINT        NULL,
    [vatc_ref_compnr]      BIGINT        NULL,
    [cvat_ref_compnr]      BIGINT        NULL,
    [diac_ref_compnr]      BIGINT        NULL,
    [lpac_ref_compnr]      BIGINT        NULL,
    [pdac_ref_compnr]      BIGINT        NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFCMG008_lookup]
    ON [dbo].[LN_TFCMG008]([compnr] ASC, [vatc] ASC, [cvat] ASC, [vtyp] ASC);


GO

