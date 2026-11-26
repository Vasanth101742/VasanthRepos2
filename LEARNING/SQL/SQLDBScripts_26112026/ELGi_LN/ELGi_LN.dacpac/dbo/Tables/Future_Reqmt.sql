CREATE TABLE [dbo].[Future_Reqmt] (
    [company]      INT          NULL,
    [itemcode]     VARCHAR (50) NULL,
    [ItemDescr]    VARCHAR (50) NULL,
    [Supplier]     VARCHAR (50) NULL,
    [SuppName]     VARCHAR (50) NULL,
    [Buyer]        VARCHAR (50) NULL,
    [BuyerName]    VARCHAR (50) NULL,
    [No_of_lines]  INT          NULL,
    [OrderQty]     FLOAT (53)   NULL,
    [DelQty]       FLOAT (53)   NULL,
    [PendQty]      FLOAT (53)   NULL,
    [UnitPrice]    FLOAT (53)   NULL,
    [OrderValue]   FLOAT (53)   NULL,
    [weekno]       INT          NULL,
    [monthno]      INT          NULL,
    [year]         INT          NULL,
    [DeliveryDate] DATE         NULL,
    [ordernum]     VARCHAR (50) NULL
);


GO

