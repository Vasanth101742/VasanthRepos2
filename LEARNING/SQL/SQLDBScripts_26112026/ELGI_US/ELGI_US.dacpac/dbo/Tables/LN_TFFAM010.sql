CREATE TABLE [dbo].[LN_TFFAM010] (
    [compnr]          BIGINT        NULL,
    [book]            NVARCHAR (10) NULL,
    [reqd]            BIGINT        NULL,
    [reqd_kw]         NVARCHAR (20) NULL,
    [addl]            BIGINT        NULL,
    [addl_kw]         NVARCHAR (20) NULL,
    [book_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFFAM010_lookup]
    ON [dbo].[LN_TFFAM010]([compnr] ASC, [book] ASC);


GO

