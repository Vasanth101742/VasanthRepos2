CREATE TABLE [dbo].[TmpslsDespdata_2016_17] (
    [Company]      INT             NOT NULL,
    [OrderNum]     INT             NOT NULL,
    [PositionNum]  INT             NOT NULL,
    [SequenceNum]  INT             NOT NULL,
    [OrderType]    VARCHAR (3)     NULL,
    [Date]         VARCHAR (50)    NULL,
    [Dpst]         INT             NULL,
    [SalesRep]     INT             NULL,
    [Division]     INT             NULL,
    [Warehouse]    VARCHAR (3)     NULL,
    [Area]         VARCHAR (3)     NULL,
    [FinCustGrp]   VARCHAR (3)     NULL,
    [CustCode]     VARCHAR (6)     NULL,
    [ItemGrp]      VARCHAR (6)     NULL,
    [ItemCode]     VARCHAR (16)    NOT NULL,
    [DeliveredQty] NUMERIC (16, 2) NULL,
    [BasicPrice]   NUMERIC (16, 4) NULL,
    [AssesValue]   NUMERIC (16, 4) NULL,
    [OAssesValue]  NUMERIC (16, 4) NULL,
    [DiscAmt]      NUMERIC (16, 4) NULL,
    [TodAmt]       NUMERIC (16, 4) NULL,
    [EDAmt]        NUMERIC (16, 4) NULL,
    [STAmt]        NUMERIC (16, 4) NULL,
    [SCAmt]        NUMERIC (16, 4) NULL,
    [SaleType]     INT             NULL,
    [TranType]     VARCHAR (3)     NULL,
    [InvoiceNum]   INT             NULL
);


GO

