CREATE TABLE [dbo].[ACR_Cube] (
    [Company]       INT            NULL,
    [CustCode]      NVARCHAR (18)  NULL,
    [CustName]      NVARCHAR (100) NULL,
    [InvDate]       DATE           NULL,
    [TranType]      NVARCHAR (6)   NULL,
    [InvNo]         INT            NULL,
    [InvLine]       INT            NULL,
    [InvSchedule]   INT            NULL,
    [InitialDocTyp] NVARCHAR (6)   NULL,
    [InitialDocNo]  INT            NULL,
    [Currency]      NVARCHAR (6)   NULL,
    [CurRate]       FLOAT (53)     NULL,
    [InvAmti]       FLOAT (53)     NULL,
    [InvAmth]       FLOAT (53)     NULL,
    [RecvDate]      DATE           NULL,
    [Recvline]      INT            NULL,
    [RecvSchedule]  INT            NULL,
    [RecvDocType]   NVARCHAR (6)   NULL,
    [RecvDocNo]     INT            NULL,
    [RecvAmti]      FLOAT (53)     NULL,
    [RecvAmth]      FLOAT (53)     NULL,
    [InvBali]       FLOAT (53)     NULL,
    [InvBalh]       FLOAT (53)     NULL,
    [Period]        VARCHAR (10)   NULL,
    [EntryDate]     DATE           NULL,
    [CalYear]       INT            NULL,
    [CalMonth]      INT            NULL,
    [Month_Name]    VARCHAR (20)   NULL,
    [FinYear]       INT            NULL,
    [FinMonth]      INT            NULL,
    [FiscalYear]    VARCHAR (10)   NULL,
    [DueDate]       DATE           NULL
);


GO

