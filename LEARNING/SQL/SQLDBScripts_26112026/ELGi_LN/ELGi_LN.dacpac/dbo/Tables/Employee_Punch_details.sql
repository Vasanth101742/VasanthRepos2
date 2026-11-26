CREATE TABLE [dbo].[Employee_Punch_details] (
    [attendance_date]  VARCHAR (50)  NULL,
    [emp_code]         INT           NULL,
    [shift_code]       VARCHAR (10)  NULL,
    [in1]              VARCHAR (10)  NULL,
    [out1]             VARCHAR (10)  NULL,
    [in2]              VARCHAR (10)  NULL,
    [out2]             VARCHAR (10)  NULL,
    [in3]              VARCHAR (10)  NULL,
    [out3]             VARCHAR (10)  NULL,
    [in4]              VARCHAR (50)  NULL,
    [out4]             VARCHAR (10)  NULL,
    [details]          VARCHAR (50)  NULL,
    [new_emp_code]     INT           NULL,
    [InTime]           DATETIME      NULL,
    [OutTime]          DATETIME      NULL,
    [Hrs]              VARCHAR (5)   NULL,
    [Mins]             VARCHAR (5)   NULL,
    [Gender]           VARCHAR (50)  NULL,
    [EmpName]          VARCHAR (100) NULL,
    [NewEmpCode]       INT           NULL,
    [Band]             VARCHAR (50)  NULL,
    [ucode]            INT           NULL,
    [uname]            VARCHAR (100) NULL,
    [AttendDate]       DATE          NULL,
    [AttendStatus]     VARCHAR (20)  NULL,
    [AttendStatusOrdr] INT           NULL
);


GO

