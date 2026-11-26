CREATE TABLE [dbo].[ACR_Status] (
    [Company]        INT          NULL,
    [TranType]       NVARCHAR (6) NULL,
    [InvNo]          INT          NULL,
    [InvDate]        DATE         NULL,
    [InvAmth]        FLOAT (53)   NULL,
    [DueDate]        DATE         NULL,
    [DueAmth]        FLOAT (53)   NULL,
    [RecvAmth]       FLOAT (53)   NULL,
    [LatestPaidDate] DATE         NULL,
    [InvBalh]        FLOAT (53)   NULL,
    [DueBalh]        FLOAT (53)   NULL,
    [ReceivedStatus] VARCHAR (50) NULL,
    [DueStatus]      VARCHAR (9)  NOT NULL
);


GO

