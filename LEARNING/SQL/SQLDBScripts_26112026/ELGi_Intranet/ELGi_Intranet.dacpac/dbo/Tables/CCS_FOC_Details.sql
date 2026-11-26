CREATE TABLE [dbo].[CCS_FOC_Details] (
    [focno]             NVARCHAR (15)   NULL,
    [FOCType_Descr]     NVARCHAR (100)  NULL,
    [FocDate]           VARCHAR (50)    NULL,
    [ccstrackno]        NVARCHAR (15)   NULL,
    [fabno]             NVARCHAR (100)  NULL,
    [item_code]         NVARCHAR (MAX)  NULL,
    [item_desc]         NVARCHAR (MAX)  NULL,
    [foc_status]        INT             NULL,
    [FOC_Category]      VARCHAR (20)    NULL,
    [TrackCreationDate] DATE            NULL,
    [pr_model]          NVARCHAR (4000) NULL,
    [symptoms]          NVARCHAR (MAX)  NULL,
    [problem]           NVARCHAR (MAX)  NULL,
    [symptom_descr]     NVARCHAR (1000) NULL,
    [engr_com]          NVARCHAR (MAX)  NULL,
    [escl_com]          NVARCHAR (MAX)  NULL,
    [comm_date]         DATETIME        NULL,
    [firno]             NVARCHAR (100)  NULL,
    [FinalApprovalDate] DATE            NULL
);


GO

