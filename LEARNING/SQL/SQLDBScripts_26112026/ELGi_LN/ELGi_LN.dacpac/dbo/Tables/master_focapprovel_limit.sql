CREATE TABLE [dbo].[master_focapprovel_limit] (
    [category]    NVARCHAR (50)  NULL,
    [start_limit] FLOAT (53)     NULL,
    [end_limit]   FLOAT (53)     NULL,
    [foc_type]    NVARCHAR (127) NULL,
    [region]      NVARCHAR (50)  NULL,
    [pr_grp]      NVARCHAR (127) NULL,
    [login_type]  NVARCHAR (50)  NULL,
    [app_level]   INT            NULL,
    [alias]       NVARCHAR (30)  NULL
);


GO

