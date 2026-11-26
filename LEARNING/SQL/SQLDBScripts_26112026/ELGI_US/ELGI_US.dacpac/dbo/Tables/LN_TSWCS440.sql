CREATE TABLE [dbo].[LN_TSWCS440] (
    [compnr]          BIGINT        NULL,
    [orno]            NVARCHAR (9)  NULL,
    [cotp]            BIGINT        NULL,
    [lino]            BIGINT        NULL,
    [acln]            BIGINT        NULL,
    [cotp_kw]         NVARCHAR (20) NULL,
    [amnt_1]          FLOAT (53)    NULL,
    [amnt_2]          FLOAT (53)    NULL,
    [amnt_3]          FLOAT (53)    NULL,
    [orno_ref_compnr] BIGINT        NULL,
    [amnt_trnc]       FLOAT (53)    NULL,
    [amnt_refc]       FLOAT (53)    NULL,
    [amnt_dwhc]       FLOAT (53)    NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSWCS440_lookup]
    ON [dbo].[LN_TSWCS440]([compnr] ASC, [orno] ASC, [cotp] ASC, [lino] ASC, [acln] ASC);


GO

