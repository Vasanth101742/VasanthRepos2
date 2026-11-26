CREATE TABLE [dbo].[dms_subtask_capa_assigning] (
    [sno]                INT            NULL,
    [defect_id]          NVARCHAR (20)  NULL,
    [task]               NVARCHAR (200) NULL,
    [resp_func]          NVARCHAR (10)  NULL,
    [target_date]        DATETIME       NULL,
    [created_at]         DATETIME       NULL,
    [created_by]         INT            NULL,
    [status]             INT            NULL,
    [action_details]     NVARCHAR (MAX) NULL,
    [action_closed_date] DATETIME       NULL,
    [action_status]      NVARCHAR (5)   NULL,
    [attach1]            NVARCHAR (200) NULL,
    [attach2]            NVARCHAR (200) NULL,
    [attach3]            NVARCHAR (200) NULL
);


GO

