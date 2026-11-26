CREATE TABLE [dbo].[ATS_DailyInventory2] (
    [COMPANY]          NVARCHAR (38) NULL,
    [CWAR]             NVARCHAR (12) NULL,
    [ItemCode]         NVARCHAR (94) NULL,
    [Item_desc]        NVARCHAR (60) NULL,
    [BuyerCode]        VARCHAR (50)  NULL,
    [BuyerName]        VARCHAR (50)  NULL,
    [SuppCode]         VARCHAR (50)  NULL,
    [SuppName]         VARCHAR (50)  NULL,
    [DivCode]          INT           NULL,
    [DivName]          VARCHAR (50)  NULL,
    [DeptCode]         INT           NULL,
    [DeptName]         VARCHAR (50)  NULL,
    [BinType]          VARCHAR (20)  NULL,
    [binQty]           FLOAT (53)    NULL,
    [QSKT]             FLOAT (53)    NULL,
    [UnitPrice]        FLOAT (53)    NULL,
    [amnt]             FLOAT (53)    NULL,
    [651]              FLOAT (53)    NULL,
    [652]              FLOAT (53)    NULL,
    [653]              FLOAT (53)    NULL,
    [654]              FLOAT (53)    NULL,
    [655]              FLOAT (53)    NULL,
    [667]              FLOAT (53)    NULL,
    [671]              FLOAT (53)    NULL,
    [674]              FLOAT (53)    NULL,
    [675]              FLOAT (53)    NULL,
    [ExcessQty]        FLOAT (53)    NULL,
    [ExcessVal]        FLOAT (53)    NULL,
    [PriceSource]      VARCHAR (25)  NULL,
    [Currency]         VARCHAR (25)  NULL,
    [CurRate]          FLOAT (53)    NULL,
    [639]              FLOAT (53)    NULL,
    [Productgroup_MRP] VARCHAR (50)  NULL
);


GO

