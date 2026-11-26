CREATE TABLE [dbo].[LN_BTREC212] (
    [compnr]          BIGINT        NULL,
    [fire]            NVARCHAR (9)  NULL,
    [line]            BIGINT        NULL,
    [seri]            BIGINT        NULL,
    [odat]            NVARCHAR (40) NULL,
    [ncmp]            BIGINT        NULL,
    [oorg]            BIGINT        NULL,
    [oorg_kw]         NVARCHAR (26) NULL,
    [orno]            NVARCHAR (15) NULL,
    [pono]            NVARCHAR (15) NULL,
    [ordn]            NVARCHAR (15) NULL,
    [ordl]            NVARCHAR (15) NULL,
    [seqn]            BIGINT        NULL,
    [rcno]            NVARCHAR (15) NULL,
    [rcln]            NVARCHAR (15) NULL,
    [cwar]            NVARCHAR (12) NULL,
    [unit]            NVARCHAR (6)  NULL,
    [qnty]            FLOAT (53)    NULL,
    [qnts]            FLOAT (53)    NULL,
    [tsrc]            BIGINT        NULL,
    [tsrc_kw]         NVARCHAR (20) NULL,
    [cpva]            BIGINT        NULL,
    [fire_ref_compnr] BIGINT        NULL,
    [cwar_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_BTREC212_lookup]
    ON [dbo].[LN_BTREC212]([compnr] ASC, [fire] ASC, [line] ASC, [seri] ASC);


GO

