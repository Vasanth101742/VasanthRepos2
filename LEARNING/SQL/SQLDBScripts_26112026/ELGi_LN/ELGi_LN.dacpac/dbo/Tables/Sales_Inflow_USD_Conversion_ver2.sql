CREATE TABLE [dbo].[Sales_Inflow_USD_Conversion_ver2] (
    [OrderDate] DATE         NULL,
    [Currency]  NVARCHAR (6) NULL,
    [BCUR]      NVARCHAR (6) NULL,
    [CCUR]      NVARCHAR (6) NULL,
    [STDT]      DATE         NULL,
    [RATE]      FLOAT (53)   NULL,
    [DaysDiff]  INT          NULL,
    [Rnk]       BIGINT       NULL
);


GO

