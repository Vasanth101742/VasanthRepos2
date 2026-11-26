CREATE TABLE [dbo].[closed_fir] (
    [date_time]        DATETIME2 (0)  NULL,
    [ccstrackno]       NVARCHAR (15)  NULL,
    [cu_name]          NVARCHAR (MAX) NULL,
    [firno]            NVARCHAR (15)  NULL,
    [pr_type]          NVARCHAR (10)  NULL,
    [pr_model]         NVARCHAR (100) NULL,
    [fabno]            NVARCHAR (100) NULL,
    [sale_date]        DATETIME2 (0)  NULL,
    [comm_date]        DATETIME2 (0)  NULL,
    [clock_hr]         INT            NULL,
    [working_hr]       INT            NULL,
    [failure_nature]   NVARCHAR (MAX) NULL,
    [field_inference]  NVARCHAR (MAX) NULL,
    [foc_status]       NVARCHAR (100) NULL,
    [escl_stat]        INT            NULL,
    [elaps_time]       BIGINT         NULL,
    [foc_time]         DATETIME2 (0)  NULL,
    [load_unload]      NVARCHAR (15)  NULL,
    [servc_code]       NVARCHAR (20)  NULL,
    [servc_repno]      NVARCHAR (50)  NULL,
    [ent_code]         NVARCHAR (20)  NULL,
    [application]      NVARCHAR (MAX) NULL,
    [failed_qty]       INT            NULL,
    [awareness_prd]    NVARCHAR (10)  NULL,
    [install_guide]    NVARCHAR (10)  NULL,
    [practices_follow] NVARCHAR (10)  NULL,
    [genuine_spares]   NVARCHAR (10)  NULL,
    [other_info]       NVARCHAR (MAX) NULL,
    [prepared_by]      NVARCHAR (50)  NULL,
    [loggedby]         NVARCHAR (MAX) NULL,
    [actpr_grp]        NVARCHAR (25)  NULL
);


GO

