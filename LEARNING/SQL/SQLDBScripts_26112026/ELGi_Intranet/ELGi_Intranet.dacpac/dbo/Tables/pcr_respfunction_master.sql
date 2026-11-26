CREATE TABLE [dbo].[pcr_respfunction_master] (
    [resp_id]     NVARCHAR (10)  NULL,
    [resp_name]   NVARCHAR (100) NULL,
    [created_at]  DATETIME2 (0)  NULL,
    [created_by]  INT            NULL,
    [status]      INT            NULL,
    [resp_person] INT            NULL,
    [sno]         INT            NULL,
    [function]    NVARCHAR (10)  NULL,
    [plant]       NVARCHAR (20)  NULL
);


GO

