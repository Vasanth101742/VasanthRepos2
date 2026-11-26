CREATE TABLE [dbo].[LN_TSCFG262] (
    [compnr]               BIGINT          NULL,
    [item]                 NVARCHAR (47)   NULL,
    [sern]                 NVARCHAR (30)   NULL,
    [stdt]                 NVARCHAR (40)   NULL,
    [occu]                 BIGINT          NULL,
    [endt]                 NVARCHAR (40)   NULL,
    [date]                 NVARCHAR (10)   NULL,
    [dura]                 DECIMAL (12, 6) NULL,
    [orig]                 BIGINT          NULL,
    [orig_kw]              NVARCHAR (22)   NULL,
    [avyn]                 BIGINT          NULL,
    [avyn_kw]              NVARCHAR (22)   NULL,
    [boty]                 BIGINT          NULL,
    [boty_kw]              NVARCHAR (27)   NULL,
    [boco]                 BIGINT          NULL,
    [bobj]                 NVARCHAR (9)    NULL,
    [line]                 BIGINT          NULL,
    [cotp]                 BIGINT          NULL,
    [cotp_kw]              NVARCHAR (20)   NULL,
    [dtln]                 BIGINT          NULL,
    [mtyp]                 BIGINT          NULL,
    [mtyp_kw]              NVARCHAR (25)   NULL,
    [seqn]                 BIGINT          NULL,
    [sqnb]                 BIGINT          NULL,
    [item_sern_ref_compnr] BIGINT          NULL,
    [item_ref_compnr]      BIGINT          NULL,
    [deleted]              NCHAR (1)       NULL,
    [username]             NVARCHAR (8)    NULL,
    [timestamp]            DATETIME        NULL,
    [sequencenumber]       BIGINT          NULL,
    [dlDocumentDate]       NVARCHAR (40)   NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCFG262_lookup]
    ON [dbo].[LN_TSCFG262]([compnr] ASC, [item] ASC, [sern] ASC, [stdt] ASC, [occu] ASC);


GO

