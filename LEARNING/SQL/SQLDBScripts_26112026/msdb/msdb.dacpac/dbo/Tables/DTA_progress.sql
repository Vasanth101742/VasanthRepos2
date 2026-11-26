CREATE TABLE [dbo].[DTA_progress] (
    [ProgressEventID]           INT            IDENTITY (1, 1) NOT NULL,
    [SessionID]                 INT            NULL,
    [TuningStage]               TINYINT        DEFAULT ((0)) NOT NULL,
    [WorkloadConsumption]       TINYINT        NOT NULL,
    [EstImprovement]            INT            DEFAULT ((0)) NOT NULL,
    [ProgressEventTime]         DATETIME       DEFAULT (getdate()) NOT NULL,
    [ConsumingWorkLoadMessage]  NVARCHAR (256) NULL,
    [PerformingAnalysisMessage] NVARCHAR (256) NULL,
    [GeneratingReportsMessage]  NVARCHAR (256) NULL,
    CHECK ([WorkloadConsumption]>=(0) AND [WorkloadConsumption]<=(100)),
    FOREIGN KEY ([SessionID]) REFERENCES [dbo].[DTA_input] ([SessionID]) ON DELETE CASCADE
);


GO

CREATE CLUSTERED INDEX [DTA_progress_index]
    ON [dbo].[DTA_progress]([SessionID] ASC);


GO

