CREATE TABLE [dbo].[CCS_Calls] (
    [slno]             INT             NULL,
    [cu_name]          NVARCHAR (400)  NULL,
    [ent_code]         NVARCHAR (200)  NULL,
    [Branch]           NVARCHAR (100)  NULL,
    [Region]           NVARCHAR (100)  NULL,
    [loggedby]         NVARCHAR (200)  NULL,
    [loggedbyName]     NVARCHAR (200)  NULL,
    [pr_model]         NVARCHAR (4000) NULL,
    [trackno]          NVARCHAR (200)  NULL,
    [dt_time]          DATETIME        NULL,
    [FinYear]          INT             NULL,
    [FinMonth]         INT             NULL,
    [fabno]            NVARCHAR (400)  NULL,
    [hr_mtr_reading]   INT             NULL,
    [symptoms]         NVARCHAR (MAX)  NULL,
    [problem]          NVARCHAR (MAX)  NULL,
    [CallCategory]     NVARCHAR (50)   NULL,
    [CallStatus]       VARCHAR (6)     NOT NULL,
    [CloseDate]        DATETIME        NULL,
    [Ageing1]          INT             NULL,
    [Actual_StartDate] DATETIME        NULL,
    [Actual_CloseDate] DATETIME        NULL,
    [Ageing2]          INT             NULL,
    [engr_com]         NVARCHAR (MAX)  NULL,
    [escl_com]         NVARCHAR (MAX)  NULL,
    [comm_date]        DATE            NULL,
    [Problem_Desc]     NVARCHAR (MAX)  NULL,
    [Fix]              NVARCHAR (MAX)  NULL,
    [sym_desc]         NVARCHAR (MAX)  NULL,
    [fix_desc]         NVARCHAR (MAX)  NULL,
    [PartClaim]        VARCHAR (50)    NULL,
    [ServiceClaim]     VARCHAR (50)    NULL
);


GO

