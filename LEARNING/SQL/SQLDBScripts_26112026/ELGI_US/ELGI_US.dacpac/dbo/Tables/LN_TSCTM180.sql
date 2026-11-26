CREATE TABLE [dbo].[LN_TSCTM180] (
    [compnr]               BIGINT        NULL,
    [ortp]                 BIGINT        NULL,
    [orno]                 NVARCHAR (9)  NULL,
    [acln]                 BIGINT        NULL,
    [cotp]                 BIGINT        NULL,
    [lino]                 BIGINT        NULL,
    [term]                 BIGINT        NULL,
    [dcnr]                 BIGINT        NULL,
    [ortp_kw]              NVARCHAR (20) NULL,
    [cotp_kw]              NVARCHAR (20) NULL,
    [ivsq]                 BIGINT        NULL,
    [cfln]                 BIGINT        NULL,
    [cctp]                 NVARCHAR (3)  NULL,
    [nrbt]                 BIGINT        NULL,
    [cseq]                 BIGINT        NULL,
    [ealc_1]               FLOAT (53)    NULL,
    [ealc_2]               FLOAT (53)    NULL,
    [ealc_3]               FLOAT (53)    NULL,
    [eals]                 FLOAT (53)    NULL,
    [aldi]                 FLOAT (53)    NULL,
    [alco_1]               FLOAT (53)    NULL,
    [alco_2]               FLOAT (53)    NULL,
    [alco_3]               FLOAT (53)    NULL,
    [alsa]                 FLOAT (53)    NULL,
    [alnr]                 BIGINT        NULL,
    [aln2]                 BIGINT        NULL,
    [alqu]                 FLOAT (53)    NULL,
    [eanr]                 BIGINT        NULL,
    [ean2]                 BIGINT        NULL,
    [eaqu]                 FLOAT (53)    NULL,
    [tcam]                 FLOAT (53)    NULL,
    [tcqa]                 FLOAT (53)    NULL,
    [cots]                 BIGINT        NULL,
    [cots_kw]              NVARCHAR (20) NULL,
    [trdt]                 NVARCHAR (40) NULL,
    [term_cfln_ref_compnr] BIGINT        NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM180_lookup]
    ON [dbo].[LN_TSCTM180]([compnr] ASC, [ortp] ASC, [orno] ASC, [acln] ASC, [cotp] ASC, [lino] ASC, [term] ASC, [dcnr] ASC);


GO

