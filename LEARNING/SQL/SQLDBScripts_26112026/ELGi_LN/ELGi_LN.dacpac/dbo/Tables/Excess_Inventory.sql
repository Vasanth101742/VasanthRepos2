CREATE TABLE [dbo].[Excess_Inventory] (
    [COMPANY]         NVARCHAR (38) NULL,
    [ITEM]            NVARCHAR (94) NULL,
    [Description]     NVARCHAR (60) NULL,
    [CATEGORY]        VARCHAR (50)  NULL,
    [SLOQ]            INT           NULL,
    [BinQty]          INT           NULL,
    [AllocatedQty]    FLOAT (53)    NULL,
    [StockQty]        FLOAT (53)    NULL,
    [ExcessQty]       FLOAT (53)    NULL,
    [SUPPCODE]        NVARCHAR (18) NULL,
    [SUPP_NAME]       NVARCHAR (70) NULL,
    [BUYRCODE]        NVARCHAR (18) NULL,
    [BUYER_NAME]      NVARCHAR (50) NULL,
    [AllocationType]  VARCHAR (50)  NULL,
    [AllocRnk]        INT           NULL,
    [LatestRecptDate] DATE          NULL,
    [StockValue]      FLOAT (53)    NULL,
    [ExcessValue]     FLOAT (53)    NULL,
    [ExcessType]      VARCHAR (25)  NULL
);


GO

