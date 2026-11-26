CREATE TABLE [dbo].[LN_TSCTM460] (
    [compnr]               BIGINT        NULL,
    [csco]                 NVARCHAR (9)  NULL,
    [cchn]                 BIGINT        NULL,
    [cfln]                 BIGINT        NULL,
    [plyr]                 BIGINT        NULL,
    [plpr]                 BIGINT        NULL,
    [seqn]                 BIGINT        NULL,
    [ndrc]                 BIGINT        NULL,
    [clrv]                 FLOAT (53)    NULL,
    [corv]                 FLOAT (53)    NULL,
    [rahc_1]               FLOAT (53)    NULL,
    [rahc_2]               FLOAT (53)    NULL,
    [rahc_3]               FLOAT (53)    NULL,
    [ratc_1]               FLOAT (53)    NULL,
    [ratc_2]               FLOAT (53)    NULL,
    [ratc_3]               FLOAT (53)    NULL,
    [ratf_1]               BIGINT        NULL,
    [ratf_2]               BIGINT        NULL,
    [ratf_3]               BIGINT        NULL,
    [ratd]                 NVARCHAR (40) NULL,
    [rtor]                 BIGINT        NULL,
    [rtor_kw]              NVARCHAR (25) NULL,
    [crdt]                 NVARCHAR (40) NULL,
    [cmdt]                 NVARCHAR (40) NULL,
    [cmur]                 NVARCHAR (16) NULL,
    [rcdt]                 NVARCHAR (40) NULL,
    [rcur]                 NVARCHAR (16) NULL,
    [poyr]                 BIGINT        NULL,
    [popr]                 BIGINT        NULL,
    [stat]                 BIGINT        NULL,
    [stat_kw]              NVARCHAR (20) NULL,
    [erfa]                 FLOAT (53)    NULL,
    [prov]                 FLOAT (53)    NULL,
    [rchn]                 BIGINT        NULL,
    [camt_1]               FLOAT (53)    NULL,
    [camt_2]               FLOAT (53)    NULL,
    [camt_3]               FLOAT (53)    NULL,
    [acco_1]               FLOAT (53)    NULL,
    [acco_2]               FLOAT (53)    NULL,
    [acco_3]               FLOAT (53)    NULL,
    [csco_cchn_ref_compnr] BIGINT        NULL,
    [csco_rchn_ref_compnr] BIGINT        NULL,
    [csco_ref_compnr]      BIGINT        NULL,
    [corv_refc]            FLOAT (53)    NULL,
    [corv_dwhc]            FLOAT (53)    NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM460_lookup]
    ON [dbo].[LN_TSCTM460]([compnr] ASC, [csco] ASC, [cchn] ASC, [cfln] ASC, [plyr] ASC, [plpr] ASC, [seqn] ASC);


GO

