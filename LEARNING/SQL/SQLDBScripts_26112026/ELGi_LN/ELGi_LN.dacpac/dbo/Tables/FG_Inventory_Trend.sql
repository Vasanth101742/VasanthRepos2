CREATE TABLE [dbo].[FG_Inventory_Trend] (
    [EntryDate]      DATE          NULL,
    [Company]        INT           NOT NULL,
    [CWAR]           NVARCHAR (12) NULL,
    [WH_desc]        VARCHAR (50)  NULL,
    [QSKT]           FLOAT (53)    NULL,
    [Amnt]           FLOAT (53)    NULL,
    [PredictionType] VARCHAR (25)  NULL
);


GO

