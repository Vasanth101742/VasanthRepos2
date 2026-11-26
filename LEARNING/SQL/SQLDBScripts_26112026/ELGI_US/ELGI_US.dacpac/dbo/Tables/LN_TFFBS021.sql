CREATE TABLE [dbo].[LN_TFFBS021] (
    [compnr]          BIGINT        NULL,
    [dtyp]            BIGINT        NULL,
    [tlea]            NVARCHAR (12) NULL,
    [slea]            NVARCHAR (12) NULL,
    [rper]            FLOAT (53)    NULL,
    [dtyp_ref_compnr] BIGINT        NULL,
    [tlea_ref_compnr] BIGINT        NULL,
    [slea_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFFBS021_lookup]
    ON [dbo].[LN_TFFBS021]([compnr] ASC, [dtyp] ASC, [tlea] ASC, [slea] ASC);


GO

