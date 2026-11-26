CREATE TABLE [dbo].[LN_TFGLD019] (
    [compnr]          BIGINT        NULL,
    [ccur]            NVARCHAR (3)  NULL,
    [modu]            BIGINT        NULL,
    [tcur]            BIGINT        NULL,
    [modu_kw]         NVARCHAR (20) NULL,
    [tcur_kw]         NVARCHAR (26) NULL,
    [leac]            NVARCHAR (12) NULL,
    [ccur_ref_compnr] BIGINT        NULL,
    [leac_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFGLD019_lookup]
    ON [dbo].[LN_TFGLD019]([compnr] ASC, [ccur] ASC, [modu] ASC, [tcur] ASC);


GO

