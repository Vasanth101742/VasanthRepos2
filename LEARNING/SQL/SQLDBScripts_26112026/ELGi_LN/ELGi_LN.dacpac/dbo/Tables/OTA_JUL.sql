CREATE TABLE [dbo].[OTA_JUL] (
    [Item]         NVARCHAR (MAX) NULL,
    [Model]        NVARCHAR (MAX) NULL,
    [Product_Line] NVARCHAR (MAX) NULL,
    [Bin_Quantity] NVARCHAR (MAX) NULL,
    [Daily_Max]    NVARCHAR (MAX) NULL,
    [Month_Max]    NVARCHAR (MAX) NULL,
    [DEM_Class]    NVARCHAR (50)  NULL,
    [Division]     NVARCHAR (50)  NULL,
    [Sub_divn]     NVARCHAR (50)  NULL,
    [DEM_subclass] NVARCHAR (50)  NULL,
    [Eff_day]      DATETIME       NULL,
    [Month]        INT            NULL,
    [Year]         INT            NULL
);


GO

