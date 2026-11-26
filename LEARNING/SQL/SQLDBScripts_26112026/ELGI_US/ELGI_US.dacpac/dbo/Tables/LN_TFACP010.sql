CREATE TABLE [dbo].[LN_TFACP010] (
    [compnr]          BIGINT        NULL,
    [lnty]            NVARCHAR (3)  NULL,
    [desc]            NVARCHAR (50) NULL,
    [seak]            NVARCHAR (16) NULL,
    [lnct]            BIGINT        NULL,
    [lnct_kw]         NVARCHAR (20) NULL,
    [fico]            BIGINT        NULL,
    [leac]            NVARCHAR (12) NULL,
    [dim1]            NVARCHAR (9)  NULL,
    [dim2]            NVARCHAR (9)  NULL,
    [dim3]            NVARCHAR (9)  NULL,
    [dim4]            NVARCHAR (9)  NULL,
    [dim5]            NVARCHAR (9)  NULL,
    [dim6]            NVARCHAR (9)  NULL,
    [dim7]            NVARCHAR (9)  NULL,
    [dim8]            NVARCHAR (9)  NULL,
    [dim9]            NVARCHAR (9)  NULL,
    [dm10]            NVARCHAR (9)  NULL,
    [dm11]            NVARCHAR (9)  NULL,
    [dm12]            NVARCHAR (9)  NULL,
    [code]            NVARCHAR (3)  NULL,
    [text]            BIGINT        NULL,
    [code_ref_compnr] BIGINT        NULL,
    [text_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFACP010_lookup]
    ON [dbo].[LN_TFACP010]([compnr] ASC, [lnty] ASC);


GO

