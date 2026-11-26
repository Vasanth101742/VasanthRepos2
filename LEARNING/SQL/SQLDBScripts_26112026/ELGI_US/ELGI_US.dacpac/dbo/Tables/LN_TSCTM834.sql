CREATE TABLE [dbo].[LN_TSCTM834] (
    [compnr]                              BIGINT        NULL,
    [term]                                BIGINT        NULL,
    [cfln]                                BIGINT        NULL,
    [cctp]                                NVARCHAR (3)  NULL,
    [cotp]                                BIGINT        NULL,
    [nrbt]                                BIGINT        NULL,
    [cseq]                                BIGINT        NULL,
    [cotp_kw]                             NVARCHAR (20) NULL,
    [desc]                                NVARCHAR (30) NULL,
    [nrcl]                                BIGINT        NULL,
    [nrun]                                BIGINT        NULL,
    [clrt]                                NVARCHAR (6)  NULL,
    [cuni]                                NVARCHAR (3)  NULL,
    [cinv]                                NVARCHAR (3)  NULL,
    [ccmp]                                NVARCHAR (8)  NULL,
    [wrac_1]                              FLOAT (53)    NULL,
    [wrac_2]                              FLOAT (53)    NULL,
    [wrac_3]                              FLOAT (53)    NULL,
    [wras]                                FLOAT (53)    NULL,
    [camt_1]                              FLOAT (53)    NULL,
    [camt_2]                              FLOAT (53)    NULL,
    [camt_3]                              FLOAT (53)    NULL,
    [amnt]                                FLOAT (53)    NULL,
    [crtc]                                NVARCHAR (3)  NULL,
    [rstu]                                NVARCHAR (3)  NULL,
    [rctt]                                FLOAT (53)    NULL,
    [slst]                                FLOAT (53)    NULL,
    [slfn]                                FLOAT (53)    NULL,
    [ccal]                                NVARCHAR (9)  NULL,
    [rsin]                                BIGINT        NULL,
    [rsin_kw]                             NVARCHAR (20) NULL,
    [bsls]                                BIGINT        NULL,
    [bsfn]                                BIGINT        NULL,
    [srcl]                                NVARCHAR (9)  NULL,
    [spcl]                                BIGINT        NULL,
    [spun]                                BIGINT        NULL,
    [spco_1]                              FLOAT (53)    NULL,
    [spco_2]                              FLOAT (53)    NULL,
    [spco_3]                              FLOAT (53)    NULL,
    [spsa]                                FLOAT (53)    NULL,
    [alcl]                                BIGINT        NULL,
    [alun]                                BIGINT        NULL,
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

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM834_lookup]
    ON [dbo].[LN_TSCTM834]([compnr] ASC, [term] ASC, [cfln] ASC, [cctp] ASC, [cotp] ASC, [nrbt] ASC, [cseq] ASC);


GO

