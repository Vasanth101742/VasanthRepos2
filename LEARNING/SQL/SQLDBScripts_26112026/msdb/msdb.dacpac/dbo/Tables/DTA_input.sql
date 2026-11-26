CREATE TABLE [dbo].[DTA_input] (
    [SessionName]        [sysname]        NOT NULL,
    [SessionID]          INT              IDENTITY (1, 1) NOT NULL,
    [TuningOptions]      NVARCHAR (MAX)   NOT NULL,
    [CreationTime]       DATETIME         DEFAULT (getdate()) NOT NULL,
    [ScheduledStartTime] DATETIME         DEFAULT (getdate()) NOT NULL,
    [ScheduledJobName]   [sysname]        DEFAULT ('') NOT NULL,
    [InteractiveStatus]  TINYINT          DEFAULT ((0)) NOT NULL,
    [LogTableName]       NVARCHAR (1280)  DEFAULT ('') NOT NULL,
    [GlobalSessionID]    UNIQUEIDENTIFIER DEFAULT (newid()) NULL,
    PRIMARY KEY CLUSTERED ([SessionID] ASC)
);


GO

