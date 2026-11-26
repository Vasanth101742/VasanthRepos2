CREATE TABLE [dbo].[AirAlert_EquipmentDetails] (
    [equipmentId]           INT           NULL,
    [equipmentCode]         VARCHAR (100) NULL,
    [description]           VARCHAR (500) NULL,
    [deviceId]              VARCHAR (100) NULL,
    [customerCode]          VARCHAR (100) NULL,
    [latitude]              FLOAT (53)    NULL,
    [longitude]             FLOAT (53)    NULL,
    [modelCode]             VARCHAR (100) NULL,
    [siteName]              VARCHAR (200) NULL,
    [siteCode]              VARCHAR (100) NULL,
    [hierarchyName]         VARCHAR (200) NULL,
    [subCategoryName]       VARCHAR (200) NULL,
    [manufacturingYear]     VARCHAR (50)  NULL,
    [commissioningDate]     VARCHAR (50)  NULL,
    [warrantyExpiry]        VARCHAR (50)  NULL,
    [sectorName]            VARCHAR (200) NULL,
    [fuelConfigurationName] VARCHAR (200) NULL,
    [active]                BIT           NULL
);


GO

