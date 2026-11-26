CREATE TABLE [dbo].[pcr_standarddoc_master] (
    [doc_id]         NVARCHAR (20)  NULL,
    [pcr_id]         NVARCHAR (30)  NULL,
    [doc_name]       NVARCHAR (MAX) NULL,
    [update_req]     NVARCHAR (5)   NULL,
    [file_attach]    NVARCHAR (MAX) NULL,
    [revised_doc_no] NVARCHAR (200) NULL,
    [created_by]     INT            NULL,
    [created_at]     DATETIME2 (0)  NULL,
    [status]         INT            NULL,
    [add_attach]     NVARCHAR (MAX) NULL
);


GO

