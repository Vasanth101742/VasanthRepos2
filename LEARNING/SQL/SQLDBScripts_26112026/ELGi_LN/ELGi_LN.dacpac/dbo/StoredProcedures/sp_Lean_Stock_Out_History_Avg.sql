-- =============================================
-- Author:		<Author,,Raviprasath>
-- Create date: 13/10/2025
-- Description:	<Lean_Stock_Out_History_Avg,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Lean_Stock_Out_History_Avg]
	-- Add the parameters for the stored procedure here

AS
BEGIN

IF GETDATE() < DATEADD(HOUR, 16, CAST(CAST(GETDATE() AS DATE) AS DATETIME))
BEGIN

    -- On the first day of the month:
    -- Delete all previous month's daily records
    -- except the last day of the previous month

    IF DAY(GETDATE()) = 1
    BEGIN

        DELETE FROM Lean_Stock_Out_History_Avg
        WHERE EntryDate < DATEFROMPARTS(
                                YEAR(GETDATE()),
                                MONTH(GETDATE()),
                                1
                            )
          AND EntryDate <> EOMONTH(GETDATE(), -1);

    END


    -- Remove today's records if already inserted
    DELETE FROM Lean_Stock_Out_History_Avg
    WHERE CurrentMonth = FORMAT(GETDATE(), 'MMM-yyyy')
      AND CONVERT(DATE,EntryDate) = CONVERT(DATE, GETDATE());


    -- Insert today's data
    INSERT INTO Lean_Stock_Out_History_Avg
    SELECT
        Distinct empname AS Buyer,
        company,
        0 AS Average,
        FORMAT(GETDATE(), 'MMM-yyyy') AS CurrentMonth,
        CONVERT(DATE, EntryDate) AS EntryDate,
        COUNT(DISTINCT ITEM) AS Item_Count
    FROM Lean_Stock_Out_History
    WHERE CONVERT(DATE, EntryDate) = CONVERT(DATE, GETDATE())
    GROUP BY
        CONVERT(DATE, EntryDate),
        empname,
        company;

END

END

GO

