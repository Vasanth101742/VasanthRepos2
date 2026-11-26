CREATE TABLE [dbo].[LN_TFGLD016] (
    [compnr]          BIGINT        NULL,
    [cono]            BIGINT        NULL,
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
    [rcmp]            BIGINT        NULL,
    [rlea]            NVARCHAR (12) NULL,
    [rdi1]            NVARCHAR (9)  NULL,
    [rdi2]            NVARCHAR (9)  NULL,
    [rdi3]            NVARCHAR (9)  NULL,
    [rdi4]            NVARCHAR (9)  NULL,
    [rdi5]            NVARCHAR (9)  NULL,
    [rdi6]            NVARCHAR (9)  NULL,
    [rdi7]            NVARCHAR (9)  NULL,
    [rdi8]            NVARCHAR (9)  NULL,
    [rdi9]            NVARCHAR (9)  NULL,
    [rd10]            NVARCHAR (9)  NULL,
    [rd11]            NVARCHAR (9)  NULL,
    [rd12]            NVARCHAR (9)  NULL,
    [icrt]            BIGINT        NULL,
    [icrt_kw]         NVARCHAR (20) NULL,
    [ccur]            NVARCHAR (3)  NULL,
    [ccur_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFGLD016_lookup]
    ON [dbo].[LN_TFGLD016]([compnr] ASC, [cono] ASC, [leac] ASC);


GO

