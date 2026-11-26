CREATE TABLE [dbo].[testdata] (
    [Dpst]             NVARCHAR (12)   NULL,
    [Company]          INT             NULL,
    [OrderNum]         NVARCHAR (18)   NULL,
    [PositionNum]      SMALLINT        NULL,
    [CustCode]         NVARCHAR (18)   NULL,
    [OrderDate]        VARCHAR (100)   NULL,
    [plann_deliv_date] DATETIME        NULL,
    [orderqty]         NUMERIC (16, 2) NULL,
    [DeliveryDt]       DATETIME        NULL,
    [DeliveredQty]     FLOAT (53)      NULL,
    [BackOrderQty]     FLOAT (53)      NULL,
    [warehouse]        VARCHAR (50)    NULL,
    [itemcode]         NVARCHAR (94)   NULL,
    [ordertype]        NVARCHAR (6)    NULL,
    [type]             VARCHAR (3)     NULL
);


GO

