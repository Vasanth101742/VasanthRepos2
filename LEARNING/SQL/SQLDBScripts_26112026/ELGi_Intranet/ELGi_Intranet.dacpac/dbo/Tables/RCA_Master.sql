CREATE TABLE [dbo].[RCA_Master] (
    [pgroup]            NVARCHAR (50)  NULL,
    [pgcode]            NVARCHAR (2)   NULL,
    [subsystem]         NVARCHAR (30)  NULL,
    [subsyscode]        NVARCHAR (2)   NULL,
    [assy_part]         NVARCHAR (100) NULL,
    [part_code]         NVARCHAR (3)   NULL,
    [prob_desc]         NVARCHAR (100) NULL,
    [fmcode]            NVARCHAR (3)   NULL,
    [rca_code]          NVARCHAR (13)  NULL,
    [revno]             NVARCHAR (2)   NULL,
    [ryg_status]        NVARCHAR (3)   NULL,
    [bo_cat]            NVARCHAR (20)  NULL,
    [project_leader]    DECIMAL (38)   NULL,
    [imp_date]          DATETIME2 (0)  NULL,
    [wrty_months]       SMALLINT       NULL,
    [updated_date]      DATETIME2 (0)  NULL,
    [product]           NVARCHAR (50)  NULL,
    [critical_category] NVARCHAR (20)  NULL,
    [usr_id]            NVARCHAR (20)  NULL,
    [level]             SMALLINT       NULL,
    [rodate]            DATETIME2 (0)  NULL,
    [roby]              NVARCHAR (20)  NULL,
    [roryg]             NVARCHAR (1)   NULL,
    [new_impdt]         DATETIME2 (0)  NULL,
    [ptype]             NVARCHAR (1)   NULL,
    [created_on]        DATETIME2 (0)  NULL
);


GO

