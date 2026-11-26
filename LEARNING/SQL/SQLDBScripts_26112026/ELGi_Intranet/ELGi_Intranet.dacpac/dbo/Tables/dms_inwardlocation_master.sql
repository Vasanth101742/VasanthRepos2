CREATE TABLE [dbo].[dms_inwardlocation_master] (
    [inloc_id]   NVARCHAR (10) NULL,
    [inloc_name] NVARCHAR (50) NULL,
    [cmp]        NVARCHAR (5)  NULL,
    [created_at] DATETIME2 (0) NULL,
    [created_by] INT           NULL,
    [status]     INT           NULL
);


GO

