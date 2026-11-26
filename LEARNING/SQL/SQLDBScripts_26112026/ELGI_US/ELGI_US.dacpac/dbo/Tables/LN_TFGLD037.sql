CREATE TABLE [dbo].[LN_TFGLD037] (
    [compnr]         BIGINT        NULL,
    [ncmp]           BIGINT        NULL,
    [leac]           NVARCHAR (12) NULL,
    [nosu]           BIGINT        NULL,
    [nocu]           BIGINT        NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFGLD037_lookup]
    ON [dbo].[LN_TFGLD037]([compnr] ASC, [ncmp] ASC, [leac] ASC);


GO

