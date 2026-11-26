CREATE TABLE [dbo].[LN_TSCTM830] (
    [compnr]               BIGINT        NULL,
    [term]                 BIGINT        NULL,
    [cfln]                 BIGINT        NULL,
    [cctp]                 NVARCHAR (3)  NULL,
    [cotp]                 BIGINT        NULL,
    [nrbt]                 BIGINT        NULL,
    [cotp_kw]              NVARCHAR (20) NULL,
    [cvtp]                 BIGINT        NULL,
    [cvtp_kw]              NVARCHAR (20) NULL,
    [desc]                 NVARCHAR (50) NULL,
    [nrpe]                 BIGINT        NULL,
    [peru]                 BIGINT        NULL,
    [peru_kw]              NVARCHAR (20) NULL,
    [stdt]                 NVARCHAR (10) NULL,
    [endt]                 NVARCHAR (10) NULL,
    [cmdl]                 NVARCHAR (47) NULL,
    [sigr]                 NVARCHAR (6)  NULL,
    [limi]                 FLOAT (53)    NULL,
    [ccov]                 BIGINT        NULL,
    [ccov_kw]              NVARCHAR (20) NULL,
    [ceil]                 FLOAT (53)    NULL,
    [disc]                 FLOAT (53)    NULL,
    [camt_1]               FLOAT (53)    NULL,
    [camt_2]               FLOAT (53)    NULL,
    [camt_3]               FLOAT (53)    NULL,
    [amnt]                 FLOAT (53)    NULL,
    [spco_1]               FLOAT (53)    NULL,
    [spco_2]               FLOAT (53)    NULL,
    [spco_3]               FLOAT (53)    NULL,
    [spsa]                 FLOAT (53)    NULL,
    [spdi]                 FLOAT (53)    NULL,
    [alco_1]               FLOAT (53)    NULL,
    [alco_2]               FLOAT (53)    NULL,
    [alco_3]               FLOAT (53)    NULL,
    [alsa]                 FLOAT (53)    NULL,
    [aldi]                 FLOAT (53)    NULL,
    [clco_1]               FLOAT (53)    NULL,
    [clco_2]               FLOAT (53)    NULL,
    [clco_3]               FLOAT (53)    NULL,
    [clsa]                 FLOAT (53)    NULL,
    [ccal]                 NVARCHAR (9)  NULL,
    [ract]                 NVARCHAR (6)  NULL,
    [txta]                 BIGINT        NULL,
    [term_cfln_ref_compnr] BIGINT        NULL,
    [sigr_ref_compnr]      BIGINT        NULL,
    [ccal_ref_compnr]      BIGINT        NULL,
    [ract_ref_compnr]      BIGINT        NULL,
    [txta_ref_compnr]      BIGINT        NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM830_lookup]
    ON [dbo].[LN_TSCTM830]([compnr] ASC, [term] ASC, [cfln] ASC, [cctp] ASC, [cotp] ASC, [nrbt] ASC);


GO

