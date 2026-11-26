CREATE TABLE [dbo].[CompanyCalendar] (
    [CalendarDate] DATE         NOT NULL,
    [Company]      VARCHAR (20) NOT NULL,
    [IsWorkingDay] BIT          NOT NULL,
    [WorkingDayNo] INT          NULL,
    CONSTRAINT [PK_CompanyCalendar] PRIMARY KEY CLUSTERED ([CalendarDate] ASC, [Company] ASC)
);


GO

