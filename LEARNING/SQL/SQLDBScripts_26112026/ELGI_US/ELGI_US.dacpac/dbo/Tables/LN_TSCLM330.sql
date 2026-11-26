CREATE TABLE [dbo].[LN_TSCLM330] (
    [compnr]          BIGINT        NULL,
    [cprl]            NVARCHAR (10) NULL,
    [desc]            NVARCHAR (30) NULL,
    [prpr]            BIGINT        NULL,
    [sear]            NVARCHAR (16) NULL,
    [rpyn]            BIGINT        NULL,
    [rpyn_kw]         NVARCHAR (20) NULL,
    [epyn]            BIGINT        NULL,
    [epyn_kw]         NVARCHAR (20) NULL,
    [esyn]            BIGINT        NULL,
    [esyn_kw]         NVARCHAR (20) NULL,
    [umtc]            BIGINT        NULL,
    [umtc_kw]         NVARCHAR (20) NULL,
    [prpr_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCLM330_lookup]
    ON [dbo].[LN_TSCLM330]([compnr] ASC, [cprl] ASC);


GO

