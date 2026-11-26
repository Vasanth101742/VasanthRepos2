CREATE TABLE [dbo].[PublicHolidays] (
    [HolidayDate] DATE         NOT NULL,
    [Company]     VARCHAR (20) NOT NULL,
    CONSTRAINT [PK_PublicHolidays] PRIMARY KEY CLUSTERED ([HolidayDate] ASC, [Company] ASC)
);


GO

