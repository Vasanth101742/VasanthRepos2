CREATE TABLE [dbo].[Engineerwise_Sales_details] (
    [company]          INT            NULL,
    [trantype]         NVARCHAR (3)   NULL,
    [Invoice]          INT            NULL,
    [EntryDate]        DATETIME       NULL,
    [SalesRepCode]     NVARCHAR (18)  NULL,
    [SalesRep]         NVARCHAR (70)  NULL,
    [dpst]             NVARCHAR (6)   NULL,
    [dpstname]         VARCHAR (100)  NULL,
    [areacode]         VARCHAR (50)   NULL,
    [areaname]         VARCHAR (200)  NULL,
    [Zone]             VARCHAR (100)  NULL,
    [custcode]         NVARCHAR (9)   NULL,
    [custname]         NVARCHAR (100) NULL,
    [Sales_amount]     FLOAT (53)     NULL,
    [Fin_year]         INT            NULL,
    [Fin_month]        INT            NULL,
    [Monthname]        NVARCHAR (30)  NULL,
    [SalesBudValue]    FLOAT (53)     NULL,
    [cal_Year]         INT            NULL,
    [cal_Month]        INT            NULL,
    [CRM_AssemblyLine] NVARCHAR (255) NULL
);


GO

