CREATE TABLE [dbo].[LN_WHINR140] (
    [compnr]               BIGINT        NULL,
    [cwar]                 NVARCHAR (6)  NULL,
    [loca]                 NVARCHAR (10) NULL,
    [item]                 NVARCHAR (47) NULL,
    [clot]                 NVARCHAR (20) NULL,
    [idat]                 NVARCHAR (40) NULL,
    [effn]                 BIGINT        NULL,
    [qhnd]                 FLOAT (53)    NULL,
    [qblk]                 FLOAT (53)    NULL,
    [qlal]                 FLOAT (53)    NULL,
    [qord]                 FLOAT (53)    NULL,
    [qcom]                 FLOAT (53)    NULL,
    [qcsl]                 FLOAT (53)    NULL,
    [ball]                 BIGINT        NULL,
    [ball_kw]              NVARCHAR (20) NULL,
    [bout]                 BIGINT        NULL,
    [bout_kw]              NVARCHAR (20) NULL,
    [btri]                 BIGINT        NULL,
    [btri_kw]              NVARCHAR (20) NULL,
    [bcyc]                 BIGINT        NULL,
    [bcyc_kw]              NVARCHAR (20) NULL,
    [bass]                 BIGINT        NULL,
    [bass_kw]              NVARCHAR (20) NULL,
    [crem]                 NVARCHAR (3)  NULL,
    [crdt]                 NVARCHAR (40) NULL,
    [trdt]                 NVARCHAR (40) NULL,
    [lsid]                 NVARCHAR (40) NULL,
    [mpkd]                 BIGINT        NULL,
    [mpkd_kw]              NVARCHAR (20) NULL,
    [cwar_loca_ref_compnr] BIGINT        NULL,
    [cwar_ref_compnr]      BIGINT        NULL,
    [item_ref_compnr]      BIGINT        NULL,
    [effn_ref_compnr]      BIGINT        NULL,
    [crem_ref_compnr]      BIGINT        NULL,
    [deleted]              NCHAR (1)     NULL,
    [username]             NVARCHAR (8)  NULL,
    [timestamp]            DATETIME      NULL,
    [sequencenumber]       BIGINT        NULL,
    [dlDocumentDate]       NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_WHINR140_lookup]
    ON [dbo].[LN_WHINR140]([compnr] ASC, [cwar] ASC, [loca] ASC, [item] ASC, [clot] ASC, [idat] ASC);


GO

