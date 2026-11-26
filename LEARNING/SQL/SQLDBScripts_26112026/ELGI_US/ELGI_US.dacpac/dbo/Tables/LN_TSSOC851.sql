CREATE TABLE [dbo].[LN_TSSOC851] (
    [compnr]          BIGINT         NULL,
    [orno]            NVARCHAR (9)   NULL,
    [vsln]            BIGINT         NULL,
    [htim]            NVARCHAR (40)  NULL,
    [emno]            NVARCHAR (9)   NULL,
    [lcad]            NVARCHAR (9)   NULL,
    [astm]            NVARCHAR (40)  NULL,
    [aftm]            NVARCHAR (40)  NULL,
    [file]            NVARCHAR (256) NULL,
    [vrsb]            BIGINT         NULL,
    [vrsb_kw]         NVARCHAR (24)  NULL,
    [orno_ref_compnr] BIGINT         NULL,
    [emno_ref_compnr] BIGINT         NULL,
    [lcad_ref_compnr] BIGINT         NULL,
    [deleted]         NCHAR (1)      NULL,
    [username]        NVARCHAR (8)   NULL,
    [timestamp]       DATETIME       NULL,
    [sequencenumber]  BIGINT         NULL,
    [dlDocumentDate]  NVARCHAR (40)  NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSSOC851_lookup]
    ON [dbo].[LN_TSSOC851]([compnr] ASC, [orno] ASC, [vsln] ASC, [htim] ASC);


GO

