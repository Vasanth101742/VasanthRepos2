CREATE TABLE [dbo].[acp_creditors_US] (
    [COMPANY]       INT            NOT NULL,
    [TranType]      VARCHAR (3)    NULL,
    [InvNo]         NVARCHAR (10)  NULL,
    [line]          NVARCHAR (10)  NULL,
    [SuppCode]      VARCHAR (10)   NULL,
    [Currency]      VARCHAR (3)    NULL,
    [rate_1]        NVARCHAR (10)  NULL,
    [DocDt]         DATE           NULL,
    [FinMonth]      NVARCHAR (10)  NULL,
    [FinYear]       NVARCHAR (10)  NULL,
    [InvAmnt]       FLOAT (53)     NULL,
    [PaidAmnt]      FLOAT (53)     NULL,
    [BalanceAmt]    FLOAT (53)     NOT NULL,
    [SuppName]      NVARCHAR (254) NULL,
    [ID]            INT            IDENTITY (1, 1) NOT NULL,
    [refnumber]     NVARCHAR (50)  NULL,
    [paymentstatus] NVARCHAR (50)  NULL,
    [payment_date]  NVARCHAR (50)  NULL,
    [DueDate]       DATE           NULL,
    [Ageing]        VARCHAR (50)   NULL,
    [AgeingOrdr]    INT            NULL,
    [DueType]       VARCHAR (50)   NULL,
    [CalYear]       INT            NULL,
    [CalMonth]      INT            NULL,
    [SuppInvNo]     VARCHAR (100)  NULL,
    [ORNO]          NVARCHAR (25)  NULL,
    [REFR]          NVARCHAR (100) NULL
);


GO

