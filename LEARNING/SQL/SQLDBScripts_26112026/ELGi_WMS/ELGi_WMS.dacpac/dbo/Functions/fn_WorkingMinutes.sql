CREATE   FUNCTION [dbo].[fn_WorkingMinutes]
(
    @StartDate DATETIME,
    @EndDate   DATETIME
)
RETURNS INT
AS
BEGIN
    DECLARE @Minutes INT = 0;

    -- Return zero for non-positive ranges
    IF @EndDate <= @StartDate
        RETURN 0;

    DECLARE @Start DATETIME = @StartDate;
    DECLARE @End   DATETIME = @EndDate;

    -- Helpers to get datetime at 07:00 / 17:00 for a given datetime's date
    -- Pattern: DATEADD(DAY, DATEDIFF(DAY, 0, @d), CAST('07:00:00' AS DATETIME))
    -- which yields the same date as @d with the required time component.
    -------------------------------------------------------------------
    -- Move START forward to a valid working datetime
    -------------------------------------------------------------------
    -- If start falls on weekend → move to next working day at 07:00
    WHILE DATENAME(WEEKDAY, @Start) IN ('Saturday', 'Sunday')
    BEGIN
        SET @Start = DATEADD(DAY, 1, DATEADD(DAY, DATEDIFF(DAY, 0, @Start), CAST('07:00:00' AS DATETIME)));
    END

    -- If time after work hours -> move to next day 07:00
    IF CONVERT(TIME, @Start) >= '17:00:00'
        SET @Start = DATEADD(DAY, 1, DATEADD(DAY, DATEDIFF(DAY, 0, @Start), CAST('07:00:00' AS DATETIME)));

    -- If time before work hours -> set to same day 07:00
    IF CONVERT(TIME, @Start) < '07:00:00'
        SET @Start = DATEADD(DAY, 0, DATEADD(DAY, DATEDIFF(DAY, 0, @Start), CAST('07:00:00' AS DATETIME)));

    -------------------------------------------------------------------
    -- Move END backward to a valid working datetime
    -------------------------------------------------------------------
    -- If end falls on weekend -> move to previous working day at 17:00
    WHILE DATENAME(WEEKDAY, @End) IN ('Saturday', 'Sunday')
    BEGIN
        SET @End = DATEADD(DAY, -1, DATEADD(DAY, DATEDIFF(DAY, 0, @End), CAST('17:00:00' AS DATETIME)));
    END

    -- If time after work hours -> cap to same day 17:00
    IF CONVERT(TIME, @End) > '17:00:00'
        SET @End = DATEADD(DAY, 0, DATEADD(DAY, DATEDIFF(DAY, 0, @End), CAST('17:00:00' AS DATETIME)));

    -- If time before work hours -> cap to same day 07:00
    IF CONVERT(TIME, @End) < '07:00:00'
        SET @End = DATEADD(DAY, 0, DATEADD(DAY, DATEDIFF(DAY, 0, @End), CAST('07:00:00' AS DATETIME)));

    -- After adjustments it's possible End <= Start
    IF @End <= @Start
        RETURN 0;

    -------------------------------------------------------------------
    -- If both fall on the same working day, simple diff
    -------------------------------------------------------------------
    IF CONVERT(DATE, @Start) = CONVERT(DATE, @End)
    BEGIN
        SET @Minutes = DATEDIFF(MINUTE, @Start, @End);
        RETURN CASE WHEN @Minutes < 0 THEN 0 ELSE @Minutes END;
    END

    -------------------------------------------------------------------
    -- Multi-day calculation:
    -- 1) minutes remaining on start day (start -> 17:00)
    -- 2) full work-days in between (each = 9 * 60)
    -- 3) minutes on end day (07:00 -> end)
    -------------------------------------------------------------------

    -- 1) remaining minutes on start day
    SET @Minutes = DATEDIFF(
                        MINUTE,
                        @Start,
                        DATEADD(DAY, DATEDIFF(DAY, 0, @Start), CAST('17:00:00' AS DATETIME))
                   );

    -- 2) full working days between start and end
    DECLARE @CurDate DATE = DATEADD(DAY, 1, CONVERT(DATE, @Start));
    DECLARE @EndDateOnly DATE = CONVERT(DATE, @End);

    WHILE @CurDate < @EndDateOnly
    BEGIN
        IF DATENAME(WEEKDAY, @CurDate) NOT IN ('Saturday', 'Sunday')
            SET @Minutes = @Minutes + 9 * 60; -- 9 hours = 540 minutes

        SET @CurDate = DATEADD(DAY, 1, @CurDate);
    END

    -- 3) minutes on end day (07:00 -> @End)
    SET @Minutes = @Minutes + DATEDIFF(
                                    MINUTE,
                                    DATEADD(DAY, DATEDIFF(DAY, 0, @End), CAST('07:00:00' AS DATETIME)),
                                    @End
                                );

    RETURN @Minutes;
END;

GO

