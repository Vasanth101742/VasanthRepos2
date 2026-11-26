CREATE TABLE [dbo].[CurrencyRateMaster_bkup02092026] (
    [Company]       FLOAT (53)       NULL,
    [UpdatedDate]   DATETIME         NULL,
    [FromCurrency]  NVARCHAR (6)     NULL,
    [ToCurrency]    NVARCHAR (6)     NULL,
    [CurrencyRate]  NUMERIC (30, 20) NULL,
    [ValidFromDate] DATE             NULL,
    [ValidToDate]   DATE             NULL
);


GO

