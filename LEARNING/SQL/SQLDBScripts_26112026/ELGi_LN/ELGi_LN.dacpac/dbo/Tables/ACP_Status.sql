CREATE TABLE [dbo].[ACP_Status] (
    [Company]        INT           NULL,
    [TranType]       NVARCHAR (6)  NULL,
    [InvNo]          INT           NULL,
    [suppcode]       NVARCHAR (18) NULL,
    [InvDate]        DATE          NULL,
    [InvAmth]        FLOAT (53)    NULL,
    [DueDate]        DATE          NULL,
    [PaidAmth]       FLOAT (53)    NULL,
    [LatestPaidDate] DATE          NULL,
    [InvBalh]        FLOAT (53)    NULL,
    [PaidStatus]     VARCHAR (11)  NULL,
    [DueStatus]      VARCHAR (9)   NOT NULL
);


GO

