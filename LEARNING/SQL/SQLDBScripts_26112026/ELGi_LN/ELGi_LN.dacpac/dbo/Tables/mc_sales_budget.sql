CREATE TABLE [dbo].[mc_sales_budget] (
    [year]            INT             NULL,
    [month]           INT             NULL,
    [dpst]            NVARCHAR (100)  NULL,
    [areacode]        VARCHAR (5)     NULL,
    [item]            VARCHAR (50)    NULL,
    [sales]           FLOAT (53)      NULL,
    [deliveryqty]     FLOAT (53)      NULL,
    [sales_mc]        BIGINT          NULL,
    [sales_bud]       NUMERIC (38, 8) NULL,
    [mc_budget]       FLOAT (53)      NULL,
    [sales_bud_Qty]   INT             NULL,
    [Organ]           VARCHAR (100)   NULL,
    [Vertical]        VARCHAR (100)   NULL,
    [level2_vertical] VARCHAR (100)   NULL,
    [dpstname]        VARCHAR (100)   NULL,
    [areaname]        VARCHAR (100)   NULL,
    [Item_desc]       VARCHAR (100)   NULL
);


GO

