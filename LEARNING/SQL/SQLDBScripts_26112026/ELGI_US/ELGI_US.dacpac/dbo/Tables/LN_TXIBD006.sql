CREATE TABLE [dbo].[LN_TXIBD006] (
    [compnr]          BIGINT        NULL,
    [item]            NVARCHAR (47) NULL,
    [attr]            NVARCHAR (20) NULL,
    [valu]            NVARCHAR (20) NULL,
    [item_ref_compnr] BIGINT        NULL,
    [attr_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TXIBD006_lookup]
    ON [dbo].[LN_TXIBD006]([compnr] ASC, [item] ASC, [attr] ASC);


GO

