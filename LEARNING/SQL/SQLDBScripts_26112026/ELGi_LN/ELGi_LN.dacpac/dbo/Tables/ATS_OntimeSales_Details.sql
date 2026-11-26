CREATE TABLE [dbo].[ATS_OntimeSales_Details] (
    [company]           INT           NULL,
    [OrderDate]         DATETIME      NULL,
    [SaleOrderType]     NVARCHAR (6)  NULL,
    [OrderNo]           NVARCHAR (9)  NULL,
    [PositionNo]        INT           NULL,
    [Invoice_Date]      DATETIME      NULL,
    [trantype]          NVARCHAR (3)  NULL,
    [Invoice]           INT           NULL,
    [DeliveryQty]       FLOAT (53)    NULL,
    [warehouse]         NVARCHAR (6)  NULL,
    [custcode]          NVARCHAR (9)  NULL,
    [custname]          NVARCHAR (35) NULL,
    [Item]              NVARCHAR (47) NULL,
    [Item_desc]         NVARCHAR (30) NULL,
    [Reference]         NVARCHAR (64) NULL,
    [ClearAODate]       DATE          NULL,
    [ProductGroup_MRP]  VARCHAR (50)  NULL,
    [LeadTime]          FLOAT (53)    NULL,
    [LeadTime_Prdgrp]   FLOAT (53)    NULL,
    [DeliveryDays]      INT           NULL,
    [Failure]           INT           NULL,
    [CalYear]           INT           NULL,
    [CalMonth]          INT           NULL,
    [Prdgrp_rnk]        INT           NULL,
    [LeadTime_Delivery] FLOAT (53)    NULL
);


GO

