CREATE TABLE [dbo].[ATS_TrialSales] (
    [Company]       INT            NULL,
    [Trantyp]       NVARCHAR (6)   NULL,
    [Trantype_desc] VARCHAR (30)   NULL,
    [SaleOrderType] NVARCHAR (6)   NULL,
    [OrderNo]       NVARCHAR (9)   NULL,
    [InvNo]         INT            NULL,
    [CustNo]        NVARCHAR (18)  NULL,
    [CustName]      NVARCHAR (50)  NULL,
    [DPST]          INT            NULL,
    [DpstName]      NVARCHAR (100) NULL,
    [InvDate]       DATE           NULL,
    [InvAmt]        FLOAT (53)     NULL,
    [PaidAmt]       FLOAT (53)     NULL,
    [BalanceAmt]    FLOAT (53)     NULL,
    [DueDate]       DATE           NULL,
    [AreaCode]      VARCHAR (10)   NULL,
    [AreaName]      VARCHAR (50)   NULL,
    [Item]          NVARCHAR (47)  NULL,
    [Item_desc]     NVARCHAR (30)  NULL,
    [DeliveryQty]   FLOAT (53)     NULL,
    [DelayDays]     INT            NULL,
    [LN_Company]    INT            NULL
);


GO

