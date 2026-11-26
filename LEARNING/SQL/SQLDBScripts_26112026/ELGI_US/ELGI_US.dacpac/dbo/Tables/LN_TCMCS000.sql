CREATE TABLE [dbo].[LN_TCMCS000] (
    [compnr]          BIGINT        NULL,
    [indt]            NVARCHAR (40) NULL,
    [dsca]            NVARCHAR (50) NULL,
    [cwei]            NVARCHAR (3)  NULL,
    [clen]            NVARCHAR (3)  NULL,
    [care]            NVARCHAR (3)  NULL,
    [cvol]            NVARCHAR (3)  NULL,
    [ctim]            NVARCHAR (3)  NULL,
    [rtyp]            NVARCHAR (3)  NULL,
    [logn]            NVARCHAR (16) NULL,
    [cwei_ref_compnr] BIGINT        NULL,
    [clen_ref_compnr] BIGINT        NULL,
    [care_ref_compnr] BIGINT        NULL,
    [cvol_ref_compnr] BIGINT        NULL,
    [ctim_ref_compnr] BIGINT        NULL,
    [rtyp_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCMCS000_lookup]
    ON [dbo].[LN_TCMCS000]([compnr] ASC, [indt] ASC);


GO

