CREATE TABLE [dbo].[Sales_Trend_Australia] (
    [orderdate]      DATE          NULL,
    [Finyear]        INT           NULL,
    [Finmonth]       INT           NULL,
    [wk2]            INT           NULL,
    [dw2]            INT           NULL,
    [weekdayname]    NVARCHAR (30) NULL,
    [Category]       VARCHAR (11)  NULL,
    [CustType]       VARCHAR (25)  NULL,
    [vertical1]      VARCHAR (25)  NULL,
    [weekly_Inflow]  FLOAT (53)    NULL,
    [FiveWeek_MA]    FLOAT (53)    NULL,
    [ThreeMonths_MA] FLOAT (53)    NULL,
    [Budget]         FLOAT (53)    NULL
);


GO

