CREATE TABLE [dbo].[mc_budget] (
    [dpst]          NVARCHAR (12)   NULL,
    [areacode]      VARCHAR (3)     NULL,
    [year]          INT             NULL,
    [month]         INT             NULL,
    [item]          VARCHAR (50)    NULL,
    [sales]         INT             NOT NULL,
    [delqty]        INT             NOT NULL,
    [sales_mc]      INT             NOT NULL,
    [sales_bud]     NUMERIC (38, 8) NULL,
    [sales_bud_Qty] FLOAT (53)      NULL,
    [mat_bud]       FLOAT (53)      NULL
);


GO

