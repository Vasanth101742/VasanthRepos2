CREATE TABLE [dbo].[BAD_Inventory_Report] (
    [Alpha]           VARCHAR (255)   NULL,
    [Description]     VARCHAR (255)   NULL,
    [Item]            VARCHAR (50)    NULL,
    [Sum_Available]   DECIMAL (18, 2) NULL,
    [Sum_Sales_Price] DECIMAL (18, 2) NULL,
    [Type]            VARCHAR (10)    NULL,
    [Inserted_Date]   DATETIME        DEFAULT (getdate()) NULL
);


GO

