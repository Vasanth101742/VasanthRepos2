CREATE TABLE [dbo].[LN_TSCTM841] (
    [compnr]               BIGINT        NULL,
    [csco]                 NVARCHAR (9)  NULL,
    [cchn]                 BIGINT        NULL,
    [cfln]                 BIGINT        NULL,
    [fsyr]                 BIGINT        NULL,
    [fspr]                 BIGINT        NULL,
    [htim]                 NVARCHAR (40) NULL,
    [nody]                 BIGINT        NULL,
    [cvdy]                 BIGINT        NULL,
    [esrv]                 FLOAT (53)    NULL,
    [rcrv]                 FLOAT (53)    NULL,
    [csco_cchn_ref_compnr] BIGINT        NULL,
    [csco_ref_compnr]      BIGINT        NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM841_lookup]
    ON [dbo].[LN_TSCTM841]([compnr] ASC, [csco] ASC, [cchn] ASC, [cfln] ASC, [fsyr] ASC, [fspr] ASC, [htim] ASC);


GO

