CREATE TABLE [dbo].[ACR_Debtors_Stage] (
    [Company]      INT            NULL,
    [Trantyp]      NVARCHAR (6)   NULL,
    [InvNo]        INT            NULL,
    [Line]         INT            NULL,
    [CustNo]       NVARCHAR (18)  NULL,
    [CustName]     NVARCHAR (50)  NULL,
    [FinCustGrp]   NVARCHAR (10)  NULL,
    [VerticalOrdr] INT            NULL,
    [Vertical1]    NVARCHAR (100) NULL,
    [Vertical]     NVARCHAR (100) NULL,
    [DPST]         INT            NULL,
    [DpstName]     NVARCHAR (100) NULL,
    [AreaCode]     INT            NULL,
    [AreaName]     NVARCHAR (20)  NULL,
    [InvDate]      DATETIME       NULL,
    [DueDate]      DATETIME       NULL,
    [Currency]     NVARCHAR (6)   NULL,
    [CurRate]      FLOAT (53)     NULL,
    [InvAmt]       FLOAT (53)     NULL,
    [PaidAmt]      FLOAT (53)     NULL,
    [BalanceAmt]   FLOAT (53)     NULL,
    [InvAmti]      FLOAT (53)     NULL,
    [PaidAmti]     FLOAT (53)     NULL,
    [BalanceAmti]  FLOAT (53)     NULL,
    [Ageing]       VARCHAR (14)   NULL,
    [AgeingOrdr]   INT            NULL,
    [FinYear]      INT            NULL,
    [FinMonth]     INT            NULL,
    [CalYear]      INT            NULL,
    [CalMonth]     INT            NULL
);


GO

