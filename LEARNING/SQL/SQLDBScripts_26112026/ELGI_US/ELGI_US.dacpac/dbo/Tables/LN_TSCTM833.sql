CREATE TABLE [dbo].[LN_TSCTM833] (
    [compnr]                              BIGINT        NULL,
    [term]                                BIGINT        NULL,
    [cfln]                                BIGINT        NULL,
    [cctp]                                NVARCHAR (3)  NULL,
    [cotp]                                BIGINT        NULL,
    [nrbt]                                BIGINT        NULL,
    [cseq]                                BIGINT        NULL,
    [cotp_kw]                             NVARCHAR (20) NULL,
    [ctsk]                                NVARCHAR (8)  NULL,
    [ccmp]                                NVARCHAR (8)  NULL,
    [clrt]                                NVARCHAR (6)  NULL,
    [chlt]                                NVARCHAR (3)  NULL,
    [nrhr]                                FLOAT (53)    NULL,
    [wrac_1]                              FLOAT (53)    NULL,
    [wrac_2]                              FLOAT (53)    NULL,
    [wrac_3]                              FLOAT (53)    NULL,
    [wras]                                FLOAT (53)    NULL,
    [camt_1]                              FLOAT (53)    NULL,
    [camt_2]                              FLOAT (53)    NULL,
    [camt_3]                              FLOAT (53)    NULL,
    [amnt]                                FLOAT (53)    NULL,
    [dspc]                                BIGINT        NULL,
    [dspc_kw]                             NVARCHAR (20) NULL,
    [sphr]                                FLOAT (53)    NULL,
    [spco_1]                              FLOAT (53)    NULL,
    [spco_2]                              FLOAT (53)    NULL,
    [spco_3]                              FLOAT (53)    NULL,
    [spsa]                                FLOAT (53)    NULL,
    [alhr]                                FLOAT (53)    NULL,
    [alco_1]                              FLOAT (53)    NULL,
    [alco_2]                              FLOAT (53)    NULL,
    [alco_3]                              FLOAT (53)    NULL,
    [alsa]                                FLOAT (53)    NULL,
    [txta]                                BIGINT        NULL,
    [term_cfln_cctp_cotp_nrbt_ref_compnr] BIGINT        NULL,
    [term_cfln_ref_compnr]                BIGINT        NULL,
    [txta_ref_compnr]                     BIGINT        NULL,
    [deleted]                             NCHAR (1)     NULL,
    [username]                            NVARCHAR (8)  NULL,
    [timestamp]                           DATETIME      NULL,
    [sequencenumber]                      BIGINT        NULL,
    [dlDocumentDate]                      NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM833_lookup]
    ON [dbo].[LN_TSCTM833]([compnr] ASC, [term] ASC, [cfln] ASC, [cctp] ASC, [cotp] ASC, [nrbt] ASC, [cseq] ASC);


GO

