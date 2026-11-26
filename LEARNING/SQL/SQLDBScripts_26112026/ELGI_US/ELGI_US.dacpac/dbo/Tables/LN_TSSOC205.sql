CREATE TABLE [dbo].[LN_TSSOC205] (
    [compnr]                    BIGINT        NULL,
    [orgn]                      BIGINT        NULL,
    [orno]                      NVARCHAR (9)  NULL,
    [line]                      BIGINT        NULL,
    [orgn_kw]                   NVARCHAR (24) NULL,
    [emno]                      NVARCHAR (9)  NULL,
    [acln]                      BIGINT        NULL,
    [stat]                      BIGINT        NULL,
    [stat_kw]                   NVARCHAR (20) NULL,
    [dltm]                      NVARCHAR (40) NULL,
    [actm]                      NVARCHAR (40) NULL,
    [rjtm]                      NVARCHAR (40) NULL,
    [rejr]                      NVARCHAR (6)  NULL,
    [pstm]                      NVARCHAR (40) NULL,
    [pftm]                      NVARCHAR (40) NULL,
    [ptst]                      NVARCHAR (40) NULL,
    [ptft]                      NVARCHAR (40) NULL,
    [astm]                      NVARCHAR (40) NULL,
    [aftm]                      NVARCHAR (40) NULL,
    [atst]                      NVARCHAR (40) NULL,
    [atft]                      NVARCHAR (40) NULL,
    [jctm]                      NVARCHAR (40) NULL,
    [ltct]                      NVARCHAR (40) NULL,
    [esdt]                      NVARCHAR (40) NULL,
    [acdu]                      FLOAT (53)    NULL,
    [trdu]                      FLOAT (53)    NULL,
    [trdi]                      FLOAT (53)    NULL,
    [uecp]                      BIGINT        NULL,
    [uecp_kw]                   NVARCHAR (20) NULL,
    [pged]                      BIGINT        NULL,
    [pged_kw]                   NVARCHAR (20) NULL,
    [pgrd]                      BIGINT        NULL,
    [pgrd_kw]                   NVARCHAR (20) NULL,
    [actp]                      BIGINT        NULL,
    [actp_kw]                   NVARCHAR (20) NULL,
    [pgit]                      BIGINT        NULL,
    [pgdt]                      NVARCHAR (40) NULL,
    [pgcn]                      BIGINT        NULL,
    [txta]                      BIGINT        NULL,
    [cdf_aftt]                  NVARCHAR (40) NULL,
    [cdf_astt]                  NVARCHAR (40) NULL,
    [cdf_pstt]                  NVARCHAR (40) NULL,
    [cmbb_orno_acln_ref_compnr] BIGINT        NULL,
    [cmbc_orno_acln_ref_compnr] BIGINT        NULL,
    [emno_ref_compnr]           BIGINT        NULL,
    [rejr_ref_compnr]           BIGINT        NULL,
    [txta_ref_compnr]           BIGINT        NULL,
    [trdi_buln]                 FLOAT (53)    NULL,
    [trdu_butm]                 FLOAT (53)    NULL,
    [deleted]                   NCHAR (1)     NULL,
    [username]                  NVARCHAR (8)  NULL,
    [timestamp]                 DATETIME      NULL,
    [sequencenumber]            BIGINT        NULL,
    [dlDocumentDate]            NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSSOC205_lookup]
    ON [dbo].[LN_TSSOC205]([compnr] ASC, [orgn] ASC, [orno] ASC, [line] ASC);


GO

