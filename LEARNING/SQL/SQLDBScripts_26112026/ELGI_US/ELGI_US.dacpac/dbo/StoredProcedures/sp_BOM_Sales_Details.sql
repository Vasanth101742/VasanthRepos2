
--exec sp_BOM_Sales_Details
CREATE proc [dbo].[sp_BOM_Sales_Details] as 
begin

Truncate Table BOM_Sales_Details_Temp1
Truncate Table BOM_Sales_Details

--Alter Table BOM_Sales_Details add ccur nvarchar(10)
--Alter Table BOM_Sales_Details add amth_1 float

Insert into BOM_Sales_Details_Temp1(Region,compnr,InvDate,idat2,[tran],idoc,orno,pono,Rnk1,
ItemCode,ItemDesc,dqua,amti,pric,sitm,qibm,ccur,amth_1)
--select * into BOM_Sales_Details_Temp1 from (
SELECT CASE WHEN a.compnr IN (3110) THEN 'USA'
WHEN a.compnr IN (2000) THEN 'Brazil'
WHEN a.compnr in (1100,1700) then'Europe'
END AS Region,a.compnr,
--Method 1:
convert(date,CASE WHEN a.compnr IN (3110) THEN DATEADD(MINUTE, -29, DATEADD(HOUR, -9, a.idat2))
WHEN a.compnr = 2000 THEN DATEADD(MINUTE, -29, DATEADD(HOUR, -8, a.idat2))
WHEN a.compnr IN (1100,1700) Then dateadd(MINUTE ,-29,dateadd(hour,-3,a.idat2))
END) AS InvDate ,
--Method 2:
--convert(date,CASE WHEN a.compnr IN (3110) THEN DATEADD(MINUTE, -29, DATEADD(HOUR, -9, a.idat))
--WHEN a.compnr = 2000 THEN DATEADD(MINUTE, -29, DATEADD(HOUR, -8, a.idat))
--WHEN a.compnr IN (1100,1700) Then dateadd(MINUTE ,-29,dateadd(hour,-3,a.idat))
--END) AS InvDate ,
a.idat2,a.[tran],a.idoc,a.orno,a.pono,
Row_number() over(partition by a.compnr,a.orno,a.pono,a.item order by a.compnr,a.orno,a.pono,a.item) as Rnk1,
REPLACE(a.item, ' ', '') AS ItemCode,a.dsca as ItemDesc,
a.dqua,a.amti,a.pric,b.sitm,b.qibm,
a.ccur,a.amth_1
from 
(select a.compnr,c.idat,c.idat2,a.[tran],a.idoc,a.orno,a.pono,
a.item,b.dsca,a.dqua,a.pric,a.amti ,c.ccur,a.amth_1
FROM LN_cisli310 a

LEFT JOIN LN_cisli305 c 
ON c.idoc = a.idoc AND c.[tran] = a.[tran] AND c.compnr = a.compnr  AND c.deleted = 'N'

LEFT JOIN LN_tcibd001 b 
ON REPLACE(b.item, ' ', '') = REPLACE(a.item, ' ', '') 
AND b.deleted = 'N'
AND ((a.compnr = 2000 AND b.compnr = '2000') OR (a.compnr IN (1100,1700) AND b.compnr = 1100) OR
(a.compnr IN (3110) AND b.compnr = '3100'))

WHERE a.compnr IN (2000,3110,1100,1700) AND a.deleted = 'N'
AND ((a.compnr IN (3110) AND c.stat = '80') OR (a.compnr in  (1100,1700)  
and c.stat_kw='tcsli.stat.posted')
OR a.compnr = 2000)
and a.koor<>61
and a.srtp not in ('70','120','43','64')
--and a.[tran]<>'ZCR'
--and a.amti>0 Commented on 03-10-2025
)a
left outer join (select compnr,orno,pono,sitm,qibm from LN_TDSLS403
where deleted='N')b
--on a.compnr=b.compnr --Old method not workout for Europe
on ((a.compnr = 2000 AND b.compnr = '2000') OR (a.compnr IN (1100,1700) AND b.compnr = 1100) OR
(a.compnr IN (3110) AND b.compnr = 3110))
and a.orno=b.orno
and a.pono=b.pono
--where replace(a.item,' ','')='B005700730003'
--where ltrim(rtrim(item))='012521021-KIT' --Child Item list missing 
--and a.idat2='2024-08-30'
--where b.sitm is not null
--and ltrim(rtrim(a.item))='012400595-KIT'
--and a.orno='IND004493'
--)a



delete from BOM_Sales_Details_Temp1 where ltrim(rtrim(ItemCode))=''

update BOM_Sales_Details_Temp1 set FinYear=Year(InvDate)-1 where Month(InvDate)<4
update BOM_Sales_Details_Temp1 set FinYear=Year(InvDate) where Month(InvDate)>=4

update BOM_Sales_Details_Temp1 set FinMonth=Month(InvDate)+9 where Month(InvDate)<4
update BOM_Sales_Details_Temp1 set FinMonth=Month(InvDate)-3 where Month(InvDate)>=4

--Alter Table BOM_Sales_Details_Temp1 add FinYear varchar(25)
--Alter Table BOM_Sales_Details_Temp1 add FinMonth varchar(25)

--select * from BOM_Sales_Details_Temp1 
--where orno='IND009145'
--sitm='         B009800780015' and ItemCode='012400594-KIT'

--Alter Table BOM_Sales_Details add UnitPrice float

