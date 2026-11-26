CREATE TABLE [dbo].[LN_TTAMS420] (
    [compnr]                                   BIGINT        NULL,
    [user]                                     NVARCHAR (12) NULL,
    [cntx]                                     BIGINT        NULL,
    [cdem]                                     BIGINT        NULL,
    [brfm]                                     NVARCHAR (6)  NULL,
    [vers]                                     NVARCHAR (10) NULL,
    [optp]                                     NVARCHAR (6)  NULL,
    [role]                                     NVARCHAR (15) NULL,
    [cntx_kw]                                  NVARCHAR (20) NULL,
    [gnrt]                                     BIGINT        NULL,
    [gnrt_kw]                                  NVARCHAR (20) NULL,
    [gntm]                                     NVARCHAR (40) NULL,
    [user_ref_compnr]                          BIGINT        NULL,
    [cntx_cdem_brfm_vers_optp_role_ref_compnr] BIGINT        NULL,
    [cdem_ref_compnr]                          BIGINT        NULL,
    [deleted]                                  NCHAR (1)     NULL,
    [username]                                 NVARCHAR (8)  NULL,
    [timestamp]                                DATETIME      NULL,
    [sequencenumber]                           BIGINT        NULL,
    [dlDocumentDate]                           NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TTAMS420_lookup]
    ON [dbo].[LN_TTAMS420]([compnr] ASC, [user] ASC, [cntx] ASC, [cdem] ASC, [brfm] ASC, [vers] ASC, [optp] ASC, [role] ASC);


GO

