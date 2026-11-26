CREATE TABLE [dbo].[LN_BTREC210] (
    [compnr]          BIGINT        NULL,
    [fire]            NVARCHAR (9)  NULL,
    [sqnb]            BIGINT        NULL,
    [refr]            NVARCHAR (9)  NULL,
    [fire_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_BTREC210_lookup]
    ON [dbo].[LN_BTREC210]([compnr] ASC, [fire] ASC, [sqnb] ASC);


GO

