CREATE TABLE [dbo].[Employee_leave_master] (
    [emp_code]              INT            NULL,
    [divn_code]             NVARCHAR (10)  NULL,
    [func_code]             NVARCHAR (10)  NULL,
    [dept_code]             NVARCHAR (10)  NULL,
    [application_no]        INT            NULL,
    [total_days]            FLOAT (53)     NULL,
    [from_date]             DATETIME       NULL,
    [to_date]               DATETIME       NULL,
    [from_session]          NVARCHAR (2)   NULL,
    [to_session]            NVARCHAR (2)   NULL,
    [sanctioned_days]       FLOAT (53)     NULL,
    [leave_type]            NVARCHAR (50)  NULL,
    [leave_reason]          NVARCHAR (200) NULL,
    [sanctioning_authority] NVARCHAR (20)  NULL,
    [approver_name]         NVARCHAR (50)  NULL,
    [approver_email]        NVARCHAR (50)  NULL,
    [approved]              NVARCHAR (10)  NULL,
    [rejected_reason]       NVARCHAR (200) NULL,
    [sanctioned_date]       DATETIME       NULL,
    [applied_date]          DATETIME       NULL,
    [availedcldays]         FLOAT (53)     NULL,
    [availedpldays]         FLOAT (53)     NULL,
    [availedcoldays]        FLOAT (53)     NULL,
    [lossofpay]             FLOAT (53)     NULL,
    [availedspldays]        FLOAT (53)     NULL,
    [availedmldays]         FLOAT (53)     NULL,
    [ucode]                 INT            NULL,
    [availedskldays]        FLOAT (53)     NULL,
    [approver_code]         INT            NULL,
    [availed_spl_days]      FLOAT (53)     NULL,
    [shift_code]            NVARCHAR (10)  NULL
);


GO

