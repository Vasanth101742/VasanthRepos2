CREATE TABLE [dbo].[dms_defect_category_master] (
    [cat_id]     NVARCHAR (10) NULL,
    [parent_id]  NVARCHAR (10) NULL,
    [cat_name]   NVARCHAR (70) NULL,
    [created_at] DATETIME      NULL,
    [created_by] INT           NULL,
    [status]     INT           NULL
);


GO

