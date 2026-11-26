CREATE TABLE [dbo].[conveyance_status] (
    [emp_code]     INT           NULL,
    [reqno]        INT           NULL,
    [onduty_reqno] INT           NULL,
    [appr_code]    INT           NULL,
    [level]        INT           NULL,
    [due]          VARCHAR (2)   NULL,
    [status]       VARCHAR (15)  NULL,
    [comments]     VARCHAR (250) NULL,
    [appr_date]    DATETIME      NULL
);


GO

