CREATE TABLE [dbo].[Sales_forecast_Master] (
    [Organ]            VARCHAR (5)  NOT NULL,
    [BusinessVertical] VARCHAR (15) NOT NULL,
    [AreaName]         VARCHAR (25) NULL,
    [AreaCode]         VARCHAR (25) NULL,
    [Currency]         VARCHAR (25) NULL,
    [Forecast]         FLOAT (53)   NULL,
    [Calyear]          VARCHAR (10) NULL,
    [Calmonth]         VARCHAR (10) NULL
);


GO

