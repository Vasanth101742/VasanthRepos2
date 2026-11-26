CREATE TABLE [dbo].[LN_TSCTM835] (
    [compnr]                              BIGINT        NULL,
    [term]                                BIGINT        NULL,
    [cfln]                                BIGINT        NULL,
    [cctp]                                NVARCHAR (3)  NULL,
    [cotp]                                BIGINT        NULL,
    [nrbt]                                BIGINT        NULL,
    [cseq]                                BIGINT        NULL,
    [cotp_kw]                             NVARCHAR (20) NULL,
    [otbp]                                NVARCHAR (9)  NULL,
    [item]                                NVARCHAR (47) NULL,
    [ccmp]                                NVARCHAR (8)  NULL,
    [desc]                                NVARCHAR (60) NULL,
    [quan]                                FLOAT (53)    NULL,
    [cuni]                                NVARCHAR (3)  NULL,
    [pric_1]                              FLOAT (53)    NULL,
    [pric_2]                              FLOAT (53)    NULL,
    [pric_3]                              FLOAT (53)    NULL,
    [pris]                                FLOAT (53)    NULL,
    [camt_1]                              FLOAT (53)    NULL,
    [camt_2]                              FLOAT (53)    NULL,
    [camt_3]                              FLOAT (53)    NULL,
    [amnt]                                FLOAT (53)    NULL,
    [dspc]                                BIGINT        NULL,
    [dspc_kw]                             NVARCHAR (20) NULL,
    [spqu]                                FLOAT (53)    NULL,
    [spco_1]                              FLOAT (53)    NULL,
    [spco_2]                              FLOAT (53)    NULL,
    [spco_3]                              FLOAT (53)    NULL,
    [spsa]                                FLOAT (53)    NULL,
    [alqu]                                FLOAT (53)    NULL,
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

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM835_lookup]
    ON [dbo].[LN_TSCTM835]([compnr] ASC, [term] ASC, [cfln] ASC, [cctp] ASC, [cotp] ASC, [nrbt] ASC, [cseq] ASC);


GO

