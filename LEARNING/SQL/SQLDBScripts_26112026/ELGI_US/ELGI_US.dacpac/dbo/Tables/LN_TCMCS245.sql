CREATE TABLE [dbo].[LN_TCMCS245] (
    [compnr]         BIGINT        NULL,
    [inpl]           NVARCHAR (9)  NULL,
    [desc]           NVARCHAR (50) NULL,
    [insm]           BIGINT        NULL,
    [insm_kw]        NVARCHAR (21) NULL,
    [atti]           BIGINT        NULL,
    [atti_kw]        NVARCHAR (20) NULL,
    [alai]           BIGINT        NULL,
    [alai_kw]        NVARCHAR (22) NULL,
    [clai]           BIGINT        NULL,
    [clai_kw]        NVARCHAR (22) NULL,
    [acai]           BIGINT        NULL,
    [acai_kw]        NVARCHAR (22) NULL,
    [tcai]           BIGINT        NULL,
    [tcai_kw]        NVARCHAR (22) NULL,
    [ibic]           BIGINT        NULL,
    [ibic_kw]        NVARCHAR (20) NULL,
    [inde]           BIGINT        NULL,
    [inde_kw]        NVARCHAR (20) NULL,
    [deleted]        NCHAR (1)     NULL,
    [username]       NVARCHAR (8)  NULL,
    [timestamp]      DATETIME      NULL,
    [sequencenumber] BIGINT        NULL,
    [dlDocumentDate] NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TCMCS245_lookup]
    ON [dbo].[LN_TCMCS245]([compnr] ASC, [inpl] ASC);


GO

