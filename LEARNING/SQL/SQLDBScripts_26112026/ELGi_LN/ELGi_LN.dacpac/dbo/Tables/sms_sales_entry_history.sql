CREATE TABLE [dbo].[sms_sales_entry_history] (
    [region]            NVARCHAR (10)   NULL,
    [entry_date]        DATETIME        NULL,
    [curr1]             NVARCHAR (3)    NULL,
    [curr2]             NVARCHAR (3)    NULL,
    [curr1_ftmbudget]   NUMERIC (28, 6) NULL,
    [curr2_ftmbudget]   NUMERIC (28, 6) NULL,
    [curr1_ftmactual]   NUMERIC (28, 6) NULL,
    [curr2_ftmactual]   NUMERIC (28, 6) NULL,
    [curr1_ftmyractual] NUMERIC (28, 6) NULL,
    [curr2_ftmyractual] NUMERIC (28, 6) NULL,
    [curr1_ytdbudget]   NUMERIC (28, 6) NULL,
    [curr2_ytdbudget]   NUMERIC (28, 6) NULL,
    [curr1_ytdactual]   NUMERIC (28, 6) NULL,
    [curr2_ytdactual]   NUMERIC (28, 6) NULL,
    [curr1_ytdyractual] NUMERIC (28, 6) NULL,
    [curr2_ytdyractual] NUMERIC (28, 6) NULL,
    [emp_code]          INT             NULL,
    [yyyy]              INT             NULL,
    [month]             NVARCHAR (3)    NULL
);


GO

