CREATE TABLE [dbo].[LN_TSCTM010] (
    [compnr]         BIGINT        NULL,
    [ccds]           NVARCHAR (3)  NULL,
    [desc]           NVARCHAR (30) NULL,
    [peru]           BIGINT        NULL,
    [peru_kw]        NVARCHAR (20) NULL,
    [perd_1]         BIGINT        NULL,
    [perd_2]         BIGINT        NULL,
    [perd_3]         BIGINT        NULL,
    [perd_4]         BIGINT        NULL,
    [perd_5]         BIGINT        NULL,
    [perd_6]         BIGINT        NULL,
    [perd_7]         BIGINT        NULL,
    [perd_8]         BIGINT        NULL,
    [perd_9]         BIGINT        NULL,
    [perd_10]        BIGINT        NULL,
    [disc_1]         FLOAT (53)    NULL,
    [disc_2]         FLOAT (53)    NULL,
    [disc_3]         FLOAT (53)    NULL,
    [disc_4]         FLOAT (53)    NULL,
    [disc_5]         FLOAT (53)    NULL,
    [disc_6]         FLOAT (53)    NULL,
    [disc_7]         FLOAT (53)    NULL,
    [disc_8]         FLOAT (53)    NULL,
    [disc_9]         FLOAT (53)    NULL,
    [disc_10]        FLOAT (53)    NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM010_lookup]
    ON [dbo].[LN_TSCTM010]([compnr] ASC, [ccds] ASC);


GO

