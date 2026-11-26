CREATE TABLE [dbo].[dms_rc_fishbone] (
    [sno]            INT            NULL,
    [defect_id]      NVARCHAR (20)  NULL,
    [type]           NVARCHAR (30)  NULL,
    [fishbone_name]  NVARCHAR (MAX) NULL,
    [fishbone_cause] NVARCHAR (5)   NULL,
    [created_at]     DATETIME       NULL,
    [created_by]     INT            NULL,
    [status]         INT            NULL
);


GO

