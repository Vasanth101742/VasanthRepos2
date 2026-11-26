CREATE TABLE [dbo].[LN_TFCAT402] (
    [compnr]                    BIGINT        NULL,
    [rule]                      NVARCHAR (4)  NULL,
    [akey]                      NVARCHAR (4)  NULL,
    [ddty]                      BIGINT        NULL,
    [ddim]                      NVARCHAR (9)  NULL,
    [dref]                      NVARCHAR (3)  NULL,
    [dlea]                      NVARCHAR (12) NULL,
    [disb]                      NVARCHAR (3)  NULL,
    [pdpe]                      FLOAT (53)    NULL,
    [valp]                      BIGINT        NULL,
    [valp_kw]                   NVARCHAR (20) NULL,
    [coca]                      NVARCHAR (12) NULL,
    [perc]                      FLOAT (53)    NULL,
    [dvar]                      FLOAT (53)    NULL,
    [txta]                      BIGINT        NULL,
    [rule_ref_compnr]           BIGINT        NULL,
    [akey_ref_compnr]           BIGINT        NULL,
    [ddty_ddim_ref_compnr]      BIGINT        NULL,
    [ddty_ddim_dref_ref_compnr] BIGINT        NULL,
    [ddty_ref_compnr]           BIGINT        NULL,
    [dlea_ref_compnr]           BIGINT        NULL,
    [disb_ref_compnr]           BIGINT        NULL,
    [coca_ref_compnr]           BIGINT        NULL,
    [txta_ref_compnr]           BIGINT        NULL,
    [deleted]                   NCHAR (1)     NULL,
    [username]                  NVARCHAR (8)  NULL,
    [timestamp]                 DATETIME      NULL,
    [sequencenumber]            BIGINT        NULL,
    [dlDocumentDate]            NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFCAT402_lookup]
    ON [dbo].[LN_TFCAT402]([compnr] ASC, [rule] ASC, [akey] ASC, [ddty] ASC, [ddim] ASC, [dref] ASC, [dlea] ASC);


GO

