CREATE TABLE [dbo].[DTA_reports_querydatabase] (
    [QueryID]    INT NOT NULL,
    [SessionID]  INT NOT NULL,
    [DatabaseID] INT NOT NULL,
    FOREIGN KEY ([DatabaseID]) REFERENCES [dbo].[DTA_reports_database] ([DatabaseID]),
    CONSTRAINT [DTA_reports_querydatabase_fk] FOREIGN KEY ([SessionID], [QueryID]) REFERENCES [dbo].[DTA_reports_query] ([SessionID], [QueryID]) ON DELETE CASCADE
);


GO

CREATE CLUSTERED INDEX [DTA_reports_querydatabase_index]
    ON [dbo].[DTA_reports_querydatabase]([SessionID] ASC, [QueryID] ASC);


GO

CREATE NONCLUSTERED INDEX [DTA_reports_querydatabase_index2]
    ON [dbo].[DTA_reports_querydatabase]([DatabaseID] ASC);


GO

