CREATE TABLE [dbo].[DOL] (
    [year]         INT           NULL,
    [month]        INT           NULL,
    [monthname]    NVARCHAR (30) NULL,
    [week]         INT           NULL,
    [COMPANY]      NVARCHAR (38) NULL,
    [T$RCNO]       NVARCHAR (18) NULL,
    [Rec_Date]     DATE          NULL,
    [T$ORNO]       NVARCHAR (18) NULL,
    [T$PONO]       NVARCHAR (38) NULL,
    [T$SQNB]       NVARCHAR (38) NULL,
    [CWAR]         NVARCHAR (12) NULL,
    [ITEM]         NVARCHAR (94) NULL,
    [Item_desc]    VARCHAR (100) NULL,
    [OTBP]         NVARCHAR (18) NULL,
    [SupplierName] VARCHAR (100) NULL,
    [Rec_Count]    INT           NULL,
    [DOL_SysCnt]   INT           NULL,
    [DOL_ManCnt]   INT           NULL,
    [QIAP]         FLOAT (53)    NULL
);


GO

