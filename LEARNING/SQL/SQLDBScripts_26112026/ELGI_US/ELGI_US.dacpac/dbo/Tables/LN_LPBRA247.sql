CREATE TABLE [dbo].[LN_LPBRA247] (
    [compnr]          BIGINT        NULL,
    [fire]            NVARCHAR (9)  NULL,
    [flin]            BIGINT        NULL,
    [item]            NVARCHAR (47) NULL,
    [pric]            FLOAT (53)    NULL,
    [cups]            NVARCHAR (3)  NULL,
    [dqua]            FLOAT (53)    NULL,
    [cuns]            NVARCHAR (3)  NULL,
    [copr]            FLOAT (53)    NULL,
    [iprt]            FLOAT (53)    NULL,
    [gamt]            FLOAT (53)    NULL,
    [amnt]            FLOAT (53)    NULL,
    [fire_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_LPBRA247_lookup]
    ON [dbo].[LN_LPBRA247]([compnr] ASC, [fire] ASC, [flin] ASC);


GO

