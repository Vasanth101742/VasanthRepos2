CREATE TABLE [dbo].[LN_TCCOM180] (
    [compnr]         BIGINT        NULL,
    [ctst]           NVARCHAR (14) NULL,
    [dsca]           NVARCHAR (30) NULL,
    [cdf_ubbb]       BIGINT        NULL,
    [cdf_ubbb_kw]    NVARCHAR (20) NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCCOM180_lookup]
    ON [dbo].[LN_TCCOM180]([compnr] ASC, [ctst] ASC);


GO

