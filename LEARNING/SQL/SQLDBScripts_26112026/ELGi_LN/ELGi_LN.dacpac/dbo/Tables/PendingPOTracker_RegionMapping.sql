CREATE TABLE [dbo].[PendingPOTracker_RegionMapping] (
    [Warehouse]             NVARCHAR (100) NULL,
    [Region]                NVARCHAR (250) NULL,
    [Region_SOPMaster]      NVARCHAR (250) NULL,
    [Region_PlanningMaster] NVARCHAR (100) NULL,
    [WHDesc]                NVARCHAR (250) NULL,
    [UpdatedDate]           DATETIME       NULL
);


GO

