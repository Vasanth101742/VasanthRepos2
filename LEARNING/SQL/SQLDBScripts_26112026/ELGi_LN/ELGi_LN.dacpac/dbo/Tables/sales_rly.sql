CREATE TABLE [dbo].[sales_rly] (
    [typ]          VARCHAR (4)    NOT NULL,
    [Invoice_Date] DATETIME       NULL,
    [Company]      INT            NULL,
    [TranType]     NVARCHAR (3)   NULL,
    [Invoice]      INT            NULL,
    [Item]         NVARCHAR (47)  NULL,
    [Item_desc]    NVARCHAR (30)  NULL,
    [Dpst]         NVARCHAR (100) NULL,
    [DPSTName]     VARCHAR (100)  NULL,
    [areacode]     VARCHAR (5)    NULL,
    [AreaName]     VARCHAR (50)   NULL,
    [Zone]         VARCHAR (100)  NULL,
    [custcode]     NVARCHAR (9)   NULL,
    [custname]     NVARCHAR (100) NULL,
    [OrderNo]      NVARCHAR (50)  NULL,
    [DeliveryQty]  FLOAT (53)     NULL,
    [sales]        FLOAT (53)     NULL
);


GO

