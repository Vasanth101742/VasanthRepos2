CREATE TABLE [dbo].[ATS_Spares_BDI_FOC_Orders] (
    [Dpst]             NVARCHAR (12)   NULL,
    [Company]          INT             NULL,
    [OrderNum]         NVARCHAR (18)   NULL,
    [PositionNum]      SMALLINT        NULL,
    [CustCode]         NVARCHAR (18)   NULL,
    [OrderDate]        VARCHAR (100)   NULL,
    [plann_deliv_date] DATETIME        NULL,
    [orderqty]         NUMERIC (16, 2) NULL,
    [warehouse]        VARCHAR (50)    NULL,
    [ItemCode]         NVARCHAR (94)   NULL,
    [Ordertype]        NVARCHAR (6)    NULL,
    [Type]             VARCHAR (3)     NULL
);


GO

