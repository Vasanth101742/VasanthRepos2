CREATE FUNCTION [dbo].[fn_WorkingHours]
(
    @StartDate DATETIME,
    @EndDate   DATETIME
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Minutes INT;

    SET @Minutes = dbo.fn_WorkingMinutes(@StartDate, @EndDate);

    -- Convert minutes to hours
    RETURN CAST(@Minutes AS DECIMAL(10,2)) / 60.0;
END;

GO

