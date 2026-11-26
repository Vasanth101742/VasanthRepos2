CREATE TABLE [dbo].[pcr_approvals] (
    [sno]           INT            NULL,
    [function]      NVARCHAR (50)  NULL,
    [appr_code]     INT            NULL,
    [pcr_id]        NVARCHAR (30)  NULL,
    [appr_comments] NVARCHAR (MAX) NULL,
    [appr_lvl]      NVARCHAR (10)  NULL,
    [created_on]    DATETIME2 (0)  NULL,
    [appr_status]   NVARCHAR (2)   NULL,
    [type]          NVARCHAR (10)  NULL,
    [file1]         NVARCHAR (MAX) NULL,
    [appr_date]     DATETIME2 (0)  NULL,
    [file2]         NVARCHAR (MAX) NULL,
    [file3]         NVARCHAR (MAX) NULL,
    [file4]         NVARCHAR (MAX) NULL,
    [file5]         NVARCHAR (MAX) NULL
);


GO

