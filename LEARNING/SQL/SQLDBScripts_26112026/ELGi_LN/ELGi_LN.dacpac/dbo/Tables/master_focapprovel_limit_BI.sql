CREATE TABLE [dbo].[master_focapprovel_limit_BI] (
    [category]    NVARCHAR (50)  NULL,
    [start_limit] FLOAT (53)     NULL,
    [end_limit]   FLOAT (53)     NULL,
    [region]      NVARCHAR (50)  NULL,
    [login_type]  NVARCHAR (50)  NULL,
    [app_level]   INT            NULL,
    [alias]       NVARCHAR (30)  NULL,
    [foc_type]    VARCHAR (8000) NULL,
    [pr_grp]      VARCHAR (8000) NULL
);


GO

