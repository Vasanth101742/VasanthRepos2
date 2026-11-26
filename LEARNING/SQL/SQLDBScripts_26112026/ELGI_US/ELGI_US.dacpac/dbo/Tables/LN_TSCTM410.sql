CREATE TABLE [dbo].[LN_TSCTM410] (
    [compnr]         BIGINT        NULL,
    [ctin]           NVARCHAR (3)  NULL,
    [desc]           NVARCHAR (30) NULL,
    [nrpe]           BIGINT        NULL,
    [peru]           BIGINT        NULL,
    [peru_kw]        NVARCHAR (20) NULL,
    [vins]           BIGINT        NULL,
    [vins_kw]        NVARCHAR (21) NULL,
    [shnp]           BIGINT        NULL,
    [shpu]           BIGINT        NULL,
    [shpu_kw]        NVARCHAR (20) NULL,
    [nrpf]           BIGINT        NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM410_lookup]
    ON [dbo].[LN_TSCTM410]([compnr] ASC, [ctin] ASC);


GO

