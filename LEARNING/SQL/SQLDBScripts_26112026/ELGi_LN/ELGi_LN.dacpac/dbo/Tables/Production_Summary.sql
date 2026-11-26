CREATE TABLE [dbo].[Production_Summary] (
    [Description]          VARCHAR (50)  NULL,
    [company]              NVARCHAR (38) NULL,
    [warehouse]            NVARCHAR (12) NULL,
    [item]                 NVARCHAR (94) NULL,
    [itemdescr]            VARCHAR (50)  NULL,
    [Month_sls_plan_qty]   FLOAT (53)    NULL,
    [Month_sls_plan_value] FLOAT (53)    NULL,
    [MTD_sls_qty]          FLOAT (53)    NULL,
    [MTD_sls_value]        FLOAT (53)    NULL,
    [FG_qty]               FLOAT (53)    NULL,
    [FG_value]             FLOAT (53)    NULL,
    [plan_qty]             FLOAT (53)    NULL,
    [plan_value]           FLOAT (53)    NULL,
    [WIP_qty]              FLOAT (53)    NULL,
    [WIP_value]            FLOAT (53)    NULL,
    [Backlog_qty]          FLOAT (53)    NULL,
    [Backlog_value]        FLOAT (53)    NULL,
    [CalYear]              VARCHAR (10)  NULL,
    [CalMonth]             VARCHAR (10)  NULL,
    [Avg_Sales_amount]     FLOAT (53)    NULL,
    [FutureOrders]         FLOAT (53)    NULL,
    [PredictionType]       VARCHAR (25)  NULL,
    [CustCode]             VARCHAR (25)  NULL,
    [CustName]             VARCHAR (50)  NULL,
    [Rnk]                  INT           NULL,
    [Actual_qty]           FLOAT (53)    NULL
);


GO

