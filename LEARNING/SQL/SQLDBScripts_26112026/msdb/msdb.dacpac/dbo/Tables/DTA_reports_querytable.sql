CREATE TABLE [dbo].[DTA_reports_querytable] (
    [QueryID]   INT NOT NULL,
    [SessionID] INT NOT NULL,
    [TableID]   INT NOT NULL,
    FOREIGN KEY ([TableID]) REFERENCES [dbo].[DTA_reports_table] ([TableID]),
    CONSTRAINT [DTA_reports_querytable_fk] FOREIGN KEY ([SessionID], [QueryID]) REFERENCES [dbo].[DTA_reports_query] ([SessionID], [QueryID]) ON DELETE CASCADE
);


GO

CREATE CLUSTERED INDEX [DTA_reports_querytable_index]
    ON [dbo].[DTA_reports_querytable]([SessionID] ASC, [QueryID] ASC);


GO

CREATE NONCLUSTERED INDEX [DTA_reports_querytable_index2]
    ON [dbo].[DTA_reports_querytable]([TableID] ASC);


GO

