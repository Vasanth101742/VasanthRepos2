CREATE TABLE [dbo].[cheqreq_elgi_sauer_billdetails] (
    [reqno]      INT            NULL,
    [emp_code]   INT            NULL,
    [divn_code]  NVARCHAR (2)   NULL,
    [func_code]  NVARCHAR (2)   NULL,
    [dept_code]  NVARCHAR (2)   NULL,
    [order_no]   INT            NULL,
    [sno]        INT            NULL,
    [billno]     NVARCHAR (70)  NULL,
    [bill_date]  DATETIME2 (0)  NULL,
    [grin_no]    INT            NULL,
    [grin_date]  DATETIME2 (0)  NULL,
    [ibno]       NVARCHAR (10)  NULL,
    [ib_date]    DATETIME2 (0)  NULL,
    [amount]     FLOAT (53)     NULL,
    [total]      FLOAT (53)     NULL,
    [emp_name]   NVARCHAR (100) NULL,
    [orderval]   FLOAT (53)     NULL,
    [ordercur]   NVARCHAR (4)   NULL,
    [session_id] NVARCHAR (50)  NULL,
    [confirm]    NVARCHAR (1)   NULL
);


GO

