CREATE TABLE [dbo].[LN_TFFBS000] (
    [compnr]          BIGINT        NULL,
    [indt]            NVARCHAR (40) NULL,
    [dsca]            NVARCHAR (50) NULL,
    [dcur]            NVARCHAR (3)  NULL,
    [hier]            NVARCHAR (3)  NULL,
    [rtat]            BIGINT        NULL,
    [rtat_kw]         NVARCHAR (20) NULL,
    [uefr]            BIGINT        NULL,
    [uefr_kw]         NVARCHAR (20) NULL,
    [rsub]            BIGINT        NULL,
    [rsub_kw]         NVARCHAR (20) NULL,
    [text]            BIGINT        NULL,
    [dcur_ref_compnr] BIGINT        NULL,
    [hier_ref_compnr] BIGINT        NULL,
    [text_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFFBS000_lookup]
    ON [dbo].[LN_TFFBS000]([compnr] ASC, [indt] ASC);


GO

