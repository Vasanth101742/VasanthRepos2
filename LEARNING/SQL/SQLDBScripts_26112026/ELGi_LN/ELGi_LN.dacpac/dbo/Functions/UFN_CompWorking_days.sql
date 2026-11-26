

CREATE FUNCTION [dbo].[UFN_CompWorking_days]
(
    @addDate DATETIME,
    @numdays INT
)
RETURNS DATETIME
AS
BEGIN

    DECLARE @WorkDayNo INT;
    DECLARE @ResultDate DATE;

    SELECT @WorkDayNo = WorkDayNo
    FROM VW_CompanyWorkingCalendar
    WHERE WorkDate =
    (
        SELECT MAX(WorkDate)
        FROM VW_CompanyWorkingCalendar
        WHERE WorkDate <= @addDate
    );

    SELECT @ResultDate = WorkDate
    FROM VW_CompanyWorkingCalendar
    WHERE WorkDayNo = @WorkDayNo + @numdays;

    RETURN @ResultDate;

END

--    -- Add working days
--    IF @numdays > 0
--    BEGIN
--        WHILE @numdays > 0
--        BEGIN
--            SET @addDate = DATEADD(DAY, 1, @addDate);

--            -- Keep moving until a company working day is found
--            WHILE NOT EXISTS
--            (
--                SELECT 1
--                FROM TTCCCP020400
--                WHERE ccal = 'Company'
--                  AND dfca = 1
--                  AND CONVERT(DATE, [date]) = CONVERT(DATE, @addDate)
--            )
--            BEGIN
--                SET @addDate = DATEADD(DAY, 1, @addDate);
--            END;

--            SET @numdays = @numdays - 1;
--        END
--    END

--    -- Subtract working days
--    ELSE IF @numdays < 0
--    BEGIN
--        WHILE @numdays < 0
--        BEGIN
--            SET @addDate = DATEADD(DAY, -1, @addDate);

--            -- Keep moving until a company working day is found
--            WHILE NOT EXISTS
--            (
--                SELECT 1
--                FROM TTCCCP020400
--                WHERE ccal = 'Company'
--                  AND dfca = 1
--                  AND CONVERT(DATE, [date]) = CONVERT(DATE, @addDate)
--            )
--            BEGIN
--                SET @addDate = DATEADD(DAY, -1, @addDate);
--            END;

--            SET @numdays = @numdays + 1;
--        END
--    END;

--    RETURN CAST(@addDate AS DATETIME);
--END

GO

