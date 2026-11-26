CREATE TABLE [dbo].[employee_hierarchy2_CRM] (
    [employeeid]             NVARCHAR (100) NULL,
    [fullname]               NVARCHAR (200) NULL,
    [level]                  INT            NULL,
    [internalemailaddress]   NVARCHAR (100) NULL,
    [parentsystemuserid]     NVARCHAR (100) NULL,
    [systemuserid]           NVARCHAR (100) NULL,
    [p_employeeid]           NVARCHAR (100) NULL,
    [p_fullname]             NVARCHAR (200) NULL,
    [p_level]                INT            NULL,
    [p_internalemailaddress] NVARCHAR (100) NULL
);


GO

