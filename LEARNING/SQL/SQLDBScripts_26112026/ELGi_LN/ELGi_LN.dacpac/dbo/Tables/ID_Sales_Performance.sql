CREATE TABLE [dbo].[ID_Sales_Performance] (
    [Global]                   VARCHAR (20)   NULL,
    [organ]                    VARCHAR (20)   NULL,
    [region]                   VARCHAR (150)  NULL,
    [user_names]               VARCHAR (100)  NULL,
    [Division]                 VARCHAR (50)   NULL,
    [description]              VARCHAR (50)   NULL,
    [Dpstcode]                 VARCHAR (50)   NULL,
    [dpstname]                 VARCHAR (100)  NULL,
    [AreaCode]                 NVARCHAR (255) NULL,
    [AreaName]                 VARCHAR (50)   NULL,
    [ordr]                     INT            NULL,
    [budget_year]              FLOAT (53)     NULL,
    [last_month_budget]        FLOAT (53)     NULL,
    [ytd_budget]               FLOAT (53)     NULL,
    [this_month_budget]        FLOAT (53)     NULL,
    [next_month_budget]        FLOAT (53)     NULL,
    [nextof_next_month_budget] FLOAT (53)     NULL,
    [last_year_sale]           FLOAT (53)     NULL,
    [last_year_ytd]            FLOAT (53)     NULL,
    [thr_month_sale]           FLOAT (53)     NULL,
    [this_month_sale]          FLOAT (53)     NULL,
    [this_year_sale]           FLOAT (53)     NULL,
    [last_month_sale]          FLOAT (53)     NULL,
    [n1_month_sale]            FLOAT (53)     NULL,
    [n2_month_sale]            FLOAT (53)     NULL,
    [n3_month_sale]            FLOAT (53)     NULL,
    [this_month_inflow]        FLOAT (53)     NULL,
    [YTD_INFLOW]               FLOAT (53)     NULL,
    [PendValue]                FLOAT (53)     NULL,
    [SalesPlan]                FLOAT (53)     NULL,
    [Vertical1]                VARCHAR (25)   NULL
);


GO

