CREATE TABLE [dbo].[sales_data] (
    [COMPANY]       INT            NULL,
    [trantype]      NVARCHAR (3)   NULL,
    [Invoice]       INT            NULL,
    [Invoice_Date]  DATETIME       NULL,
    [SaleOrderType] NVARCHAR (6)   NULL,
    [OrderNo]       NVARCHAR (50)  NULL,
    [PositionNo]    INT            NULL,
    [dpst]          INT            NULL,
    [dpstname]      VARCHAR (100)  NULL,
    [areacode]      VARCHAR (5)    NULL,
    [areaname]      VARCHAR (50)   NULL,
    [Item]          NVARCHAR (47)  NULL,
    [Item_desc]     NVARCHAR (30)  NULL,
    [custcode]      NVARCHAR (9)   NULL,
    [custname]      NVARCHAR (100) NULL,
    [Qty]           FLOAT (53)     NULL,
    [sales]         FLOAT (53)     NULL,
    [month]         INT            NULL,
    [year]          INT            NULL,
    [Monthname]     VARCHAR (23)   NULL,
    [zone]          VARCHAR (20)   NULL
);


GO

