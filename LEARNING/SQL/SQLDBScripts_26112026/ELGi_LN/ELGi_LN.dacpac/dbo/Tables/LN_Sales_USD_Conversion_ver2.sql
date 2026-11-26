CREATE TABLE [dbo].[LN_Sales_USD_Conversion_ver2] (
    [Invoice_Date] DATETIME     NULL,
    [Currency]     NVARCHAR (3) NULL,
    [BCUR]         NVARCHAR (6) NULL,
    [CCUR]         NVARCHAR (6) NULL,
    [STDT]         DATE         NULL,
    [RATE]         FLOAT (53)   NULL,
    [DaysDiff]     INT          NULL,
    [Rnk]          BIGINT       NULL
);


GO

