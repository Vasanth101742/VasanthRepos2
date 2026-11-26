CREATE TABLE [dbo].[LN_TFGLD013] (
    [compnr]          BIGINT        NULL,
    [trsc]            NVARCHAR (3)  NULL,
    [lino]            BIGINT        NULL,
    [tcom]            BIGINT        NULL,
    [leac]            NVARCHAR (12) NULL,
    [typ1]            BIGINT        NULL,
    [dim1]            NVARCHAR (9)  NULL,
    [typ2]            BIGINT        NULL,
    [dim2]            NVARCHAR (9)  NULL,
    [typ3]            BIGINT        NULL,
    [dim3]            NVARCHAR (9)  NULL,
    [typ4]            BIGINT        NULL,
    [dim4]            NVARCHAR (9)  NULL,
    [typ5]            BIGINT        NULL,
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
    [perc]            FLOAT (53)    NULL,
    [amnt]            FLOAT (53)    NULL,
    [fact]            BIGINT        NULL,
    [vtyp]            BIGINT        NULL,
    [vtyp_kw]         NVARCHAR (25) NULL,
    [qty1]            FLOAT (53)    NULL,
    [qty2]            FLOAT (53)    NULL,
    [cvat]            NVARCHAR (9)  NULL,
    [refr]            NVARCHAR (32) NULL,
    [cfrs]            NVARCHAR (6)  NULL,
    [cacc]            NVARCHAR (12) NULL,
    [txta]            BIGINT        NULL,
    [trsc_ref_compnr] BIGINT        NULL,
    [cfrs_ref_compnr] BIGINT        NULL,
    [txta_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFGLD013_lookup]
    ON [dbo].[LN_TFGLD013]([compnr] ASC, [trsc] ASC, [lino] ASC);


GO

