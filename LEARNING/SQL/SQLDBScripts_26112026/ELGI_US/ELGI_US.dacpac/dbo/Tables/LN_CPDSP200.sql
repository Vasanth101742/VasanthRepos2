CREATE TABLE [dbo].[LN_CPDSP200] (
    [compnr]          BIGINT        NULL,
    [plnc]            NVARCHAR (3)  NULL,
    [plni]            NVARCHAR (50) NULL,
    [inst]            NVARCHAR (9)  NULL,
    [spdt]            NVARCHAR (40) NULL,
    [orig]            BIGINT        NULL,
    [sern]            BIGINT        NULL,
    [orig_kw]         NVARCHAR (20) NULL,
    [quan]            FLOAT (53)    NULL,
    [requ]            FLOAT (53)    NULL,
    [reas]            NVARCHAR (60) NULL,
    [spid]            NVARCHAR (22) NULL,
    [plnc_ref_compnr] BIGINT        NULL,
    [plni_ref_compnr] BIGINT        NULL,
    [spid_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_CPDSP200_lookup]
    ON [dbo].[LN_CPDSP200]([compnr] ASC, [plnc] ASC, [plni] ASC, [inst] ASC, [spdt] ASC, [orig] ASC, [sern] ASC);


GO

