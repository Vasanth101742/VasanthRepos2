CREATE TABLE [dbo].[DESPDETAILS] (
    [dl_code]          NVARCHAR (9)   NULL,
    [pr_grp]           SMALLINT       NULL,
    [cu_code]          NVARCHAR (9)   NULL,
    [tpl]              NVARCHAR (60)  NULL,
    [tpl_desc]         NVARCHAR (60)  NULL,
    [fabno]            NVARCHAR (50)  NULL,
    [desp_dt]          DATETIME       NULL,
    [dealer]           NVARCHAR (MAX) NULL,
    [war_code]         NVARCHAR (3)   NULL,
    [pr_model]         NVARCHAR (50)  NULL,
    [ar_code]          NVARCHAR (5)   NULL,
    [ar_desc]          NVARCHAR (30)  NULL,
    [value]            REAL           NULL,
    [trackno]          NVARCHAR (15)  NULL,
    [war_end]          DATETIME       NULL,
    [comm_date]        DATETIME       NULL,
    [end_cust]         NVARCHAR (100) NULL,
    [caller]           NVARCHAR (50)  NULL,
    [cu_ph]            NVARCHAR (50)  NULL,
    [cu_fax]           NVARCHAR (50)  NULL,
    [cu_mail]          NVARCHAR (MAX) NULL,
    [cu_add1]          NVARCHAR (MAX) NULL,
    [cu_add2]          NVARCHAR (MAX) NULL,
    [cu_city]          NVARCHAR (MAX) NULL,
    [cugrp_code]       NVARCHAR (MAX) NULL,
    [lob]              NVARCHAR (MAX) NULL,
    [company]          NVARCHAR (3)   NULL,
    [uptime_warranty]  NVARCHAR (3)   NULL,
    [distributor]      NVARCHAR (MAX) NULL,
    [distributor_city] NVARCHAR (MAX) NULL,
    [war_month]        INT            NULL
);


GO

