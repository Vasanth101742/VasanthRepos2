CREATE TABLE [dbo].[LN_TSMDM015] (
    [compnr]          BIGINT        NULL,
    [ctsk]            NVARCHAR (8)  NULL,
    [desc]            NVARCHAR (30) NULL,
    [sear]            NVARCHAR (16) NULL,
    [clrt]            NVARCHAR (6)  NULL,
    [occf]            FLOAT (53)    NULL,
    [cpcp]            NVARCHAR (8)  NULL,
    [tmdu]            FLOAT (53)    NULL,
    [txta]            BIGINT        NULL,
    [clrt_ref_compnr] BIGINT        NULL,
    [cpcp_ref_compnr] BIGINT        NULL,
    [txta_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSMDM015_lookup]
    ON [dbo].[LN_TSMDM015]([compnr] ASC, [ctsk] ASC);


GO

