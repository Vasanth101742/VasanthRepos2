CREATE TABLE [dbo].[call_closing_parts] (
    [trackno]           NVARCHAR (20)  NULL,
    [product_group]     NVARCHAR (175) NULL,
    [part_name]         NVARCHAR (175) NULL,
    [subsytem_name]     NVARCHAR (175) NULL,
    [primary_secondary] NVARCHAR (10)  NULL,
    [part_code]         NVARCHAR (3)   NULL,
    [added_on]          DATETIME2 (0)  NULL,
    [added_by]          NVARCHAR (9)   NULL,
    [high_low]          NVARCHAR (6)   NULL,
    [high_value_part]   NVARCHAR (75)  NULL,
    [serial_no]         NVARCHAR (75)  NULL
);


GO

