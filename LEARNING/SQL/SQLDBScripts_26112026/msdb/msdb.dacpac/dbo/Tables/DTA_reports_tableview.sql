CREATE TABLE [dbo].[DTA_reports_tableview] (
    [TableID] INT NOT NULL,
    [ViewID]  INT NOT NULL,
    FOREIGN KEY ([TableID]) REFERENCES [dbo].[DTA_reports_table] ([TableID]) ON DELETE CASCADE,
    FOREIGN KEY ([ViewID]) REFERENCES [dbo].[DTA_reports_table] ([TableID])
);


GO

CREATE CLUSTERED INDEX [DTA_reports_tableview_index]
    ON [dbo].[DTA_reports_tableview]([TableID] ASC);


GO

CREATE NONCLUSTERED INDEX [DTA_reports_tableview_index2]
    ON [dbo].[DTA_reports_tableview]([ViewID] ASC);


GO

