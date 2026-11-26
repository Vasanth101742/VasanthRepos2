CREATE TABLE [dbo].[LN_TSCTM501] (
    [compnr]               BIGINT        NULL,
    [wrty]                 NVARCHAR (16) NULL,
    [item]                 NVARCHAR (47) NULL,
    [sern]                 NVARCHAR (30) NULL,
    [trtm]                 NVARCHAR (40) NULL,
    [seqn]                 BIGINT        NULL,
    [cctp]                 NVARCHAR (3)  NULL,
    [cotp]                 BIGINT        NULL,
    [cotp_kw]              NVARCHAR (20) NULL,
    [ortp]                 BIGINT        NULL,
    [ortp_kw]              NVARCHAR (20) NULL,
    [orno]                 NVARCHAR (9)  NULL,
    [pono]                 BIGINT        NULL,
    [cvln]                 BIGINT        NULL,
    [tcst]                 BIGINT        NULL,
    [tcst_kw]              NVARCHAR (20) NULL,
    [wrtp]                 BIGINT        NULL,
    [wrtp_kw]              NVARCHAR (22) NULL,
    [cstp]                 NVARCHAR (3)  NULL,
    [cwoc]                 NVARCHAR (6)  NULL,
    [clst]                 NVARCHAR (9)  NULL,
    [litm]                 NVARCHAR (47) NULL,
    [lser]                 NVARCHAR (30) NULL,
    [ofbp]                 NVARCHAR (9)  NULL,
    [ccur]                 NVARCHAR (3)  NULL,
    [spco_1]               FLOAT (53)    NULL,
    [spco_2]               FLOAT (53)    NULL,
    [spco_3]               FLOAT (53)    NULL,
    [spsa]                 FLOAT (53)    NULL,
    [item_sern_ref_compnr] BIGINT        NULL,
    [item_ref_compnr]      BIGINT        NULL,
    [cctp_ref_compnr]      BIGINT        NULL,
    [cstp_ref_compnr]      BIGINT        NULL,
    [cwoc_ref_compnr]      BIGINT        NULL,
    [clst_ref_compnr]      BIGINT        NULL,
    [litm_lser_ref_compnr] BIGINT        NULL,
    [litm_ref_compnr]      BIGINT        NULL,
    [ofbp_ref_compnr]      BIGINT        NULL,
    [ccur_ref_compnr]      BIGINT        NULL,
    [spco_trnc]            FLOAT (53)    NULL,
    [spco_refc]            FLOAT (53)    NULL,
    [spco_dwhc]            FLOAT (53)    NULL,
    [spsa_homc]            FLOAT (53)    NULL,
    [spsa_rpc1]            FLOAT (53)    NULL,
    [spsa_rpc2]            FLOAT (53)    NULL,
    [spsa_refc]            FLOAT (53)    NULL,
    [spsa_dwhc]            FLOAT (53)    NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM501_lookup]
    ON [dbo].[LN_TSCTM501]([compnr] ASC, [wrty] ASC, [item] ASC, [sern] ASC, [trtm] ASC, [seqn] ASC);


GO

