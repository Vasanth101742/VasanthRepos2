CREATE TABLE [dbo].[GSC_A_CLASS_ITEMS] (
    [Itemcode]     VARCHAR (100) NULL,
    [Item_desc]    VARCHAR (200) NULL,
    [BUYER]        NVARCHAR (70) NULL,
    [SUPPLIER]     NVARCHAR (70) NULL,
    [Inflow]       INT           NOT NULL,
    [Delqty]       INT           NOT NULL,
    [Allocation]   INT           NOT NULL,
    [Stock]        INT           NOT NULL,
    [BinQty]       INT           NOT NULL,
    [RplDays]      INT           NOT NULL,
    [BinType]      VARCHAR (14)  NOT NULL,
    [Trigger_Date] DATE          NULL,
    [Net_Req]      INT           NOT NULL,
    [Wk]           FLOAT (53)    NULL
);


GO

