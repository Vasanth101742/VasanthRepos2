CREATE TABLE [dbo].[PendingPOTracker_Master] (
    [Region]      NVARCHAR (250) NULL,
    [Item]        NVARCHAR (250) NULL,
    [ItemDesc]    NVARCHAR (250) NULL,
    [DFUCode]     NVARCHAR (250) NULL,
    [IndiaTPL]    NVARCHAR (250) NULL,
    [ProductLine] NVARCHAR (250) NULL,
    [Region2]     NVARCHAR (250) NULL,
    [SLA]         FLOAT (53)     NULL,
    [DayMax]      FLOAT (53)     NULL,
    [MonthMax]    FLOAT (53)     NULL,
    [Department]  NVARCHAR (250) NULL,
    [UpdatedDate] DATETIME       NULL
);


GO

