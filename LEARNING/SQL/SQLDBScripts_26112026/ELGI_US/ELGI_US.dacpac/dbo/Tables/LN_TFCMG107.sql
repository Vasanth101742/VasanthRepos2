CREATE TABLE [dbo].[LN_TFCMG107] (
    [compnr]         BIGINT        NULL,
    [user]           NVARCHAR (16) NULL,
    [faab]           BIGINT        NULL,
    [faab_kw]        NVARCHAR (20) NULL,
    [maxa]           FLOAT (53)    NULL,
    [fpay]           BIGINT        NULL,
    [fpay_kw]        NVARCHAR (20) NULL,
    [pyid]           NVARCHAR (11) NULL,
    [mafp]           FLOAT (53)    NULL,
    [pbap]           BIGINT        NULL,
    [pbap_kw]        NVARCHAR (20) NULL,
    [ddba]           BIGINT        NULL,
    [ddba_kw]        NVARCHAR (20) NULL,
    [fabc]           BIGINT        NULL,
    [fabc_kw]        NVARCHAR (20) NULL,
    [mabc]           FLOAT (53)    NULL,
    [fapd]           BIGINT        NULL,
    [fapd_kw]        NVARCHAR (20) NULL,
    [mapd]           FLOAT (53)    NULL,
    [mnpd]           FLOAT (53)    NULL,
    [perl]           FLOAT (53)    NULL,
    [perh]           FLOAT (53)    NULL,
    [amtl]           FLOAT (53)    NULL,
    [amth]           FLOAT (53)    NULL,
    [pbaa]           FLOAT (53)    NULL,
    [dbaa]           FLOAT (53)    NULL,
    [kupa]           BIGINT        NULL,
    [kupa_kw]        NVARCHAR (22) NULL,
    [kudb]           BIGINT        NULL,
    [kudb_kw]        NVARCHAR (22) NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFCMG107_lookup]
    ON [dbo].[LN_TFCMG107]([compnr] ASC, [user] ASC);


GO

