CREATE TABLE [dbo].[LN_TDSLS403] (
    [compnr]                    BIGINT          NULL,
    [orno]                      NVARCHAR (9)    NULL,
    [pono]                      BIGINT          NULL,
    [sqnb]                      BIGINT          NULL,
    [ponb]                      BIGINT          NULL,
    [sitm]                      NVARCHAR (47)   NULL,
    [qibm]                      DECIMAL (12, 6) NULL,
    [orno_pono_sqnb_ref_compnr] BIGINT          NULL,
    [orno_ref_compnr]           BIGINT          NULL,
    [sitm_ref_compnr]           BIGINT          NULL,
    [deleted]                   NCHAR (1)       NULL,
    [username]                  NVARCHAR (8)    NULL,
    [timestamp]                 DATETIME        NULL,
    [sequencenumber]            BIGINT          NULL,
    [dlDocumentDate]            NVARCHAR (40)   NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TDSLS403_lookup]
    ON [dbo].[LN_TDSLS403]([compnr] ASC, [orno] ASC, [pono] ASC, [sqnb] ASC, [ponb] ASC);


GO

