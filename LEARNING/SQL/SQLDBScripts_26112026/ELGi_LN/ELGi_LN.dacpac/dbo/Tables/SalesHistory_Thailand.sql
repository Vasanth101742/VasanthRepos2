CREATE TABLE [dbo].[SalesHistory_Thailand] (
    [company]      INT            NULL,
    [trantype]     NVARCHAR (3)   NULL,
    [Invoice]      INT            NULL,
    [Invoice_Date] DATETIME       NULL,
    [DeliveryQty]  FLOAT (53)     NULL,
    [Sales_amount] FLOAT (53)     NULL,
    [dpst]         NVARCHAR (6)   NULL,
    [dpstname]     VARCHAR (100)  NULL,
    [areacode]     VARCHAR (5)    NULL,
    [areaname]     VARCHAR (50)   NULL,
    [custcode]     NVARCHAR (9)   NULL,
    [custname]     NVARCHAR (100) NULL,
    [Item]         NVARCHAR (47)  NULL,
    [Item_desc]    NVARCHAR (30)  NULL,
    [productgrp]   VARCHAR (50)   NULL,
    [Fin_year]     INT            NULL,
    [Fin_month]    INT            NULL,
    [Month_Name]   VARCHAR (20)   NULL
);


GO

