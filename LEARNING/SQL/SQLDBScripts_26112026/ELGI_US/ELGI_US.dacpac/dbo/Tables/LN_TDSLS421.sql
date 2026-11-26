CREATE TABLE [dbo].[LN_TDSLS421] (
    [compnr]          BIGINT        NULL,
    [orno]            NVARCHAR (9)  NULL,
    [pono]            BIGINT        NULL,
    [sqnb]            BIGINT        NULL,
    [csqn]            BIGINT        NULL,
    [hrea]            NVARCHAR (3)  NULL,
    [dtbl]            NVARCHAR (40) NULL,
    [opon]            BIGINT        NULL,
    [lobl]            NVARCHAR (16) NULL,
    [dtrl]            NVARCHAR (40) NULL,
    [lorl]            NVARCHAR (16) NULL,
    [bpid]            NVARCHAR (9)  NULL,
    [bprt]            BIGINT        NULL,
    [bprt_kw]         NVARCHAR (21) NULL,
    [rlty]            BIGINT        NULL,
    [rlty_kw]         NVARCHAR (20) NULL,
    [rlam]            FLOAT (53)    NULL,
    [erdt]            NVARCHAR (40) NULL,
    [pstc]            NVARCHAR (10) NULL,
    [phsn]            BIGINT        NULL,
    [orno_ref_compnr] BIGINT        NULL,
    [hrea_ref_compnr] BIGINT        NULL,
    [bpid_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TDSLS421_lookup]
    ON [dbo].[LN_TDSLS421]([compnr] ASC, [orno] ASC, [pono] ASC, [sqnb] ASC, [csqn] ASC, [hrea] ASC, [dtbl] ASC);


GO

