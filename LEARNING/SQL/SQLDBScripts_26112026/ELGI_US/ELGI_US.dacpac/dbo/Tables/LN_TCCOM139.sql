CREATE TABLE [dbo].[LN_TCCOM139] (
    [compnr]               BIGINT        NULL,
    [ccty]                 NVARCHAR (3)  NULL,
    [cste]                 NVARCHAR (3)  NULL,
    [city]                 NVARCHAR (8)  NULL,
    [dsca]                 NVARCHAR (30) NULL,
    [seak]                 NVARCHAR (16) NULL,
    [idnr]                 BIGINT        NULL,
    [ccty_ref_compnr]      BIGINT        NULL,
    [ccty_cste_ref_compnr] BIGINT        NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCCOM139_lookup]
    ON [dbo].[LN_TCCOM139]([compnr] ASC, [ccty] ASC, [cste] ASC, [city] ASC);


GO

