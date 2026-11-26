CREATE TABLE [dbo].[BOM_Sales_Details] (
    [Region]        VARCHAR (6)     NULL,
    [compnr]        BIGINT          NULL,
    [FinYear]       VARCHAR (25)    NULL,
    [FinMonth]      VARCHAR (25)    NULL,
    [InvDate]       DATE            NULL,
    [ItemCode]      NVARCHAR (4000) NULL,
    [ItemDesc]      NVARCHAR (60)   NULL,
    [sitm]          NVARCHAR (47)   NULL,
    [SalesItemCode] NVARCHAR (4000) NULL,
    [SalesItemDesc] NVARCHAR (60)   NULL,
    [SalesQty]      DECIMAL (38, 6) NULL,
    [SalesAmnt]     FLOAT (53)      NULL,
    [UnitPrice]     FLOAT (53)      NULL,
    [ccur]          NVARCHAR (10)   NULL,
    [amth_1]        FLOAT (53)      NULL
);


GO

