CREATE TABLE [dbo].[DTA_reports_query] (
    [QueryID]         INT            NOT NULL,
    [SessionID]       INT            NOT NULL,
    [StatementType]   SMALLINT       NOT NULL,
    [StatementString] NVARCHAR (MAX) NOT NULL,
    [CurrentCost]     FLOAT (53)     NOT NULL,
    [RecommendedCost] FLOAT (53)     NOT NULL,
    [Weight]          FLOAT (53)     NOT NULL,
    [EventString]     NVARCHAR (MAX) NULL,
    [EventWeight]     FLOAT (53)     NOT NULL,
    CONSTRAINT [DTA_reports_query_pk] PRIMARY KEY CLUSTERED ([SessionID] ASC, [QueryID] ASC),
    FOREIGN KEY ([SessionID]) REFERENCES [dbo].[DTA_input] ([SessionID]) ON DELETE CASCADE
);


GO

