CREATE TABLE [dbo].[collection_report_daily_new_ats] (
    [company]     INT           NULL,
    [Trantyp]     NVARCHAR (3)  NULL,
    [InvNo]       INT           NULL,
    [CustNo]      NVARCHAR (9)  NULL,
    [CustName1]   NVARCHAR (70) NULL,
    [DocDt]       DATETIME      NULL,
    [doctyp]      INT           NULL,
    [collection]  FLOAT (53)    NULL,
    [DpstCode]    VARCHAR (20)  NULL,
    [DpstName]    VARCHAR (100) NULL,
    [Description] VARCHAR (50)  NULL,
    [areacode]    NVARCHAR (4)  NULL,
    [AreaName]    VARCHAR (50)  NULL,
    [Zone]        VARCHAR (50)  NULL,
    [region]      VARCHAR (50)  NULL,
    [Global]      VARCHAR (20)  NULL,
    [AnpTranTyp]  NVARCHAR (3)  NULL,
    [anpdocno]    INT           NULL,
    [ctrantyp]    NVARCHAR (3)  NULL,
    [cdocno]      INT           NULL,
    [refr]        INT           NULL
);


GO

