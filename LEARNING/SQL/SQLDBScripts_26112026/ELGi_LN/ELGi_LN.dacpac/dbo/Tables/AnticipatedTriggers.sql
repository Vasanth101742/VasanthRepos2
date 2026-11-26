CREATE TABLE [dbo].[AnticipatedTriggers] (
    [COMPANY]                NVARCHAR (38)  NULL,
    [ITEM]                   NVARCHAR (100) NULL,
    [Description]            NVARCHAR (60)  NULL,
    [StockQty]               INT            NULL,
    [BinQty]                 INT            NULL,
    [ANTICIPATED_IND]        FLOAT (53)     NULL,
    [SLOQ]                   NVARCHAR (38)  NULL,
    [SUPPCODE]               NVARCHAR (18)  NULL,
    [SUPP_NAME]              NVARCHAR (70)  NULL,
    [BUYRCODE]               NVARCHAR (18)  NULL,
    [BUYER_NAME]             NVARCHAR (50)  NULL,
    [CATEGORY]               VARCHAR (11)   NULL,
    [SUP_PRIORITY]           BIGINT         NULL,
    [Consumed_quan]          INT            NULL,
    [Consumed_days]          INT            NULL,
    [AvgConsumption]         FLOAT (53)     NULL,
    [StkAvlDays]             INT            NULL,
    [Sales_Consumption]      INT            NULL,
    [Production_Consumption] INT            NULL,
    [RPLT]                   NVARCHAR (38)  NULL
);


GO

