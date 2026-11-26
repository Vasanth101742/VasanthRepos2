CREATE TABLE [dbo].[LN_TSCTM480] (
    [compnr]               BIGINT        NULL,
    [csco]                 NVARCHAR (9)  NULL,
    [cchn]                 BIGINT        NULL,
    [cfln]                 BIGINT        NULL,
    [seqn]                 BIGINT        NULL,
    [ivsq]                 BIGINT        NULL,
    [acco_1]               FLOAT (53)    NULL,
    [acco_2]               FLOAT (53)    NULL,
    [acco_3]               FLOAT (53)    NULL,
    [codt]                 NVARCHAR (40) NULL,
    [plyr]                 BIGINT        NULL,
    [plpr]                 BIGINT        NULL,
    [ortp]                 BIGINT        NULL,
    [ortp_kw]              NVARCHAR (20) NULL,
    [orno]                 NVARCHAR (9)  NULL,
    [pono]                 BIGINT        NULL,
    [cvln]                 BIGINT        NULL,
    [cotp]                 BIGINT        NULL,
    [cotp_kw]              NVARCHAR (20) NULL,
    [poyr]                 BIGINT        NULL,
    [popr]                 BIGINT        NULL,
    [stat]                 BIGINT        NULL,
    [stat_kw]              NVARCHAR (20) NULL,
    [ircl]                 BIGINT        NULL,
    [ircl_kw]              NVARCHAR (20) NULL,
    [rchn]                 BIGINT        NULL,
    [csco_cchn_ref_compnr] BIGINT        NULL,
    [csco_rchn_ref_compnr] BIGINT        NULL,
    [csco_ref_compnr]      BIGINT        NULL,
    [acco_cntc]            FLOAT (53)    NULL,
    [acco_refc]            FLOAT (53)    NULL,
    [acco_dwhc]            FLOAT (53)    NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM480_lookup]
    ON [dbo].[LN_TSCTM480]([compnr] ASC, [csco] ASC, [cchn] ASC, [cfln] ASC, [seqn] ASC);


GO

