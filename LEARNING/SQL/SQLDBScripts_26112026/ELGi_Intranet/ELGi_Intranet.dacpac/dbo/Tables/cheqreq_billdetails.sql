CREATE TABLE [dbo].[cheqreq_billdetails] (
    [reqno]      INT            NULL,
    [emp_code]   INT            NULL,
    [divn_code]  NVARCHAR (2)   NULL,
    [func_code]  NVARCHAR (2)   NULL,
    [dept_code]  NVARCHAR (2)   NULL,
    [order_no]   NVARCHAR (25)  NULL,
    [sno]        INT            NULL,
    [billno]     NVARCHAR (70)  NULL,
    [bill_date]  NVARCHAR (25)  NULL,
    [grin_no]    NVARCHAR (25)  NULL,
    [grin_date]  NVARCHAR (25)  NULL,
    [ibno]       NVARCHAR (25)  NULL,
    [ib_date]    NVARCHAR (25)  NULL,
    [amount]     FLOAT (53)     NULL,
    [total]      NVARCHAR (25)  NULL,
    [emp_name]   NVARCHAR (100) NULL,
    [orderval]   FLOAT (53)     NULL,
    [ordercur]   NVARCHAR (4)   NULL,
    [session_id] NVARCHAR (50)  NULL,
    [confirm]    NVARCHAR (1)   NULL
);


GO

