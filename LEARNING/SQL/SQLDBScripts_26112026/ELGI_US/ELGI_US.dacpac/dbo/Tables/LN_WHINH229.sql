CREATE TABLE [dbo].[LN_WHINH229] (
    [compnr]                         BIGINT          NULL,
    [oorg]                           BIGINT          NULL,
    [orno]                           NVARCHAR (9)    NULL,
    [pono]                           BIGINT          NULL,
    [seqn]                           BIGINT          NULL,
    [dlin]                           BIGINT          NULL,
    [oorg_kw]                        NVARCHAR (26)   NULL,
    [refe]                           NVARCHAR (35)   NULL,
    [prfa]                           NVARCHAR (35)   NULL,
    [prfb]                           NVARCHAR (35)   NULL,
    [adin]                           NVARCHAR (22)   NULL,
    [qord]                           DECIMAL (12, 6) NULL,
    [qapr]                           DECIMAL (12, 6) NULL,
    [qshp]                           DECIMAL (12, 6) NULL,
    [qnse]                           DECIMAL (12, 6) NULL,
    [oorg_orno_pono_seqn_ref_compnr] BIGINT          NULL,
    [deleted]                        NCHAR (1)       NULL,
    [username]                       NVARCHAR (8)    NULL,
    [timestamp]                      DATETIME        NULL,
    [sequencenumber]                 BIGINT          NULL,
    [dlDocumentDate]                 NVARCHAR (40)   NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_WHINH229_lookup]
    ON [dbo].[LN_WHINH229]([compnr] ASC, [oorg] ASC, [orno] ASC, [pono] ASC, [seqn] ASC, [dlin] ASC);


GO

