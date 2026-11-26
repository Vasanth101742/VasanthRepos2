CREATE TABLE [dbo].[LN_TSCLM370] (
    [compnr]               BIGINT        NULL,
    [orig]                 BIGINT        NULL,
    [orno]                 NVARCHAR (9)  NULL,
    [acln]                 BIGINT        NULL,
    [lino]                 BIGINT        NULL,
    [seqn]                 BIGINT        NULL,
    [orig_kw]              NVARCHAR (20) NULL,
    [item]                 NVARCHAR (47) NULL,
    [sern]                 NVARCHAR (30) NULL,
    [fare]                 NVARCHAR (6)  NULL,
    [fadt]                 NVARCHAR (40) NULL,
    [espr]                 NVARCHAR (10) NULL,
    [sltn]                 NVARCHAR (10) NULL,
    [crac]                 NVARCHAR (16) NULL,
    [ordt]                 NVARCHAR (40) NULL,
    [txta]                 BIGINT        NULL,
    [item_sern_ref_compnr] BIGINT        NULL,
    [item_ref_compnr]      BIGINT        NULL,
    [fare_ref_compnr]      BIGINT        NULL,
    [espr_ref_compnr]      BIGINT        NULL,
    [sltn_ref_compnr]      BIGINT        NULL,
    [crac_ref_compnr]      BIGINT        NULL,
    [txta_ref_compnr]      BIGINT        NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCLM370_lookup]
    ON [dbo].[LN_TSCLM370]([compnr] ASC, [orig] ASC, [orno] ASC, [acln] ASC, [lino] ASC, [seqn] ASC);


GO

