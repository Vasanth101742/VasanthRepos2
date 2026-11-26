CREATE TABLE [dbo].[LN_TSCTM050] (
    [compnr]          BIGINT          NULL,
    [ccte]            NVARCHAR (16)   NULL,
    [desc]            NVARCHAR (30)   NULL,
    [sear]            NVARCHAR (16)   NULL,
    [tfdt]            NVARCHAR (10)   NULL,
    [txdt]            NVARCHAR (10)   NULL,
    [cwoc]            NVARCHAR (6)    NULL,
    [term]            BIGINT          NULL,
    [nrpe]            BIGINT          NULL,
    [peru]            BIGINT          NULL,
    [peru_kw]         NVARCHAR (20)   NULL,
    [prmt]            BIGINT          NULL,
    [prmt_kw]         NVARCHAR (25)   NULL,
    [perc]            DECIMAL (12, 6) NULL,
    [ctin]            NVARCHAR (3)    NULL,
    [ccur]            NVARCHAR (3)    NULL,
    [txta]            BIGINT          NULL,
    [cwoc_ref_compnr] BIGINT          NULL,
    [ctin_ref_compnr] BIGINT          NULL,
    [ccur_ref_compnr] BIGINT          NULL,
    [txta_ref_compnr] BIGINT          NULL,
    [deleted]         NCHAR (1)       NULL,
    [username]        NVARCHAR (8)    NULL,
    [timestamp]       DATETIME        NULL,
    [sequencenumber]  BIGINT          NULL,
    [dlDocumentDate]  NVARCHAR (40)   NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM050_lookup]
    ON [dbo].[LN_TSCTM050]([compnr] ASC, [ccte] ASC);


GO

