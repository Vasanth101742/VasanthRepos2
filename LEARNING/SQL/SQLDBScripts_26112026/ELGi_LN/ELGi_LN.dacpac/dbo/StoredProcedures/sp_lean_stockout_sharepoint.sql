CREATE Procedure [dbo].[sp_lean_stockout_sharepoint]
As
Begin 

Select a.CurrentDate'Date',a.Company,a.Department,a.SUPERMARKET'Super Market',a.Final_vari'Varriant',a.SOPS_DESC'Procurment Type'
,a.ITEM'ItemCode',a.Description,a.NAMA'Supplier',
a.empname'Buyer',Sum(a.StockIN)'Trigger within due',Sum(a.StockOut)'Trigger overdue',
Case When Sum(a.StockOut) >= 1 Then 'Stock Out' Else 'Within Due Date'	End as Remarks
--,'' as Reasons,'' 'Occurance in Month','' 'OTMA Failure', '' 'Remarks 1'

from (

Select *,

Case When Ageing Between 1 and 5 Then 2
When Ageing Between 6 and 10 Then 3
When Ageing Between 11 and 15 Then 4
When Ageing Between 16 and 20 Then 5
When Ageing > 20 Then 6
When Ageing LIKE '-%' Then 1
When Ageing = 0 Then 1 End as Ageing_Order,

Case When Ageing Between 1 and 5 Then '1 - 5 days'
When Ageing Between 6 and 10 Then '6 - 10 days'
When Ageing Between 11 and 15 Then '11 - 15 days'
When Ageing Between 16 and 20 Then '16 - 20 days'
When Ageing > 20 Then 'Greater than 21days'
When Ageing LIKE '-%' Then 'Within Due'
When Ageing = 0 Then 'Within Due' End as Ageing_Slab,

Case When (vari = ' ' OR vari IS NULL) and SUPP = 'SU1E99998' Then 'Airend'
When (vari = ' ' OR vari IS NULL) and SUPP = 'SU1E00451' Then 'PVD'
When (vari = ' ' OR vari IS NULL) and SUPP = 'SRE000003' Then 'Motor'
--When (vari = ' ' OR vari IS NULL) and SUPP NOT IN ('SU1E99998','SU1E00451','SRE000003')  Then SUPERMARKET
else VARI End as Final_vari,Case when [Trigger Due] = 'Trigger within due' Then 1 Else 0 End as StockIN,
Case when [Trigger Due] = 'Stock Out' Then 1 Else 0 End as StockOut,0 as Target

from (

select Distinct a.*,b.VARI,b.CATG,b.SCAT,PLMT,
case when Convert(date,a.DUDT) >= Convert(date,GETDATE()) Then 'Trigger within due' Else 'Stock Out' End as 'Trigger Due',
CASE 
    WHEN CAST(GETDATE() AS DATE) <= CAST(a.DUDT AS DATE) THEN
        -(
            DATEDIFF(DAY, CAST(GETDATE() AS DATE), CAST(a.DUDT AS DATE))
            - (DATEDIFF(WEEK, CAST(GETDATE() AS DATE), CAST(a.DUDT AS DATE)) * 2)
            - CASE 
                WHEN DATEPART(WEEKDAY, CAST(GETDATE() AS DATE)) = 7 THEN 1
                ELSE 0
              END
            - CASE 
                WHEN DATEPART(WEEKDAY, CAST(a.DUDT AS DATE)) = 1 THEN 1
                ELSE 0
              END
        )
    ELSE
        (
            DATEDIFF(DAY, CAST(a.DUDT AS DATE), CAST(GETDATE() AS DATE))
            - (DATEDIFF(WEEK, CAST(a.DUDT AS DATE), CAST(GETDATE() AS DATE)) * 2)
            - CASE 
                WHEN DATEPART(WEEKDAY, CAST(a.DUDT AS DATE)) = 7 THEN 1
                ELSE 0
              END
            - CASE 
                WHEN DATEPART(WEEKDAY, CAST(GETDATE() AS DATE)) = 1 THEN 1
                ELSE 0
              END
        )
END AS Ageing,CONVERT(Date,EntryDate)'CurrentDate'
from Lean_Stock_Out_History a
LEFT JOIN [TZZINV310ALL] b on TRIM(a.Item) = TRIM(b.ITEM) and a.company = '401'
where CONVERT(Date,EntryDate) IN (Select Distinct CONVERT(Date,WorkDate) from VW_CompanyWorkingCalendar)
--TRIM(a.ITEM) in ('X990684')
--and a.BUYR in (@buyer)
--AND a.trig_dt <=@AS_OF_DATE
--and a.company in (@Company)
)a
)a
Where a.company <> 600 
and (a.Final_vari NOT IN ('PVD-CONSUMABLES','PACKING & CONS') or a.Final_vari is null) 
AND a.CurrentDate =
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM VW_CompanyWorkingCalendar
            WHERE CONVERT(DATE, WorkDate) = CONVERT(DATE, GETDATE() - 1)
        )
        THEN CONVERT(DATE, GETDATE() - 1)
        ELSE (
            SELECT MAX(Convert(date,EntryDate))
            FROM Lean_Stock_Out_History
			Where Convert(date,EntryDate) IN (Select Distinct CONVERT(Date,WorkDate) from VW_CompanyWorkingCalendar)
        )
    END
Group BY a.CurrentDate,a.company,a.DEPARTMENT,a.SUPERMARKET,a.Final_vari,a.SOPS_DESC,a.ITEM,a.Description,a.NAMA,a.empname


End

GO

