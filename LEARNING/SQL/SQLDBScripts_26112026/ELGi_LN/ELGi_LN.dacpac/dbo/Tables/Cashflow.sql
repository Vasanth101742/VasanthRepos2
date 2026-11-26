CREATE TABLE [dbo].[Cashflow] (
    [company]           VARCHAR (10) NULL,
    [InvoiceDate]       DATE         NULL,
    [Trantype]          VARCHAR (25) NULL,
    [invoice]           VARCHAR (25) NULL,
    [RecvDocDate]       DATE         NULL,
    [RecvDoctype]       VARCHAR (25) NULL,
    [RecvDocn]          VARCHAR (25) NULL,
    [SalesTypeOrdering] INT          NULL,
    [SalesType]         VARCHAR (50) NULL,
    [ZoneOrdering]      INT          NULL,
    [Zone]              VARCHAR (50) NULL,
    [DpstCode]          VARCHAR (25) NULL,
    [DpstName]          VARCHAR (50) NULL,
    [AreaCode]          VARCHAR (20) NULL,
    [AreaName]          VARCHAR (50) NULL,
    [OnDate_Balance]    FLOAT (53)   NULL,
    [OnDate_Sales]      FLOAT (53)   NULL,
    [OnDate_Collection] FLOAT (53)   NULL,
    [Updt]              DATE         NULL,
    [Opening_Balance]   FLOAT (53)   NULL,
    [Closing_Balance]   FLOAT (53)   NULL
);


GO

