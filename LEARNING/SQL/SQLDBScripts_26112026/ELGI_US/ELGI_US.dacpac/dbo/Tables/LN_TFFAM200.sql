CREATE TABLE [dbo].[LN_TFFAM200] (
    [compnr]          BIGINT        NULL,
    [ctgy]            NVARCHAR (10) NULL,
    [agrp]            NVARCHAR (10) NULL,
    [amth]            NVARCHAR (20) NULL,
    [aslf]            BIGINT        NULL,
    [bslv]            BIGINT        NULL,
    [bslv_kw]         NVARCHAR (20) NULL,
    [cmth]            NVARCHAR (20) NULL,
    [desc]            NVARCHAR (30) NULL,
    [fmth]            NVARCHAR (20) NULL,
    [itcd]            BIGINT        NULL,
    [itcd_kw]         NVARCHAR (20) NULL,
    [lmth]            NVARCHAR (20) NULL,
    [life]            BIGINT        NULL,
    [mmth]            NVARCHAR (20) NULL,
    [omth]            NVARCHAR (20) NULL,
    [prop]            NVARCHAR (10) NULL,
    [sctg]            NVARCHAR (10) NULL,
    [smth]            NVARCHAR (20) NULL,
    [tmth]            NVARCHAR (20) NULL,
    [umth]            NVARCHAR (20) NULL,
    [dscr]            BIGINT        NULL,
    [dscr_kw]         NVARCHAR (20) NULL,
    [fadr]            FLOAT (53)    NULL,
    [agrp_ref_compnr] BIGINT        NULL,
    [amth_ref_compnr] BIGINT        NULL,
    [cmth_ref_compnr] BIGINT        NULL,
    [fmth_ref_compnr] BIGINT        NULL,
    [lmth_ref_compnr] BIGINT        NULL,
    [mmth_ref_compnr] BIGINT        NULL,
    [omth_ref_compnr] BIGINT        NULL,
    [prop_ref_compnr] BIGINT        NULL,
    [smth_ref_compnr] BIGINT        NULL,
    [tmth_ref_compnr] BIGINT        NULL,
    [umth_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFFAM200_lookup]
    ON [dbo].[LN_TFFAM200]([compnr] ASC, [ctgy] ASC);


GO

