CREATE TABLE [dbo].[DTA_reports_indexcolumn] (
    [IndexID]              INT NOT NULL,
    [ColumnID]             INT NOT NULL,
    [ColumnOrder]          INT NULL,
    [PartitionColumnOrder] INT DEFAULT ((0)) NOT NULL,
    [IsKeyColumn]          BIT DEFAULT ((1)) NOT NULL,
    [IsDescendingColumn]   BIT DEFAULT ((1)) NOT NULL,
    FOREIGN KEY ([IndexID]) REFERENCES [dbo].[DTA_reports_index] ([IndexID]) ON DELETE CASCADE
);


GO

CREATE CLUSTERED INDEX [DTA_reports_indexcolumn_index]
    ON [dbo].[DTA_reports_indexcolumn]([IndexID] ASC);


GO

CREATE NONCLUSTERED INDEX [DTA_reports_indexcolumn_index2]
    ON [dbo].[DTA_reports_indexcolumn]([ColumnID] ASC);


GO

