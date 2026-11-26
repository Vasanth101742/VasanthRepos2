CREATE TABLE [dbo].[PFC_details] (
    [emp_code]    INT             NULL,
    [entry_date]  DATETIME        NULL,
    [pgcode]      NVARCHAR (2)    NULL,
    [region]      NVARCHAR (10)   NULL,
    [tplcode]     NVARCHAR (16)   NULL,
    [curyear]     SMALLINT        NULL,
    [curmonth]    SMALLINT        NULL,
    [fmyear]      SMALLINT        NULL,
    [fmmonth]     SMALLINT        NULL,
    [fmqty]       SMALLINT        NULL,
    [fmmrp]       SMALLINT        NULL,
    [t2year]      SMALLINT        NULL,
    [t2month]     SMALLINT        NULL,
    [t2mkt]       SMALLINT        NULL,
    [t2mrp]       SMALLINT        NULL,
    [t1year]      SMALLINT        NULL,
    [t1month]     SMALLINT        NULL,
    [t1mkt]       SMALLINT        NULL,
    [t1mrp]       SMALLINT        NULL,
    [mrp_ecode]   NUMERIC (28, 6) NULL,
    [mrp_edate]   DATETIME        NULL,
    [baan_pgcode] SMALLINT        NULL
);


GO

