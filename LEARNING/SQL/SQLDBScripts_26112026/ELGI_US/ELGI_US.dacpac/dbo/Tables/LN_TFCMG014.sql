CREATE TABLE [dbo].[LN_TFCMG014] (
    [compnr]          BIGINT        NULL,
    [paym]            NVARCHAR (3)  NULL,
    [step]            BIGINT        NULL,
    [sern]            BIGINT        NULL,
    [step_kw]         NVARCHAR (26) NULL,
    [tacc]            BIGINT        NULL,
    [tacc_kw]         NVARCHAR (25) NULL,
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
    [dbcr]            BIGINT        NULL,
    [dbcr_kw]         NVARCHAR (20) NULL,
    [tamt]            BIGINT        NULL,
    [tamt_kw]         NVARCHAR (20) NULL,
    [pode]            BIGINT        NULL,
    [pode_kw]         NVARCHAR (20) NULL,
    [paym_ref_compnr] BIGINT        NULL,
    [leac_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFCMG014_lookup]
    ON [dbo].[LN_TFCMG014]([compnr] ASC, [paym] ASC, [step] ASC, [sern] ASC);


GO

