CREATE TABLE [dbo].[elgi_hr_tmp] (
    [GLOBAL]           VARCHAR (13)   NOT NULL,
    [company]          INT            NULL,
    [Emp_Name]         NVARCHAR (255) NULL,
    [OLD_BAAN_EMPCODE] INT            NULL,
    [EMP_CODE]         INT            NULL,
    [ERANK]            BIGINT         NULL,
    [Designation]      NVARCHAR (255) NULL,
    [Org_Unit]         VARCHAR (255)  NULL,
    [Division_Name]    NVARCHAR (255) NOT NULL,
    [Function_Name]    NVARCHAR (255) NOT NULL,
    [Department]       NVARCHAR (255) NOT NULL,
    [Band]             NVARCHAR (255) NULL,
    [Location]         NVARCHAR (255) NULL,
    [Emp_Status]       NVARCHAR (255) NULL,
    [Reason]           VARCHAR (255)  NULL,
    [Seperation_Date]  DATETIME       NULL,
    [Transfer_Date]    VARCHAR (255)  NULL,
    [Start_Date]       DATE           NULL,
    [Data_Load_Date]   DATETIME       NULL,
    [num]              INT            NULL,
    [FinMonthNo]       INT            NULL,
    [FinMonthName]     NVARCHAR (510) NULL,
    [FinYear]          INT            NULL,
    [Fin_Year]         VARCHAR (510)  NULL,
    [Vertical_ordr]    INT            NULL,
    [vertical]         VARCHAR (50)   NULL,
    [Function2]        VARCHAR (50)   NULL,
    [Function2_ordr]   INT            NULL
);


GO

