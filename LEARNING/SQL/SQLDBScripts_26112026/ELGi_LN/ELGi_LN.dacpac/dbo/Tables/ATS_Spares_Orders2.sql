CREATE TABLE [dbo].[ATS_Spares_Orders2] (
    [Dpst]             NVARCHAR (12) NULL,
    [Company]          INT           NULL,
    [OrderNum]         NVARCHAR (18) NULL,
    [PositionNum]      INT           NULL,
    [CustCode]         NVARCHAR (18) NULL,
    [OrderDate]        DATETIME      NULL,
    [plann_deliv_date] DATETIME      NULL,
    [orderqty]         INT           NULL,
    [warehouse]        INT           NULL,
    [itemcode]         NVARCHAR (94) NULL,
    [ordertype]        NVARCHAR (6)  NULL,
    [Type]             VARCHAR (3)   NOT NULL
);


GO

