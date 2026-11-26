CREATE TABLE [dbo].[Airsolve_Tools] (
    [id]            BIGINT         NULL,
    [country_code]  NVARCHAR (150) NULL,
    [user_id]       INT            NULL,
    [module]        NVARCHAR (200) NULL,
    [product_group] NVARCHAR (100) NULL,
    [from_time]     DATETIME       NULL,
    [to_time]       DATETIME       NULL,
    [created_at]    DATETIME       NULL,
    [updated_at]    DATETIME       NULL
);


GO

