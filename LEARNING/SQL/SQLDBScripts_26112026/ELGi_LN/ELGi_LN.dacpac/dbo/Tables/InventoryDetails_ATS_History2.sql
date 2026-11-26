CREATE TABLE [dbo].[InventoryDetails_ATS_History2] (
    [InvType]          VARCHAR (50) NULL,
    [Vertical]         VARCHAR (50) NULL,
    [Productgroup]     VARCHAR (50) NULL,
    [QSKT]             FLOAT (53)   NULL,
    [Amnt4]            FLOAT (53)   NULL,
    [Sales_Amount]     FLOAT (53)   NULL,
    [CalYear]          INT          NULL,
    [CalMonth]         INT          NULL,
    [EntryDate]        DATETIME     NULL,
    [InvTypeOrdr]      INT          NULL,
    [VerticalOrdr]     INT          NULL,
    [ProductGroupOrdr] INT          NULL
);


GO

