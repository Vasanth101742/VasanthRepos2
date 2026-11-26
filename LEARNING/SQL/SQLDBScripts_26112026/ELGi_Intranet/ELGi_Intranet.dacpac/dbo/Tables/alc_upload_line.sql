CREATE TABLE [dbo].[alc_upload_line] (
    [rev_no]          DECIMAL (38)    NULL,
    [month]           NVARCHAR (5)    NULL,
    [year]            DECIMAL (38)    NULL,
    [item_code]       NVARCHAR (20)   NULL,
    [item_desc]       NVARCHAR (100)  NULL,
    [sub_cat]         NVARCHAR (50)   NULL,
    [variant]         NVARCHAR (50)   NULL,
    [monthly_max_dem] NVARCHAR (20)   NULL,
    [max_cap]         NVARCHAR (20)   NULL,
    [fg_one_bin]      NVARCHAR (20)   NULL,
    [no_slot]         NVARCHAR (20)   NULL,
    [plan_mdl]        NVARCHAR (30)   NULL,
    [oltdays]         NVARCHAR (20)   NULL,
    [remarks]         NVARCHAR (1000) NULL,
    [slno]            DECIMAL (38)    NULL
);


GO

