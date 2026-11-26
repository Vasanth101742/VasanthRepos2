CREATE TABLE [dbo].[crm] (
    [L1_EMPNAME]                 NVARCHAR (200) NULL,
    [L2_EMPNAME]                 NVARCHAR (200) NULL,
    [L3_EMPNAME]                 NVARCHAR (200) NULL,
    [L4_EMPNAME]                 NVARCHAR (200) NULL,
    [L5_EMPNAME]                 NVARCHAR (200) NULL,
    [L6_EMPNAME]                 NVARCHAR (200) NULL,
    [L7_EMPNAME]                 NVARCHAR (200) NULL,
    [elgi_customertypesalesname] NVARCHAR (255) NULL,
    [elgi_monthstartingdate]     DATE           NULL,
    [elgi_weeklyplannumbername]  NVARCHAR (100) NULL,
    [crmwkno]                    NVARCHAR (8)   NOT NULL,
    [plan]                       INT            NULL,
    [Actual]                     INT            NULL,
    [curDate]                    DATE           NULL,
    [prev_wkno]                  NVARCHAR (27)  NOT NULL
);


GO

