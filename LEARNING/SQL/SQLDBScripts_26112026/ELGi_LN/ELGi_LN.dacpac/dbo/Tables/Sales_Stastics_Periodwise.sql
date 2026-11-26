CREATE TABLE [dbo].[Sales_Stastics_Periodwise] (
    [organ]              VARCHAR (50)  NULL,
    [fin_year]           INT           NULL,
    [fin_month]          INT           NULL,
    [item]               NVARCHAR (47) NULL,
    [item_desc]          NVARCHAR (30) NULL,
    [Total_DeliveryQty]  FLOAT (53)    NULL,
    [Total_Sales_amount] FLOAT (53)    NULL,
    [MeanQty]            FLOAT (53)    NULL,
    [SDQty]              FLOAT (53)    NULL,
    [CV]                 FLOAT (53)    NULL,
    [ActiveMonths]       FLOAT (53)    NULL,
    [ConsideredMonths]   FLOAT (53)    NULL,
    [ADI]                FLOAT (53)    NULL
);


GO

