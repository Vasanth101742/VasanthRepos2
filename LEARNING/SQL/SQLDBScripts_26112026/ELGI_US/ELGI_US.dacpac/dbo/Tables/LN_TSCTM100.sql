CREATE TABLE [dbo].[LN_TSCTM100] (
    [compnr]               BIGINT        NULL,
    [term]                 BIGINT        NULL,
    [type]                 BIGINT        NULL,
    [cfln]                 BIGINT        NULL,
    [cctp]                 NVARCHAR (3)  NULL,
    [cotp]                 BIGINT        NULL,
    [type_kw]              NVARCHAR (25) NULL,
    [cotp_kw]              NVARCHAR (20) NULL,
    [camt_1]               FLOAT (53)    NULL,
    [camt_2]               FLOAT (53)    NULL,
    [camt_3]               FLOAT (53)    NULL,
    [amnt]                 FLOAT (53)    NULL,
    [ealc_1]               FLOAT (53)    NULL,
    [ealc_2]               FLOAT (53)    NULL,
    [ealc_3]               FLOAT (53)    NULL,
    [eals]                 FLOAT (53)    NULL,
    [alco_1]               FLOAT (53)    NULL,
    [alco_2]               FLOAT (53)    NULL,
    [alco_3]               FLOAT (53)    NULL,
    [spco_1]               FLOAT (53)    NULL,
    [spco_2]               FLOAT (53)    NULL,
    [spco_3]               FLOAT (53)    NULL,
    [alsa]                 FLOAT (53)    NULL,
    [spsa]                 FLOAT (53)    NULL,
    [clco_1]               FLOAT (53)    NULL,
    [clco_2]               FLOAT (53)    NULL,
    [clco_3]               FLOAT (53)    NULL,
    [clsa]                 FLOAT (53)    NULL,
    [term_cfln_ref_compnr] BIGINT        NULL,
    [cctp_ref_compnr]      BIGINT        NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM100_lookup]
    ON [dbo].[LN_TSCTM100]([compnr] ASC, [term] ASC, [type] ASC, [cfln] ASC, [cctp] ASC, [cotp] ASC);


GO