Insert into BOM_Sales_Details(Region,compnr,FinYear,FinMonth,InvDate,ItemCode,
ItemDesc,sitm,SalesItemCode,SalesItemDesc,ccur,SalesQty,SalesAmnt,--UnitPrice
amth_1
)
--select * into BOM_Sales_Details from (
Select Region,compnr,FinYear,FinMonth,
InvDate,
--idat2,
ItemCode,ItemDesc,sitm,
ItemCode as SalesItemCode,ItemDesc as SalesItemDesc,
ccur,
sum(dqua) as SalesQty,
sum(amti) as SalesAmnt,
sum(amth_1) as amth_1
--,avg(pric) UnitPrice
from BOM_Sales_Details_Temp1
where sitm is null
--and ItemCode='012521021-KIT'
--and InvDate='2024-01-04'
group by Region,compnr,FinYear,FinMonth,
InvDate,
--idat2,
ItemCode,ItemDesc,sitm,ccur
union
Select Region,compnr,FinYear,FinMonth,
InvDate,
--idat2,
ItemCode,ItemDesc,sitm,
sitm as SalesItemCode,null as SalesItemDesc,
null as ccur,
sum(dqua*qibm) qibm,null as amti ,
null as amth_1
--,avg(pric) UnitPrice
from BOM_Sales_Details_Temp1
where sitm is not null
--and ItemCode='012521021-KIT'
group by Region,compnr,FinYear,FinMonth,
InvDate,
--idat2,
ItemCode,ItemDesc,sitm,ccur
--order by ItemCode,Rnk1
--)a

Insert into BOM_Sales_Details(Region,compnr,FinYear,FinMonth,InvDate,ItemCode,
ItemDesc,SalesItemCode,SalesItemDesc,ccur,SalesQty,SalesAmnt,amth_1,UnitPrice)
Select Region,compnr,FinYear,FinMonth,
InvDate,
--idat2,
ItemCode,ItemDesc,
ItemCode as SalesItemCode,ItemDesc as SalesItemDesc,
ccur,
null as qty,sum(amti) as amti,
sum(amth_1) as amth_1,
avg(pric) UnitPrice
from BOM_Sales_Details_Temp1
where sitm is not null
and Rnk1=1
--and itemcode='012521021-KIT'
--and itemcode='012474249-KIT' --for Testing
group by Region,compnr,FinYear,FinMonth,
InvDate,
--idat2,
ItemCode,ItemDesc,ccur
having sum(amti)>0

update BOM_Sales_Details set SalesItemDesc=a.dsca
from (select a.*,b.dsca from BOM_Sales_Details a
LEFT JOIN LN_tcibd001 b 
ON REPLACE(b.item, ' ', '') = REPLACE(a.SalesItemCode, ' ', '') 
AND b.deleted = 'N'
AND ((a.compnr = 2000 AND b.compnr = '2000') OR (a.compnr IN (1100,1700) AND b.compnr = 1100) OR
(a.compnr IN (3110) AND b.compnr = '3100'))
where a.SalesItemDesc is null
--where a.salesitemcode='B676103'

)a
where BOM_Sales_Details.Region=a.Region
and BOM_Sales_Details.SalesItemCode=a.SalesItemCode
and BOM_Sales_Details.SalesItemDesc is null

update BOM_Sales_Details set ItemCode=ltrim(rtrim(ItemCode))
update BOM_Sales_Details set SalesItemCode=ltrim(rtrim(SalesItemCode))
update BOM_Sales_Details set sitm=ltrim(rtrim(sitm))
--select * from vw_Sales_data_US

delete from BOM_sales_details where compnr='1100' 

update BOM_sales_details set SalesItemDesc =a.dsca from 
(select *, 
case when compnr ='1100' then 'Europe'
when compnr='2000' then 'Brazil'
when compnr='3100' then 'USA' end 'region'
from elgi_us.dbo.ln_tcibd001) a
where BOM_sales_details.Region=a.region and trim(BOM_sales_details.itemcode)=trim(a.item) 
and SalesItemDesc is null



--delete from BOM_Sales_Details where SalesQty<0 --commented on 03-10-2025


----KIT Items sold without ChildItem List unavailability

--select * from BOM_Sales_Details
--where concat(Region,'-',ItemCode) in (
--select concat(a.Region,'-',a.ItemCode) from 
--(select distinct Region,itemcode from BOM_Sales_Details
--where sitm is not null)a
--inner join (select distinct Region,itemcode from BOM_Sales_Details
--where sitm is null)b
--on a.Region=b.Region
--and a.ItemCode=b.ItemCode
--)
--and sitm is null

--Test Case :
--select * from BOM_Sales_Details
--where ItemCode='A990287'
--and InvDate in ('2024-02-09','2024-07-24','2024-07-30')
--and region='USA'
--order by InvDate


end

--select * from BOM_sales_details_Temp1
--where orno='AM2301420' --and itemcode='EU012486229'
--and ltrim(rtrim(sitm))='B004800770001'

select * from BOM_Sales_details
where INvdate between '2025-09-01' and '2025-09-30'
and Region='Europe'
--where ltrim(rtrim(ItemCode)) in (--'ACDDHLBB01500','ACDRCYAB00300','ACDRNCAB00053','ACDRNCAB00070' 'ACDRNCAB00100')
--and ltrim(rtrim(sitm))='B004800770001'
--where Region='Europe' and ltrim(rtrim(SalesItemCode))='B676103'--'000998101'
--'B005705760002'--'015400889'--'X017503'--'B004800770001'

GO

