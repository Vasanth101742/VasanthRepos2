CREATE TABLE [dbo].[LN_TFGLD010] (
    [compnr]               BIGINT        NULL,
    [dtyp]                 BIGINT        NULL,
    [dimx]                 NVARCHAR (9)  NULL,
    [desc]                 NVARCHAR (50) NULL,
    [subl]                 BIGINT        NULL,
    [pdix]                 NVARCHAR (9)  NULL,
    [uni1]                 BIGINT        NULL,
    [uni1_kw]              NVARCHAR (20) NULL,
    [uni2]                 BIGINT        NULL,
    [uni2_kw]              NVARCHAR (20) NULL,
    [emno]                 NVARCHAR (9)  NULL,
    [pseq]                 BIGINT        NULL,
    [bloc]                 BIGINT        NULL,
    [bloc_kw]              NVARCHAR (23) NULL,
    [bfdt]                 NVARCHAR (10) NULL,
    [budt]                 NVARCHAR (10) NULL,
    [atyp]                 BIGINT        NULL,
    [atyp_kw]              NVARCHAR (20) NULL,
    [skey]                 NVARCHAR (16) NULL,
    [qan1]                 NVARCHAR (3)  NULL,
    [qan2]                 NVARCHAR (3)  NULL,
    [text]                 BIGINT        NULL,
    [dtyp_pdix_ref_compnr] BIGINT        NULL,
    [dtyp_ref_compnr]      BIGINT        NULL,
    [emno_ref_compnr]      BIGINT        NULL,
    [qan1_ref_compnr]      BIGINT        NULL,
    [qan2_ref_compnr]      BIGINT        NULL,
    [text_ref_compnr]      BIGINT        NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFGLD010_lookup]
    ON [dbo].[LN_TFGLD010]([compnr] ASC, [dtyp] ASC, [dimx] ASC);


GO

