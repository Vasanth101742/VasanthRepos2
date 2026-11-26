CREATE TABLE [dbo].[TEXPENSE] (
    [tr_no]        VARCHAR (20)    NULL,
    [empcode]      INT             NULL,
    [empname]      VARCHAR (50)    NULL,
    [reportid]     INT             NULL,
    [mgrName]      VARCHAR (30)    NULL,
    [appno]        INT             NULL,
    [tour_type]    VARCHAR (2)     NULL,
    [region]       VARCHAR (50)    NULL,
    [place]        VARCHAR (MAX)   NULL,
    [reason]       VARCHAR (MAX)   NULL,
    [from_date]    DATETIME        NULL,
    [todate]       DATETIME        NULL,
    [tot_days]     NUMERIC (10, 2) NULL,
    [currency]     VARCHAR (10)    NULL,
    [food_exp]     NUMERIC (16, 2) NULL,
    [travel_exp]   NUMERIC (16, 2) NULL,
    [hotel_exp]    NUMERIC (16, 2) NULL,
    [other_exp]    NUMERIC (16, 2) NULL,
    [Efood_exp]    FLOAT (53)      NULL,
    [Etravel_exp]  FLOAT (53)      NULL,
    [Ehotel_exp]   FLOAT (53)      NULL,
    [Eother_exp]   FLOAT (53)      NULL,
    [acc_close_dt] DATETIME        NULL,
    [curRate]      FLOAT (53)      NULL
);


GO

