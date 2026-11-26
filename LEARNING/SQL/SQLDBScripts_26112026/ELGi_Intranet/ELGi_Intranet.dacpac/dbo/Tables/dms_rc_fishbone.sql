CREATE TABLE [dbo].[dms_rc_fishbone] (
    [sno]            INT            NULL,
    [defect_id]      NVARCHAR (20)  NULL,
    [type]           NVARCHAR (30)  NULL,
    [fishbone_name]  NVARCHAR (500) NULL,
    [fishbone_cause] NVARCHAR (5)   NULL,
    [created_at]     DATETIME2 (0)  NULL,
    [created_by]     NVARCHAR (10)  NULL,
    [status]         INT            NULL
);


GO

