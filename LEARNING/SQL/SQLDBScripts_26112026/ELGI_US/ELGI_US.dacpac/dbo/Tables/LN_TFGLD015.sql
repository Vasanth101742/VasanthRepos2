CREATE TABLE [dbo].[LN_TFGLD015] (
    [compnr]         BIGINT        NULL,
    [cono]           BIGINT        NULL,
    [rcmp]           BIGINT        NULL,
    [ttyp]           NVARCHAR (3)  NULL,
    [leac]           NVARCHAR (12) NULL,
    [typ1]           BIGINT        NULL,
    [dim1]           NVARCHAR (9)  NULL,
    [typ2]           BIGINT        NULL,
    [dim2]           NVARCHAR (9)  NULL,
    [typ3]           BIGINT        NULL,
    [dim3]           NVARCHAR (9)  NULL,
    [typ4]           BIGINT        NULL,
    [dim4]           NVARCHAR (9)  NULL,
    [typ5]           BIGINT        NULL,
    [dim5]           NVARCHAR (9)  NULL,
    [dim6]           NVARCHAR (9)  NULL,
    [dim7]           NVARCHAR (9)  NULL,
    [dim8]           NVARCHAR (9)  NULL,
    [dim9]           NVARCHAR (9)  NULL,
    [dm10]           NVARCHAR (9)  NULL,
    [dm11]           NVARCHAR (9)  NULL,
    [dm12]           NVARCHAR (9)  NULL,
    [rlea]           NVARCHAR (12) NULL,
    [rty1]           BIGINT        NULL,
    [rdi1]           NVARCHAR (9)  NULL,
    [rty2]           BIGINT        NULL,
    [rdi2]           NVARCHAR (9)  NULL,
    [rty3]           BIGINT        NULL,
    [rdi3]           NVARCHAR (9)  NULL,
    [rty4]           BIGINT        NULL,
    [rdi4]           NVARCHAR (9)  NULL,
    [rty5]           BIGINT        NULL,
    [rdi5]           NVARCHAR (9)  NULL,
    [rdi6]           NVARCHAR (9)  NULL,
    [rdi7]           NVARCHAR (9)  NULL,
    [rdi8]           NVARCHAR (9)  NULL,
    [rdi9]           NVARCHAR (9)  NULL,
    [rd10]           NVARCHAR (9)  NULL,
    [rd11]           NVARCHAR (9)  NULL,
    [rd12]           NVARCHAR (9)  NULL,
    [rtyp]           NVARCHAR (3)  NULL,
    [rser]           BIGINT        NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFGLD015_lookup]
    ON [dbo].[LN_TFGLD015]([compnr] ASC, [cono] ASC, [rcmp] ASC, [ttyp] ASC);


GO

