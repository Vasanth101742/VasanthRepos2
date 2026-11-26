CREATE TABLE [dbo].[Employee_onduty_request] (
    [emp_code]              INT            NULL,
    [application_no]        INT            NULL,
    [divn_code]             NVARCHAR (5)   NULL,
    [func_code]             NVARCHAR (5)   NULL,
    [dept_code]             NVARCHAR (5)   NULL,
    [ucode]                 INT            NULL,
    [shift_code]            NVARCHAR (10)  NULL,
    [from_date]             DATETIME       NULL,
    [to_date]               DATETIME       NULL,
    [from_time]             NVARCHAR (10)  NULL,
    [to_time]               NVARCHAR (10)  NULL,
    [actto_time]            NVARCHAR (10)  NULL,
    [opening_breakups]      INT            NULL,
    [current_breakups]      INT            NULL,
    [place]                 NVARCHAR (MAX) NULL,
    [reason]                NVARCHAR (MAX) NULL,
    [sanctioning_authority] NVARCHAR (20)  NULL,
    [approver_code]         INT            NULL,
    [approved]              NVARCHAR (10)  NULL,
    [user_closed]           NVARCHAR (10)  NULL,
    [comments]              NVARCHAR (MAX) NULL,
    [sanctioned_date]       DATETIME       NULL,
    [last_modified]         DATETIME       NULL,
    [applied_date]          DATETIME       NULL
);


GO

