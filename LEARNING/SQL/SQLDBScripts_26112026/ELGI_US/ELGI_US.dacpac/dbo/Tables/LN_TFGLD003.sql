CREATE TABLE [dbo].[LN_TFGLD003] (
    [compnr]         BIGINT        NULL,
    [indt]           NVARCHAR (40) NULL,
    [dsca]           NVARCHAR (50) NULL,
    [dhcu]           NVARCHAR (9)  NULL,
    [dim1]           BIGINT        NULL,
    [dim1_kw]        NVARCHAR (20) NULL,
    [dim2]           BIGINT        NULL,
    [dim2_kw]        NVARCHAR (20) NULL,
    [dim3]           BIGINT        NULL,
    [dim3_kw]        NVARCHAR (20) NULL,
    [dim4]           BIGINT        NULL,
    [dim4_kw]        NVARCHAR (20) NULL,
    [dim5]           BIGINT        NULL,
    [dim5_kw]        NVARCHAR (20) NULL,
    [dim6]           BIGINT        NULL,
    [dim6_kw]        NVARCHAR (20) NULL,
    [dim7]           BIGINT        NULL,
    [dim7_kw]        NVARCHAR (20) NULL,
    [dim8]           BIGINT        NULL,
    [dim8_kw]        NVARCHAR (20) NULL,
    [dim9]           BIGINT        NULL,
    [dim9_kw]        NVARCHAR (20) NULL,
    [dm10]           BIGINT        NULL,
    [dm10_kw]        NVARCHAR (20) NULL,
    [dm11]           BIGINT        NULL,
    [dm11_kw]        NVARCHAR (20) NULL,
    [dm12]           BIGINT        NULL,
    [dm12_kw]        NVARCHAR (20) NULL,
    [rper]           BIGINT        NULL,
    [rper_kw]        NVARCHAR (20) NULL,
    [nfpr]           BIGINT        NULL,
    [nrpr]           BIGINT        NULL,
    [nvpr]           BIGINT        NULL,
    [sdat]           BIGINT        NULL,
    [bcmp]           BIGINT        NULL,
    [psep]           NVARCHAR (1)  NULL,
    [cfst]           BIGINT        NULL,
    [cfst_kw]        NVARCHAR (20) NULL,
    [dcfi]           BIGINT        NULL,
    [dcfi_kw]        NVARCHAR (20) NULL,
    [papp]           BIGINT        NULL,
    [papp_kw]        NVARCHAR (20) NULL,
    [gmbi]           BIGINT        NULL,
    [gmbi_kw]        NVARCHAR (20) NULL,
    [sgmr]           BIGINT        NULL,
    [sgmr_kw]        NVARCHAR (20) NULL,
    [psic]           BIGINT        NULL,
    [psic_kw]        NVARCHAR (20) NULL,
    [psbk]           BIGINT        NULL,
    [psbk_kw]        NVARCHAR (20) NULL,
    [pupt]           BIGINT        NULL,
    [pupt_kw]        NVARCHAR (20) NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFGLD003_lookup]
    ON [dbo].[LN_TFGLD003]([compnr] ASC, [indt] ASC);


GO

