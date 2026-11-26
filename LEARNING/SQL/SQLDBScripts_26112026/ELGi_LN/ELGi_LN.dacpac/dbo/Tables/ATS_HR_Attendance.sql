CREATE TABLE [dbo].[ATS_HR_Attendance] (
    [SNo]               FLOAT (53)     NULL,
    [Department]        NVARCHAR (255) NULL,
    [PermissibleLimit]  FLOAT (53)     NULL,
    [LastYearThisMonth] FLOAT (53)     NULL,
    [ThisMonth]         FLOAT (53)     NULL,
    [DataLoadDate]      DATE           NULL,
    [Data_Load_Date]    DATETIME       NULL,
    [num]               INT            NULL,
    [FinMonthNo]        INT            NULL,
    [FinMonthName]      NVARCHAR (30)  NULL,
    [FinYear]           INT            NULL,
    [Fin_Year]          VARCHAR (61)   NULL
);


GO

