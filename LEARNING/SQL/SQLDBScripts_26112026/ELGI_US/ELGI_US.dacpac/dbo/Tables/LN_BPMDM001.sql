CREATE TABLE [dbo].[LN_BPMDM001] (
    [compnr]          BIGINT          NULL,
    [emno]            NVARCHAR (9)    NULL,
    [cadr]            NVARCHAR (9)    NULL,
    [hwem]            DECIMAL (12, 6) NULL,
    [wtsc]            NVARCHAR (3)    NULL,
    [sdte]            NVARCHAR (10)   NULL,
    [edte]            NVARCHAR (10)   NULL,
    [daob]            NVARCHAR (10)   NULL,
    [sexe]            BIGINT          NULL,
    [sexe_kw]         NVARCHAR (20)   NULL,
    [cist]            NVARCHAR (15)   NULL,
    [emtp]            BIGINT          NULL,
    [emtp_kw]         NVARCHAR (20)   NULL,
    [finr]            NVARCHAR (16)   NULL,
    [telw]            NVARCHAR (32)   NULL,
    [tlw1]            NVARCHAR (32)   NULL,
    [tefw]            NVARCHAR (32)   NULL,
    [mail]            NVARCHAR (100)  NULL,
    [ucrm]            BIGINT          NULL,
    [ucrm_kw]         NVARCHAR (20)   NULL,
    [telm]            NVARCHAR (32)   NULL,
    [msty]            BIGINT          NULL,
    [msty_kw]         NVARCHAR (20)   NULL,
    [msad]            NVARCHAR (50)   NULL,
    [jobt]            NVARCHAR (50)   NULL,
    [bano]            NVARCHAR (34)   NULL,
    [tctr]            NVARCHAR (30)   NULL,
    [cedt]            NVARCHAR (10)   NULL,
    [otbp]            NVARCHAR (9)    NULL,
    [ccty]            NVARCHAR (3)    NULL,
    [rgno]            NVARCHAR (30)   NULL,
    [prtn]            NVARCHAR (35)   NULL,
    [ptbp]            NVARCHAR (9)    NULL,
    [supv]            NVARCHAR (9)    NULL,
    [ctrg]            NVARCHAR (6)    NULL,
    [txta]            BIGINT          NULL,
    [emno_ref_compnr] BIGINT          NULL,
    [cadr_ref_compnr] BIGINT          NULL,
    [wtsc_ref_compnr] BIGINT          NULL,
    [otbp_ref_compnr] BIGINT          NULL,
    [ccty_ref_compnr] BIGINT          NULL,
    [ptbp_ref_compnr] BIGINT          NULL,
    [supv_ref_compnr] BIGINT          NULL,
    [txta_ref_compnr] BIGINT          NULL,
    [deleted]         NCHAR (1)       NULL,
    [username]        NVARCHAR (8)    NULL,
    [timestamp]       DATETIME        NULL,
    [sequencenumber]  BIGINT          NULL,
    [dlDocumentDate]  NVARCHAR (40)   NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_BPMDM100_lookup]
    ON [dbo].[LN_BPMDM001]([compnr] ASC, [emno] ASC);


GO

