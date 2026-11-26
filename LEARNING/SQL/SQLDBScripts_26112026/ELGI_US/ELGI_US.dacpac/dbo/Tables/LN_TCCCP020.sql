CREATE TABLE [dbo].[LN_TCCCP020] (
    [compnr]               BIGINT        NULL,
    [ccal]                 NVARCHAR (9)  NULL,
    [ract]                 NVARCHAR (6)  NULL,
    [date]                 NVARCHAR (10) NULL,
    [sern]                 BIGINT        NULL,
    [sttm]                 BIGINT        NULL,
    [entm]                 BIGINT        NULL,
    [shfn]                 NVARCHAR (9)  NULL,
    [titp]                 NVARCHAR (6)  NULL,
    [capp]                 BIGINT        NULL,
    [ovyn]                 BIGINT        NULL,
    [ovyn_kw]              NVARCHAR (20) NULL,
    [dfca]                 BIGINT        NULL,
    [dfca_kw]              NVARCHAR (21) NULL,
    [pcal]                 NVARCHAR (9)  NULL,
    [pcode]                BIGINT        NULL,
    [recu]                 NVARCHAR (6)  NULL,
    [wkwk]                 NVARCHAR (9)  NULL,
    [avlb]                 BIGINT        NULL,
    [avlb_kw]              NVARCHAR (20) NULL,
    [efac]                 FLOAT (53)    NULL,
    [desc]                 NVARCHAR (30) NULL,
    [ccal_ref_compnr]      BIGINT        NULL,
    [ccal_ract_ref_compnr] BIGINT        NULL,
    [ract_ref_compnr]      BIGINT        NULL,
    [titp_ref_compnr]      BIGINT        NULL,
    [recu_ref_compnr]      BIGINT        NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCCCP020_lookup]
    ON [dbo].[LN_TCCCP020]([compnr] ASC, [ccal] ASC, [ract] ASC, [date] ASC, [sern] ASC);


GO

