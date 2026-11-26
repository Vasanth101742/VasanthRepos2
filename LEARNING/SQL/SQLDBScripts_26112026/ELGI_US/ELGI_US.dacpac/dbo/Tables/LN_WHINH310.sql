CREATE TABLE [dbo].[LN_WHINH310] (
    [compnr]          BIGINT          NULL,
    [rcno]            NVARCHAR (9)    NULL,
    [sfbp]            NVARCHAR (9)    NULL,
    [carr]            NVARCHAR (3)    NULL,
    [cwar]            NVARCHAR (6)    NULL,
    [shda]            NVARCHAR (9)    NULL,
    [pddt]            NVARCHAR (40)   NULL,
    [shdt]            NVARCHAR (40)   NULL,
    [fval]            DECIMAL (12, 6) NULL,
    [curr]            NVARCHAR (3)    NULL,
    [wght]            DECIMAL (12, 6) NULL,
    [cwun]            NVARCHAR (3)    NULL,
    [crdt]            NVARCHAR (40)   NULL,
    [dino]            NVARCHAR (30)   NULL,
    [conf]            BIGINT          NULL,
    [conf_kw]         NVARCHAR (20)   NULL,
    [load]            NVARCHAR (9)    NULL,
    [shid]            NVARCHAR (9)    NULL,
    [huid]            NVARCHAR (25)   NULL,
    [imre]            NVARCHAR (30)   NULL,
    [irdt]            NVARCHAR (40)   NULL,
    [imrk]            NVARCHAR (30)   NULL,
    [port]            NVARCHAR (9)    NULL,
    [stat]            BIGINT          NULL,
    [stat_kw]         NVARCHAR (23)   NULL,
    [tcap]            BIGINT          NULL,
    [tcap_kw]         NVARCHAR (20)   NULL,
    [tccp]            BIGINT          NULL,
    [tccp_kw]         NVARCHAR (20)   NULL,
    [trcd]            NVARCHAR (50)   NULL,
    [text]            BIGINT          NULL,
    [sfbp_ref_compnr] BIGINT          NULL,
    [carr_ref_compnr] BIGINT          NULL,
    [cwar_ref_compnr] BIGINT          NULL,
    [shda_ref_compnr] BIGINT          NULL,
    [curr_ref_compnr] BIGINT          NULL,
    [cwun_ref_compnr] BIGINT          NULL,
    [huid_ref_compnr] BIGINT          NULL,
    [port_ref_compnr] BIGINT          NULL,
    [text_ref_compnr] BIGINT          NULL,
    [deleted]         NCHAR (1)       NULL,
    [username]        NVARCHAR (8)    NULL,
    [timestamp]       DATETIME        NULL,
    [sequencenumber]  BIGINT          NULL,
    [dlDocumentDate]  NVARCHAR (40)   NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_WHINH310_lookup]
    ON [dbo].[LN_WHINH310]([compnr] ASC, [rcno] ASC);


GO

