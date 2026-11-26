CREATE TABLE [dbo].[LN_TFGLD475] (
    [compnr]          BIGINT         NULL,
    [fcmp]            BIGINT         NULL,
    [glcd]            NVARCHAR (135) NULL,
    [desc]            NVARCHAR (50)  NULL,
    [leac]            NVARCHAR (12)  NULL,
    [dim1]            NVARCHAR (9)   NULL,
    [dim2]            NVARCHAR (9)   NULL,
    [dim3]            NVARCHAR (9)   NULL,
    [dim4]            NVARCHAR (9)   NULL,
    [dim5]            NVARCHAR (9)   NULL,
    [dim6]            NVARCHAR (9)   NULL,
    [dim7]            NVARCHAR (9)   NULL,
    [dim8]            NVARCHAR (9)   NULL,
    [dim9]            NVARCHAR (9)   NULL,
    [dm10]            NVARCHAR (9)   NULL,
    [dm11]            NVARCHAR (9)   NULL,
    [dm12]            NVARCHAR (9)   NULL,
    [actv]            BIGINT         NULL,
    [actv_kw]         NVARCHAR (20)  NULL,
    [budg]            BIGINT         NULL,
    [budg_kw]         NVARCHAR (20)  NULL,
    [fcmp_ref_compnr] BIGINT         NULL,
    [deleted]         NCHAR (1)      NULL,
    [username]        NVARCHAR (8)   NULL,
    [timestamp]       DATETIME       NULL,
    [sequencenumber]  BIGINT         NULL,
    [dlDocumentDate]  NVARCHAR (40)  NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFGLD475_lookup]
    ON [dbo].[LN_TFGLD475]([compnr] ASC, [fcmp] ASC, [glcd] ASC);


GO

