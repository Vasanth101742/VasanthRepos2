CREATE TABLE [dbo].[DTA_tuninglog] (
    [SessionID]  INT            NOT NULL,
    [RowID]      INT            NOT NULL,
    [CategoryID] NVARCHAR (4)   NOT NULL,
    [Event]      NVARCHAR (MAX) NULL,
    [Statement]  NVARCHAR (MAX) NULL,
    [Frequency]  INT            NOT NULL,
    [Reason]     NVARCHAR (MAX) NULL,
    FOREIGN KEY ([SessionID]) REFERENCES [dbo].[DTA_input] ([SessionID]) ON DELETE CASCADE
);


GO

CREATE CLUSTERED INDEX [DTA_tuninglog_index]
    ON [dbo].[DTA_tuninglog]([SessionID] ASC, [RowID] ASC);


GO

