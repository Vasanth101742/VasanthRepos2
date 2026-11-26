CREATE TABLE [dbo].[LN_WHINA115] (
    [compnr]                                   BIGINT        NULL,
    [item]                                     NVARCHAR (47) NULL,
    [cwar]                                     NVARCHAR (6)  NULL,
    [trdt]                                     NVARCHAR (40) NULL,
    [seqn]                                     BIGINT        NULL,
    [inwp]                                     BIGINT        NULL,
    [sern]                                     BIGINT        NULL,
    [cpcp]                                     NVARCHAR (8)  NULL,
    [inwp_kw]                                  NVARCHAR (20) NULL,
    [hour]                                     FLOAT (53)    NULL,
    [amnt_1]                                   FLOAT (53)    NULL,
    [amnt_2]                                   FLOAT (53)    NULL,
    [amnt_3]                                   FLOAT (53)    NULL,
    [item_cwar_trdt_seqn_inwp_sern_ref_compnr] BIGINT        NULL,
    [item_ref_compnr]                          BIGINT        NULL,
    [cwar_ref_compnr]                          BIGINT        NULL,
    [cpcp_ref_compnr]                          BIGINT        NULL,
    [deleted]                                  NCHAR (1)     NULL,
    [username]                                 NVARCHAR (8)  NULL,
    [timestamp]                                DATETIME      NULL,
    [sequencenumber]                           BIGINT        NULL,
    [dlDocumentDate]                           NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_WHINA115_lookup]
    ON [dbo].[LN_WHINA115]([compnr] ASC, [item] ASC, [cwar] ASC, [trdt] ASC, [seqn] ASC, [inwp] ASC, [sern] ASC, [cpcp] ASC);


GO

