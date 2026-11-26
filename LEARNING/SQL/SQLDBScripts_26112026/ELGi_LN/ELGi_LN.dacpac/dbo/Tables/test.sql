CREATE TABLE [dbo].[test] (
    [SlsPriceLst] NVARCHAR (6)  NULL,
    [DiscPerc1]   REAL          NULL,
    [DiscPerc2]   REAL          NULL,
    [DiscPerc3]   REAL          NULL,
    [Company]     INT           NULL,
    [OrderDate]   DATE          NULL,
    [OrderNum]    NVARCHAR (18) NULL,
    [PositionNum] INT           NULL,
    [ordertype]   NVARCHAR (6)  NULL,
    [dpst]        NVARCHAR (12) NULL,
    [dpstname]    VARCHAR (100) NULL,
    [CustCode]    NVARCHAR (18) NULL,
    [custname1]   NVARCHAR (70) NULL,
    [item]        NVARCHAR (94) NULL,
    [Item_desc]   VARCHAR (51)  NOT NULL,
    [qty]         FLOAT (53)    NULL,
    [Price]       FLOAT (53)    NULL,
    [inflow]      FLOAT (53)    NULL
);


GO

