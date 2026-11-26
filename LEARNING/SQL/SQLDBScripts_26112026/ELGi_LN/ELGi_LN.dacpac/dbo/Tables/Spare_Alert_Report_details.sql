CREATE TABLE [dbo].[Spare_Alert_Report_details] (
    [company]       INT            NULL,
    [WareHouse]     VARCHAR (25)   NULL,
    [ItemCode]      NVARCHAR (94)  NULL,
    [Item_desc]     NVARCHAR (100) NULL,
    [EntryDate]     DATE           NULL,
    [ordertype]     NVARCHAR (6)   NULL,
    [Category]      VARCHAR (25)   NULL,
    [OrderCategory] VARCHAR (25)   NULL,
    [OrderNum]      NVARCHAR (18)  NULL,
    [PositionNum]   INT            NULL,
    [ord_qty]       FLOAT (53)     NULL,
    [DelQty]        FLOAT (53)     NULL,
    [pendQty]       FLOAT (53)     NULL,
    [InvType]       VARCHAR (25)   NULL,
    [StockQty]      FLOAT (53)     NULL,
    [Description]   VARCHAR (25)   NULL,
    [Prodorderno]   VARCHAR (25)   NULL,
    [wip_qty]       FLOAT (53)     NULL,
    [Planned_qty]   FLOAT (53)     NULL,
    [Group1]        VARCHAR (25)   NULL,
    [Group1_order]  INT            NULL,
    [Group2]        VARCHAR (25)   NULL,
    [Group2_order]  INT            NULL,
    [Qty]           FLOAT (53)     NULL,
    [Ageing]        VARCHAR (50)   NULL
);


GO

