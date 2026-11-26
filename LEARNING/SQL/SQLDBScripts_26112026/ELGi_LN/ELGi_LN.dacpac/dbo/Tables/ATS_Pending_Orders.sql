CREATE TABLE [dbo].[ATS_Pending_Orders] (
    [company]      INT            NULL,
    [WareHouse]    NVARCHAR (12)  NULL,
    [CustCode]     NVARCHAR (18)  NULL,
    [CustName]     NVARCHAR (100) NULL,
    [ItemCode]     NVARCHAR (94)  NULL,
    [Item_desc]    NVARCHAR (100) NULL,
    [OrderDate]    DATETIME       NULL,
    [ordertype]    NVARCHAR (6)   NULL,
    [OrderNum]     NVARCHAR (18)  NULL,
    [PositionNum]  INT            NULL,
    [Indent]       NVARCHAR (60)  NULL,
    [Dpst]         NVARCHAR (12)  NULL,
    [Dpstname]     NVARCHAR (100) NULL,
    [Areacode]     NVARCHAR (10)  NULL,
    [Areaname]     NVARCHAR (100) NULL,
    [ord_qty]      FLOAT (53)     NULL,
    [PendQty]      FLOAT (53)     NULL,
    [value]        FLOAT (53)     NULL,
    [Ageing]       VARCHAR (50)   NULL,
    [AgeingOrder]  INT            NULL,
    [StockQty]     FLOAT (53)     NULL,
    [StockStatus]  VARCHAR (25)   NULL,
    [ItemType]     VARCHAR (25)   NULL,
    [ItemRnk]      INT            NULL,
    [Buyer]        VARCHAR (50)   NULL,
    [StockStatus1] VARCHAR (25)   NULL
);


GO

