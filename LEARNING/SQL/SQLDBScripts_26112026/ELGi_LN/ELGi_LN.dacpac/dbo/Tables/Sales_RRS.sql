CREATE TABLE [dbo].[Sales_RRS] (
    [Region]             VARCHAR (50)   NULL,
    [ItemCode]           NVARCHAR (47)  NULL,
    [Item_Desc]          NVARCHAR (100) NULL,
    [DFUCode]            VARCHAR (50)   NULL,
    [ItemCategory]       VARCHAR (50)   NULL,
    [FirstSaleDate]      DATE           NULL,
    [LastSaleDate]       DATE           NULL,
    [TotalDeliveryQty]   FLOAT (53)     NULL,
    [MeanDemand]         FLOAT (53)     NULL,
    [StdDemand]          FLOAT (53)     NULL,
    [CV]                 FLOAT (53)     NULL,
    [DemandCount]        FLOAT (53)     NULL,
    [TotalPeriods]       FLOAT (53)     NULL,
    [ADI]                FLOAT (53)     NULL,
    [SeasonalPattern]    VARCHAR (25)   NULL,
    [ABC_Classification] VARCHAR (50)   NULL,
    [RRS_Classification] VARCHAR (50)   NULL,
    [Zscore]             FLOAT (53)     NULL,
    [std_dev_lead_time]  FLOAT (53)     NULL,
    [safety_stock]       FLOAT (53)     NULL,
    [Norms_Strategy]     FLOAT (53)     NULL,
    [total_lead_time]    FLOAT (53)     NULL,
    [lead_time_demand]   FLOAT (53)     NULL,
    [reorder_point]      FLOAT (53)     NULL,
    [eoq]                FLOAT (53)     NULL,
    [max_inv]            FLOAT (53)     NULL,
    [avg_inv]            FLOAT (53)     NULL
);


GO

