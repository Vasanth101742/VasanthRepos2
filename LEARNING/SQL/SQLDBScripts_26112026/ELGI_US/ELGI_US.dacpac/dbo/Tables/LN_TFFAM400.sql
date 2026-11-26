CREATE TABLE [dbo].[LN_TFFAM400] (
    [compnr]         BIGINT        NULL,
    [agrp]           NVARCHAR (10) NULL,
    [desc]           NVARCHAR (30) NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFFAM400_lookup]
    ON [dbo].[LN_TFFAM400]([compnr] ASC, [agrp] ASC);


GO

