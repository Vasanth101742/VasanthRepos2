CREATE TABLE [dbo].[LN_TSCTM500] (
    [compnr]          BIGINT        NULL,
    [gwte]            NVARCHAR (16) NULL,
    [cwte]            NVARCHAR (16) NULL,
    [desc]            NVARCHAR (50) NULL,
    [uprd]            BIGINT        NULL,
    [uprd_kw]         NVARCHAR (20) NULL,
    [nrpe]            BIGINT        NULL,
    [peru]            BIGINT        NULL,
    [peru_kw]         NVARCHAR (20) NULL,
    [cwoc]            NVARCHAR (6)  NULL,
    [ccur]            NVARCHAR (3)  NULL,
    [term]            BIGINT        NULL,
    [efdt]            NVARCHAR (10) NULL,
    [exdt]            NVARCHAR (10) NULL,
    [txta]            BIGINT        NULL,
    [cwte_ref_compnr] BIGINT        NULL,
    [cwoc_ref_compnr] BIGINT        NULL,
    [ccur_ref_compnr] BIGINT        NULL,
    [txta_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM500_lookup]
    ON [dbo].[LN_TSCTM500]([compnr] ASC, [gwte] ASC);


GO

