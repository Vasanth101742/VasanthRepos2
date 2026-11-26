CREATE VIEW dbo.VW_CompanyWorkingCalendar
AS
SELECT
    CAST([date] AS DATE) AS WorkDate,
    ROW_NUMBER() OVER
    (
        ORDER BY CAST([date] AS DATE)
    ) AS WorkDayNo
FROM TTCCCP020400
WHERE ccal = 'Company'
  AND dfca = 1;

GO

