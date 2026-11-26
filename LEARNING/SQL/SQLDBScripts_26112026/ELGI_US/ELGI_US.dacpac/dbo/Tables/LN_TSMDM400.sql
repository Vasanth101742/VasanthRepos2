CREATE TABLE [dbo].[LN_TSMDM400] (
    [compnr]         BIGINT        NULL,
    [orig]           BIGINT        NULL,
    [orno]           NVARCHAR (9)  NULL,
    [apln]           BIGINT        NULL,
    [cotp]           BIGINT        NULL,
    [csln]           BIGINT        NULL,
    [mtyp]           BIGINT        NULL,
    [seqn]           BIGINT        NULL,
    [orig_kw]        NVARCHAR (27) NULL,
    [cotp_kw]        NVARCHAR (20) NULL,
    [mtyp_kw]        NVARCHAR (25) NULL,
    [ttyp]           BIGINT        NULL,
    [ttyp_kw]        NVARCHAR (20) NULL,
    [ocyn]           BIGINT        NULL,
    [ocyn_kw]        NVARCHAR (20) NULL,
    [roty]           BIGINT        NULL,
    [roty_kw]        NVARCHAR (25) NULL,
    [rono]           NVARCHAR (9)  NULL,
    [reln]           BIGINT        NULL,
    [rseq]           BIGINT        NULL,
    [oseq]           BIGINT        NULL,
    [rorf]           NVARCHAR (90) NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSMDM400_lookup]
    ON [dbo].[LN_TSMDM400]([compnr] ASC, [orig] ASC, [orno] ASC, [apln] ASC, [cotp] ASC, [csln] ASC, [mtyp] ASC, [seqn] ASC);


GO

