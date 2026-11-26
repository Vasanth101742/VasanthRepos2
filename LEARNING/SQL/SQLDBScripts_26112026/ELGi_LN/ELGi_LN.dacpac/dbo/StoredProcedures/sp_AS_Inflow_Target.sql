Create PROCEDURE [dbo].[sp_AS_Inflow_Target]
(
            @WeekName nvarchar(250),
            @FromDate date,
            @ToDate date,
			@MonthYear nvarchar(250),
			@Region  nvarchar(250),
			@Plan float,
			@BdgTot float
)
AS
BEGIN

    MERGE AS_Inflow_Target AS Target

    USING
    (
        SELECT
            @WeekName as WeekName,
            @FromDate as fromdate,
            @ToDate as todate,
			@MonthYear as MonthYear,
			@Region as region,
			@Plan as [plan],
			@BdgTot as bdgtot
    ) AS Source

    ON  Target.WeekName      = Source.WeekName
	AND Target.FromDate = Source.FromDate
    AND Target.ToDate   = Source.ToDate
	and target.monthyear=source.monthyear
	and target.region=source.region 
	and target.[plan]=source.[plan]
	and target.bdgtot=source.bdgtot


    WHEN NOT MATCHED THEN
        INSERT
        (
      [WeekName]
      ,[FromDate]
      ,[ToDate]
      ,[MonthYear]
      ,[Region]
      ,[Plan]
      ,[BdgTot]
        )
        VALUES
        (
            @WeekName,
            @FromDate,
            @ToDate,
			@MonthYear,
			@Region,
			@Plan,
			@BdgTot
        );

END

GO

