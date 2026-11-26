CREATE TABLE [dbo].[DTA_tuningresults_part] (
    [SessionID]  INT             NOT NULL,
    [PartNumber] INT             NOT NULL,
    [Content]    NVARCHAR (3500) NOT NULL,
    PRIMARY KEY CLUSTERED ([SessionID] ASC, [PartNumber] ASC),
    FOREIGN KEY ([SessionID]) REFERENCES [dbo].[DTA_input] ([SessionID]) ON DELETE CASCADE
);


GO

