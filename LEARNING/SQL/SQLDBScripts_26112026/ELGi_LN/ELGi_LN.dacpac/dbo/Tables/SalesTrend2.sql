CREATE TABLE [dbo].[SalesTrend2] (
    [Organ]                      VARCHAR (50) NULL,
    [Vertical]                   VARCHAR (50) NULL,
    [Invoice_Date]               DATETIME     NULL,
    [VerticalOrdr]               INT          NULL,
    [Budget]                     FLOAT (53)   NULL,
    [this_month_sales]           FLOAT (53)   NULL,
    [last_year_this_month_sales] FLOAT (53)   NULL,
    [CalYear]                    INT          NULL,
    [CalMonth]                   INT          NULL,
    [FinYear]                    INT          NULL,
    [FinMonth]                   INT          NULL,
    [CalMonthName]               VARCHAR (50) NULL
);


GO

