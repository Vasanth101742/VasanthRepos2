CREATE TABLE [dbo].[Consumption] (
    [COMPANY]                NVARCHAR (38) NULL,
    [ItemCode]               NVARCHAR (94) NULL,
    [ItemDescr]              VARCHAR (50)  NULL,
    [BuyrCode]               VARCHAR (20)  NULL,
    [BuyrName]               VARCHAR (50)  NULL,
    [SuppCode]               VARCHAR (20)  NULL,
    [SuppName]               VARCHAR (50)  NULL,
    [Production_Consumption] FLOAT (53)    NULL,
    [Sales_Consumption]      FLOAT (53)    NULL,
    [CalMonth]               INT           NULL,
    [CalYear]                INT           NULL,
    [TRDT]                   DATE          NULL
);


GO

