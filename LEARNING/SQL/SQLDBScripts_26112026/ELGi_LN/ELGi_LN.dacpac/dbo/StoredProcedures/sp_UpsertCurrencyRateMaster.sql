CREATE PROCEDURE [dbo].[sp_UpsertCurrencyRateMaster]
(
    @Company         VARCHAR(100),
    @UpdatedDate     DATE,
    @FromCurrency    VARCHAR(20),
    @ToCurrency      VARCHAR(20),
    @CurrencyRate    float,
    @ValidFromDate   DATE,
    @ValidToDate     DATE
)
AS
BEGIN

    MERGE CurrencyRateMaster AS Target

    USING
    (
        SELECT
            @Company       AS Company,
			@UpdatedDate as UpdatedDate,
            @FromCurrency  AS FromCurrency,
            @ToCurrency    AS ToCurrency,
			@CurrencyRate as CurrencyRate,
			@ValidFromDate as ValidFromDate,
			@ValidToDate as ValidToDate

    ) AS Source

    ON  Target.Company      = Source.Company
	and convert(date,Target.UpdatedDate)=convert(date,Source.UpdatedDate)
	AND Target.FromCurrency = Source.FromCurrency
    AND Target.ToCurrency   = Source.ToCurrency
	AND Target.CurrencyRate= Source.CurrencyRate
	AND Target.ValidFromDate= Source.ValidFromDate
	AND Target.ValidToDate= Source.ValidToDate

    WHEN NOT MATCHED THEN
        INSERT
        (
            Company,
            UpdatedDate,
            FromCurrency,
            ToCurrency,
            CurrencyRate,
            ValidFromDate,
            ValidToDate
        )
        VALUES
        (
            @Company,
            @UpdatedDate,
            @FromCurrency,
            @ToCurrency,
            @CurrencyRate,
            @ValidFromDate,
            @ValidToDate
        );

END

GO

