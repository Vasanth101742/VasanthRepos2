CREATE TABLE [dbo].[IAS_Sales_Performance] (
    [Company]      INT           NULL,
    [CustCode]     NVARCHAR (18) NULL,
    [CustName]     NVARCHAR (70) NULL,
    [AreaCode]     NVARCHAR (6)  NULL,
    [AreaName]     VARCHAR (50)  NULL,
    [OrderNum]     NVARCHAR (18) NULL,
    [PositionNum]  INT           NULL,
    [WareHouse]    NVARCHAR (12) NULL,
    [TranType]     NVARCHAR (6)  NULL,
    [InvDate]      DATETIME      NULL,
    [InvNo]        INT           NULL,
    [OrderQty]     FLOAT (53)    NULL,
    [DeliveredQty] FLOAT (53)    NULL,
    [UnitPrice]    FLOAT (53)    NULL,
    [SalesValue]   FLOAT (53)    NULL,
    [REFA]         NVARCHAR (60) NULL,
    [REFB]         NVARCHAR (40) NULL,
    [CPAY]         NVARCHAR (6)  NULL,
    [odat]         DATETIME      NULL,
    [CCUR]         NVARCHAR (6)  NULL,
    [CREP]         NVARCHAR (18) NULL,
    [CFCG]         NVARCHAR (6)  NULL,
    [DDAT]         DATETIME      NULL,
    [ItemCode]     NVARCHAR (94) NULL,
    [ItemDesc]     NVARCHAR (60) NULL
);


GO

