CREATE TABLE [dbo].[GR_Overdue_trend] (
    [CurrentDate] DATE            NULL,
    [Department]  NVARCHAR (30)   NULL,
    [OrderStatus] NVARCHAR (30)   NULL,
    [amount]      DECIMAL (19, 2) NULL,
    [LineCount]   INT             NULL,
    [MonthYear]   NVARCHAR (20)   NULL,
    [DPST]        NVARCHAR (15)   NULL
);


GO

