CREATE TABLE [dbo].[pending_stock_Ameropa] (
    [Company]          INT           NULL,
    [Dpst]             NVARCHAR (12) NULL,
    [ordertype]        NVARCHAR (6)  NULL,
    [OrderNum]         NVARCHAR (18) NULL,
    [OrderDate]        DATE          NULL,
    [PositionNum]      INT           NULL,
    [CustCode]         NVARCHAR (18) NULL,
    [Custname]         NVARCHAR (70) NULL,
    [ItemCode]         NVARCHAR (94) NULL,
    [DeliveryDate]     DATETIME      NULL,
    [Item_desc]        NVARCHAR (60) NULL,
    [WareHouse]        NVARCHAR (12) NULL,
    [Price]            FLOAT (53)    NULL,
    [qty]              FLOAT (53)    NULL,
    [Indent]           NVARCHAR (60) NULL,
    [Buyer]            VARCHAR (1)   NOT NULL,
    [DiscPerc1]        FLOAT (53)    NULL,
    [Value]            FLOAT (53)    NULL,
    [diffdays]         INT           NULL,
    [STOCK_440_act]    INT           NOT NULL,
    [STOCK_440_onhand] INT           NOT NULL,
    [STOCK_401_act]    INT           NOT NULL,
    [STOCK_401_onhand] INT           NOT NULL,
    [STOCK_416_act]    INT           NOT NULL,
    [STOCK_416_onhand] INT           NOT NULL,
    [STOCK_450_act]    INT           NOT NULL,
    [STOCK_450_onhand] INT           NOT NULL,
    [STOCK_490_act]    INT           NOT NULL,
    [STOCK_490_onhand] INT           NOT NULL,
    [STOCK_DEL_act]    INT           NOT NULL,
    [STOCK_DEL_onhand] INT           NOT NULL,
    [STOCK_CAL_act]    INT           NOT NULL,
    [STOCK_CAL_onhand] INT           NOT NULL
);


GO

