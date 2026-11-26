CREATE TABLE [dbo].[Inventory_DailyTrend] (
    [Company]     NVARCHAR (38) NULL,
    [INVType]     VARCHAR (50)  NULL,
    [Ageing2]     VARCHAR (50)  NULL,
    [AgeingOrdr2] INT           NULL,
    [SuppCode]    VARCHAR (50)  NULL,
    [SuppName]    VARCHAR (50)  NULL,
    [BuyerCode]   VARCHAR (50)  NULL,
    [BuyerName]   VARCHAR (50)  NULL,
    [TeamLeader]  VARCHAR (50)  NULL,
    [LeanType]    VARCHAR (50)  NULL,
    [PLMT1]       VARCHAR (50)  NULL,
    [category]    NVARCHAR (70) NULL,
    [vari]        NVARCHAR (60) NULL,
    [category3]   VARCHAR (50)  NULL,
    [Region]      VARCHAR (25)  NULL,
    [RegionOrder] INT           NULL,
    [QSKT]        FLOAT (53)    NULL,
    [Amnt4_INR]   FLOAT (53)    NULL,
    [EntryDate]   DATE          NULL,
    [CalYear]     INT           NULL,
    [CalMonth]    INT           NULL,
    [CompName]    VARCHAR (50)  NULL
);


GO

