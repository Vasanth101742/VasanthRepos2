CREATE TABLE [dbo].[LN_BTREC209] (
    [compnr]               BIGINT        NULL,
    [fire]                 NVARCHAR (9)  NULL,
    [sqnb]                 BIGINT        NULL,
    [refr]                 NVARCHAR (9)  NULL,
    [line]                 BIGINT        NULL,
    [fire_ref_compnr]      BIGINT        NULL,
    [refr_line_ref_compnr] BIGINT        NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_BTREC209_lookup]
    ON [dbo].[LN_BTREC209]([compnr] ASC, [fire] ASC, [sqnb] ASC);


GO

