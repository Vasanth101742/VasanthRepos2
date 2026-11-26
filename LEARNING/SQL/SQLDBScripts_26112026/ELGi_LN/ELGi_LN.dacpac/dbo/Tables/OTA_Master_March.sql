CREATE TABLE [dbo].[OTA_Master_March] (
    [Item]         NVARCHAR (50)  NULL,
    [Model]        NVARCHAR (250) NULL,
    [Product_Line] NVARCHAR (50)  NULL,
    [Bin_Quantity] NVARCHAR (50)  NULL,
    [Daily_Max]    NVARCHAR (50)  NULL,
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

