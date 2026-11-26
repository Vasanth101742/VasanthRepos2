CREATE TABLE [dbo].[conveyance_details] (
    [emp_code]           INT             NULL,
    [reqno]              INT             NULL,
    [onduty_reqno]       INT             NULL,
    [onduty_date]        DATETIME        NULL,
    [from_place]         NVARCHAR (MAX)  NULL,
    [to_place]           NVARCHAR (MAX)  NULL,
    [purpose]            NVARCHAR (MAX)  NULL,
    [transport]          VARCHAR (25)    NULL,
    [vehicle]            VARCHAR (20)    NULL,
    [total_kms]          FLOAT (53)      NULL,
    [total_hrs]          VARCHAR (10)    NULL,
    [total_conveyance_a] NUMERIC (16, 4) NULL,
    [confirm]            VARCHAR (1)     NULL,
    [status]             VARCHAR (10)    NULL,
    [added_on]           DATETIME        NULL,
    [approved_date]      DATETIME        NULL,
    [approved_amount]    FLOAT (53)      NULL,
    [sessionid]          VARCHAR (45)    NULL
);


GO

