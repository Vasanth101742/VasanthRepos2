CREATE TABLE [dbo].[OTA_TPL_Master_Sept] (
    [Item]         NVARCHAR (50)  NULL,
    [Model]        NVARCHAR (150) NULL,
    [Product_Line] NVARCHAR (50)  NULL,
    [Bin_Quantity] NVARCHAR (50)  NULL,
    [Daily_Max]    FLOAT (53)     NULL,
    [Month_Max]    NVARCHAR (50)  NULL,
    [DEM_Class]    NVARCHAR (50)  NULL,
    [Division]     NVARCHAR (50)  NULL,
    [Sub_divn]     NVARCHAR (50)  NULL,
    [DEM_subclass] NVARCHAR (50)  NULL,
    [Eff_day]      DATETIME2 (7)  NULL,
    [Month]        INT            NULL,
    [Year]         INT            NULL
);


GO

