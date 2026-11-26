CREATE TABLE [dbo].[Catg_MatBudget] (
    [YEAR]      NVARCHAR (8)   NULL,
    [UPDT]      DATETIME       NULL,
    [LOGN]      NVARCHAR (32)  NULL,
    [ITEM]      NVARCHAR (94)  NULL,
    [PRIC]      FLOAT (53)     NULL,
    [Q1PR]      FLOAT (53)     NULL,
    [Q2PR]      FLOAT (53)     NULL,
    [Q3PR]      FLOAT (53)     NULL,
    [Q4PR]      FLOAT (53)     NULL,
    [IMPO]      NVARCHAR (38)  NULL,
    [CCUR]      NVARCHAR (6)   NULL,
    [RATE]      FLOAT (53)     NULL,
    [BVAL]      FLOAT (53)     NULL,
    [COMP]      NVARCHAR (38)  NULL,
    [REMK1]     NVARCHAR (512) NULL,
    [BUYR]      NVARCHAR (18)  NULL,
    [CATG]      NVARCHAR (100) NULL,
    [KITM]      NVARCHAR (38)  NULL,
    [QTY1]      FLOAT (53)     NULL,
    [QTY2]      FLOAT (53)     NULL,
    [QTY3]      FLOAT (53)     NULL,
    [QTY4]      FLOAT (53)     NULL,
    [SUBC]      NVARCHAR (100) NULL,
    [REFCNTD]   NVARCHAR (38)  NULL,
    [REFCNTU]   NVARCHAR (38)  NULL,
    [emp_name]  NVARCHAR (100) NULL,
    [Item_desc] NVARCHAR (120) NULL,
    [WGHT]      NVARCHAR (38)  NULL
);


GO

