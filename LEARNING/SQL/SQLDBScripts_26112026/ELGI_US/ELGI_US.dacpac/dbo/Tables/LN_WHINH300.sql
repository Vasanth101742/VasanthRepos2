CREATE TABLE [dbo].[LN_WHINH300] (
    [compnr]          BIGINT          NULL,
    [sfbp]            NVARCHAR (9)    NULL,
    [shid]            NVARCHAR (9)    NULL,
    [cwar]            NVARCHAR (6)    NULL,
    [dadd]            NVARCHAR (9)    NULL,
    [carr]            NVARCHAR (3)    NULL,
    [tcod]            NVARCHAR (2)    NULL,
    [acdt]            NVARCHAR (40)   NULL,
    [shdt]            NVARCHAR (40)   NULL,
    [crdt]            NVARCHAR (40)   NULL,
    [pddt]            NVARCHAR (40)   NULL,
    [addt]            NVARCHAR (40)   NULL,
    [fval]            DECIMAL (12, 6) NULL,
    [curr]            NVARCHAR (3)    NULL,
    [koch]            BIGINT          NULL,
    [koch_kw]         NVARCHAR (25)   NULL,
    [cham]            DECIMAL (12, 6) NULL,
    [wght]            DECIMAL (12, 6) NULL,
    [cwun]            NVARCHAR (3)    NULL,
    [hazm]            BIGINT          NULL,
    [hazm_kw]         NVARCHAR (20)   NULL,
    [stat]            BIGINT          NULL,
    [stat_kw]         NVARCHAR (24)   NULL,
    [cdec]            NVARCHAR (3)    NULL,
    [ptpa]            NVARCHAR (9)    NULL,
    [shrf]            NVARCHAR (30)   NULL,
    [exhu]            NVARCHAR (25)   NULL,
    [huid]            NVARCHAR (25)   NULL,
    [load]            NVARCHAR (9)    NULL,
    [shpm]            NVARCHAR (9)    NULL,
    [cpro]            NVARCHAR (30)   NULL,
    [asnr]            NVARCHAR (30)   NULL,
    [bola]            NVARCHAR (30)   NULL,
    [plst]            NVARCHAR (30)   NULL,
    [pcsp]            NVARCHAR (30)   NULL,
    [idmr]            NVARCHAR (36)   NULL,
    [iedi]            BIGINT          NULL,
    [odms]            BIGINT          NULL,
    [odms_kw]         NVARCHAR (20)   NULL,
    [text]            BIGINT          NULL,
    [sfbp_ref_compnr] BIGINT          NULL,
    [cwar_ref_compnr] BIGINT          NULL,
    [dadd_ref_compnr] BIGINT          NULL,
    [carr_ref_compnr] BIGINT          NULL,
    [curr_ref_compnr] BIGINT          NULL,
    [cwun_ref_compnr] BIGINT          NULL,
    [cdec_ref_compnr] BIGINT          NULL,
    [ptpa_ref_compnr] BIGINT          NULL,
    [iedi_ref_compnr] BIGINT          NULL,
    [text_ref_compnr] BIGINT          NULL,
    [deleted]         NCHAR (1)       NULL,
    [username]        NVARCHAR (8)    NULL,
    [timestamp]       DATETIME        NULL,
    [sequencenumber]  BIGINT          NULL,
    [dlDocumentDate]  NVARCHAR (40)   NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_WHINH300_lookup]
    ON [dbo].[LN_WHINH300]([compnr] ASC, [sfbp] ASC, [shid] ASC);


GO

