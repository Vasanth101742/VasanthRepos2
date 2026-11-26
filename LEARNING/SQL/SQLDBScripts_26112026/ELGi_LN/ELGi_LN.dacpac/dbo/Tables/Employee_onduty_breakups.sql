CREATE TABLE [dbo].[Employee_onduty_breakups] (
    [emp_code]       INT           NULL,
    [application_no] INT           NULL,
    [shift_code]     NVARCHAR (10) NULL,
    [idate]          DATETIME      NULL,
    [from_time]      NVARCHAR (10) NULL,
    [to_time]        NVARCHAR (10) NULL,
    [actto_time]     NVARCHAR (10) NULL,
    [ecancelled]     NVARCHAR (10) NULL
);


GO

