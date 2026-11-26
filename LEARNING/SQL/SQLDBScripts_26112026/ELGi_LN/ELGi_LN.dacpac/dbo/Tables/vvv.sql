CREATE TABLE [dbo].[vvv] (
    [qty]          NUMERIC (38, 2) NULL,
    [sptyp]        FLOAT (53)      NULL,
    [company]      INT             NULL,
    [ordernum]     INT             NULL,
    [PositionNum]  INT             NULL,
    [SequenceNum]  INT             NULL,
    [OrderType]    VARCHAR (3)     NULL,
    [date]         VARCHAR (50)    NULL,
    [dpst]         INT             NULL,
    [CustCode]     VARCHAR (10)    NULL,
    [itemcode]     VARCHAR (16)    NULL,
    [DeliveredQty] NUMERIC (16, 2) NULL,
    [TranType]     VARCHAR (3)     NULL,
    [InvoiceNum]   INT             NULL,
    [pgcode]       INT             NULL,
    [baan_pg]      NVARCHAR (50)   NULL,
    [ccs_pg]       NVARCHAR (50)   NULL,
    [product]      NVARCHAR (50)   NULL,
    [new_date]     DATETIME        NULL
);


GO

