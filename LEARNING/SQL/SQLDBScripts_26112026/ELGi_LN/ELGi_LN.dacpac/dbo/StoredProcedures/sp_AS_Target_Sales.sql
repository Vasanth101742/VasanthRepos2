CREATE PROCEDURE [dbo].[sp_AS_Target_Sales]
(
    @Zone         VARCHAR(100),
    @MonthYear    nvarchar(250),
    @Sales_Plan    float
)
AS
BEGIN

    MERGE AS_Target_Sales AS Target

    USING
    (
        SELECT
            @Zone       AS Zone,
			@MonthYear as MonthYear,
            @Sales_Plan as Sales_Plan

    ) AS Source

    ON  Target.Zone      = Source.Zone
	AND Target.MonthYear = Source.MonthYear
    AND Target.Sales_Plan   = Source.Sales_Plan


    WHEN NOT MATCHED THEN
        INSERT
        (
            Zone,
            MonthYear,
            Sales_Plan
        )
        VALUES
        (
            @Zone,
            @MonthYear,
            @Sales_Plan
        );

END

GO

