CREATE TABLE [dbo].[ACP_Creditors_complete_Advances] (
    [Company]            INT           NULL,
    [Trantype]           NVARCHAR (6)  NULL,
    [InvNo]              INT           NULL,
    [SuppCode]           NVARCHAR (18) NULL,
    [DocDt]              DATE          NULL,
    [InvAmnt]            FLOAT (53)    NULL,
    [PaidAmnt]           FLOAT (53)    NULL,
    [BalanceAmt]         FLOAT (53)    NULL,
    [DateRnk]            BIGINT        NULL,
    [PendingBalance]     FLOAT (53)    NULL,
    [Cumulative_Balance] FLOAT (53)    NULL,
    [TempBalance]        FLOAT (53)    NULL,
    [LastDateFlag]       VARCHAR (10)  NULL,
    [UnlinkedCredits]    FLOAT (53)    NULL,
    [NetAdvance]         FLOAT (53)    NULL
);


GO

