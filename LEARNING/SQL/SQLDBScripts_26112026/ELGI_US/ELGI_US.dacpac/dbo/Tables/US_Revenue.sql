CREATE TABLE [dbo].[US_Revenue] (
    [COMPN]       NVARCHAR (20)   NULL,
    [idoc]        NVARCHAR (20)   NULL,
    [line]        NVARCHAR (5)    NULL,
    [Order_Type]  NVARCHAR (20)   NULL,
    [Invt_KW]     NVARCHAR (20)   NULL,
    [idat]        DATE            NULL,
    [Inv_Date]    NVARCHAR (20)   NULL,
    [amti]        DECIMAL (19, 2) NULL,
    [EngName]     NVARCHAR (254)  NULL,
    [Branch]      NVARCHAR (254)  NULL,
    [ProductLine] NVARCHAR (254)  NULL,
    [BPName]      NVARCHAR (254)  NULL,
    [ItemName]    NVARCHAR (254)  NULL,
    [ProdType]    NVARCHAR (20)   NULL
);


GO

