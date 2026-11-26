CREATE TABLE [dbo].[LN_TCCOM998] (
    [compnr]         BIGINT         NULL,
    [indt]           NVARCHAR (40)  NULL,
    [dsca]           NVARCHAR (50)  NULL,
    [txpr]           BIGINT         NULL,
    [txpr_kw]        NVARCHAR (20)  NULL,
    [potp]           BIGINT         NULL,
    [potp_kw]        NVARCHAR (20)  NULL,
    [txms]           BIGINT         NULL,
    [txms_kw]        NVARCHAR (20)  NULL,
    [itmr]           BIGINT         NULL,
    [itmr_kw]        NVARCHAR (20)  NULL,
    [itgr]           BIGINT         NULL,
    [itgr_kw]        NVARCHAR (20)  NULL,
    [ctpr]           BIGINT         NULL,
    [ctpr_kw]        NVARCHAR (20)  NULL,
    [accr]           BIGINT         NULL,
    [accr_kw]        NVARCHAR (20)  NULL,
    [stpr]           BIGINT         NULL,
    [stpr_kw]        NVARCHAR (20)  NULL,
    [edtr]           BIGINT         NULL,
    [edtr_kw]        NVARCHAR (20)  NULL,
    [prjr]           BIGINT         NULL,
    [prjr_kw]        NVARCHAR (20)  NULL,
    [stsk]           BIGINT         NULL,
    [stsk_kw]        NVARCHAR (20)  NULL,
    [ptsk]           BIGINT         NULL,
    [ptsk_kw]        NVARCHAR (20)  NULL,
    [ssdr]           BIGINT         NULL,
    [ssdr_kw]        NVARCHAR (20)  NULL,
    [psdr]           BIGINT         NULL,
    [psdr_kw]        NVARCHAR (20)  NULL,
    [prov]           BIGINT         NULL,
    [prov_kw]        NVARCHAR (20)  NULL,
    [qbus]           NVARCHAR (100) NULL,
    [deleted]        NCHAR (1)      NULL,
    [username]       NVARCHAR (8)   NULL,
    [timestamp]      DATETIME       NULL,
    [sequencenumber] BIGINT         NULL,
    [dlDocumentDate] NVARCHAR (40)  NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCCOM998_lookup]
    ON [dbo].[LN_TCCOM998]([compnr] ASC, [indt] ASC);


GO

