CREATE TABLE [dbo].[CreditPayment] (
    [DocNo]         INT             IDENTITY (1, 1) NOT NULL,
    [CmpCode]       NVARCHAR (10)   NOT NULL,
    [OrdNo]         NVARCHAR (15)   NOT NULL,
    [OrdDate]       DATE            NOT NULL,
    [CustCode]      NVARCHAR (15)   NOT NULL,
    [CustNmae]      NVARCHAR (100)  NULL,
    [SaleAmount]    DECIMAL (18, 2) NOT NULL,
    [CreditBlock]   DECIMAL (18, 2) NULL,
    [OrdUpdateDate] DATE            NOT NULL,
    [SystemDate]    DATE            CONSTRAINT [DF_CreditPayment_SystemDate] DEFAULT (getdate()) NOT NULL,
    [AuthId]        NVARCHAR (100)  NULL,
    [AuthRef]       NVARCHAR (100)  NULL,
    [AuthAmount]    DECIMAL (18, 2) NULL,
    [AuthDate]      DATE            NULL,
    [AuthStatus]    NVARCHAR (10)   CONSTRAINT [DF_CreditPayment_AuthStatus] DEFAULT (N'No') NULL,
    [InvNo]         NVARCHAR (30)   NULL,
    [InvDate]       DATE            NULL,
    [InvAmount]     DECIMAL (18, 2) NULL
);


GO

