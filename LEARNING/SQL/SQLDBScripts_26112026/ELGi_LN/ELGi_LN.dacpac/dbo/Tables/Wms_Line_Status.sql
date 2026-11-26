CREATE TABLE [dbo].[Wms_Line_Status] (
    [T$SHPM]             NVARCHAR (18) NULL,
    [Item]               NVARCHAR (94) NULL,
    [Plan_Qty]           FLOAT (53)    NULL,
    [Shp_Qty]            FLOAT (53)    NULL,
    [T$ORNO]             NVARCHAR (18) NULL,
    [T$PONO]             NVARCHAR (38) NULL,
    [T$PLST]             FLOAT (53)    NULL,
    [T$OORG]             FLOAT (53)    NULL,
    [WMS_Shipment]       NVARCHAR (20) NULL,
    [WMS_ItemCode]       NVARCHAR (50) NULL,
    [ORIGINALQTY]        FLOAT (53)    NULL,
    [SHIPPEDQTY]         FLOAT (53)    NULL,
    [SALESORDERDOCUMENT] NVARCHAR (64) NULL,
    [SALESORDERLINE]     NVARCHAR (20) NULL,
    [Wms_Line_Status]    FLOAT (53)    NULL,
    [orderkey]           NVARCHAR (10) NULL,
    [ACTUALSHIPDATE]     DATE          NULL,
    [Wms_Header_Status]  NVARCHAR (10) NULL
);


GO

