CREATE TABLE [dbo].[pcr_invest_det] (
    [sno]           INT            NULL,
    [pcr_id]        NVARCHAR (30)  NULL,
    [invest_detail] NVARCHAR (MAX) NULL,
    [invest_value]  FLOAT (53)     NULL,
    [created_by]    INT            NULL,
    [created_at]    DATETIME2 (0)  NULL,
    [status]        INT            NULL
);


GO

