CREATE TABLE [dbo].[LN_TFACP106] (
    [compnr]          BIGINT        NULL,
    [fact]            NVARCHAR (9)  NULL,
    [ptbp]            NVARCHAR (9)  NULL,
    [fano]            NVARCHAR (10) NULL,
    [dfbp]            BIGINT        NULL,
    [dfbp_kw]         NVARCHAR (20) NULL,
    [actv]            BIGINT        NULL,
    [actv_kw]         NVARCHAR (20) NULL,
    [fact_ref_compnr] BIGINT        NULL,
    [ptbp_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFACP106_lookup]
    ON [dbo].[LN_TFACP106]([compnr] ASC, [fact] ASC, [ptbp] ASC);


GO

