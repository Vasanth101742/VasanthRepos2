CREATE TABLE [dbo].[LN_TCIBD411] (
    [compnr]          BIGINT        NULL,
    [lssn]            NVARCHAR (22) NULL,
    [seqn]            BIGINT        NULL,
    [clot]            NVARCHAR (20) NULL,
    [sern]            NVARCHAR (30) NULL,
    [atse]            NVARCHAR (35) NULL,
    [tagn]            NVARCHAR (9)  NULL,
    [quni]            FLOAT (53)    NULL,
    [qipu]            FLOAT (53)    NULL,
    [atse_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCIBD411_lookup]
    ON [dbo].[LN_TCIBD411]([compnr] ASC, [lssn] ASC, [seqn] ASC);


GO

