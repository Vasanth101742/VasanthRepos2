CREATE VIEW [dbo].[vw_Sales_data_US] AS
select Region,Company,Fin_year,Fin_month,
InvDate,ItemCode,ItemDesc,
sum(DelQty) DelQty,sum(Amount) Amount,
sum(Unitprice) Unitprice
from (
select Region,Company,
case when month(InvDate)<4 then year(InvDate)-1 else year(InvDate) end as Fin_year,
case when month(InvDate)<4 then month(InvDate)+9 else month(InvDate)-3 end as Fin_month,
InvDate,ItemCode,ItemDesc,DelQty,Amount,Unitprice
from (
SELECT CASE WHEN a.compnr IN (3110) THEN 'USA'
			WHEN a.compnr IN (2000) THEN 'Brazil'
			WHEN a.compnr in (1100,1700) then'Europe'
			END AS Region,a.compnr'Company',
       convert(date,CASE WHEN a.compnr IN (3110) THEN DATEADD(MINUTE, -29, DATEADD(HOUR, -9, c.idat2))
            WHEN a.compnr = 2000 THEN DATEADD(MINUTE, -29, DATEADD(HOUR, -8, c.idat2))
			WHEN a.compnr IN (1100,1700) Then dateadd(MINUTE ,-29,dateadd(hour,-3,c.idat2))
            END) AS InvDate,
	   REPLACE(a.item, ' ', '') AS ItemCode,b.dsca'ItemDesc',
	   a.dqua'DelQty',a.amti'Amount',
	   a.pric as Unitprice
FROM LN_cisli310 a
LEFT JOIN LN_cisli305 c 
ON c.idoc = a.idoc AND c.[tran] = a.[tran] AND c.compnr = a.compnr  AND c.deleted = 'N'
LEFT JOIN LN_tcibd001 b 
ON REPLACE(b.item, ' ', '') = REPLACE(a.item, ' ', '') AND b.deleted = 'N'
AND ((a.compnr = 2000 AND b.compnr = '2000') OR (a.compnr IN (1100,1700) AND b.compnr = 1100) OR
(a.compnr IN (3110) AND b.compnr = '3100'))

WHERE a.compnr IN (2000,3110,1100,1700) 
AND a.deleted = 'N'
AND ((a.compnr IN (3110) AND c.stat = '80') OR (a.compnr in  (1100,1700)  
and c.stat_kw='tcsli.stat.posted')
OR a.compnr = 2000)  
)a
--Data Validation
--where ltrim(rtrim(ItemCode))='000998078'
--and company='3110'
--and convert(date,InvDate) between '2025-01-01' and '2025-01-31'
)a
group by Region,Company,Fin_year,Fin_month,
InvDate,ItemCode,ItemDesc
--order by ItemCode,Fin_year,Fin_month

GO

