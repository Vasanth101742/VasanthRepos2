CREATE TABLE [dbo].[LN_TCCOM001] (
    [compnr]          BIGINT        NULL,
    [emno]            NVARCHAR (9)  NULL,
    [nama]            NVARCHAR (35) NULL,
    [namb]            NVARCHAR (50) NULL,
    [namc]            NVARCHAR (50) NULL,
    [namd]            NVARCHAR (50) NULL,
    [seak]            NVARCHAR (16) NULL,
    [cwoc]            NVARCHAR (6)  NULL,
    [clrt]            NVARCHAR (6)  NULL,
    [cpcp]            NVARCHAR (8)  NULL,
    [clan]            NVARCHAR (3)  NULL,
    [ccal]            NVARCHAR (9)  NULL,
    [loco]            NVARCHAR (16) NULL,
    [imag]            NVARCHAR (22) NULL,
    [guid]            NVARCHAR (22) NULL,
    [ctit]            NVARCHAR (3)  NULL,
    [cdf_cntr]        NVARCHAR (15) NULL,
    [cwoc_ref_compnr] BIGINT        NULL,
    [clrt_ref_compnr] BIGINT        NULL,
    [cpcp_ref_compnr] BIGINT        NULL,
    [clan_ref_compnr] BIGINT        NULL,
    [ccal_ref_compnr] BIGINT        NULL,
    [ctit_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCCOM001_lookup]
    ON [dbo].[LN_TCCOM001]([compnr] ASC, [emno] ASC);


GO

