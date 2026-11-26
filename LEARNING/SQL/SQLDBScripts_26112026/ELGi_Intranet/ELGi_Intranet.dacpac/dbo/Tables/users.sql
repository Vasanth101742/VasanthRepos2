CREATE TABLE [dbo].[users] (
    [ent_code]    NVARCHAR (50)  NULL,
    [usr_id]      NVARCHAR (30)  NULL,
    [usr_pass]    NVARCHAR (175) NULL,
    [usr_mail]    NVARCHAR (MAX) NULL,
    [sms]         NVARCHAR (MAX) NULL,
    [login_type]  NVARCHAR (20)  NULL,
    [pr_grp]      NVARCHAR (MAX) NULL,
    [foc_type]    NVARCHAR (MAX) NULL,
    [foc_prgrp]   NVARCHAR (MAX) NULL,
    [locations]   NVARCHAR (MAX) NULL,
    [foc_escal]   INT            NULL,
    [foc_status]  INT            NULL,
    [usr_name]    NVARCHAR (MAX) NULL,
    [rca_status]  NVARCHAR (MAX) NULL,
    [rca_syst]    NVARCHAR (MAX) NULL,
    [log]         NVARCHAR (MAX) NULL,
    [expiry_date] DATETIME2 (0)  NULL,
    [total_count] INT            NULL,
    [status]      NVARCHAR (25)  NULL,
    [lastlogin]   DATETIME2 (0)  NULL,
    [disabled_on] DATETIME2 (0)  NULL
);


GO

