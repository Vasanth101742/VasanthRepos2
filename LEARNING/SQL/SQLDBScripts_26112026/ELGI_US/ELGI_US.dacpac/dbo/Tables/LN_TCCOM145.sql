CREATE TABLE [dbo].[LN_TCCOM145] (
    [compnr]          BIGINT        NULL,
    [bpid]            NVARCHAR (9)  NULL,
    [ccnt]            NVARCHAR (9)  NULL,
    [cofc]            NVARCHAR (6)  NULL,
    [cmsk_1]          BIGINT        NULL,
    [cmsk_kw_1]       NVARCHAR (20) NULL,
    [cmsk_2]          BIGINT        NULL,
    [cmsk_kw_2]       NVARCHAR (20) NULL,
    [cmsk_3]          BIGINT        NULL,
    [cmsk_kw_3]       NVARCHAR (20) NULL,
    [cmsk_4]          BIGINT        NULL,
    [cmsk_kw_4]       NVARCHAR (20) NULL,
    [cmsk_5]          BIGINT        NULL,
    [cmsk_kw_5]       NVARCHAR (20) NULL,
    [cmsk_6]          BIGINT        NULL,
    [cmsk_kw_6]       NVARCHAR (20) NULL,
    [cmsk_7]          BIGINT        NULL,
    [cmsk_kw_7]       NVARCHAR (20) NULL,
    [cmsk_8]          BIGINT        NULL,
    [cmsk_kw_8]       NVARCHAR (20) NULL,
    [cmsk_9]          BIGINT        NULL,
    [cmsk_kw_9]       NVARCHAR (20) NULL,
    [ctpr_1]          BIGINT        NULL,
    [ctpr_kw_1]       NVARCHAR (20) NULL,
    [ctpr_2]          BIGINT        NULL,
    [ctpr_kw_2]       NVARCHAR (20) NULL,
    [ctpr_3]          BIGINT        NULL,
    [ctpr_kw_3]       NVARCHAR (20) NULL,
    [ctpr_4]          BIGINT        NULL,
    [ctpr_kw_4]       NVARCHAR (20) NULL,
    [ctpr_5]          BIGINT        NULL,
    [ctpr_kw_5]       NVARCHAR (20) NULL,
    [ctpr_6]          BIGINT        NULL,
    [ctpr_kw_6]       NVARCHAR (20) NULL,
    [ctpr_7]          BIGINT        NULL,
    [ctpr_kw_7]       NVARCHAR (20) NULL,
    [ctpr_8]          BIGINT        NULL,
    [ctpr_kw_8]       NVARCHAR (20) NULL,
    [ctpr_9]          BIGINT        NULL,
    [ctpr_kw_9]       NVARCHAR (20) NULL,
    [seak]            NVARCHAR (16) NULL,
    [bpid_ref_compnr] BIGINT        NULL,
    [ccnt_ref_compnr] BIGINT        NULL,
    [cofc_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCCOM145_lookup]
    ON [dbo].[LN_TCCOM145]([compnr] ASC, [bpid] ASC, [ccnt] ASC, [cofc] ASC);


GO

