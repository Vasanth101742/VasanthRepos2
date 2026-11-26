CREATE TABLE [dbo].[LN_WHINR120] (
    [compnr]          BIGINT        NULL,
    [item]            NVARCHAR (47) NULL,
    [year]            BIGINT        NULL,
    [peri]            BIGINT        NULL,
    [acip]            FLOAT (53)    NULL,
    [decl]            FLOAT (53)    NULL,
    [deqt]            FLOAT (53)    NULL,
    [qdeq]            FLOAT (53)    NULL,
    [ddcl]            FLOAT (53)    NULL,
    [ddqt]            FLOAT (53)    NULL,
    [lsts]            FLOAT (53)    NULL,
    [dmfp]            FLOAT (53)    NULL,
    [rets]            FLOAT (53)    NULL,
    [item_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_WHINR120_lookup]
    ON [dbo].[LN_WHINR120]([compnr] ASC, [item] ASC, [year] ASC, [peri] ASC);


GO

