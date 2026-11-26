CREATE TABLE [dbo].[sales_cube] (
    [company]       INT           NULL,
    [trantype]      NVARCHAR (3)  NULL,
    [OrderNo]       NVARCHAR (9)  NULL,
    [PositionNo]    INT           NULL,
    [Invoice]       INT           NULL,
    [item]          NVARCHAR (47) NULL,
    [Item_desc]     NVARCHAR (30) NULL,
    [custcode]      NVARCHAR (9)  NULL,
    [custname]      NVARCHAR (35) NULL,
    [dpst]          NVARCHAR (6)  NULL,
    [dpstname]      VARCHAR (100) NULL,
    [organ]         VARCHAR (50)  NULL,
    [Region]        VARCHAR (150) NOT NULL,
    [Vertical1]     VARCHAR (100) NOT NULL,
    [Division]      VARCHAR (50)  NOT NULL,
    [areacode]      VARCHAR (5)   NULL,
    [areaname]      VARCHAR (50)  NOT NULL,
    [Zone]          VARCHAR (100) NOT NULL,
    [cal_year]      INT           NULL,
    [Fin_year]      INT           NULL,
    [cal_Month]     INT           NULL,
    [Fin_month]     INT           NULL,
    [Monthname]     NVARCHAR (30) NULL,
    [Day]           INT           NULL,
    [SaleOrderType] NVARCHAR (6)  NULL,
    [shipmentno]    VARCHAR (23)  NOT NULL,
    [shipmentline]  INT           NOT NULL,
    [shiptoaddress] VARCHAR (23)  NOT NULL,
    [Sales_amount]  FLOAT (53)    NULL,
    [Vertical_new]  VARCHAR (100) NULL,
    [Global]        VARCHAR (13)  NULL
);


GO

