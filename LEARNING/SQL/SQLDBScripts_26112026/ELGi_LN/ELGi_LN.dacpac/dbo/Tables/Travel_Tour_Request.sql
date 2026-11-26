CREATE TABLE [dbo].[Travel_Tour_Request] (
    [emp_code]              INT            NULL,
    [application_no]        INT            NULL,
    [divn_code]             NVARCHAR (5)   NULL,
    [func_code]             NVARCHAR (5)   NULL,
    [dept_code]             NVARCHAR (5)   NULL,
    [ucode]                 INT            NULL,
    [tour_type]             NVARCHAR (20)  NULL,
    [from_date]             DATETIME       NULL,
    [from_session]          NVARCHAR (10)  NULL,
    [to_date]               DATETIME       NULL,
    [to_session]            NVARCHAR (10)  NULL,
    [actto_date]            DATETIME       NULL,
    [actto_session]         NVARCHAR (10)  NULL,
    [total_days]            FLOAT (53)     NULL,
    [sanctioned_days]       FLOAT (53)     NULL,
    [place]                 NVARCHAR (MAX) NULL,
    [reason]                NVARCHAR (MAX) NULL,
    [contact_add]           NVARCHAR (MAX) NULL,
    [contact_phno]          NVARCHAR (25)  NULL,
    [sanctioning_authority] NVARCHAR (20)  NULL,
    [approver_code]         INT            NULL,
    [approver_name]         NVARCHAR (50)  NULL,
    [approved]              NVARCHAR (10)  NULL,
    [user_closed]           NVARCHAR (10)  NULL,
    [comments]              NVARCHAR (MAX) NULL,
    [sanctioned_date]       DATETIME       NULL,
    [last_modified]         DATETIME       NULL,
    [applied_date]          DATETIME       NULL
);


GO

