CREATE TABLE [dbo].[LN_CISLI311] (
    [compnr]                         INT             NULL,
    [sfcp]                           INT             NULL,
    [tran]                           NVARCHAR (3)    NULL,
    [idoc]                           INT             NULL,
    [line]                           INT             NULL,
    [fldc]                           NVARCHAR (6)    NULL,
    [fldv]                           NVARCHAR (100)  NULL,
    [flda_1]                         DECIMAL (12, 6) NULL,
    [flda_2]                         DECIMAL (12, 6) NULL,
    [flda_3]                         DECIMAL (12, 6) NULL,
    [sfcp_tran_idoc_line_ref_compnr] INT             NULL,
    [deleted]                        NCHAR (1)       NULL,
    [username]                       NVARCHAR (8)    NULL,
    [timestamp]                      DATETIME        NULL,
    [sequencenumber]                 INT             NULL,
    [dlDocumentDate]                 NVARCHAR (40)   NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_CISLI311_lookup]
    ON [dbo].[LN_CISLI311]([compnr] ASC, [sfcp] ASC, [tran] ASC, [idoc] ASC, [line] ASC, [fldc] ASC);


GO

