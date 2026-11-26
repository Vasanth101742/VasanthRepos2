CREATE TABLE [dbo].[LN_TSCTM139] (
    [compnr]                              BIGINT        NULL,
    [term]                                BIGINT        NULL,
    [cfln]                                BIGINT        NULL,
    [cctp]                                NVARCHAR (3)  NULL,
    [cotp]                                BIGINT        NULL,
    [nrbt]                                BIGINT        NULL,
    [cseq]                                BIGINT        NULL,
    [cotp_kw]                             NVARCHAR (20) NULL,
    [avtm]                                FLOAT (53)    NULL,
    [utpc]                                FLOAT (53)    NULL,
    [cstm]                                FLOAT (53)    NULL,
    [sptm]                                FLOAT (53)    NULL,
    [crmt]                                FLOAT (53)    NULL,
    [proc]                                BIGINT        NULL,
    [proc_kw]                             NVARCHAR (20) NULL,
    [camt_1]                              FLOAT (53)    NULL,
    [camt_2]                              FLOAT (53)    NULL,
    [camt_3]                              FLOAT (53)    NULL,
    [amnt]                                FLOAT (53)    NULL,
    [txta]                                BIGINT        NULL,
    [term_cfln_cctp_cotp_nrbt_ref_compnr] BIGINT        NULL,
    [term_cfln_ref_compnr]                BIGINT        NULL,
    [cctp_ref_compnr]                     BIGINT        NULL,
    [txta_ref_compnr]                     BIGINT        NULL,
    [camt_cntc]                           FLOAT (53)    NULL,
    [camt_refc]                           FLOAT (53)    NULL,
    [camt_dwhc]                           FLOAT (53)    NULL,
    [amnt_homc]                           FLOAT (53)    NULL,
    [amnt_rpc1]                           FLOAT (53)    NULL,
    [amnt_rpc2]                           FLOAT (53)    NULL,
    [amnt_refc]                           FLOAT (53)    NULL,
    [amnt_dwhc]                           FLOAT (53)    NULL,
    [sptm_butm]                           FLOAT (53)    NULL,
    [avtm_butm]                           FLOAT (53)    NULL,
    [cstm_butm]                           FLOAT (53)    NULL,
    [deleted]                             NCHAR (1)     NULL,
    [username]                            NVARCHAR (8)  NULL,
    [timestamp]                           DATETIME      NULL,
    [sequencenumber]                      BIGINT        NULL,
    [dlDocumentDate]                      NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM139_lookup]
    ON [dbo].[LN_TSCTM139]([compnr] ASC, [term] ASC, [cfln] ASC, [cctp] ASC, [cotp] ASC, [nrbt] ASC, [cseq] ASC);


GO

