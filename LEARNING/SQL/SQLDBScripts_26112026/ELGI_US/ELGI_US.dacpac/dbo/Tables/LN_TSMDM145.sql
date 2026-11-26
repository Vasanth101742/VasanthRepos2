CREATE TABLE [dbo].[LN_TSMDM145] (
    [compnr]          BIGINT        NULL,
    [ccar]            NVARCHAR (10) NULL,
    [desc]            NVARCHAR (30) NULL,
    [cwar]            NVARCHAR (6)  NULL,
    [imbs]            BIGINT        NULL,
    [imbs_kw]         NVARCHAR (20) NULL,
    [coun]            FLOAT (53)    NULL,
    [cuni]            NVARCHAR (3)  NULL,
    [cndt]            NVARCHAR (10) NULL,
    [telp]            NVARCHAR (32) NULL,
    [cwar_ref_compnr] BIGINT        NULL,
    [cuni_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSMDM145_lookup]
    ON [dbo].[LN_TSMDM145]([compnr] ASC, [ccar] ASC);


GO

