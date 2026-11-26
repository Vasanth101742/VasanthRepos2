CREATE TABLE [dbo].[LN_BTREC208] (
    [compnr]          BIGINT        NULL,
    [fire]            NVARCHAR (9)  NULL,
    [line]            BIGINT        NULL,
    [accd]            NVARCHAR (8)  NULL,
    [trtp]            BIGINT        NULL,
    [brty]            BIGINT        NULL,
    [taxd]            BIGINT        NULL,
    [seri]            BIGINT        NULL,
    [dbcr]            BIGINT        NULL,
    [seqn]            BIGINT        NULL,
    [trtp_kw]         NVARCHAR (21) NULL,
    [brty_kw]         NVARCHAR (26) NULL,
    [taxd_kw]         NVARCHAR (22) NULL,
    [dbcr_kw]         NVARCHAR (20) NULL,
    [bfcd]            NVARCHAR (6)  NULL,
    [ccur]            NVARCHAR (3)  NULL,
    [rate_1]          FLOAT (53)    NULL,
    [rate_2]          FLOAT (53)    NULL,
    [rate_3]          FLOAT (53)    NULL,
    [ratf_1]          BIGINT        NULL,
    [ratf_2]          BIGINT        NULL,
    [ratf_3]          BIGINT        NULL,
    [amnt]            FLOAT (53)    NULL,
    [amth_1]          FLOAT (53)    NULL,
    [amth_2]          FLOAT (53)    NULL,
    [amth_3]          FLOAT (53)    NULL,
    [leac]            NVARCHAR (30) NULL,
    [dim1]            NVARCHAR (15) NULL,
    [dim2]            NVARCHAR (15) NULL,
    [dim3]            NVARCHAR (15) NULL,
    [dim4]            NVARCHAR (15) NULL,
    [dim5]            NVARCHAR (15) NULL,
    [dim6]            NVARCHAR (15) NULL,
    [dim7]            NVARCHAR (15) NULL,
    [dim8]            NVARCHAR (15) NULL,
    [dim9]            NVARCHAR (15) NULL,
    [dm10]            NVARCHAR (15) NULL,
    [dm11]            NVARCHAR (15) NULL,
    [dm12]            NVARCHAR (15) NULL,
    [hcod]            NVARCHAR (15) NULL,
    [hdes]            NVARCHAR (45) NULL,
    [fire_ref_compnr] BIGINT        NULL,
    [accd_ref_compnr] BIGINT        NULL,
    [bfcd_ref_compnr] BIGINT        NULL,
    [ccur_ref_compnr] BIGINT        NULL,
    [hcod_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_BTREC208_lookup]
    ON [dbo].[LN_BTREC208]([compnr] ASC, [fire] ASC, [line] ASC, [accd] ASC, [trtp] ASC, [brty] ASC, [taxd] ASC, [seri] ASC, [dbcr] ASC, [seqn] ASC);


GO

