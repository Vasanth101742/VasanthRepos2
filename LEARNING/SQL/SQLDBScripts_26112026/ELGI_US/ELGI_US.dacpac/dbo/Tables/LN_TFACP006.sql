CREATE TABLE [dbo].[LN_TFACP006] (
    [compnr]         BIGINT        NULL,
    [user]           NVARCHAR (16) NULL,
    [fico]           BIGINT        NULL,
    [grid]           NVARCHAR (6)  NULL,
    [cwoc]           NVARCHAR (6)  NULL,
    [lppd]           BIGINT        NULL,
    [hppd]           BIGINT        NULL,
    [lapd]           FLOAT (53)    NULL,
    [hapd]           FLOAT (53)    NULL,
    [falo]           BIGINT        NULL,
    [falo_kw]        NVARCHAR (20) NULL,
    [fahi]           BIGINT        NULL,
    [fahi_kw]        NVARCHAR (20) NULL,
    [maac]           FLOAT (53)    NULL,
    [faac]           BIGINT        NULL,
    [faac_kw]        NVARCHAR (20) NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFACP006_lookup]
    ON [dbo].[LN_TFACP006]([compnr] ASC, [user] ASC, [fico] ASC, [grid] ASC, [cwoc] ASC);


GO

