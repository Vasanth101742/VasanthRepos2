CREATE TABLE [dbo].[OTA_TPL_Master_Oct] (
    [Item]         NVARCHAR (255) NULL,
    [Model]        NVARCHAR (255) NULL,
    [Product_Line] NVARCHAR (255) NULL,
    [Bin_Quantity] NVARCHAR (255) NULL,
    [Daily_Max]    FLOAT (53)     NULL,
    [Month_Max]    NVARCHAR (255) NULL,
    [DEM_Class]    NVARCHAR (255) NULL,
    [Division]     NVARCHAR (255) NULL,
    [Sub_divn]     NVARCHAR (255) NULL,
    [DEM_subclass] NVARCHAR (255) NULL,
    [Eff_day]      DATETIME2 (7)  NULL,
    [Month]        INT            NULL,
    [Year]         INT            NULL
);


GO

