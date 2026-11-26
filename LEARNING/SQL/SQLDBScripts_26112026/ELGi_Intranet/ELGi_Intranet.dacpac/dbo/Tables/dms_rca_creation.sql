CREATE TABLE [dbo].[dms_rca_creation] (
    [rca_id]              NVARCHAR (30)  NULL,
    [created_on]          DATETIME2 (0)  NULL,
    [created_by]          INT            NULL,
    [product_line]        NVARCHAR (30)  NULL,
    [inward_location]     NVARCHAR (30)  NULL,
    [part_category]       NVARCHAR (30)  NULL,
    [defect_category]     NVARCHAR (30)  NULL,
    [defect_sub_category] NVARCHAR (30)  NULL,
    [supplier_name]       NVARCHAR (MAX) NULL,
    [status]              INT            NULL,
    [resp_func]           NVARCHAR (20)  NULL,
    [defective_item]      NVARCHAR (MAX) NULL,
    [cmp]                 NVARCHAR (10)  NULL
);


GO

