CREATE TABLE [dbo].[Budget_Sales_CUBE] (
    [Global]      VARCHAR (20)   NULL,
    [date]        DATE           NULL,
    [organ]       VARCHAR (20)   NULL,
    [region]      VARCHAR (150)  NULL,
    [user_names]  VARCHAR (100)  NULL,
    [Division]    VARCHAR (50)   NULL,
    [Vertical1]   VARCHAR (100)  NULL,
    [AreaCode]    NVARCHAR (255) NULL,
    [areaname]    VARCHAR (50)   NULL,
    [Dpstcode]    VARCHAR (50)   NULL,
    [DPSTName]    VARCHAR (100)  NULL,
    [Budget]      FLOAT (53)     NULL,
    [Sales]       FLOAT (53)     NULL,
    [description] VARCHAR (50)   NULL,
    [custcode]    VARCHAR (20)   NULL,
    [custname]    VARCHAR (50)   NULL,
    [CalYear]     INT            NULL,
    [CalMonth]    INT            NULL,
    [Month_Name]  VARCHAR (20)   NULL,
    [FinYear]     INT            NULL,
    [FinMonth]    INT            NULL,
    [FiscalYear]  VARCHAR (10)   NULL,
    [HalfYear]    INT            NULL,
    [Qrtr]        INT            NULL,
    [Latitude]    FLOAT (53)     NULL,
    [Longitude]   FLOAT (53)     NULL,
    [Last_Yr_YTD] FLOAT (53)     NULL
);


GO

