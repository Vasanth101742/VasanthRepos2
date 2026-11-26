CREATE TABLE [dbo].[LN_WHLTC000] (
    [compnr]          BIGINT        NULL,
    [indt]            NVARCHAR (40) NULL,
    [dsca]            NVARCHAR (50) NULL,
    [adco]            BIGINT        NULL,
    [adco_kw]         NVARCHAR (20) NULL,
    [erac]            BIGINT        NULL,
    [erac_kw]         NVARCHAR (20) NULL,
    [prmk]            NVARCHAR (9)  NULL,
    [pumk]            NVARCHAR (9)  NULL,
    [gemk]            NVARCHAR (9)  NULL,
    [rxlm]            NVARCHAR (9)  NULL,
    [rxsm]            NVARCHAR (9)  NULL,
    [prmk_ref_compnr] BIGINT        NULL,
    [pumk_ref_compnr] BIGINT        NULL,
    [gemk_ref_compnr] BIGINT        NULL,
    [rxlm_ref_compnr] BIGINT        NULL,
    [rxsm_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_WHLTC000_lookup]
    ON [dbo].[LN_WHLTC000]([compnr] ASC, [indt] ASC);


GO

