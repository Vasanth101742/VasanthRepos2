CREATE TABLE [dbo].[conveyance_foodexpense] (
    [emp_code]             INT           NULL,
    [reqno]                INT           NULL,
    [onduty_reqno]         INT           NULL,
    [onduty_date]          DATETIME      NULL,
    [breakfast]            FLOAT (53)    NULL,
    [lunch]                FLOAT (53)    NULL,
    [dinner]               FLOAT (53)    NULL,
    [total_conveyance_b]   FLOAT (53)    NULL,
    [confirm]              NVARCHAR (1)  NULL,
    [status]               NVARCHAR (15) NULL,
    [added_on]             DATETIME      NULL,
    [approved_date]        DATETIME      NULL,
    [approved_amount]      FLOAT (53)    NULL,
    [sessionid]            NVARCHAR (45) NULL,
    [tea]                  FLOAT (53)    NULL,
    [app_breakfast_amount] FLOAT (53)    NULL,
    [app_lunch_amount]     FLOAT (53)    NULL,
    [app_dinner_amount]    FLOAT (53)    NULL
);


GO

