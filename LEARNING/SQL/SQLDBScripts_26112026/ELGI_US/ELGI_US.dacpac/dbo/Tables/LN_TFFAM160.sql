CREATE TABLE [dbo].[LN_TFFAM160] (
    [compnr]          BIGINT        NULL,
    [plcy]            NVARCHAR (20) NULL,
    [dsca]            NVARCHAR (50) NULL,
    [agen]            NVARCHAR (9)  NULL,
    [text]            BIGINT        NULL,
    [agen_ref_compnr] BIGINT        NULL,
    [text_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFFAM160_lookup]
    ON [dbo].[LN_TFFAM160]([compnr] ASC, [plcy] ASC);


GO

