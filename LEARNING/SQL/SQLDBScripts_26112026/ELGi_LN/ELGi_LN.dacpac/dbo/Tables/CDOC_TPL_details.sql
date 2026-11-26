CREATE TABLE [dbo].[CDOC_TPL_details] (
    [date1]                  DATE          NULL,
    [company]                NVARCHAR (38) NULL,
    [item]                   NVARCHAR (94) NULL,
    [itemdescr]              VARCHAR (50)  NULL,
    [prodorderno]            NVARCHAR (18) NULL,
    [ManufacturedQty]        INT           NULL,
    [trantype]               VARCHAR (20)  NULL,
    [Invoice]                VARCHAR (20)  NULL,
    [SoldQty]                FLOAT (53)    NULL,
    [Model]                  VARCHAR (50)  NULL,
    [prod_group]             VARCHAR (50)  NULL,
    [FinYear]                INT           NULL,
    [FinMonth]               INT           NULL,
    [Month_Name]             VARCHAR (20)  NULL,
    [Latest_Invoice_Date]    DATE          NULL,
    [Latest_Production_Date] DATE          NULL,
    [Slno]                   INT           NULL,
    [Fin_Year]               VARCHAR (20)  NULL
);


GO

