CREATE TABLE [dbo].[DTA_tuningresults] (
    [SessionID]      INT      NOT NULL,
    [StopTime]       DATETIME DEFAULT (getdate()) NOT NULL,
    [FinishStatus]   TINYINT  DEFAULT ((0)) NOT NULL,
    [LastPartNumber] INT      NULL,
    PRIMARY KEY CLUSTERED ([SessionID] ASC),
    FOREIGN KEY ([SessionID]) REFERENCES [dbo].[DTA_input] ([SessionID]) ON DELETE CASCADE
);


GO

