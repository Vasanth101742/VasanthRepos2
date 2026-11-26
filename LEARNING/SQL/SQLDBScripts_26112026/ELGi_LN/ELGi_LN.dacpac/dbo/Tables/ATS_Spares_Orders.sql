CREATE TABLE [dbo].[ATS_Spares_Orders] (
    [Dpst]             NVARCHAR (12) NULL,
    [Company]          INT           NULL,
    [OrderNum]         NVARCHAR (18) NULL,
    [PositionNum]      INT           NULL,
    [CustCode]         NVARCHAR (18) NULL,
    [OrderDate]        DATETIME      NULL,
    [plann_deliv_date] DATETIME      NULL,
    [orderqty]         INT           NULL,
    [warehouse]        NVARCHAR (10) NULL,
    [itemcode]         NVARCHAR (94) NULL
);


GO

