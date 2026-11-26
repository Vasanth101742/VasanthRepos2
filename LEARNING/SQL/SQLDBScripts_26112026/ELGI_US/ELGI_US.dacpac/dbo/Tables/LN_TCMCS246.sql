CREATE TABLE [dbo].[LN_TCMCS246] (
    [compnr]          BIGINT        NULL,
    [inpl]            NVARCHAR (9)  NULL,
    [nins]            BIGINT        NULL,
    [desc]            NVARCHAR (50) NULL,
    [inty]            BIGINT        NULL,
    [inty_kw]         NVARCHAR (25) NULL,
    [perc]            FLOAT (53)    NULL,
    [pipr]            BIGINT        NULL,
    [txta]            BIGINT        NULL,
    [inpl_ref_compnr] BIGINT        NULL,
    [txta_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCMCS246_lookup]
    ON [dbo].[LN_TCMCS246]([compnr] ASC, [inpl] ASC, [nins] ASC);


GO

