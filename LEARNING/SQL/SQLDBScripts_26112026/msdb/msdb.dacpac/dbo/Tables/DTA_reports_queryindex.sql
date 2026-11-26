CREATE TABLE [dbo].[DTA_reports_queryindex] (
    [QueryID]                    INT NOT NULL,
    [SessionID]                  INT NOT NULL,
    [IndexID]                    INT NOT NULL,
    [IsRecommendedConfiguration] BIT NOT NULL,
    FOREIGN KEY ([IndexID]) REFERENCES [dbo].[DTA_reports_index] ([IndexID]),
    CONSTRAINT [DTA_reports_queryindex_fk] FOREIGN KEY ([SessionID], [QueryID]) REFERENCES [dbo].[DTA_reports_query] ([SessionID], [QueryID]) ON DELETE CASCADE
);


GO

CREATE NONCLUSTERED INDEX [DTA_reports_queryindex_index2]
    ON [dbo].[DTA_reports_queryindex]([IndexID] ASC);


GO

CREATE CLUSTERED INDEX [DTA_reports_queryindex_index]
    ON [dbo].[DTA_reports_queryindex]([SessionID] ASC, [QueryID] ASC);


GO

