CREATE TABLE [dbo].[LN_TFCMG004] (
    [compnr]         BIGINT        NULL,
    [topy]           NVARCHAR (3)  NULL,
    [desc]           NVARCHAR (30) NULL,
    [code]           NVARCHAR (3)  NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFCMG004_lookup]
    ON [dbo].[LN_TFCMG004]([compnr] ASC, [topy] ASC);


GO

