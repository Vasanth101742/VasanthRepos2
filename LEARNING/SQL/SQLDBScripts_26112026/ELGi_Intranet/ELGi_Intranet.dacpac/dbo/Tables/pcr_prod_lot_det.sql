CREATE TABLE [dbo].[pcr_prod_lot_det] (
    [sno]           INT             NULL,
    [pcr_id]        NVARCHAR (30)   NULL,
    [trial_date]    DATETIME2 (0)   NULL,
    [fab_no]        NVARCHAR (20)   NULL,
    [model]         NVARCHAR (50)   NULL,
    [created_by]    INT             NULL,
    [created_at]    DATETIME2 (0)   NULL,
    [status]        INT             NULL,
    [item]          NVARCHAR (50)   NULL,
    [pcr_status]    NVARCHAR (5)    NULL,
    [serialno]      NVARCHAR (1000) NULL,
    [specification] NVARCHAR (MAX)  NULL,
    [actual]        NVARCHAR (MAX)  NULL
);


GO

