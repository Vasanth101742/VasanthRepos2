CREATE TABLE [dbo].[Sales_Inflow_USD_Conversion] (
    [Company]      INT           NULL,
    [OrderDate]    DATE          NULL,
    [ordertype]    NVARCHAR (6)  NULL,
    [OrderNum]     NVARCHAR (18) NULL,
    [PositionNum]  INT           NULL,
    [Trantype]     NVARCHAR (6)  NULL,
    [invnum]       INT           NULL,
    [sales]        FLOAT (53)    NULL,
    [BCUR]         NVARCHAR (6)  NULL,
    [CCUR]         NVARCHAR (6)  NULL,
    [STDT]         DATETIME      NULL,
    [RATE]         FLOAT (53)    NULL,
    [DaysDiff]     INT           NULL,
    [Rnk]          BIGINT        NULL,
    [Sales_in_USD] FLOAT (53)    NULL
);


GO

