--exec Orderbook_OpeningOB


CREATE procedure [dbo].[Orderbook_OpeningOB] as
begin 

DECLARE @Today DATE = GETDATE()

--DECLARE @Today DATE = '20260403'
DECLARE @StartOfMonth DATE = DATEFROMPARTS(YEAR(@Today), MONTH(@Today), 1) --always the day -1 start of the month
--DECLARE @DataDate DATE = DATEADD(DAY, -1, @Today)

delete from  OpeningOB where MonthYear = @StartOfMonth

-- Only run on Month Start Snapshot Day
--IF DAY(@Today) <> 1
--BEGIN
--    -- Delete current month data
--    DELETE FROM OpeningOB
--    WHERE MonthYear = @StartOfMonth

--    -- Insert fresh snapshot
--    INSERT INTO OpeningOB (Region, MonthYear, OpeningOB)
--    SELECT 
--        Company_name,
--        @StartOfMonth,
--        SUM(sales)
--    FROM vw_Orderbook_PendOrder
--    GROUP BY Company_name
--END

IF DAY(@Today) = 1
BEGIN
    -- Delete current month data
    --DELETE FROM OpeningOB
    --WHERE MonthYear = @StartOfMonth

    -- Insert fresh snapshot
    INSERT INTO OpeningOB (Region, MonthYear, OpeningOB,ProductGroup,ItemCategory)
    SELECT 
        Company_name,
        @StartOfMonth,
        SUM(sales),Product_group,Item_Category
    FROM vw_Orderbook_PendOrder
    GROUP BY Company_name,Product_group,Item_Category

END



end


--declare @warehouse nvarchar(50)='657'


--select top 10 * from vw_Orderbook_PendOrder

GO

