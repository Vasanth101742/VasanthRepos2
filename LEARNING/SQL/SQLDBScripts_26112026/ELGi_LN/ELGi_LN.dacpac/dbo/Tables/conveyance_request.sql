CREATE TABLE [dbo].[conveyance_request] (
    [emp_code]        INT          NULL,
    [reqno]           INT          NULL,
    [onduty_reqno]    INT          NULL,
    [divn_code]       VARCHAR (6)  NULL,
    [func_code]       VARCHAR (6)  NULL,
    [dept_code]       VARCHAR (6)  NULL,
    [approver_code]   INT          NULL,
    [status]          VARCHAR (10) NULL,
    [applied_date]    DATETIME     NULL,
    [sanctioned_date] DATETIME     NULL,
    [application_no]  INT          NULL,
    [paid]            VARCHAR (5)  NULL
);


GO

