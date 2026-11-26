CREATE TABLE [dbo].[ACR_Debtors_complete_Advances] (
    [Company]            INT           NULL,
    [Trantyp]            NVARCHAR (6)  NULL,
    [InvNo]              INT           NULL,
    [CustNo]             NVARCHAR (18) NULL,
    [InvDate]            DATE          NULL,
    [InvAmt]             FLOAT (53)    NULL,
    [paidamt]            FLOAT (53)    NULL,
    [balanceAmt]         FLOAT (53)    NULL,
    [DateRnk]            BIGINT        NULL,
    [PendingBalance]     FLOAT (53)    NULL,
    [Cumulative_Balance] FLOAT (53)    NULL,
    [TempBalance]        FLOAT (53)    NULL,
    [LastDateFlag]       VARCHAR (10)  NULL,
    [UnlinkedCredits]    FLOAT (53)    NULL,
    [NetAdvance]         FLOAT (53)    NULL
);


GO

