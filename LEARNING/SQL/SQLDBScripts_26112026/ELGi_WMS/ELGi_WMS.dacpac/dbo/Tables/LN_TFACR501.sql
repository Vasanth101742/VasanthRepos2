CREATE TABLE [dbo].[LN_TFACR501] (
    [compnr]          BIGINT        NULL,
    [srno]            BIGINT        NULL,
    [days]            BIGINT        NULL,
    [amnt]            FLOAT (53)    NULL,
    [cpyn]            BIGINT        NULL,
    [cpyn_kw]         NVARCHAR (20) NULL,
    [cpay]            NVARCHAR (3)  NULL,
    [dfic]            BIGINT        NULL,
    [dfic_kw]         NVARCHAR (20) NULL,
    [isel]            BIGINT        NULL,
    [isel_kw]         NVARCHAR (22) NULL,
    [inii]            BIGINT        NULL,
    [ctax]            BIGINT        NULL,
    [ctax_kw]         NVARCHAR (20) NULL,
    [cvat]            NVARCHAR (9)  NULL,
    [iclc]            BIGINT        NULL,
    [iclc_kw]         NVARCHAR (20) NULL,
    [iurc]            BIGINT        NULL,
    [iurc_kw]         NVARCHAR (20) NULL,
    [cpay_ref_compnr] BIGINT        NULL,
    [cvat_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFACR501_lookup]
    ON [dbo].[LN_TFACR501]([compnr] ASC, [srno] ASC);


GO

