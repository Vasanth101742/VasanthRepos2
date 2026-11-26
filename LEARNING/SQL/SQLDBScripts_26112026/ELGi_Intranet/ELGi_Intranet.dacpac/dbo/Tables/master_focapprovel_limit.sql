CREATE TABLE [dbo].[master_focapprovel_limit] (
    [category]    NVARCHAR (50)  NULL,
    [start_limit] FLOAT (53)     NULL,
    [end_limit]   FLOAT (53)     NULL,
    [foc_type]    NVARCHAR (MAX) NULL,
    [region]      NVARCHAR (50)  NULL,
    [pr_grp]      NVARCHAR (MAX) NULL,
    [login_type]  NVARCHAR (50)  NULL,
    [app_level]   INT            NULL,
    [alias]       NVARCHAR (30)  NULL,
    [updated_on]  DATETIME2 (0)  NULL
);


GO

