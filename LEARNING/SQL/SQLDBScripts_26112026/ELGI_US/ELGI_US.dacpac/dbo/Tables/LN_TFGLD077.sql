CREATE TABLE [dbo].[LN_TFGLD077] (
    [compnr]          BIGINT        NULL,
    [reco]            BIGINT        NULL,
    [recs]            BIGINT        NULL,
    [reco_kw]         NVARCHAR (22) NULL,
    [rcyr]            BIGINT        NULL,
    [rcfp]            BIGINT        NULL,
    [aryr]            BIGINT        NULL,
    [arfp]            BIGINT        NULL,
    [clyr]            BIGINT        NULL,
    [clfp]            BIGINT        NULL,
    [obyr]            BIGINT        NULL,
    [obfp]            BIGINT        NULL,
    [rcyr_ref_compnr] BIGINT        NULL,
    [aryr_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFGLD077_lookup]
    ON [dbo].[LN_TFGLD077]([compnr] ASC, [reco] ASC, [recs] ASC);


GO

