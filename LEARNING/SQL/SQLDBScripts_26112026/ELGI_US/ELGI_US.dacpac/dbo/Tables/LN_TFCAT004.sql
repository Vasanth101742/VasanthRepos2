CREATE TABLE [dbo].[LN_TFCAT004] (
    [compnr]               BIGINT        NULL,
    [sdty]                 BIGINT        NULL,
    [sdim]                 NVARCHAR (9)  NULL,
    [cpor]                 BIGINT        NULL,
    [cpor_kw]              NVARCHAR (20) NULL,
    [slea]                 NVARCHAR (12) NULL,
    [tdty]                 BIGINT        NULL,
    [tdim]                 NVARCHAR (9)  NULL,
    [tlea]                 NVARCHAR (12) NULL,
    [sdty_sdim_ref_compnr] BIGINT        NULL,
    [sdty_ref_compnr]      BIGINT        NULL,
    [slea_ref_compnr]      BIGINT        NULL,
    [tdty_tdim_ref_compnr] BIGINT        NULL,
    [tdty_ref_compnr]      BIGINT        NULL,
    [tlea_ref_compnr]      BIGINT        NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFCAT004_lookup]
    ON [dbo].[LN_TFCAT004]([compnr] ASC, [sdty] ASC, [sdim] ASC, [cpor] ASC);


GO

