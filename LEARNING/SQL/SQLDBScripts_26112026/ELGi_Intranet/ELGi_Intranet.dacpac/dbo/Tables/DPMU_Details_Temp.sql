CREATE TABLE [dbo].[DPMU_Details_Temp] (
    [FABNO]                 NVARCHAR (60)  NULL,
    [COMPANY]               NVARCHAR (38)  NULL,
    [TTYP]                  NVARCHAR (6)   NULL,
    [INVN]                  NVARCHAR (38)  NULL,
    [AREA]                  NVARCHAR (10)  NULL,
    [AreaName]              VARCHAR (50)   NULL,
    [DPST]                  NVARCHAR (12)  NULL,
    [item]                  NVARCHAR (94)  NULL,
    [Item_desc]             NVARCHAR (60)  NULL,
    [Invoice_date]          DATE           NULL,
    [Invqty]                FLOAT (53)     NULL,
    [Inv_amount]            FLOAT (53)     NULL,
    [Total_inv]             FLOAT (53)     NULL,
    [Months_after_Dispatch] INT            NULL,
    [Warrantyperiod]        FLOAT (53)     NULL,
    [WarrantyType]          VARCHAR (20)   NULL,
    [Productgroup1]         NVARCHAR (255) NULL,
    [Productgroup2]         NVARCHAR (255) NULL,
    [Trackno]               NVARCHAR (200) NULL,
    [Log_Date]              DATETIME       NULL,
    [Rnk1]                  BIGINT         NULL,
    [Rnk2]                  BIGINT         NULL,
    [Country]               NVARCHAR (25)  NULL,
    [Region]                NVARCHAR (25)  NULL,
    [TO_BE_MAPPED_AS]       NVARCHAR (25)  NULL,
    [Calyear]               INT            NULL,
    [CalMonth]              INT            NULL,
    [Finyear]               INT            NULL,
    [FinMonth]              INT            NULL,
    [Finperiod]             VARCHAR (20)   NULL,
    [FinperiodName]         VARCHAR (20)   NULL,
    [Fabno2]                VARCHAR (50)   NULL,
    [FabnoRnk]              INT            NULL
);


GO

