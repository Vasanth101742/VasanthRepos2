CREATE TABLE [dbo].[Sales_Stastics] (
    [organ]              VARCHAR (50)  NULL,
    [item]               NVARCHAR (47) NULL,
    [item_desc]          NVARCHAR (30) NULL,
    [FirstSaleDate]      DATETIME      NULL,
    [LastSaleDate]       DATETIME      NULL,
    [mean_demand]        FLOAT (53)    NULL,
    [std_demand]         FLOAT (53)    NULL,
    [cv]                 FLOAT (53)    NULL,
    [demand_count]       FLOAT (53)    NULL,
    [total_periods]      FLOAT (53)    NULL,
    [adi]                FLOAT (53)    NULL,
    [Category]           VARCHAR (50)  NULL,
    [seasonality_score]  FLOAT (53)    NULL,
    [final_category]     VARCHAR (50)  NULL,
    [ABC_classification] VARCHAR (50)  NULL,
    [Mean]               FLOAT (53)    NULL,
    [SD]                 FLOAT (53)    NULL,
    [DeliveryQty]        FLOAT (53)    NULL,
    [SalesMonthsCount]   FLOAT (53)    NULL,
    [MonthsConsidered]   FLOAT (53)    NULL
);


GO

