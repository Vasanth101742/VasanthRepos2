CREATE TABLE [dbo].[GSC_OVERDUE_BCKUP] (
    [blocked]           NVARCHAR (255) NULL,
    [plan_del_date]     NVARCHAR (255) NULL,
    [dpst]              NVARCHAR (255) NULL,
    [PositionNum]       NVARCHAR (255) NULL,
    [OrderNum]          NVARCHAR (255) NULL,
    [ordertype]         NVARCHAR (255) NULL,
    [ItemCode]          NVARCHAR (255) NULL,
    [Item_desc]         NVARCHAR (255) NULL,
    [Price]             NVARCHAR (255) NULL,
    [Indent]            NVARCHAR (255) NULL,
    [OrderDate]         NVARCHAR (255) NULL,
    [CustCode]          NVARCHAR (255) NULL,
    [Custname]          NVARCHAR (255) NULL,
    [value]             NVARCHAR (255) NULL,
    [ord_qty]           NVARCHAR (255) NULL,
    [ShipQty]           NVARCHAR (255) NULL,
    [delqty]            NVARCHAR (255) NULL,
    [penqty]            NVARCHAR (255) NULL,
    [STOCK_490_onhand]  NVARCHAR (255) NULL,
    [STOCK_490_blocked] NVARCHAR (255) NULL,
    [STOCK_490_act]     NVARCHAR (255) NULL,
    [bYER]              NVARCHAR (255) NULL,
    [SUPPLIER]          NVARCHAR (255) NULL,
    [Next_Due_Date]     NVARCHAR (255) NULL,
    [Reason]            NVARCHAR (255) NULL,
    [Next_Due_Date2]    NVARCHAR (100) NULL,
    [Reason2]           NVARCHAR (100) NULL,
    [DATALOAD_DATE]     DATETIME       NULL
);


GO

