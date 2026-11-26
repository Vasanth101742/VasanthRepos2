CREATE TABLE [dbo].[LN_TTAAD420] (
    [compnr]          BIGINT        NULL,
    [tabg]            BIGINT        NULL,
    [tabl]            NVARCHAR (8)  NULL,
    [lcmp]            BIGINT        NULL,
    [tabg_kw]         NVARCHAR (22) NULL,
    [fcmp]            BIGINT        NULL,
    [lcmp_ref_compnr] BIGINT        NULL,
    [fcmp_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TTAAD420_lookup]
    ON [dbo].[LN_TTAAD420]([compnr] ASC, [tabg] ASC, [tabl] ASC, [lcmp] ASC);


GO

