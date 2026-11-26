CREATE TABLE [dbo].[LN_TSCTM111] (
    [compnr]               BIGINT        NULL,
    [term]                 BIGINT        NULL,
    [cfln]                 BIGINT        NULL,
    [cseq]                 BIGINT        NULL,
    [fplv]                 BIGINT        NULL,
    [fplv_kw]              NVARCHAR (25) NULL,
    [cact]                 NVARCHAR (16) NULL,
    [camr]                 NVARCHAR (16) NULL,
    [caro]                 NVARCHAR (16) NULL,
    [pris]                 FLOAT (53)    NULL,
    [txta]                 BIGINT        NULL,
    [term_cfln_ref_compnr] BIGINT        NULL,
    [cact_ref_compnr]      BIGINT        NULL,
    [camr_ref_compnr]      BIGINT        NULL,
    [caro_ref_compnr]      BIGINT        NULL,
    [txta_ref_compnr]      BIGINT        NULL,
    [pris_homc]            FLOAT (53)    NULL,
    [pris_rpc1]            FLOAT (53)    NULL,
    [pris_rpc2]            FLOAT (53)    NULL,
    [pris_refc]            FLOAT (53)    NULL,
    [pris_dwhc]            FLOAT (53)    NULL,
    [camt_cntc]            FLOAT (53)    NULL,
    [camt_homc]            FLOAT (53)    NULL,
    [camt_rpc1]            FLOAT (53)    NULL,
    [camt_rpc2]            FLOAT (53)    NULL,
    [camt_refc]            FLOAT (53)    NULL,
    [camt_dwhc]            FLOAT (53)    NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM111_lookup]
    ON [dbo].[LN_TSCTM111]([compnr] ASC, [term] ASC, [cfln] ASC, [cseq] ASC);


GO

