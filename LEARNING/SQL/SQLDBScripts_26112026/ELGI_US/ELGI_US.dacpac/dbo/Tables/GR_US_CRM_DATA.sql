CREATE TABLE [dbo].[GR_US_CRM_DATA] (
    [sdname]              NVARCHAR (128) NULL,
    [customerName]        NVARCHAR (128) NULL,
    [UnitModel]           NVARCHAR (255) NULL,
    [commissioned_date]   DATE           NULL,
    [UnitName]            NVARCHAR (255) NULL,
    [cur_warranty_status] NVARCHAR (255) NULL,
    [work_description]    NVARCHAR (MAX) NULL,
    [UnitId]              INT            NULL,
    [SubmittedDate]       DATETIME       NULL
);


GO

