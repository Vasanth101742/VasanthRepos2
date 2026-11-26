CREATE TABLE [dbo].[GSC_Exports] (
    [DCNO]           NVARCHAR (60) NULL,
    [DCDT]           DATETIME      NULL,
    [CUST]           NVARCHAR (40) NULL,
    [SPNO]           NVARCHAR (32) NULL,
    [SHDT]           DATETIME      NULL,
    [GTDT]           DATETIME      NULL,
    [ITEM]           NVARCHAR (94) NULL,
    [QSHP]           FLOAT (53)    NULL,
    [WORN]           NVARCHAR (18) NULL,
    [WPON]           NVARCHAR (38) NULL,
    [WSEQ]           NVARCHAR (38) NULL,
    [t_pric]         FLOAT (53)    NULL,
    [STCO]           NVARCHAR (18) NULL,
    [SHST]           NVARCHAR (38) NULL,
    [CDAT]           DATETIME      NULL,
    [ShipmentDesc]   VARCHAR (15)  NULL,
    [Company]        INT           NULL,
    [Trantype]       NVARCHAR (6)  NULL,
    [invnum]         INT           NULL,
    [AgeingDays]     INT           NULL,
    [Invoice_date]   DATE          NULL,
    [CustName]       VARCHAR (50)  NULL,
    [ccur]           NVARCHAR (6)  NULL,
    [Rate]           FLOAT (53)    NULL,
    [Amnt_FCurr]     FLOAT (53)    NULL,
    [Amnt_INR]       FLOAT (53)    NULL,
    [Data_Load_Date] DATE          NULL,
    [Warehouse]      VARCHAR (10)  NULL
);


GO

