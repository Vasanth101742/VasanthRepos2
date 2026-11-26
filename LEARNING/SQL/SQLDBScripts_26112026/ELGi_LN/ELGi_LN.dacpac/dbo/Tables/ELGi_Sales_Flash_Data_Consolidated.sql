CREATE TABLE [dbo].[ELGi_Sales_Flash_Data_Consolidated] (
    [OrganOrdr]          INT           NULL,
    [organ1]             VARCHAR (50)  NULL,
    [organ]              VARCHAR (50)  NULL,
    [user_names_ordr]    INT           NULL,
    [user_names1]        VARCHAR (100) NULL,
    [user_names]         VARCHAR (100) NULL,
    [Division]           VARCHAR (100) NULL,
    [dpstcode]           VARCHAR (50)  NULL,
    [dpstname]           VARCHAR (50)  NULL,
    [month_budget]       FLOAT (53)    NULL,
    [month_actuals]      FLOAT (53)    NULL,
    [last_month_actuals] FLOAT (53)    NULL,
    [ytd_budget]         FLOAT (53)    NULL,
    [ytd_actuals]        FLOAT (53)    NULL,
    [ly_ytd_actuals]     FLOAT (53)    NULL,
    [ly_month_actuals]   FLOAT (53)    NULL,
    [FinYear]            VARCHAR (5)   NULL,
    [FinMonthnum]        INT           NULL,
    [AreaCode]           VARCHAR (10)  NULL,
    [productgrp]         VARCHAR (25)  NULL
);


GO

