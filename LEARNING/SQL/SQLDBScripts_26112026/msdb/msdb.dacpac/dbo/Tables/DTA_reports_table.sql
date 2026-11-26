CREATE TABLE [dbo].[DTA_reports_table] (
    [TableID]    INT       IDENTITY (1, 1) NOT NULL,
    [DatabaseID] INT       NOT NULL,
    [SchemaName] [sysname] NOT NULL,
    [TableName]  [sysname] NOT NULL,
    [IsView]     BIT       DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([TableID] ASC),
    FOREIGN KEY ([DatabaseID]) REFERENCES [dbo].[DTA_reports_database] ([DatabaseID]) ON DELETE CASCADE
);


GO

CREATE NONCLUSTERED INDEX [DTA_reports_table_index]
    ON [dbo].[DTA_reports_table]([DatabaseID] ASC);


GO

