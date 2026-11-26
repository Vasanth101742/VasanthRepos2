CREATE TABLE [dbo].[CDOC_crd_attribs] (
    [tpl]              NVARCHAR (16)  NULL,
    [tpl_desc]         NVARCHAR (40)  NULL,
    [prod_group]       NVARCHAR (16)  NULL,
    [country]          NVARCHAR (16)  NULL,
    [voltage]          NVARCHAR (25)  NULL,
    [phase]            NVARCHAR (12)  NULL,
    [prod_segment]     NVARCHAR (50)  NULL,
    [prod_series]      NVARCHAR (50)  NULL,
    [cooling_type]     NVARCHAR (15)  NULL,
    [feature_variant]  NVARCHAR (30)  NULL,
    [model_variant]    NVARCHAR (20)  NULL,
    [power_variant]    NVARCHAR (10)  NULL,
    [pressure_variant] NVARCHAR (10)  NULL,
    [lube_type]        NVARCHAR (20)  NULL,
    [mount_type]       NVARCHAR (25)  NULL,
    [drive_type]       NVARCHAR (20)  NULL,
    [cfm]              NVARCHAR (127) NULL,
    [cfm_uom]          NVARCHAR (5)   NULL,
    [power]            NVARCHAR (127) NULL,
    [power_uom]        NVARCHAR (6)   NULL,
    [mkt_seg]          NVARCHAR (10)  NULL,
    [loco_seg]         NVARCHAR (30)  NULL,
    [tpl_rev]          NVARCHAR (6)   NULL,
    [pressures]        NVARCHAR (127) NULL,
    [pr_uom]           NVARCHAR (6)   NULL,
    [efdate]           DATETIME       NULL
);


GO

