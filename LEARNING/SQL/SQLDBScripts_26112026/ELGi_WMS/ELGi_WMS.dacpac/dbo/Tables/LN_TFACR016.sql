CREATE TABLE [dbo].[LN_TFACR016] (
    [compnr]          BIGINT        NULL,
    [pbbp]            NVARCHAR (9)  NULL,
    [fabp]            NVARCHAR (9)  NULL,
    [deft]            BIGINT        NULL,
    [deft_kw]         NVARCHAR (20) NULL,
    [ccur]            NVARCHAR (3)  NULL,
    [falt]            FLOAT (53)    NULL,
    [balr]            FLOAT (53)    NULL,
    [rcrs]            BIGINT        NULL,
    [rcrs_kw]         NVARCHAR (20) NULL,
    [perc]            FLOAT (53)    NULL,
    [fano]            NVARCHAR (10) NULL,
    [actv]            BIGINT        NULL,
    [actv_kw]         NVARCHAR (20) NULL,
    [pbbp_ref_compnr] BIGINT        NULL,
    [fabp_ref_compnr] BIGINT        NULL,
    [ccur_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFACR016_lookup]
    ON [dbo].[LN_TFACR016]([compnr] ASC, [pbbp] ASC, [fabp] ASC);


GO

