CREATE TABLE [dbo].[crm_service_videos_log] (
    [usr_name]         NVARCHAR (15)  NULL,
    [vname]            NVARCHAR (75)  NULL,
    [video_title]      NVARCHAR (175) NULL,
    [viewed_on]        DATETIME2 (0)  NULL,
    [product_group]    NVARCHAR (25)  NULL,
    [product_subgroup] NVARCHAR (25)  NULL,
    [source]           NVARCHAR (15)  NULL,
    [duration]         NVARCHAR (3)   NULL
);


GO

