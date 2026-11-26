CREATE TABLE [dbo].[HR_Transfers] (
    [emp_code]        INT           NULL,
    [Emp_Name]        VARCHAR (255) NULL,
    [NewBand]         VARCHAR (255) NOT NULL,
    [New_Designation] VARCHAR (255) NULL,
    [New_Division]    VARCHAR (255) NOT NULL,
    [New_Function]    VARCHAR (255) NOT NULL,
    [New_Department]  VARCHAR (255) NOT NULL,
    [Old_Band]        VARCHAR (255) NULL,
    [Old_Designation] VARCHAR (255) NULL,
    [Old_Division]    VARCHAR (255) NULL,
    [Old_Function]    VARCHAR (255) NULL,
    [Old_Department]  VARCHAR (255) NULL,
    [Transfer_Date]   VARCHAR (255) NULL,
    [Data_Load_Date]  DATETIME      NULL,
    [ERANK]           BIGINT        NULL,
    [company]         INT           NULL
);


GO

