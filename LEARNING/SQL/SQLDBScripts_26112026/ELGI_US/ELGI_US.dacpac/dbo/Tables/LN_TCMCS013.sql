CREATE TABLE [dbo].[LN_TCMCS013] (
    [compnr]          BIGINT        NULL,
    [cpay]            NVARCHAR (3)  NULL,
    [dsca]            NVARCHAR (30) NULL,
    [pper]            BIGINT        NULL,
    [pash]            NVARCHAR (3)  NULL,
    [disa]            BIGINT        NULL,
    [disb]            BIGINT        NULL,
    [disc]            BIGINT        NULL,
    [prca]            FLOAT (53)    NULL,
    [prcb]            FLOAT (53)    NULL,
    [prcc]            FLOAT (53)    NULL,
    [atie]            BIGINT        NULL,
    [atie_kw]         NVARCHAR (20) NULL,
    [pdin]            BIGINT        NULL,
    [pdin_kw]         NVARCHAR (20) NULL,
    [cdde]            BIGINT        NULL,
    [cdde_kw]         NVARCHAR (20) NULL,
    [cdis]            BIGINT        NULL,
    [cdis_kw]         NVARCHAR (20) NULL,
    [fdue]            BIGINT        NULL,
    [fdis]            BIGINT        NULL,
    [told]            FLOAT (53)    NULL,
    [tola]            FLOAT (53)    NULL,
    [tolp]            BIGINT        NULL,
    [tlsd]            BIGINT        NULL,
    [day1]            BIGINT        NULL,
    [day2]            BIGINT        NULL,
    [day3]            BIGINT        NULL,
    [ptyp]            BIGINT        NULL,
    [ptyp_kw]         NVARCHAR (20) NULL,
    [prio]            BIGINT        NULL,
    [prio_kw]         NVARCHAR (21) NULL,
    [pdyn]            BIGINT        NULL,
    [pdyn_kw]         NVARCHAR (20) NULL,
    [pdis]            BIGINT        NULL,
    [pdis_kw]         NVARCHAR (21) NULL,
    [dtbs]            BIGINT        NULL,
    [dtbs_kw]         NVARCHAR (20) NULL,
    [vtpm]            NVARCHAR (3)  NULL,
    [txta]            BIGINT        NULL,
    [pash_ref_compnr] BIGINT        NULL,
    [txta_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCMCS013_lookup]
    ON [dbo].[LN_TCMCS013]([compnr] ASC, [cpay] ASC);


GO

