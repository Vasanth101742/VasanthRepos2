CREATE TABLE [dbo].[LN_WHINH140] (
    [compnr]          BIGINT        NULL,
    [orno]            NVARCHAR (9)  NULL,
    [seri]            NVARCHAR (8)  NULL,
    [cwar]            NVARCHAR (6)  NULL,
    [crdt]            NVARCHAR (40) NULL,
    [prcd]            BIGINT        NULL,
    [prcd_kw]         NVARCHAR (20) NULL,
    [rexp]            BIGINT        NULL,
    [rexp_kw]         NVARCHAR (20) NULL,
    [txtn]            BIGINT        NULL,
    [cwar_ref_compnr] BIGINT        NULL,
    [txtn_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_WHINH140_lookup]
    ON [dbo].[LN_WHINH140]([compnr] ASC, [orno] ASC);


GO

