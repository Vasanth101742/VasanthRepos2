CREATE TABLE [dbo].[LN_TFCAT000] (
    [compnr]          BIGINT        NULL,
    [indt]            NVARCHAR (40) NULL,
    [dsca]            NVARCHAR (50) NULL,
    [flea]            NVARCHAR (12) NULL,
    [syst]            BIGINT        NULL,
    [syst_kw]         NVARCHAR (20) NULL,
    [ttor]            NVARCHAR (3)  NULL,
    [ttar]            NVARCHAR (3)  NULL,
    [typa]            BIGINT        NULL,
    [rule]            NVARCHAR (4)  NULL,
    [text]            BIGINT        NULL,
    [flea_ref_compnr] BIGINT        NULL,
    [ttor_ref_compnr] BIGINT        NULL,
    [ttar_ref_compnr] BIGINT        NULL,
    [typa_ref_compnr] BIGINT        NULL,
    [rule_ref_compnr] BIGINT        NULL,
    [text_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFCAT000_lookup]
    ON [dbo].[LN_TFCAT000]([compnr] ASC, [indt] ASC);


GO

