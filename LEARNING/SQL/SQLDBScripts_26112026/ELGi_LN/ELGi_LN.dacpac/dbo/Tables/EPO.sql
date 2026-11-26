CREATE TABLE [dbo].[EPO] (
    [company]      NVARCHAR (38)   NULL,
    [T$REFNO]      NVARCHAR (50)   NULL,
    [T$CCON]       NVARCHAR (18)   NULL,
    [T$OTBP]       NVARCHAR (18)   NULL,
    [Supp_Name]    VARCHAR (50)    NULL,
    [T$ITEM]       NVARCHAR (94)   NULL,
    [Item_desc]    VARCHAR (50)    NULL,
    [T$QOOR]       NVARCHAR (38)   NULL,
    [T$ODAT]       DATETIME        NULL,
    [T$ORNO]       NVARCHAR (18)   NULL,
    [T$PONO]       NVARCHAR (38)   NULL,
    [Order_Status] VARCHAR (20)    NULL,
    [PPNO]         INT             NULL,
    [Reason]       NVARCHAR (1024) NULL
);


GO

