CREATE TABLE [dbo].[DTA_output] (
    [SessionID]     INT            NOT NULL,
    [TuningResults] NVARCHAR (MAX) NOT NULL,
    [StopTime]      DATETIME       DEFAULT (getdate()) NOT NULL,
    [FinishStatus]  TINYINT        DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([SessionID] ASC),
    FOREIGN KEY ([SessionID]) REFERENCES [dbo].[DTA_input] ([SessionID]) ON DELETE CASCADE
);


GO

