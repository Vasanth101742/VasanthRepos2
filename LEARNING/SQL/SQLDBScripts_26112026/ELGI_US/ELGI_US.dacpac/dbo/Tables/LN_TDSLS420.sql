CREATE TABLE [dbo].[LN_TDSLS420] (
    [compnr]                    BIGINT        NULL,
    [orno]                      NVARCHAR (9)  NULL,
    [pono]                      BIGINT        NULL,
    [sqnb]                      BIGINT        NULL,
    [csqn]                      BIGINT        NULL,
    [hrea]                      NVARCHAR (3)  NULL,
    [opon]                      BIGINT        NULL,
    [cran]                      NVARCHAR (9)  NULL,
    [erdt]                      NVARCHAR (40) NULL,
    [pstc]                      NVARCHAR (10) NULL,
    [bpid]                      NVARCHAR (9)  NULL,
    [bprt]                      BIGINT        NULL,
    [bprt_kw]                   NVARCHAR (21) NULL,
    [cbtp]                      NVARCHAR (3)  NULL,
    [lobl]                      NVARCHAR (16) NULL,
    [orno_pono_sqnb_ref_compnr] BIGINT        NULL,
    [hrea_ref_compnr]           BIGINT        NULL,
    [cran_ref_compnr]           BIGINT        NULL,
    [bpid_ref_compnr]           BIGINT        NULL,
    [cbtp_ref_compnr]           BIGINT        NULL,
    [cbtp_hrea_ref_compnr]      BIGINT        NULL,
    [deleted]                   NCHAR (1)     NULL,
    [username]                  NVARCHAR (8)  NULL,
    [timestamp]                 DATETIME      NULL,
    [sequencenumber]            BIGINT        NULL,
    [dlDocumentDate]            NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TDSLS420_lookup]
    ON [dbo].[LN_TDSLS420]([compnr] ASC, [orno] ASC, [pono] ASC, [sqnb] ASC, [csqn] ASC, [hrea] ASC, [opon] ASC);


GO

