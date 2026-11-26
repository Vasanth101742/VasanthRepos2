CREATE TABLE [dbo].[FOC_Currency_Conversion] (
    [Date1]    DATETIME     NULL,
    [Currency] VARCHAR (25) NULL,
    [BCUR]     NVARCHAR (3) NULL,
    [CCUR]     NVARCHAR (3) NULL,
    [STDT]     DATE         NULL,
    [RATE]     FLOAT (53)   NULL,
    [DaysDiff] INT          NULL,
    [Rnk]      BIGINT       NULL
);


GO

