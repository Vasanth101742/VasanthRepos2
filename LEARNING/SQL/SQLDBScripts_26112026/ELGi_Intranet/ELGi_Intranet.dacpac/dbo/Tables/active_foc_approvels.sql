CREATE TABLE [dbo].[active_foc_approvels] (
    [trackno]  NVARCHAR (15)  NULL,
    [firno]    NVARCHAR (15)  NULL,
    [focno]    NVARCHAR (15)  NULL,
    [date_app] DATETIME2 (0)  NULL,
    [pre_levl] BIGINT         NULL,
    [app_levl] BIGINT         NULL,
    [apprv_id] NVARCHAR (MAX) NULL,
    [app_comm] NVARCHAR (MAX) NULL,
    [apprv_ip] NVARCHAR (MAX) NULL,
    [desig]    NVARCHAR (50)  NULL
);


GO

