CREATE TABLE [dbo].[LN_TCMCS080] (
    [compnr]          BIGINT        NULL,
    [cfrw]            NVARCHAR (3)  NULL,
    [dsca]            NVARCHAR (30) NULL,
    [seak]            NVARCHAR (16) NULL,
    [suno]            NVARCHAR (9)  NULL,
    [trmd]            BIGINT        NULL,
    [trmd_kw]         NVARCHAR (26) NULL,
    [scac]            NVARCHAR (20) NULL,
    [cdf_mail]        NVARCHAR (30) NULL,
    [suno_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCMCS080_lookup]
    ON [dbo].[LN_TCMCS080]([compnr] ASC, [cfrw] ASC);


GO

