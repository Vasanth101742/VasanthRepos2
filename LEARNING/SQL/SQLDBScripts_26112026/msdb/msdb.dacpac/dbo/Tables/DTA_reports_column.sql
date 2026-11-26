CREATE TABLE [dbo].[DTA_reports_column] (
    [ColumnID]   INT       IDENTITY (1, 1) NOT NULL,
    [TableID]    INT       NOT NULL,
    [ColumnName] [sysname] NOT NULL,
    PRIMARY KEY CLUSTERED ([ColumnID] ASC),
    FOREIGN KEY ([TableID]) REFERENCES [dbo].[DTA_reports_table] ([TableID]) ON DELETE CASCADE
);


GO

CREATE NONCLUSTERED INDEX [DTA_reports_column_index]
    ON [dbo].[DTA_reports_column]([TableID] ASC);


GO

