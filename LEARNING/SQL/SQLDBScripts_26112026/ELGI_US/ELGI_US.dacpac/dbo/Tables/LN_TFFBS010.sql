CREATE TABLE [dbo].[LN_TFFBS010] (
    [compnr]          BIGINT        NULL,
    [hier]            NVARCHAR (3)  NULL,
    [desc]            NVARCHAR (50) NULL,
    [adt1]            BIGINT        NULL,
    [adt1_kw]         NVARCHAR (20) NULL,
    [adt2]            BIGINT        NULL,
    [adt2_kw]         NVARCHAR (20) NULL,
    [adt3]            BIGINT        NULL,
    [adt3_kw]         NVARCHAR (20) NULL,
    [adt4]            BIGINT        NULL,
    [adt4_kw]         NVARCHAR (20) NULL,
    [adt5]            BIGINT        NULL,
    [adt5_kw]         NVARCHAR (20) NULL,
    [adt6]            BIGINT        NULL,
    [adt6_kw]         NVARCHAR (20) NULL,
    [adt7]            BIGINT        NULL,
    [adt7_kw]         NVARCHAR (20) NULL,
    [adt8]            BIGINT        NULL,
    [adt8_kw]         NVARCHAR (20) NULL,
    [adt9]            BIGINT        NULL,
    [adt9_kw]         NVARCHAR (20) NULL,
    [ad10]            BIGINT        NULL,
    [ad10_kw]         NVARCHAR (20) NULL,
    [ad11]            BIGINT        NULL,
    [ad11_kw]         NVARCHAR (20) NULL,
    [ad12]            BIGINT        NULL,
    [ad12_kw]         NVARCHAR (20) NULL,
    [text]            BIGINT        NULL,
    [text_ref_compnr] BIGINT        NULL,
    [deleted]         NCHAR (1)     NULL,
    [username]        NVARCHAR (8)  NULL,
    [timestamp]       DATETIME      NULL,
    [sequencenumber]  BIGINT        NULL,
    [dlDocumentDate]  NVARCHAR (40) NULL
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [idx_LN_TFFBS010_lookup]
    ON [dbo].[LN_TFFBS010]([compnr] ASC, [hier] ASC);


GO

