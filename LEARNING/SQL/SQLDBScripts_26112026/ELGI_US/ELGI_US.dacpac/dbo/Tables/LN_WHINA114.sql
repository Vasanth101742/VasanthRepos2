CREATE TABLE [dbo].[LN_WHINA114] (
    [compnr]          BIGINT        NULL,
    [item]            NVARCHAR (47) NULL,
    [cwar]            NVARCHAR (6)  NULL,
    [trdt]            NVARCHAR (40) NULL,
    [seqn]            BIGINT        NULL,
    [inwp]            BIGINT        NULL,
    [sern]            BIGINT        NULL,
    [inwp_kw]         NVARCHAR (20) NULL,
    [atse]            NVARCHAR (35) NULL,
    [ctdt]            NVARCHAR (40) NULL,
    [qstk]            FLOAT (53)    NULL,
    [serl]            NVARCHAR (30) NULL,
    [clot]            NVARCHAR (20) NULL,
    [tagn]            NVARCHAR (9)  NULL,
    [lgdt]            NVARCHAR (40) NULL,
    [ocmp]            BIGINT        NULL,
    [koor]            BIGINT        NULL,
    [koor_kw]         NVARCHAR (22) NULL,
    [orno]            NVARCHAR (9)  NULL,
    [pono]            BIGINT        NULL,
    [srnb]            BIGINT        NULL,
    [dlin]            BIGINT        NULL,
    [itid]            NVARCHAR (9)  NULL,
    [itse]            BIGINT        NULL,
    [wvgr]            NVARCHAR (6)  NULL,
    [cprj]            NVARCHAR (9)  NULL,
    [owns]            BIGINT        NULL,
    [owns_kw]         NVARCHAR (22) NULL,
    [ownr]            NVARCHAR (9)  NULL,
    [bfbp]            NVARCHAR (9)  NULL,
    [reje]            BIGINT        NULL,
    [reje_kw]         NVARCHAR (20) NULL,
    [phtr]            BIGINT        NULL,
    [phtr_kw]         NVARCHAR (20) NULL,
    [item_ref_compnr] BIGINT        NULL,
    [cwar_ref_compnr] BIGINT        NULL,
    [atse_ref_compnr] BIGINT        NULL,
    [ocmp_ref_compnr] BIGINT        NULL,
    [wvgr_ref_compnr] BIGINT        NULL,
    [cprj_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_WHINA114_lookup]
    ON [dbo].[LN_WHINA114]([compnr] ASC, [item] ASC, [cwar] ASC, [trdt] ASC, [seqn] ASC, [inwp] ASC, [sern] ASC);


GO

