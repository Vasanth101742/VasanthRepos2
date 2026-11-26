CREATE TABLE [dbo].[Salesorder_with_Fabno] (
    [Company]     INT           NULL,
    [WareHouse]   NVARCHAR (12) NULL,
    [ItemCode]    NVARCHAR (94) NULL,
    [OrderDate]   DATE          NULL,
    [ordertype]   NVARCHAR (6)  NULL,
    [OrderNum]    NVARCHAR (18) NULL,
    [PositionNum] INT           NULL,
    [CustCode]    NVARCHAR (18) NULL,
    [CustName]    VARCHAR (100) NULL,
    [PDNO]        NVARCHAR (18) NULL,
    [CWAR]        NVARCHAR (12) NULL,
    [ITEM]        NVARCHAR (94) NULL,
    [IDAT]        DATETIME      NULL,
    [SERL]        NVARCHAR (60) NULL
);


GO

