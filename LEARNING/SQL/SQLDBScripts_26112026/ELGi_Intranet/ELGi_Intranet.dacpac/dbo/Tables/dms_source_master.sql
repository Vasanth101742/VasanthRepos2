CREATE TABLE [dbo].[dms_source_master] (
    [source_id]   NVARCHAR (10) NULL,
    [source_name] NVARCHAR (50) NULL,
    [source_type] NVARCHAR (50) NULL,
    [created_at]  DATETIME2 (0) NULL,
    [created_by]  INT           NULL,
    [status]      INT           NULL
);


GO

