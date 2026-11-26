CREATE TABLE [dbo].[LN_TSCTM061] (
    [compnr]          BIGINT        NULL,
    [cind]            NVARCHAR (3)  NULL,
    [efdt]            NVARCHAR (10) NULL,
    [exdt]            NVARCHAR (10) NULL,
    [oaip]            FLOAT (53)    NULL,
    [mtip]            FLOAT (53)    NULL,
    [lbip]            FLOAT (53)    NULL,
    [tlip]            FLOAT (53)    NULL,
    [trip]            FLOAT (53)    NULL,
    [sbip]            FLOAT (53)    NULL,
    [hdip]            FLOAT (53)    NULL,
    [otip]            FLOAT (53)    NULL,
    [utip]            FLOAT (53)    NULL,
    [alip]            FLOAT (53)    NULL,
    [ipip]            FLOAT (53)    NULL,
    [bcip]            FLOAT (53)    NULL,
    [svip]            FLOAT (53)    NULL,
    [ucpl]            BIGINT        NULL,
    [ucpl_kw]         NVARCHAR (20) NULL,
    [oapm]            BIGINT        NULL,
    [oapm_kw]         NVARCHAR (20) NULL,
    [mtpm]            BIGINT        NULL,
    [mtpm_kw]         NVARCHAR (20) NULL,
    [lbpm]            BIGINT        NULL,
    [lbpm_kw]         NVARCHAR (20) NULL,
    [tlpm]            BIGINT        NULL,
    [tlpm_kw]         NVARCHAR (20) NULL,
    [trpm]            BIGINT        NULL,
    [trpm_kw]         NVARCHAR (20) NULL,
    [sbpm]            BIGINT        NULL,
    [sbpm_kw]         NVARCHAR (20) NULL,
    [hdpm]            BIGINT        NULL,
    [hdpm_kw]         NVARCHAR (20) NULL,
    [otpm]            BIGINT        NULL,
    [otpm_kw]         NVARCHAR (20) NULL,
    [cind_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TSCTM061_lookup]
    ON [dbo].[LN_TSCTM061]([compnr] ASC, [cind] ASC, [efdt] ASC);


GO

