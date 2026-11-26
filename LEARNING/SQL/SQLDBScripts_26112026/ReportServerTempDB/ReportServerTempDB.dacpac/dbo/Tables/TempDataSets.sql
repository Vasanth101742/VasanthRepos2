CREATE TABLE [dbo].[TempDataSets] (
    [ID]     UNIQUEIDENTIFIER NOT NULL,
    [ItemID] UNIQUEIDENTIFIER NOT NULL,
    [LinkID] UNIQUEIDENTIFIER NULL,
    [Name]   NVARCHAR (260)   NOT NULL,
    CONSTRAINT [PK_TempDataSet] PRIMARY KEY NONCLUSTERED ([ID] ASC),
    CONSTRAINT [FK_DataSetItemID] FOREIGN KEY ([ItemID]) REFERENCES [dbo].[TempCatalog] ([TempCatalogID])
);


GO

CREATE NONCLUSTERED INDEX [IX_DataSetLinkID]
    ON [dbo].[TempDataSets]([LinkID] ASC);


GO

CREATE CLUSTERED INDEX [IX_TempDataSet_ItemID_Name]
    ON [dbo].[TempDataSets]([ItemID] ASC, [Name] ASC);


GO

