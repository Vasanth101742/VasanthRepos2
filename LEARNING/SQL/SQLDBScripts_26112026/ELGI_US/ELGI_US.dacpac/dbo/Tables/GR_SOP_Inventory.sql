CREATE TABLE [dbo].[GR_SOP_Inventory] (
    [company]                     VARCHAR (16)    NULL,
    [compnr]                      BIGINT          NULL,
    [Item]                        NVARCHAR (4000) NULL,
    [descr]                       NVARCHAR (100)  NULL,
    [OnHand]                      FLOAT (53)      NULL,
    [Differ]                      INT             NULL,
    [Ageing]                      VARCHAR (15)    NULL,
    [dsca]                        NVARCHAR (30)   NULL,
    [ProductLine]                 NVARCHAR (30)   NOT NULL,
    [Supplier]                    NVARCHAR (50)   NULL,
    [Model]                       NVARCHAR (30)   NULL,
    [cwar]                        NVARCHAR (12)   NULL,
    [StockVal]                    FLOAT (53)      NULL,
    [seak]                        NVARCHAR (16)   NULL,
    [AlterName]                   NVARCHAR (60)   NULL,
    [Demand_Forecasting_Unit_DFU] NVARCHAR (MAX)  NULL,
    [HP]                          NVARCHAR (100)  NULL,
    [Pressure_bar]                NVARCHAR (100)  NULL,
    [Pressure_psi]                NVARCHAR (100)  NULL,
    [Master_Model]                NVARCHAR (100)  NULL,
    [Variant]                     NVARCHAR (100)  NULL,
    [KW]                          NVARCHAR (100)  NULL,
    [Region]                      NVARCHAR (100)  NULL,
    [item_category]               NVARCHAR (50)   NULL,
    [product_group]               NVARCHAR (150)  NULL
);


GO

