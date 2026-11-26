CREATE TABLE [dbo].[CRM_Budget] (
    [elgi_elgigoalid]          UNIQUEIDENTIFIER NULL,
    [elgi_dealernamename]      NVARCHAR (160)   NULL,
    [elgi_districtname]        NVARCHAR (100)   NULL,
    [elgi_financialyearname]   NVARCHAR (100)   NULL,
    [elgi_name]                NVARCHAR (300)   NULL,
    [owneridname]              NVARCHAR (200)   NULL,
    [elgi_elgigoal]            UNIQUEIDENTIFIER NULL,
    [elgi_elgigoalname]        NVARCHAR (300)   NULL,
    [elgi_productcategoryname] NVARCHAR (100)   NULL,
    [elgi_salesoffice]         UNIQUEIDENTIFIER NULL,
    [infqty]                   INT              NULL,
    [Category1]                INT              NULL,
    [infValue]                 DECIMAL (38, 2)  NULL,
    [Category2]                INT              NULL,
    [FinYear]                  INT              NULL,
    [FinMonth]                 INT              NULL,
    [CalYear]                  INT              NULL,
    [CalMonth]                 INT              NULL,
    [Month_Name]               VARCHAR (10)     NULL,
    [elgi_salesofficecode]     INT              NULL,
    [ownerid]                  UNIQUEIDENTIFIER NULL,
    [SalesRepcode]             INT              NULL,
    [Region]                   VARCHAR (20)     NULL,
    [elgi_dealername]          UNIQUEIDENTIFIER NULL,
    [elgi_erpcustomercode]     NVARCHAR (100)   NULL,
    [elgi_productcategory]     UNIQUEIDENTIFIER NULL
);


GO

