CREATE TABLE [dbo].[LN_TCLCT020] (
    [compnr]         BIGINT        NULL,
    [clas]           NVARCHAR (12) NULL,
    [dsca]           NVARCHAR (30) NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCLCT020_lookup]
    ON [dbo].[LN_TCLCT020]([compnr] ASC, [clas] ASC);


GO

