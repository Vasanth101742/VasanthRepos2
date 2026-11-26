CREATE TABLE [dbo].[DTA_reports_database] (
    [DatabaseID]               INT       IDENTITY (1, 1) NOT NULL,
    [SessionID]                INT       NOT NULL,
    [DatabaseName]             [sysname] NOT NULL,
    [IsDatabaseSelectedToTune] INT       NULL,
    PRIMARY KEY CLUSTERED ([DatabaseID] ASC),
    FOREIGN KEY ([SessionID]) REFERENCES [dbo].[DTA_input] ([SessionID]) ON DELETE CASCADE
);


GO

CREATE NONCLUSTERED INDEX [DTA_reports_database_index]
    ON [dbo].[DTA_reports_database]([SessionID] ASC);


GO

