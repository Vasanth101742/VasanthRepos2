CREATE TABLE [dbo].[qms_rca_deploymnet] (
    [rca_code]         NVARCHAR (10)   NULL,
    [slno]             DECIMAL (38)    NULL,
    [sno]              INT             NULL,
    [training_remarks] NVARCHAR (1500) NULL,
    [training_file]    NVARCHAR (MAX)  NULL,
    [auditing_remarks] NVARCHAR (1500) NULL,
    [auditing_file]    NVARCHAR (MAX)  NULL,
    [user_id]          NVARCHAR (10)   NULL,
    [entry_date]       DATETIME2 (0)   NULL,
    [confirmed]        NVARCHAR (1)    NULL,
    [fail_mode]        NVARCHAR (100)  NULL,
    [remarks]          NVARCHAR (1500) NULL
);


GO

