CREATE TABLE [dbo].[qms_rca_containment_action] (
    [rca_code]     NVARCHAR (10)   NULL,
    [slno]         DECIMAL (38)    NULL,
    [action_type]  NVARCHAR (20)   NULL,
    [action_taken] NVARCHAR (1000) NULL,
    [empcode1]     INT             NULL,
    [empcode2]     INT             NULL,
    [empcode3]     INT             NULL,
    [empcode4]     INT             NULL,
    [empcode5]     INT             NULL,
    [file]         NVARCHAR (MAX)  NULL,
    [user_id]      NVARCHAR (10)   NULL,
    [entry_date]   DATETIME2 (0)   NULL,
    [confirmed]    NVARCHAR (1)    NULL,
    [sno]          INT             NULL,
    [fail_mode]    NVARCHAR (100)  NULL
);


GO

