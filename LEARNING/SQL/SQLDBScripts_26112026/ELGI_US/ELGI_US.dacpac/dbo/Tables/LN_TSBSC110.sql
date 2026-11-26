CREATE TABLE [dbo].[LN_TSBSC110] (
    [compnr]               BIGINT        NULL,
    [clst]                 NVARCHAR (9)  NULL,
    [clcl]                 BIGINT        NULL,
    [item]                 NVARCHAR (47) NULL,
    [sern]                 NVARCHAR (30) NULL,
    [nitm]                 BIGINT        NULL,
    [stat]                 BIGINT        NULL,
    [stat_kw]              NVARCHAR (29) NULL,
    [sttm]                 NVARCHAR (40) NULL,
    [pltm]                 NVARCHAR (40) NULL,
    [clot]                 NVARCHAR (20) NULL,
    [clst_ref_compnr]      BIGINT        NULL,
    [item_sern_ref_compnr] BIGINT        NULL,
    [item_ref_compnr]      BIGINT        NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSBSC110_lookup]
    ON [dbo].[LN_TSBSC110]([compnr] ASC, [clst] ASC, [clcl] ASC);


GO

