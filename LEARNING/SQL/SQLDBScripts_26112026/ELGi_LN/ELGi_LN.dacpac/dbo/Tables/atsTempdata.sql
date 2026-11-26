CREATE TABLE [dbo].[atsTempdata] (
    [Dpst]             NVARCHAR (12) NULL,
    [Company]          INT           NULL,
    [OrderNum]         NVARCHAR (18) NULL,
    [PositionNum]      INT           NULL,
    [CustCode]         NVARCHAR (18) NULL,
    [OrderDate]        DATETIME      NULL,
    [plann_deliv_date] DATETIME      NULL,
    [orderqty]         INT           NULL,
    [DeliveryDt]       DATETIME      NULL,
    [DeliveredQty]     FLOAT (53)    NULL,
    [BackOrderQty]     FLOAT (53)    NULL,
    [warehouse]        INT           NULL,
    [itemcode]         NVARCHAR (94) NULL,
    [ordertype]        NVARCHAR (6)  NULL,
    [type]             VARCHAR (3)   NOT NULL
);


GO

