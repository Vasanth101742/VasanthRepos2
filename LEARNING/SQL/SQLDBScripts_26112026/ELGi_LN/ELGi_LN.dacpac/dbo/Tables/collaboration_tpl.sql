CREATE TABLE [dbo].[collaboration_tpl] (
    [Region]                       NVARCHAR (50)  NULL,
    [DFU]                          NVARCHAR (100) NULL,
    [RRS]                          NVARCHAR (50)  NULL,
    [TPL_Code]                     NVARCHAR (MAX) NULL,
    [TPL_Desc]                     NVARCHAR (MAX) NULL,
    [Supplier]                     NVARCHAR (150) NULL,
    [Vertical]                     NVARCHAR (150) NULL,
    [Model]                        NVARCHAR (50)  NULL,
    [Kilowatt]                     NVARCHAR (50)  NULL,
    [Item_Category]                NVARCHAR (50)  NULL,
    [Statistical_Demand]           FLOAT (53)     NULL,
    [Unconstrained_Demand]         FLOAT (53)     NULL,
    [Moderate_Unconstraint_Demand] FLOAT (53)     NULL,
    [Net_Unconstraint_Demand]      FLOAT (53)     NULL,
    [Supplier_Constraint]          FLOAT (53)     NULL,
    [Production_Constraint]        FLOAT (53)     NULL,
    [Constraint_Demand]            FLOAT (53)     NULL,
    [ABP]                          FLOAT (53)     NULL,
    [Last_Month_Sales]             FLOAT (53)     NULL,
    [Last_Month_Sales2]            FLOAT (53)     NULL,
    [Last_3_Month_Sales]           FLOAT (53)     NULL,
    [Last_6_Month_Sales]           FLOAT (53)     NULL,
    [Last_Year_Sales]              FLOAT (53)     NULL,
    [Same_Month_Last_Year]         FLOAT (53)     NULL
);


GO

