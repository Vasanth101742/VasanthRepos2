CREATE TABLE [dbo].[LN_WHINA113] (
    [compnr]                              BIGINT        NULL,
    [item]                                NVARCHAR (47) NULL,
    [cwar]                                NVARCHAR (6)  NULL,
    [trdt]                                NVARCHAR (40) NULL,
    [seqn]                                BIGINT        NULL,
    [inwp]                                BIGINT        NULL,
    [cpcp]                                NVARCHAR (8)  NULL,
    [inwp_kw]                             NVARCHAR (20) NULL,
    [hour]                                FLOAT (53)    NULL,
    [mauh]                                FLOAT (53)    NULL,
    [math]                                FLOAT (53)    NULL,
    [amah]                                FLOAT (53)    NULL,
    [atmh]                                FLOAT (53)    NULL,
    [amnt_1]                              FLOAT (53)    NULL,
    [amnt_2]                              FLOAT (53)    NULL,
    [amnt_3]                              FLOAT (53)    NULL,
    [mauc_1]                              FLOAT (53)    NULL,
    [mauc_2]                              FLOAT (53)    NULL,
    [mauc_3]                              FLOAT (53)    NULL,
    [matc_1]                              FLOAT (53)    NULL,
    [matc_2]                              FLOAT (53)    NULL,
    [matc_3]                              FLOAT (53)    NULL,
    [amac_1]                              FLOAT (53)    NULL,
    [amac_2]                              FLOAT (53)    NULL,
    [amac_3]                              FLOAT (53)    NULL,
    [atmc_1]                              FLOAT (53)    NULL,
    [atmc_2]                              FLOAT (53)    NULL,
    [atmc_3]                              FLOAT (53)    NULL,
    [item_cwar_trdt_seqn_inwp_ref_compnr] BIGINT        NULL,
    [item_ref_compnr]                     BIGINT        NULL,
    [cwar_ref_compnr]                     BIGINT        NULL,
    [cpcp_ref_compnr]                     BIGINT        NULL,
    [deleted]                             NCHAR (1)     NULL,
    [username]                            NVARCHAR (8)  NULL,
    [timestamp]                           DATETIME      NULL,
    [sequencenumber]                      BIGINT        NULL,
    [dlDocumentDate]                      NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_WHINA113_lookup]
    ON [dbo].[LN_WHINA113]([compnr] ASC, [item] ASC, [cwar] ASC, [trdt] ASC, [seqn] ASC, [inwp] ASC, [cpcp] ASC);


GO

