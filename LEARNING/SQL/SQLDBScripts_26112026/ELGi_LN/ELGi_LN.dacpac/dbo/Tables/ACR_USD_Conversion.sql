CREATE TABLE [dbo].[ACR_USD_Conversion] (
    [InvDate]  DATE         NULL,
    [Currency] NVARCHAR (6) NULL,
    [BCUR]     NVARCHAR (3) NULL,
    [CCUR]     NVARCHAR (3) NULL,
    [STDT]     DATE         NULL,
    [RATE]     FLOAT (53)   NULL,
    [DaysDiff] INT          NULL,
    [Rnk]      BIGINT       NULL
);


GO

