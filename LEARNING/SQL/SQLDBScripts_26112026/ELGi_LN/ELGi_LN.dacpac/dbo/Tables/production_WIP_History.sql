CREATE TABLE [dbo].[production_WIP_History] (
    [company]   NVARCHAR (38) NULL,
    [PDNO]      VARCHAR (25)  NULL,
    [ITEM]      NVARCHAR (94) NULL,
    [ItemDescr] VARCHAR (100) NULL,
    [Qty]       FLOAT (53)    NULL,
    [Value]     FLOAT (53)    NULL,
    [EntryDate] DATE          NULL
);


GO

