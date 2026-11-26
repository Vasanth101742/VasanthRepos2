CREATE TABLE [dbo].[ACP_Creditors] (
    [DocDt]        DATETIME       NULL,
    [COMPANY]      NVARCHAR (38)  NULL,
    [TranType]     NVARCHAR (6)   NULL,
    [InvNo]        NVARCHAR (38)  NULL,
    [SuppCode]     NVARCHAR (18)  NULL,
    [SuppName]     VARCHAR (50)   NULL,
    [SuppAreaCode] VARCHAR (10)   NULL,
    [SuppAreaName] VARCHAR (25)   NULL,
    [DPST]         VARCHAR (10)   NULL,
    [DPSTName]     VARCHAR (50)   NULL,
    [Description]  VARCHAR (50)   NULL,
    [InvAmnt]      NVARCHAR (38)  NULL,
    [PaidAmnt]     NUMERIC (38)   NULL,
    [BalanceAmt]   FLOAT (53)     NULL,
    [DueDate]      DATETIME       NULL,
    [Ageing]       VARCHAR (14)   NULL,
    [AgeingOrdr]   INT            NULL,
    [FinYear]      INT            NULL,
    [FinMonth]     INT            NULL,
    [CalYear]      INT            NULL,
    [CalMonth]     INT            NULL,
    [CurRate]      NVARCHAR (100) NULL,
    [Currency]     NVARCHAR (50)  NULL,
    [InvAmnti]     NUMERIC (18)   NULL,
    [PaidAmnti]    NUMERIC (18)   NULL
);


GO

