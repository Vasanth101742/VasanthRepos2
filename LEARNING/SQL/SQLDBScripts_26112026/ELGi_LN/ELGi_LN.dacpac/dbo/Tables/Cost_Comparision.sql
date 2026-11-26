CREATE TABLE [dbo].[Cost_Comparision] (
    [ItemSelected] NVARCHAR (255) NULL,
    [Desc]         NVARCHAR (255) NULL,
    [Main_Item]    NVARCHAR (255) NULL,
    [MainItmDesc]  NVARCHAR (255) NULL,
    [Child_Item]   NVARCHAR (255) NULL,
    [Quantity]     FLOAT (53)     NULL,
    [TYPE]         NVARCHAR (255) NULL,
    [Avg_Price]    FLOAT (53)     NULL,
    [LatestPrice]  FLOAT (53)     NULL,
    [CostPrice]    FLOAT (53)     NULL,
    [Cur]          NVARCHAR (255) NULL,
    [Import+15%]   FLOAT (53)     NULL,
    [Supplier]     NVARCHAR (255) NULL,
    [Supplie_Name] NVARCHAR (255) NULL,
    [SCu]          NVARCHAR (255) NULL,
    [CMP]          FLOAT (53)     NULL,
    [PBS_Date]     VARCHAR (100)  NULL,
    [Exch_Rate]    FLOAT (53)     NULL,
    [Rate_Unit]    FLOAT (53)     NULL,
    [ReciptDate]   VARCHAR (100)  NULL
);


GO

