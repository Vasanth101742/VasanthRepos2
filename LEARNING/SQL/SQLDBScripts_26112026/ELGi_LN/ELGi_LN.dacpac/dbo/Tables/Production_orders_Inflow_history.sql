CREATE TABLE [dbo].[Production_orders_Inflow_history] (
    [Company]                  VARCHAR (10) NULL,
    [CWAR]                     VARCHAR (25) NULL,
    [ItemCode]                 VARCHAR (50) NULL,
    [ItemDescr]                VARCHAR (50) NULL,
    [Description]              VARCHAR (50) NULL,
    [InflowOrders]             FLOAT (53)   NULL,
    [EntryDate]                DATE         NULL,
    [PDNO]                     VARCHAR (50) NULL,
    [Planned_qty_till_CurrDay] FLOAT (53)   NULL,
    [Planned_qty_till_PrevDay] FLOAT (53)   NULL,
    [Released_qty_CurrDay]     FLOAT (53)   NULL,
    [CompName]                 VARCHAR (50) NULL
);


GO

