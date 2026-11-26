CREATE TABLE [dbo].[LN_TSCTM812] (
    [compnr]               BIGINT        NULL,
    [csco]                 NVARCHAR (9)  NULL,
    [htim]                 NVARCHAR (40) NULL,
    [cchn]                 BIGINT        NULL,
    [desc]                 NVARCHAR (30) NULL,
    [actn]                 BIGINT        NULL,
    [actn_kw]              NVARCHAR (26) NULL,
    [stat]                 BIGINT        NULL,
    [stat_kw]              NVARCHAR (20) NULL,
    [term]                 BIGINT        NULL,
    [nrpe]                 BIGINT        NULL,
    [peru]                 BIGINT        NULL,
    [peru_kw]              NVARCHAR (20) NULL,
    [ochn]                 BIGINT        NULL,
    [icpn]                 FLOAT (53)    NULL,
    [efdt]                 NVARCHAR (10) NULL,
    [exdt]                 NVARCHAR (10) NULL,
    [chdt]                 NVARCHAR (10) NULL,
    [cind]                 NVARCHAR (3)  NULL,
    [crtm]                 NVARCHAR (40) NULL,
    [csmt]                 FLOAT (53)    NULL,
    [rsmt]                 FLOAT (53)    NULL,
    [camt_1]               FLOAT (53)    NULL,
    [camt_2]               FLOAT (53)    NULL,
    [camt_3]               FLOAT (53)    NULL,
    [erfa]                 FLOAT (53)    NULL,
    [amdy]                 FLOAT (53)    NULL,
    [cody_1]               FLOAT (53)    NULL,
    [cody_2]               FLOAT (53)    NULL,
    [cody_3]               FLOAT (53)    NULL,
    [inpc]                 FLOAT (53)    NULL,
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

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM812_lookup]
    ON [dbo].[LN_TSCTM812]([compnr] ASC, [csco] ASC, [htim] ASC, [cchn] ASC);


GO

