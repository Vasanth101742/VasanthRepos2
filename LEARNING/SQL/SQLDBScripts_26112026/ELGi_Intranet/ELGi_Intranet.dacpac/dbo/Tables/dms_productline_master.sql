CREATE TABLE [dbo].[dms_productline_master] (
    [productline_id]   NVARCHAR (10) NULL,
    [productline_name] NVARCHAR (50) NULL,
    [created_at]       DATETIME2 (0) NULL,
    [created_by]       INT           NULL,
    [status]           INT           NULL,
    [pl_code]          INT           NULL,
    [cmp]              INT           NULL
);


GO

