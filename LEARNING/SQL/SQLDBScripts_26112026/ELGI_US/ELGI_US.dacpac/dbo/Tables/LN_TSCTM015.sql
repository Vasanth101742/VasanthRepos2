CREATE TABLE [dbo].[LN_TSCTM015] (
    [compnr]          BIGINT        NULL,
    [item]            NVARCHAR (47) NULL,
    [ccte]            NVARCHAR (16) NULL,
    [seqn]            BIGINT        NULL,
    [rspr]            FLOAT (53)    NULL,
    [nrpe]            BIGINT        NULL,
    [peru]            BIGINT        NULL,
    [peru_kw]         NVARCHAR (20) NULL,
    [prpp]            FLOAT (53)    NULL,
    [eftm]            NVARCHAR (10) NULL,
    [item_ref_compnr] BIGINT        NULL,
    [ccte_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM015_lookup]
    ON [dbo].[LN_TSCTM015]([compnr] ASC, [item] ASC, [ccte] ASC, [seqn] ASC);


GO

