CREATE TABLE [dbo].[LN_TSCLM335] (
    [compnr]         BIGINT        NULL,
    [cstn]           NVARCHAR (10) NULL,
    [desc]           NVARCHAR (30) NULL,
    [adur]           FLOAT (53)    NULL,
    [exyn]           BIGINT        NULL,
    [exyn_kw]        NVARCHAR (20) NULL,
    [esyn]           BIGINT        NULL,
    [esyn_kw]        NVARCHAR (20) NULL,
    [umtc]           BIGINT        NULL,
    [umtc_kw]        NVARCHAR (20) NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCLM335_lookup]
    ON [dbo].[LN_TSCLM335]([compnr] ASC, [cstn] ASC);


GO

