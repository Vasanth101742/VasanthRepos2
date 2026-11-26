CREATE TABLE [dbo].[Pending_Orders_asondate] (
    [Entrydate]   DATETIME       NULL,
    [Company]     INT            NULL,
    [ordertype]   NVARCHAR (6)   NULL,
    [OrderDate]   DATETIME       NULL,
    [OrderNum]    NVARCHAR (18)  NULL,
    [PositionNum] INT            NULL,
    [dpst]        NVARCHAR (12)  NULL,
    [dpstname]    VARCHAR (100)  NULL,
    [CustCode]    NVARCHAR (18)  NULL,
    [CustName]    NVARCHAR (100) NULL,
    [areacode]    NVARCHAR (6)   NULL,
    [areaname]    VARCHAR (50)   NULL,
    [ItemCode]    NVARCHAR (94)  NULL,
    [Item_desc]   NVARCHAR (100) NULL,
    [ordqty]      FLOAT (53)     NULL,
    [price]       FLOAT (53)     NULL,
    [ord_Value]   FLOAT (53)     NULL,
    [invqty]      FLOAT (53)     NULL,
    [INv_value]   FLOAT (53)     NULL,
    [NAME]        VARCHAR (7)    NOT NULL
);


GO

