CREATE TABLE [dbo].[FOC_Summary] (
    [Organ]             VARCHAR (50)   NULL,
    [Invoice_Date]      DATETIME       NULL,
    [Fabno]             NVARCHAR (100) NULL,
    [Model]             NVARCHAR (100) NULL,
    [Product]           NVARCHAR (MAX) NULL,
    [MC_Value2]         FLOAT (53)     NULL,
    [Fin_year]          VARCHAR (10)   NULL,
    [Fin_month]         INT            NULL,
    [Monthname]         NVARCHAR (30)  NULL,
    [Col1]              VARCHAR (25)   NULL,
    [Currency]          VARCHAR (25)   NULL,
    [INR_Conv_Rate]     FLOAT (53)     NULL,
    [MC_Value2_INR]     FLOAT (53)     NULL,
    [MonthName2]        VARCHAR (25)   NULL,
    [Item]              NVARCHAR (25)  NULL,
    [Item_desc]         NVARCHAR (50)  NULL,
    [elgi_focnumber]    NVARCHAR (25)  NULL,
    [FinalApprovalDate] DATE           NULL,
    [FOC_CreationDate]  DATE           NULL,
    [Date1]             DATE           NULL,
    [cal_year]          VARCHAR (10)   NULL,
    [cal_Month]         INT            NULL,
    [workorderno]       NVARCHAR (100) NULL
);


GO

