--exec sp_usage_metrics

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_usage_metrics
AS
BEGIN
	
WITH UsageMetrics AS
 
(
 
    SELECT
         ItemPath,
         COUNT(*) AS ExecutionCount,
         COUNT(DISTINCT UserName) AS UniqueUsers,
         MAX(TimeStart) AS LastExecutedDate,
        SUM(CASE 
            WHEN Status = 'rsSuccess' THEN 1
            ELSE 0
         END) AS SuccessfulExecutions,
        SUM(CASE
             WHEN Status <> 'rsSuccess' THEN 1
             ELSE 0
         END) AS FailedExecutions,
        CAST(AVG( 
            CAST(DATEDIFF(SECOND, TimeStart, TimeEnd)
                  AS BIGINT)
         ) AS DECIMAL(10,2)) AS AvgExecutionSeconds
    FROM dbo.ExecutionLog3
    WHERE ItemPath IS NOT NULL
 
    GROUP BY ItemPath
 
)
 
SELECT
    C.ItemID,
    C.Path AS ReportPath,
    C.Name AS ReportName,
    COALESCE(U.ExecutionCount, 0) AS ExecutionCount,
    COALESCE(U.UniqueUsers, 0) AS UniqueUsers,
    U.LastExecutedDate,
    COALESCE(U.SuccessfulExecutions, 0) AS SuccessfulExecutions,
    COALESCE(U.FailedExecutions, 0) AS FailedExecutions,
    U.AvgExecutionSeconds,
    CASE
        WHEN U.ItemPath IS NULL
            THEN 'No Matching Execution Logs'
        ELSE 'Has Execution Logs'
    END AS UsageStatus,
 
	case 
		when convert(date,LastExecutedDate) >= convert(date,getdate()-5) 
			then 'High Utilization'
		when convert(date,LastExecutedDate) between convert(date,getdate()-30) 
		and convert(date,getdate()-6) then 'Medium Utilization' --within 1 month
		
		else 'Low utilization' end 'UtilizationMetrics'
 

FROM dbo.Catalog C
LEFT JOIN UsageMetrics U
    ON C.Path = U.ItemPath
WHERE C.Type = 2
ORDER BY 
    COALESCE(U.ExecutionCount, 0) DESC,
    C.Path

END

GO

