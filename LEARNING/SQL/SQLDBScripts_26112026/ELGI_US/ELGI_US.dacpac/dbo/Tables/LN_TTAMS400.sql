CREATE TABLE [dbo].[LN_TTAMS400] (
    [compnr]          BIGINT        NULL,
    [cntx]            BIGINT        NULL,
    [cdem]            BIGINT        NULL,
    [brfm]            NVARCHAR (6)  NULL,
    [vers]            NVARCHAR (10) NULL,
    [optp]            NVARCHAR (6)  NULL,
    [role]            NVARCHAR (15) NULL,
    [cntx_kw]         NVARCHAR (20) NULL,
    [desc]            NVARCHAR (70) NULL,
    [gnrt]            BIGINT        NULL,
    [gnrt_kw]         NVARCHAR (20) NULL,
    [gntm]            NVARCHAR (40) NULL,
    [chgd]            BIGINT        NULL,
    [chgd_kw]         NVARCHAR (20) NULL,
    [chdt]            NVARCHAR (40) NULL,
    [chlg]            NVARCHAR (12) NULL,
    [txtn]            BIGINT        NULL,
    [cdem_ref_compnr] BIGINT        NULL,
    [txtn_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TTAMS400_lookup]
    ON [dbo].[LN_TTAMS400]([compnr] ASC, [cntx] ASC, [cdem] ASC, [brfm] ASC, [vers] ASC, [optp] ASC, [role] ASC);


GO

