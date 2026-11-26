CREATE TABLE [dbo].[LN_TSCTM840] (
    [compnr]               BIGINT        NULL,
    [csco]                 NVARCHAR (9)  NULL,
    [htim]                 NVARCHAR (40) NULL,
    [inst]                 BIGINT        NULL,
    [desc]                 NVARCHAR (30) NULL,
    [stin]                 BIGINT        NULL,
    [stin_kw]              NVARCHAR (22) NULL,
    [pidt]                 NVARCHAR (40) NULL,
    [efdt]                 NVARCHAR (40) NULL,
    [exdt]                 NVARCHAR (40) NULL,
    [isst]                 BIGINT        NULL,
    [isst_kw]              NVARCHAR (20) NULL,
    [amnt]                 FLOAT (53)    NULL,
    [disc]                 FLOAT (53)    NULL,
    [dimt]                 FLOAT (53)    NULL,
    [ntmt]                 FLOAT (53)    NULL,
    [icmt]                 FLOAT (53)    NULL,
    [inmt]                 FLOAT (53)    NULL,
    [txmt]                 FLOAT (53)    NULL,
    [fcpc]                 FLOAT (53)    NULL,
    [fcmt_1]               FLOAT (53)    NULL,
    [fcmt_2]               FLOAT (53)    NULL,
    [fcmt_3]               FLOAT (53)    NULL,
    [nrpf]                 BIGINT        NULL,
    [indt]                 NVARCHAR (40) NULL,
    [icmp]                 BIGINT        NULL,
    [ityp]                 NVARCHAR (3)  NULL,
    [idoc]                 BIGINT        NULL,
    [fyer]                 BIGINT        NULL,
    [fper]                 BIGINT        NULL,
    [prdt]                 NVARCHAR (40) NULL,
    [istd]                 NVARCHAR (10) NULL,
    [cchn]                 BIGINT        NULL,
    [term]                 BIGINT        NULL,
    [cfln]                 BIGINT        NULL,
    [txta]                 BIGINT        NULL,
    [csco_htim_ref_compnr] BIGINT        NULL,
    [txta_ref_compnr]      BIGINT        NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM840_lookup]
    ON [dbo].[LN_TSCTM840]([compnr] ASC, [csco] ASC, [htim] ASC, [inst] ASC);


GO

