CREATE TABLE [dbo].[LN_TFACP007] (
    [compnr]          BIGINT        NULL,
    [ifbp]            NVARCHAR (9)  NULL,
    [lppd]            BIGINT        NULL,
    [hppd]            BIGINT        NULL,
    [lapd]            FLOAT (53)    NULL,
    [hapd]            FLOAT (53)    NULL,
    [falo]            BIGINT        NULL,
    [falo_kw]         NVARCHAR (20) NULL,
    [fahi]            BIGINT        NULL,
    [fahi_kw]         NVARCHAR (20) NULL,
    [fapd]            BIGINT        NULL,
    [fapd_kw]         NVARCHAR (20) NULL,
    [atpd]            FLOAT (53)    NULL,
    [ptpd]            BIGINT        NULL,
    [ampr]            BIGINT        NULL,
    [ampr_kw]         NVARCHAR (26) NULL,
    [ifbp_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFACP007_lookup]
    ON [dbo].[LN_TFACP007]([compnr] ASC, [ifbp] ASC);


GO

