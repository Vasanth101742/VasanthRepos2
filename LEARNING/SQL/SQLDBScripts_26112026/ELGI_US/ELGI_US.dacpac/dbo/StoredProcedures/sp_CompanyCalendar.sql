
CREATE  proc sp_CompanyCalendar as 

Truncate table sp_CompanyCalendar


DECLARE @StartDate DATE = '2020-01-01';
DECLARE @EndDate   DATE = '2035-12-31';

;WITH Dates AS
(
    SELECT @StartDate AS CalendarDate

    UNION ALL

    SELECT DATEADD(DAY, 1, CalendarDate)
    FROM Dates
    WHERE CalendarDate < @EndDate
),
Companies AS
(
    SELECT 'USA' AS Company
    UNION ALL
    SELECT 'Europe'
)
INSERT INTO dbo.CompanyCalendar
(
    CalendarDate,
    Company,
    IsWorkingDay  ---0 -Leave, 1 -Working day
 
)
SELECT
    d.CalendarDate,
    c.Company,

    CASE
        WHEN DATENAME(WEEKDAY, d.CalendarDate)
             IN ('Saturday','Sunday')
            THEN 0

        WHEN h.HolidayDate IS NOT NULL
            THEN 0

        ELSE 1
    END AS IsWorkingDay

FROM Dates d

CROSS JOIN Companies c

LEFT JOIN dbo.PublicHolidays h
    ON h.HolidayDate = d.CalendarDate
    AND h.Company = c.Company

OPTION (MAXRECURSION 0);


------Update Workingday no 

;WITH CTE AS
(
    SELECT
        CalendarDate,
        Company,

        ROW_NUMBER() OVER
        (
            PARTITION BY Company
            ORDER BY CalendarDate
        ) AS WorkingDayNo

    FROM dbo.CompanyCalendar
    WHERE IsWorkingDay = 1
)
UPDATE C
SET C.WorkingDayNo = CTE.WorkingDayNo
FROM dbo.CompanyCalendar C
INNER JOIN CTE
    ON C.CalendarDate = CTE.CalendarDate
    AND C.Company = CTE.Company

GO

