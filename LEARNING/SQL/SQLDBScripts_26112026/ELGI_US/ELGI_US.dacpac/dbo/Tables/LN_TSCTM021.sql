CREATE TABLE [dbo].[LN_TSCTM021] (
    [compnr]          BIGINT        NULL,
    [sigr]            NVARCHAR (6)  NULL,
    [cwte]            NVARCHAR (16) NULL,
    [sigr_ref_compnr] BIGINT        NULL,
    [cwte_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM021_lookup]
    ON [dbo].[LN_TSCTM021]([compnr] ASC, [sigr] ASC, [cwte] ASC);


GO

