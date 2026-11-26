CREATE TABLE [dbo].[LN_TFACR005] (
    [compnr]               BIGINT        NULL,
    [ficu]                 NVARCHAR (3)  NULL,
    [tran]                 BIGINT        NULL,
    [tran_kw]              NVARCHAR (26) NULL,
    [leac]                 NVARCHAR (12) NULL,
    [typ1]                 BIGINT        NULL,
    [typ2]                 BIGINT        NULL,
    [typ3]                 BIGINT        NULL,
    [typ4]                 BIGINT        NULL,
    [typ5]                 BIGINT        NULL,
    [typ6]                 BIGINT        NULL,
    [typ7]                 BIGINT        NULL,
    [typ8]                 BIGINT        NULL,
    [typ9]                 BIGINT        NULL,
    [tp10]                 BIGINT        NULL,
    [tp11]                 BIGINT        NULL,
    [tp12]                 BIGINT        NULL,
    [dim1]                 NVARCHAR (9)  NULL,
    [dim2]                 NVARCHAR (9)  NULL,
    [dim3]                 NVARCHAR (9)  NULL,
    [dim4]                 NVARCHAR (9)  NULL,
    [dim5]                 NVARCHAR (9)  NULL,
    [dim6]                 NVARCHAR (9)  NULL,
    [dim7]                 NVARCHAR (9)  NULL,
    [dim8]                 NVARCHAR (9)  NULL,
    [dim9]                 NVARCHAR (9)  NULL,
    [dm10]                 NVARCHAR (9)  NULL,
    [dm11]                 NVARCHAR (9)  NULL,
    [dm12]                 NVARCHAR (9)  NULL,
    [ficu_ref_compnr]      BIGINT        NULL,
    [leac_ref_compnr]      BIGINT        NULL,
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

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFACR005_lookup]
    ON [dbo].[LN_TFACR005]([compnr] ASC, [ficu] ASC, [tran] ASC);


GO

