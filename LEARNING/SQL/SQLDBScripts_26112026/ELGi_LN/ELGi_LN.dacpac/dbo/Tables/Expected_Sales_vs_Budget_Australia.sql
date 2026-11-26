CREATE TABLE [dbo].[Expected_Sales_vs_Budget_Australia] (
    [Company]                 INT           NULL,
    [ordertype]               NVARCHAR (6)  NULL,
    [OrderNum]                NVARCHAR (18) NULL,
    [Finyear]                 INT           NULL,
    [Finmonth]                INT           NULL,
    [vertical1]               VARCHAR (20)  NULL,
    [CustName]                VARCHAR (100) NULL,
    [CustType]                VARCHAR (20)  NULL,
    [Category]                VARCHAR (20)  NULL,
    [Foreign_currency_amount] FLOAT (53)    NULL,
    [Budget]                  FLOAT (53)    NULL,
    [Calyear]                 INT           NULL,
    [Calmonth]                INT           NULL
);


GO

