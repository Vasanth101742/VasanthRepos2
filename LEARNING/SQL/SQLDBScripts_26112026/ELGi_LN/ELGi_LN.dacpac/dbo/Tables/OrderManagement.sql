CREATE TABLE [dbo].[OrderManagement] (
    [Region]         NVARCHAR (100)  NULL,
    [OrderNum]       NVARCHAR (100)  NULL,
    [OrderDate]      DATETIME        NULL,
    [PositionNum]    INT             NULL,
    [ItemCode]       NVARCHAR (250)  NULL,
    [Item_desc]      NVARCHAR (2550) NULL,
    [WareHouse]      NVARCHAR (100)  NULL,
    [OrderQty]       FLOAT (53)      NULL,
    [PendQty]        FLOAT (53)      NULL,
    [Indent]         NVARCHAR (200)  NULL,
    [DFU]            NVARCHAR (250)  NULL,
    [ItemCategory]   NVARCHAR (100)  NULL,
    [Model]          NVARCHAR (100)  NULL,
    [ProdOrderNo]    NVARCHAR (250)  NULL,
    [Status]         NVARCHAR (100)  NULL,
    [FG]             INT             NULL,
    [WIP]            INT             NULL,
    [YTP]            INT             NULL,
    [DateOfShipment] DATE            NULL,
    [NoOfProd]       INT             NULL,
    [ProductGroup]   NVARCHAR (250)  NULL,
    [SLA]            INT             NULL,
    [ReqDate]        DATETIME        NULL,
    [NewPendQty]     FLOAT (53)      NULL,
    [FabNo]          NVARCHAR (100)  NULL,
    [inFG]           NVARCHAR (10)   NULL
);


GO

