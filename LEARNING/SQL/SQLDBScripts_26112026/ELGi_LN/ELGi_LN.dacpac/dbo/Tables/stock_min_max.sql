CREATE TABLE [dbo].[stock_min_max] (
    [Item]                NVARCHAR (94) NULL,
    [Item_desc]           NVARCHAR (60) NULL,
    [Warehouse]           NVARCHAR (12) NULL,
    [Minqty]              FLOAT (53)    NULL,
    [Maxqty]              FLOAT (53)    NULL,
    [stock_onhand]        FLOAT (53)    NULL,
    [stock_act]           FLOAT (53)    NULL,
    [pending_order_stock] FLOAT (53)    NULL
);


GO

