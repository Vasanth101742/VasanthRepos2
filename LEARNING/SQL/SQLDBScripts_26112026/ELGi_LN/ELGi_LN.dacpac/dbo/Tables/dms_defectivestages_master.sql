CREATE TABLE [dbo].[dms_defectivestages_master] (
    [stage_id]     NVARCHAR (10) NULL,
    [stage_name]   NVARCHAR (50) NULL,
    [created_at]   DATETIME      NULL,
    [created_by]   INT           NULL,
    [status]       INT           NULL,
    [product_line] NVARCHAR (10) NULL
);


GO

