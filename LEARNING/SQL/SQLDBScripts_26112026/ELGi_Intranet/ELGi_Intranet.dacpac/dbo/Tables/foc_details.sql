CREATE TABLE [dbo].[foc_details] (
    [foc_classification] NVARCHAR (6)   NULL,
    [firno]              NVARCHAR (15)  NULL,
    [ccstrackno]         NVARCHAR (15)  NULL,
    [focno]              NVARCHAR (15)  NULL,
    [fabno]              NVARCHAR (100) NULL,
    [oem_name]           NVARCHAR (100) NULL,
    [foc_desc]           NVARCHAR (100) NULL,
    [pr_model]           NVARCHAR (100) NULL,
    [pr_type]            NVARCHAR (100) NULL,
    [item_code]          NVARCHAR (MAX) NULL,
    [cate_desc]          NVARCHAR (100) NULL,
    [item_price]         FLOAT (53)     NULL,
    [total_value]        FLOAT (53)     NULL,
    [item_req]           INT            NULL,
    [comm_date]          VARCHAR (100)  NULL,
    [sale_date]          VARCHAR (100)  NULL
);


GO

