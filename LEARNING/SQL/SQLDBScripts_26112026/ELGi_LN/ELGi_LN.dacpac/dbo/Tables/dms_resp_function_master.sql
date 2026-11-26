CREATE TABLE [dbo].[dms_resp_function_master] (
    [resp_id]          NVARCHAR (10) NULL,
    [resp_name]        NVARCHAR (50) NULL,
    [created_at]       DATETIME      NULL,
    [created_by]       INT           NULL,
    [status]           INT           NULL,
    [resp_person]      INT           NULL,
    [sno]              INT           NULL,
    [productline]      NVARCHAR (10) NULL,
    [inwardloc]        NVARCHAR (20) NULL,
    [productline_name] NVARCHAR (20) NULL
);


GO

