CREATE TABLE [dbo].[travel_local] (
    [emp_code]     INT             NULL,
    [reqno]        INT             NULL,
    [onduty_reqno] INT             NULL,
    [onduty_date]  DATETIME        NULL,
    [total_kms]    FLOAT (53)      NULL,
    [total_hrs]    VARCHAR (10)    NULL,
    [food_exp]     FLOAT (53)      NOT NULL,
    [tra_exp]      NUMERIC (16, 4) NOT NULL,
    [status]       VARCHAR (10)    NULL,
    [to_place]     VARCHAR (MAX)   NULL,
    [purpose]      VARCHAR (MAX)   NULL
);


GO

