CREATE TABLE [dbo].[ELGi_Aftersales_Summary] (
    [Organ]      VARCHAR (50)  NULL,
    [Vertical1]  VARCHAR (50)  NULL,
    [zone]       VARCHAR (100) NULL,
    [areacode]   VARCHAR (5)   NULL,
    [areaname]   VARCHAR (50)  NULL,
    [dpst]       NVARCHAR (6)  NULL,
    [dpstname]   VARCHAR (100) NULL,
    [year]       INT           NULL,
    [Month]      INT           NULL,
    [Monthname]  NVARCHAR (30) NULL,
    [MonthName1] NVARCHAR (6)  NULL,
    [AssesValue] FLOAT (53)    NULL,
    [Rnk1]       BIGINT        NULL,
    [Budget]     FLOAT (53)    NULL,
    [YTDFlag]    VARCHAR (10)  NULL,
    [OrganOrder] INT           NULL
);


GO

