CREATE TABLE [dbo].[pcr_approvals_master] (
    [verfiy_type]   NVARCHAR (30) NULL,
    [approver_code] INT           NULL,
    [status]        INT           NULL,
    [created_by]    INT           NULL,
    [created_at]    DATETIME2 (0) NULL,
    [sno]           INT           NULL,
    [plant]         NVARCHAR (20) NULL,
    [function]      NVARCHAR (20) NULL
);


GO

