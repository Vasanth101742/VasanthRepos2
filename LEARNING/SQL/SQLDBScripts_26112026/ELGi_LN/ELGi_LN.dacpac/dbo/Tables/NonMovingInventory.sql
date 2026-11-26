CREATE TABLE [dbo].[NonMovingInventory] (
    [Company]        INT          NULL,
    [WareHouse]      VARCHAR (20) NULL,
    [ItemCode]       VARCHAR (50) NULL,
    [Item_Desc]      VARCHAR (50) NULL,
    [BuyerCode]      VARCHAR (20) NULL,
    [BuyerName]      VARCHAR (50) NULL,
    [SuppCode]       VARCHAR (20) NULL,
    [SuppName]       VARCHAR (50) NULL,
    [QHND]           FLOAT (53)   NULL,
    [IssueDate_CW]   DATE         NULL,
    [IssueDate_C]    DATE         NULL,
    [ReceiptDate_CW] DATE         NULL,
    [ReceiptDate_C]  DATE         NULL,
    [Amnt]           FLOAT (53)   NULL,
    [IssueAge]       VARCHAR (20) NULL,
    [RecpAge]        VARCHAR (20) NULL
);


GO

