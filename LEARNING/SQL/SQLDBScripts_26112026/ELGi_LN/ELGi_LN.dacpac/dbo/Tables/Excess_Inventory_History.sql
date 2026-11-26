CREATE TABLE [dbo].[Excess_Inventory_History] (
    [EntryDate]   DATE          NULL,
    [BUYRCODE]    NVARCHAR (18) NULL,
    [BuyerName]   NVARCHAR (50) NULL,
    [LeanType]    VARCHAR (20)  NULL,
    [ExcessQty]   FLOAT (53)    NULL,
    [ExcessValue] FLOAT (53)    NULL
);


GO

