CREATE TABLE [dbo].[LN_TCIBD004] (
    [compnr]          BIGINT        NULL,
    [citt]            NVARCHAR (3)  NULL,
    [bpid]            NVARCHAR (9)  NULL,
    [item]            NVARCHAR (47) NULL,
    [aitc]            NVARCHAR (35) NULL,
    [aitd]            NVARCHAR (60) NULL,
    [citt_ref_compnr] BIGINT        NULL,
    [bpid_ref_compnr] BIGINT        NULL,
    [item_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCIBD004_lookup]
    ON [dbo].[LN_TCIBD004]([compnr] ASC, [citt] ASC, [bpid] ASC, [item] ASC);


GO

