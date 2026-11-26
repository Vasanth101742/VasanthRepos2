CREATE TABLE [dbo].[LN_TDPUR094] (
    [compnr]               BIGINT        NULL,
    [potp]                 NVARCHAR (3)  NULL,
    [dsca]                 NVARCHAR (30) NULL,
    [drct]                 BIGINT        NULL,
    [drct_kw]              NVARCHAR (20) NULL,
    [reto]                 BIGINT        NULL,
    [reto_kw]              NVARCHAR (22) NULL,
    [coun]                 BIGINT        NULL,
    [coun_kw]              NVARCHAR (20) NULL,
    [sund]                 BIGINT        NULL,
    [sund_kw]              NVARCHAR (20) NULL,
    [cnsp]                 BIGINT        NULL,
    [cnsp_kw]              NVARCHAR (20) NULL,
    [cnsr]                 BIGINT        NULL,
    [cnsr_kw]              NVARCHAR (20) NULL,
    [subc]                 BIGINT        NULL,
    [subc_kw]              NVARCHAR (20) NULL,
    [cfnm]                 BIGINT        NULL,
    [cfnm_kw]              NVARCHAR (20) NULL,
    [wrhp]                 NVARCHAR (3)  NULL,
    [slcp]                 BIGINT        NULL,
    [slcp_kw]              NVARCHAR (20) NULL,
    [cbor]                 BIGINT        NULL,
    [cbor_kw]              NVARCHAR (20) NULL,
    [etpc]                 BIGINT        NULL,
    [etpc_kw]              NVARCHAR (20) NULL,
    [ngpo]                 NVARCHAR (3)  NULL,
    [sepo]                 NVARCHAR (8)  NULL,
    [ngpq]                 NVARCHAR (3)  NULL,
    [sepq]                 NVARCHAR (8)  NULL,
    [ngpc]                 NVARCHAR (3)  NULL,
    [sepc]                 NVARCHAR (8)  NULL,
    [efdt]                 NVARCHAR (40) NULL,
    [exdt]                 NVARCHAR (40) NULL,
    [proc]                 NVARCHAR (6)  NULL,
    [pmsk]                 NVARCHAR (20) NULL,
    [cdf_exiv]             BIGINT        NULL,
    [cdf_exiv_kw]          NVARCHAR (20) NULL,
    [ngpo_sepo_ref_compnr] BIGINT        NULL,
    [ngpo_ref_compnr]      BIGINT        NULL,
    [ngpq_sepq_ref_compnr] BIGINT        NULL,
    [ngpq_ref_compnr]      BIGINT        NULL,
    [ngpc_sepc_ref_compnr] BIGINT        NULL,
    [ngpc_ref_compnr]      BIGINT        NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TDPUR094_lookup]
    ON [dbo].[LN_TDPUR094]([compnr] ASC, [potp] ASC);


GO

