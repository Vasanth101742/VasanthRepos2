CREATE TABLE [dbo].[SessionLock] (
    [SessionID]   VARCHAR (32) NOT NULL,
    [LockVersion] INT          DEFAULT ((0)) NOT NULL
);


GO

CREATE UNIQUE CLUSTERED INDEX [IDX_SessionLock]
    ON [dbo].[SessionLock]([SessionID] ASC);


GO

