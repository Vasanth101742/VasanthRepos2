CREATE TABLE [dbo].[bin_effective_check_Sales] (
    [itemcode]                     NVARCHAR (150) NULL,
    [FirstSaleDate]                DATE           NULL,
    [LastSaleDate]                 DATE           NULL,
    [SalesQty]                     FLOAT (53)     NULL,
    [SalesValue]                   FLOAT (53)     NULL,
    [TotalPeriods]                 INT            NULL,
    [SalesMonthsConsidered]        INT            NULL,
    [MeanDemand]                   FLOAT (53)     NULL,
    [SalesMonthsConsideredMeanQty] FLOAT (53)     NULL,
    [(x-xbar)sq]                   FLOAT (53)     NULL,
    [StdDemand]                    FLOAT (53)     NULL,
    [CV]                           FLOAT (53)     NULL,
    [DemandCount]                  FLOAT (53)     NULL,
    [ADI]                          FLOAT (53)     NULL,
    [SeasonalityScore]             FLOAT (53)     NULL,
    [RRS]                          NVARCHAR (50)  NULL,
    [Avg_24M]                      FLOAT (53)     NULL
);


GO

