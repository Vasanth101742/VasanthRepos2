CREATE TABLE [dbo].[LN_TCCCP000] (
    [compnr]         BIGINT         NULL,
    [indt]           NVARCHAR (40)  NULL,
    [dsca]           NVARCHAR (50)  NULL,
    [sttm]           BIGINT         NULL,
    [clcc]           BIGINT         NULL,
    [wfrc]           NVARCHAR (255) NULL,
    [wfic]           NVARCHAR (255) NULL,
    [ract]           NVARCHAR (6)   NULL,
    [wrng]           BIGINT         NULL,
    [uwht]           BIGINT         NULL,
    [uwht_kw]        NVARCHAR (20)  NULL,
    [deleted]        NCHAR (1)      NULL,
    [username]       NVARCHAR (8)   NULL,
    [timestamp]      DATETIME       NULL,
    [sequencenumber] BIGINT         NULL,
    [dlDocumentDate] NVARCHAR (40)  NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCCCP000_lookup]
    ON [dbo].[LN_TCCCP000]([compnr] ASC, [indt] ASC);


GO

