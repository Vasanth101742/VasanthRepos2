CREATE TABLE [dbo].[LN_WHWMD215] (
    [compnr]               BIGINT        NULL,
    [cwar]                 NVARCHAR (6)  NULL,
    [item]                 NVARCHAR (47) NULL,
    [qhnd]                 FLOAT (53)    NULL,
    [qchd]                 FLOAT (53)    NULL,
    [qnhd]                 FLOAT (53)    NULL,
    [qblk]                 FLOAT (53)    NULL,
    [qbpl]                 FLOAT (53)    NULL,
    [qord]                 FLOAT (53)    NULL,
    [qoor]                 FLOAT (53)    NULL,
    [qcor]                 FLOAT (53)    NULL,
    [qnor]                 FLOAT (53)    NULL,
    [qgit]                 FLOAT (53)    NULL,
    [qint]                 FLOAT (53)    NULL,
    [qcit]                 FLOAT (53)    NULL,
    [qnit]                 FLOAT (53)    NULL,
    [qall]                 FLOAT (53)    NULL,
    [qoal]                 FLOAT (53)    NULL,
    [qcal]                 FLOAT (53)    NULL,
    [qnal]                 FLOAT (53)    NULL,
    [qnbl]                 FLOAT (53)    NULL,
    [qnbp]                 FLOAT (53)    NULL,
    [qcom]                 FLOAT (53)    NULL,
    [qlal]                 FLOAT (53)    NULL,
    [qcpr]                 FLOAT (53)    NULL,
    [qhrj]                 FLOAT (53)    NULL,
    [qcrj]                 FLOAT (53)    NULL,
    [qnrj]                 FLOAT (53)    NULL,
    [ltdt]                 NVARCHAR (40) NULL,
    [hstd]                 NVARCHAR (40) NULL,
    [lsid]                 NVARCHAR (40) NULL,
    [qcis]                 FLOAT (53)    NULL,
    [qhib]                 FLOAT (53)    NULL,
    [cwar_item_ref_compnr] BIGINT        NULL,
    [cwar_ref_compnr]      BIGINT        NULL,
    [item_ref_compnr]      BIGINT        NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_WHWMD215_lookup]
    ON [dbo].[LN_WHWMD215]([compnr] ASC, [cwar] ASC, [item] ASC);


GO

