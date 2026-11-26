CREATE TABLE [dbo].[LN_TFCAT003] (
    [compnr]          BIGINT        NULL,
    [coca]            NVARCHAR (12) NULL,
    [leac]            NVARCHAR (12) NULL,
    [perc]            FLOAT (53)    NULL,
    [coca_ref_compnr] BIGINT        NULL,
    [leac_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFCAT003_lookup]
    ON [dbo].[LN_TFCAT003]([compnr] ASC, [coca] ASC, [leac] ASC);


GO

