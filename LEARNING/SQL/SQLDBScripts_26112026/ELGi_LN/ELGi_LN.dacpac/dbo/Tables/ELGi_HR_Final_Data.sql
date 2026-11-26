CREATE TABLE [dbo].[ELGi_HR_Final_Data] (
    [GLOBAL]           VARCHAR (13)   NOT NULL,
    [Emp_Name]         VARCHAR (255)  NULL,
    [OLD_BAAN_EMPCODE] FLOAT (53)     NULL,
    [EMP_CODE]         INT            NULL,
    [ERANK]            BIGINT         NULL,
    [Designation]      VARCHAR (255)  NULL,
    [Org_Unit]         VARCHAR (255)  NULL,
    [Division_Name]    NVARCHAR (510) NOT NULL,
    [Function_Name]    VARCHAR (255)  NOT NULL,
    [Department]       VARCHAR (255)  NOT NULL,
    [Band]             VARCHAR (255)  NOT NULL,
    [Location]         NVARCHAR (510) NULL,
    [Emp_Status]       VARCHAR (255)  NULL,
    [Reason]           VARCHAR (255)  NULL,
    [Seperation_Date]  DATETIME       NULL,
    [Transfer_Date]    VARCHAR (255)  NULL,
    [Start_Date]       DATETIME       NULL,
    [Data_Load_Date]   DATETIME       NULL,
    [num]              INT            NULL,
    [FinMonthNo]       INT            NULL,
    [FinMonthName]     NVARCHAR (510) NULL,
    [FinYear]          INT            NULL,
    [Fin_Year]         VARCHAR (510)  NULL,
    [company]          INT            NULL
);


GO

