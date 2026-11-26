CREATE TABLE [dbo].[dms_defectivestages_master] (
    [stage_id]     NVARCHAR (10) NULL,
    [stage_name]   NVARCHAR (50) NULL,
    [created_at]   DATETIME2 (0) NULL,
    [created_by]   INT           NULL,
    [status]       INT           NULL,
    [product_line] NVARCHAR (10) NULL,
    [cmp]          INT           NULL
);


GO

