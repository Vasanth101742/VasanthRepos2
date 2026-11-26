CREATE TABLE [dbo].[LN_TSSOC400] (
    [compnr]               BIGINT        NULL,
    [orno]                 NVARCHAR (9)  NULL,
    [cotp]                 BIGINT        NULL,
    [lino]                 BIGINT        NULL,
    [acln]                 BIGINT        NULL,
    [cotp_kw]              NVARCHAR (20) NULL,
    [clst]                 NVARCHAR (9)  NULL,
    [ofbp]                 NVARCHAR (9)  NULL,
    [item]                 NVARCHAR (47) NULL,
    [sern]                 NVARCHAR (30) NULL,
    [emno]                 NVARCHAR (9)  NULL,
    [orno_ref_compnr]      BIGINT        NULL,
    [clst_ref_compnr]      BIGINT        NULL,
    [ofbp_ref_compnr]      BIGINT        NULL,
    [item_sern_ref_compnr] BIGINT        NULL,
    [item_ref_compnr]      BIGINT        NULL,
    [emno_ref_compnr]      BIGINT        NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSSOC400_lookup]
    ON [dbo].[LN_TSSOC400]([compnr] ASC, [orno] ASC, [cotp] ASC, [lino] ASC, [acln] ASC);


GO

