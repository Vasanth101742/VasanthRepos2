CREATE TABLE [dbo].[LN_LPBRA245] (
    [compnr]         BIGINT        NULL,
    [fire]           NVARCHAR (9)  NULL,
    [tror]           BIGINT        NULL,
    [tror_kw]        NVARCHAR (20) NULL,
    [manf]           BIGINT        NULL,
    [manf_kw]        NVARCHAR (20) NULL,
    [fdty]           BIGINT        NULL,
    [fdty_kw]        NVARCHAR (26) NULL,
    [docn]           BIGINT        NULL,
    [seri]           NVARCHAR (8)  NULL,
    [stat]           BIGINT        NULL,
    [stat_kw]        NVARCHAR (20) NULL,
    [nfes]           BIGINT        NULL,
    [nfes_kw]        NVARCHAR (24) NULL,
    [tsta]           BIGINT        NULL,
    [tsta_kw]        NVARCHAR (26) NULL,
    [cnfe]           NVARCHAR (50) NULL,
    [fcmp]           BIGINT        NULL,
    [scmp]           BIGINT        NULL,
    [cofc]           NVARCHAR (6)  NULL,
    [estb]           NVARCHAR (16) NULL,
    [ttyp]           NVARCHAR (3)  NULL,
    [ninv]           BIGINT        NULL,
    [bpid]           NVARCHAR (9)  NULL,
    [itbp]           NVARCHAR (9)  NULL,
    [cpay]           NVARCHAR (3)  NULL,
    [date]           NVARCHAR (40) NULL,
    [lrat]           FLOAT (53)    NULL,
    [lraf]           BIGINT        NULL,
    [fcrt]           BIGINT        NULL,
    [fcrt_kw]        NVARCHAR (20) NULL,
    [ccur]           NVARCHAR (3)  NULL,
    [rtyp]           NVARCHAR (3)  NULL,
    [ratd]           NVARCHAR (40) NULL,
    [rate_1]         FLOAT (53)    NULL,
    [rate_2]         FLOAT (53)    NULL,
    [rate_3]         FLOAT (53)    NULL,
    [ratf_1]         BIGINT        NULL,
    [ratf_2]         BIGINT        NULL,
    [ratf_3]         BIGINT        NULL,
    [prst]           BIGINT        NULL,
    [prst_kw]        NVARCHAR (26) NULL,
    [gamt]           FLOAT (53)    NULL,
    [amnt]           FLOAT (53)    NULL,
    [amsc]           FLOAT (53)    NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_LPBRA245_lookup]
    ON [dbo].[LN_LPBRA245]([compnr] ASC, [fire] ASC);


GO

