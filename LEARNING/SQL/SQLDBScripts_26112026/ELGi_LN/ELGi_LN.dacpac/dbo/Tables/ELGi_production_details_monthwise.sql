CREATE TABLE [dbo].[ELGi_production_details_monthwise] (
    [company]       NVARCHAR (38)  NULL,
    [warehouse]     NVARCHAR (12)  NULL,
    [item]          NVARCHAR (94)  NULL,
    [itemdescr]     VARCHAR (50)   NULL,
    [Description]   VARCHAR (50)   NULL,
    [Prodorderno]   NVARCHAR (18)  NULL,
    [date1]         DATE           NULL,
    [sls_price]     INT            NULL,
    [Planned_qty]   INT            NULL,
    [Released_qty]  INT            NULL,
    [Actual_qty]    INT            NULL,
    [WIP_qty]       INT            NULL,
    [avg_bud_price] INT            NULL,
    [Dispatch_qty]  FLOAT (53)     NULL,
    [CalMonth]      VARCHAR (2)    NULL,
    [CalYear]       VARCHAR (4)    NULL,
    [MonthPlan]     FLOAT (53)     NULL,
    [Item_DayRnk]   INT            NULL,
    [Item_MnthRnk]  INT            NULL,
    [SalesOrderNo]  VARCHAR (20)   NULL,
    [CustCode]      VARCHAR (25)   NULL,
    [CustName]      VARCHAR (50)   NULL,
    [OSTA]          INT            NULL,
    [FabNo]         NVARCHAR (120) NULL,
    [PlanDelDate]   DATE           NULL,
    [OTADate]       DATE           NULL,
    [LineNum]       NVARCHAR (10)  NULL,
    [Line]          NVARCHAR (20)  NULL,
    [SubLineNum]    NVARCHAR (10)  NULL,
    [SubLine]       NVARCHAR (20)  NULL,
    [RegionNum]     NVARCHAR (10)  NULL,
    [CompName]      NVARCHAR (25)  NULL
);


GO

