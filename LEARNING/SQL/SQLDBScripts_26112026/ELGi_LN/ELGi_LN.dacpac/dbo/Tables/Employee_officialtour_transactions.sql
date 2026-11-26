CREATE TABLE [dbo].[Employee_officialtour_transactions] (
    [emp_code]           INT           NULL,
    [application_no]     INT           NULL,
    [idate]              DATETIME      NULL,
    [session]            NVARCHAR (10) NULL,
    [days]               FLOAT (53)    NULL,
    [sanctioned_session] NVARCHAR (10) NULL,
    [sanctioned_days]    FLOAT (53)    NULL,
    [ecancelled]         NVARCHAR (10) NULL
);


GO

