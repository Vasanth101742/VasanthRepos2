CREATE TABLE [dbo].[LN_TSCTM450] (
    [compnr]               BIGINT        NULL,
    [csco]                 NVARCHAR (9)  NULL,
    [cchn]                 BIGINT        NULL,
    [cfln]                 BIGINT        NULL,
    [fsyr]                 BIGINT        NULL,
    [fspr]                 BIGINT        NULL,
    [nody]                 BIGINT        NULL,
    [cvdy]                 BIGINT        NULL,
    [esrv]                 FLOAT (53)    NULL,
    [rcrv]                 FLOAT (53)    NULL,
    [esco_1]               FLOAT (53)    NULL,
    [esco_2]               FLOAT (53)    NULL,
    [esco_3]               FLOAT (53)    NULL,
    [acpp_1]               FLOAT (53)    NULL,
    [acpp_2]               FLOAT (53)    NULL,
    [acpp_3]               FLOAT (53)    NULL,
    [csco_cchn_ref_compnr] BIGINT        NULL,
    [csco_ref_compnr]      BIGINT        NULL,
    [esrv_homc]            FLOAT (53)    NULL,
    [esrv_rpc1]            FLOAT (53)    NULL,
    [esrv_rpc2]            FLOAT (53)    NULL,
    [esrv_refc]            FLOAT (53)    NULL,
    [esrv_dwhc]            FLOAT (53)    NULL,
    [rcrv_homc]            FLOAT (53)    NULL,
    [rcrv_rpc1]            FLOAT (53)    NULL,
    [rcrv_rpc2]            FLOAT (53)    NULL,
    [rcrv_refc]            FLOAT (53)    NULL,
    [rcrv_dwhc]            FLOAT (53)    NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM450_lookup]
    ON [dbo].[LN_TSCTM450]([compnr] ASC, [csco] ASC, [cchn] ASC, [cfln] ASC, [fsyr] ASC, [fspr] ASC);


GO

