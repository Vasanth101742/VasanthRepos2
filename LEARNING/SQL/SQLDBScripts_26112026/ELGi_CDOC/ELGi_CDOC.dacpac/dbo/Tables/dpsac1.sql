CREATE TABLE [dbo].[dpsac1] (
    [tpl]              NVARCHAR (16) NULL,
    [tpl_desc]         NVARCHAR (40) NULL,
    [prod_group]       NVARCHAR (16) NULL,
    [country]          NVARCHAR (30) NULL,
    [prod_segment]     NVARCHAR (50) NULL,
    [prod_series]      NVARCHAR (50) NULL,
    [model_variant]    NVARCHAR (20) NULL,
    [max_wp]           DECIMAL (38)  NULL,
    [max_wp_uom]       NVARCHAR (8)  NULL,
    [duty_cycle]       NVARCHAR (25) NULL,
    [mount_type]       NVARCHAR (25) NULL,
    [engine_make]      NVARCHAR (25) NULL,
    [engine_model]     NVARCHAR (25) NULL,
    [engine_power]     DECIMAL (38)  NULL,
    [engine_power_uom] NVARCHAR (8)  NULL,
    [fad]              DECIMAL (38)  NULL,
    [fad_uom]          NVARCHAR (8)  NULL,
    [tpl_rev]          NVARCHAR (6)  NULL,
    [efdate]           DATETIME2 (0) NULL,
    [exp_date]         DATETIME2 (0) NULL
);


GO

