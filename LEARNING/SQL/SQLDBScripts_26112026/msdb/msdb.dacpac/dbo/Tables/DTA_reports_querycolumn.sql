CREATE TABLE [dbo].[DTA_reports_querycolumn] (
    [QueryID]   INT NOT NULL,
    [SessionID] INT NOT NULL,
    [ColumnID]  INT NOT NULL,
    FOREIGN KEY ([ColumnID]) REFERENCES [dbo].[DTA_reports_column] ([ColumnID]),
    CONSTRAINT [DTA_reports_querycolumn_fk] FOREIGN KEY ([SessionID], [QueryID]) REFERENCES [dbo].[DTA_reports_query] ([SessionID], [QueryID]) ON DELETE CASCADE
);


GO

CREATE CLUSTERED INDEX [DTA_reports_querycolumn_index]
    ON [dbo].[DTA_reports_querycolumn]([SessionID] ASC, [QueryID] ASC);


GO

CREATE NONCLUSTERED INDEX [DTA_reports_querycolumn_index2]
    ON [dbo].[DTA_reports_querycolumn]([ColumnID] ASC);


GO

