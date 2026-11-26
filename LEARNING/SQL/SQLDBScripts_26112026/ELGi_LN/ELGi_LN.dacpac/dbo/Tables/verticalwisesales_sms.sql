CREATE TABLE [dbo].[verticalwisesales_sms] (
    [Sdate]           DATE            NULL,
    [Vertical_Name]   VARCHAR (25)    NULL,
    [Shortname]       VARCHAR (7)     NULL,
    [Dval]            NUMERIC (15, 2) NULL,
    [Mval]            NUMERIC (15, 2) NULL,
    [Yval]            NUMERIC (15, 2) NULL,
    [ordr]            INT             NULL,
    [smstype]         INT             NULL,
    [OndateInflow]    NUMERIC (9, 2)  NULL,
    [ThisMonthInflow] NUMERIC (9, 2)  NULL
);


GO

