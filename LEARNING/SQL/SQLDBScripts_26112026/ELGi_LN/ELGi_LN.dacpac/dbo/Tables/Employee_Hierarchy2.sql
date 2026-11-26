CREATE TABLE [dbo].[Employee_Hierarchy2] (
    [employeeid]             INT            NULL,
    [fullname]               NVARCHAR (200) NULL,
    [level]                  INT            NULL,
    [internalemailaddress]   NVARCHAR (100) NULL,
    [parentsystemuserid]     NVARCHAR (100) NULL,
    [systemuserid]           NVARCHAR (100) NULL,
    [p_employeeid]           INT            NULL,
    [p_fullname]             NVARCHAR (200) NULL,
    [p_level]                INT            NULL,
    [p_internalemailaddress] NVARCHAR (100) NULL
);


GO

