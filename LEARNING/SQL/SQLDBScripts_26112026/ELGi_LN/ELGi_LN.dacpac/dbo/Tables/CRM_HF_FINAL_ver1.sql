CREATE TABLE [dbo].[CRM_HF_FINAL_ver1] (
    [Name]                      VARCHAR (100)   NULL,
    [Lines]                     INT             NULL,
    [Customers]                 INT             NULL,
    [LinePercent]               INT             NOT NULL,
    [CustPercent]               INT             NOT NULL,
    [elgi_businessverticalname] NVARCHAR (255)  NULL,
    [Region]                    NVARCHAR (200)  NULL,
    [Dealer]                    NVARCHAR (160)  NULL,
    [Dealer_Engineer]           NVARCHAR (160)  NULL,
    [Customer_Classification]   NVARCHAR (255)  NULL,
    [Industry]                  NVARCHAR (4000) NULL,
    [ProductCategory]           VARCHAR (100)   NULL,
    [StateName]                 NVARCHAR (100)  NULL,
    [CityName]                  NVARCHAR (100)  NULL,
    [ordr]                      INT             NOT NULL,
    [visitdate]                 DATE            NULL,
    [new]                       VARCHAR (100)   NULL
);


GO

