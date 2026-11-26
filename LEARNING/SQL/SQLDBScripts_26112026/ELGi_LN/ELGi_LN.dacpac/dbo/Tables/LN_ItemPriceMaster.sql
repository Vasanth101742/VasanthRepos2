CREATE TABLE [dbo].[LN_ItemPriceMaster] (
    [Company]       NVARCHAR (38) NULL,
    [OTBP]          NVARCHAR (18) NULL,
    [ITEM]          NVARCHAR (94) NULL,
    [CURN]          NVARCHAR (6)  NULL,
    [BAPR]          NVARCHAR (38) NULL,
    [EFDT]          DATETIME      NULL,
    [EXDT]          DATETIME      NULL,
    [BCUR]          NVARCHAR (3)  NULL,
    [CCUR]          NVARCHAR (3)  NULL,
    [RATE]          FLOAT (53)    NULL,
    [STDT]          DATETIME2 (0) NULL,
    [DateRnk]       BIGINT        NULL,
    [UnitPrice_INR] FLOAT (53)    NULL
);


GO

