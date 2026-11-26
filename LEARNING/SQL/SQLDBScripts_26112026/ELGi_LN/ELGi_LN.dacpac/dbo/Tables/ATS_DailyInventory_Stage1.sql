CREATE TABLE [dbo].[ATS_DailyInventory_Stage1] (
    [COMPANY]   NVARCHAR (38) NULL,
    [CWAR]      NVARCHAR (12) NULL,
    [ItemCode]  NVARCHAR (94) NULL,
    [TRDT]      DATETIME      NULL,
    [QSKT]      FLOAT (53)    NULL,
    [amnt]      FLOAT (53)    NULL,
    [item_desc] NVARCHAR (60) NULL,
    [BuyerCode] VARCHAR (50)  NULL,
    [BuyerName] VARCHAR (50)  NULL,
    [SuppCode]  VARCHAR (50)  NULL,
    [SuppName]  VARCHAR (50)  NULL,
    [binQty]    FLOAT (53)    NULL,
    [SOPS]      FLOAT (53)    NULL,
    [BinType]   VARCHAR (20)  NULL,
    [DivCode]   INT           NULL,
    [DivName]   VARCHAR (50)  NULL,
    [DeptCode]  INT           NULL,
    [DeptName]  VARCHAR (50)  NULL
);


GO

