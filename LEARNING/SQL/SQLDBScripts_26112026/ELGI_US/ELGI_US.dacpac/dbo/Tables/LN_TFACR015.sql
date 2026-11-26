CREATE TABLE [dbo].[LN_TFACR015] (
    [compnr]               BIGINT        NULL,
    [ficu]                 NVARCHAR (3)  NULL,
    [styp]                 NVARCHAR (6)  NULL,
    [leac]                 NVARCHAR (12) NULL,
    [arrc]                 NVARCHAR (12) NULL,
    [typ1]                 BIGINT        NULL,
    [dim1]                 NVARCHAR (9)  NULL,
    [typ2]                 BIGINT        NULL,
    [dim2]                 NVARCHAR (9)  NULL,
    [typ3]                 BIGINT        NULL,
    [dim3]                 NVARCHAR (9)  NULL,
    [typ4]                 BIGINT        NULL,
    [dim4]                 NVARCHAR (9)  NULL,
    [typ5]                 BIGINT        NULL,
    [dim5]                 NVARCHAR (9)  NULL,
    [typ6]                 BIGINT        NULL,
    [dim6]                 NVARCHAR (9)  NULL,
    [typ7]                 BIGINT        NULL,
    [dim7]                 NVARCHAR (9)  NULL,
    [typ8]                 BIGINT        NULL,
    [dim8]                 NVARCHAR (9)  NULL,
    [typ9]                 BIGINT        NULL,
    [dim9]                 NVARCHAR (9)  NULL,
    [tp10]                 BIGINT        NULL,
    [dm10]                 NVARCHAR (9)  NULL,
    [tp11]                 BIGINT        NULL,
    [dm11]                 NVARCHAR (9)  NULL,
    [tp12]                 BIGINT        NULL,
    [dm12]                 NVARCHAR (9)  NULL,
    [ficu_ref_compnr]      BIGINT        NULL,
    [styp_ref_compnr]      BIGINT        NULL,
    [leac_ref_compnr]      BIGINT        NULL,
    [arrc_ref_compnr]      BIGINT        NULL,
    [typ1_dim1_ref_compnr] BIGINT        NULL,
    [typ2_dim2_ref_compnr] BIGINT        NULL,
    [typ3_dim3_ref_compnr] BIGINT        NULL,
    [typ4_dim4_ref_compnr] BIGINT        NULL,
    [typ5_dim5_ref_compnr] BIGINT        NULL,
    [typ6_dim6_ref_compnr] BIGINT        NULL,
    [typ7_dim7_ref_compnr] BIGINT        NULL,
    [typ8_dim8_ref_compnr] BIGINT        NULL,
    [typ9_dim9_ref_compnr] BIGINT        NULL,
    [tp10_dm10_ref_compnr] BIGINT        NULL,
    [tp11_dm11_ref_compnr] BIGINT        NULL,
    [tp12_dm12_ref_compnr] BIGINT        NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFACR015_lookup]
    ON [dbo].[LN_TFACR015]([compnr] ASC, [ficu] ASC, [styp] ASC);


GO

