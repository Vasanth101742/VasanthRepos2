CREATE TABLE [dbo].[WMS_PackStatus_Orderline] (
    [SALESORDERDOCUMENT] NVARCHAR (64) NULL,
    [SALESORDERLINE]     NVARCHAR (20) NULL,
    [SKU]                NVARCHAR (50) NULL,
    [SHIPPEDQTY]         FLOAT (53)    NULL,
    [Hpkcompldate]       DATETIME      NULL
);


GO

