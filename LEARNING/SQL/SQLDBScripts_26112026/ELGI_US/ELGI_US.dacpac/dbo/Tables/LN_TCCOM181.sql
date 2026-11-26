CREATE TABLE [dbo].[LN_TCCOM181] (
    [compnr]          BIGINT        NULL,
    [ctst]            NVARCHAR (14) NULL,
    [ccty]            NVARCHAR (3)  NULL,
    [ctst_ref_compnr] BIGINT        NULL,
    [ccty_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCCOM181_lookup]
    ON [dbo].[LN_TCCOM181]([compnr] ASC, [ctst] ASC, [ccty] ASC);


GO

