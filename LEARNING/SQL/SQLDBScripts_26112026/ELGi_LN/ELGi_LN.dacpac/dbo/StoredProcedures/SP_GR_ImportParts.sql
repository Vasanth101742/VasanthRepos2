CREATE Proc [dbo].[SP_GR_ImportParts]
as
begin

--------------Added Monthly consumption qty as on 31/1/2026 as per Ticket No : #INC 1244545

select b.RRSClassification,b.Sold_Count,
case when b.RRSClassification='Runner' then 1
when b.RRSClassification='Repeater' then 2
When b.RRSClassification='Stranger' then 3
else 4 
end 'RRSSorting',

case when MaxDemand=0 then 0 else round(QSKT/ (MaxDemand/4),0) end 'WeekCoverage',

case when MaxDemand=0 then 0 else round((QSKT +[P.trig]) / (MaxDemand/4),0) end 'WeekCoverageTrigger',
isnull(c.QBLK,0) 'BlockedQty',


a.* from (
----------------------Part 1 (INVENTORY RELATED)-----------------------------------------------------------------
select * from (
select a.COMPANY,a.ITEM,a.ItemDescr,
max(QSKT) QSKT,max(Amnt4) Amnt4,	
LeanType,a.SuppCode,a.SuppName,
BuyerCode,BuyerName,a.Category,
isnull(max(b.Qty),0) 'MaxQty',max(c.Qty)'P.trig',max(g.Qty)'OverdueTrigerQty',CONCAT(a.COMPANY,a.ITEM,a.SuppCode)'cmpitem',
d.MonthQty,d.PrevQty,max(f.BinQty)'BinQty',max(c.RPL)'RPL'
,max(e.AllocQty)'AllocQty',isnull(max(h.qty),0) 'MonthlyConsumption',

case when isnull(d.MonthQty,0)>=isnull(d.PrevQty,0) and isnull(d.MonthQty,0)>=isnull(max(b.Qty),0) then isnull(d.MonthQty,0)
when isnull(d.PrevQty,0)>=isnull(d.MonthQty,0) and isnull(d.PrevQty,0)>=isnull(max(b.Qty),0) then isnull(d.PrevQty,0)
when isnull(max(b.Qty),0)>=isnull(d.PrevQty,0) and isnull(max(b.Qty),0)>=isnull(d.MonthQty,0) then isnull(max(b.Qty),0)
end 'MaxDemand',max(f.CATEGORY)'Lean',max(f.SLOQ)'Slot',sum(f.StockValue/1000000)'StockValue',concat(a.COMPANY,a.ITEM)'CompanyItem'

---This part is inventory related 

from (
select b.COMPANY,replace(isnull(b.ITEM,''),' ','')'ITEM',isnull(ItemDescr,'')'ItemDescr',
sum(QSKT)QSKT,round(sum(Amnt4),2) Amnt4,
INVType,CompName,LeanType,isnull(SuppCode,'')SuppCode,isnull(SuppName,'')SuppName,
isnull(BuyerCode,'')BuyerCode,isnull(BuyerName,'')'BuyerName',CITM,CDSCA,ORDT,PDNO,PONO,QRDR,WQTY,WAMT,UPDT,Category,
Revision,DEMCLASS
from
inventorydetails b 
where b.COMPANY in (401,490,450)
and BuyerCode in (100762,102672)
and CWAR in ('102','251','157','161','164','209','210','211','212','246','251','252','253','257','258','273',
'274','291','294','346','351','353','357','373','391','453','457','464','553','557','L46','L53','L57','O53','U53','U57','CON','V53','V57','103')
and INVType not in ('Not considered')
group by b.COMPANY,replace(isnull(b.ITEM,''),' ',''),isnull(ItemDescr,''),

INVType,CompName,LeanType,isnull(SuppCode,''),isnull(SuppName,''),
isnull(BuyerCode,''),isnull(BuyerName,''),CITM,CDSCA,ORDT,PDNO,PONO,QRDR,WQTY,WAMT,UPDT,Category,
Revision,DEMCLASS
)a

--This part is Consumption related

left join (select company,a.Item,ItemDescr,max(Qty)'Qty' from (

select company,REPLACE(ItemCode,' ','')'Item',ItemDescr,calmonth,
(sum(Sales_Consumption)+sum(Production_Consumption))'Qty' 

from
Consumption where  --BuyrCode in (100762,102672)
 concat(RIGHT('00'+CAST(CalMonth AS VARCHAR(2)),2),cast(CalYear as varchar(4))) in (
select MonthYear from (
select 
RIGHT('00'+CAST(case when month(getdate()-1)-1=0 then 12 else month(getdate()-1)-1 end AS VARCHAR(2)),2)'CalMonth',case when month(getdate()-1)-1=0 then year(getdate()-1)-1 else year(getdate()-1) end'CalYear',
concat(RIGHT('00'+CAST(case when month(getdate()-1)-1=0 then 12 else month(getdate()-1)-1 end AS VARCHAR(2)),2),case when month(getdate()-1)-1=0 then year(getdate()-1)-1 else year(getdate()-1) end)'MonthYear'
union
select RIGHT('00'+CAST(case when month(getdate()-1)-2=0 then 12 else month(getdate()-1)-2 end AS VARCHAR(2)),2),case when month(getdate()-1)-2=0 then year(getdate()-1)-1 else year(getdate()-1) end,
concat(RIGHT('00'+CAST(case when month(getdate()-1)-2=0 then 12 else month(getdate()-1)-2 end AS VARCHAR(2)),2),case when month(getdate()-1)-2=0 then year(getdate()-1)-1 else year(getdate()-1) end)
union
select RIGHT('00'+CAST(case when month(getdate()-1)-3=0 then 12 else month(getdate()-1)-3 end AS VARCHAR(2)),2),case when month(getdate()-1)-3=0 then year(getdate()-1)-1 else year(getdate()-1) end,
concat(RIGHT('00'+CAST(case when month(getdate()-1)-3=0 then 12 else month(getdate()-1)-3 end AS VARCHAR(2)),2),case when month(getdate()-1)-3=0 then year(getdate()-1)-1 else year(getdate()-1) end)) a)

group by company,REPLACE(ItemCode,' ',''),ItemDescr,CalMonth) a group by company,a.Item,ItemDescr) b on b.Item=a.ITEM and b.COMPANY=a.COMPANY 

---This is triggers related

left join (select company,replace(ITEM,' ','')'Item',SupplierNum,avg(RPLT) 'RPL',
sum(convert(float,sceduledqty))'Qty',avg(binqty)'BinQty' from ELGi_OverDue_Triggers where buyr in  (100762,102672)
group by TriggerType,company,replace(ITEM,' ',''),SupplierNum) c on c.company=a.COMPANY and c.Item=a.ITEM and c.SupplierNum=a.SuppCode

---This is related to overdue triggers alone
left join (select company,replace(ITEM,' ','')'Item',SupplierNum,avg(RPLT) 'RPL',
sum(convert(float,sceduledqty))'Qty',avg(binqty)'BinQty'
from ELGi_OverDue_Triggers
where buyr in  (100762,102672) and  DueType='Over Due'
group by TriggerType,company,replace(ITEM,' ',''),SupplierNum) g on g.company=a.COMPANY and g.Item=a.ITEM and g.SupplierNum=a.SuppCode


--DEM Qty

left join [dbo].[PartwiseDEM] d on d.Company=a.COMPANY and d.ItemCode=a.ITEM

--ALloc qty

left join (select COMPANY,replace(T$ITEM,' ','')'Item',sum(T$QANA)'AllocQty'  from TWHINP100ALL 
where COMPANY in(401,450,490)  and T$KOOR in (1,3)  and T$KOTR=2
group by COMPANY,replace(T$ITEM,' ','')) e on e.company=a.company and e.Item=a.ITEM

--Excess inventory
left join (select COMPANY,replace(Item,' ','')'Item',CATEGORY,SLOQ,BinQty,round(StockValue,0)'StockValue' from Excess_Inventory) f
on f.Item=a.ITEM and f.COMPANY=a.COMPANY

--Monthly Consumption

left join (select company,a.Item,ItemDescr,max(Qty)'Qty' from (

select company,REPLACE(ItemCode,' ','')'Item',ItemDescr,calmonth,calyear,
(sum(Sales_Consumption)+sum(Production_Consumption))'Qty' 

from
Consumption where  --BuyrCode in (100762,102672)
 CalMonth =MONTH(getdate()-1) and CalYear=year(getdate()-1)

group by company,REPLACE(ItemCode,' ',''),ItemDescr,CalMonth,calyear) a group by company,a.Item,ItemDescr) h on h.Item=a.ITEM and h.COMPANY=a.COMPANY 


--where  replace(isnull(a.ITEM,''),' ','')='B007705830030'
group by a.COMPANY,a.ITEM,a.ItemDescr,LeanType,a.SuppCode,a.SuppName,
BuyerCode,BuyerName,a.Category,d.MonthQty,d.PrevQty)a

----------------------Part 2  ()TDIPU RELATED-----------------------------------------------------
union all

select * from (

select a.COMPANY,a.ITEM,a.t_dsca,
0 QSKT,0 Amnt4,	
''LeanType,a.OTBP,a.NAMA,
BUYR,emp,''Category,
isnull(max(b.Qty),0) 'MaxQty',max(c.Qty)'P.trig',max(g.Qty)'OverdueTrigerQty',CONCAT(a.COMPANY,a.ITEM,a.OTBP)'cmpitem',d.MonthQty,d.PrevQty,max(f.BinQty)'BinQty',max(c.RPL)'RPL'
,max(e.AllocQty)'AllocQty',isnull(max(h.qty),0) 'MonthlyConsumption',

case when isnull(d.MonthQty,0)>=isnull(d.PrevQty,0) and isnull(d.MonthQty,0)>=isnull(max(b.Qty),0) then isnull(d.MonthQty,0)
when isnull(d.PrevQty,0)>=isnull(d.MonthQty,0) and isnull(d.PrevQty,0)>=isnull(max(b.Qty),0) then isnull(d.PrevQty,0)
when isnull(max(b.Qty),0)>=isnull(d.PrevQty,0) and isnull(max(b.Qty),0)>=isnull(d.MonthQty,0) then isnull(max(b.Qty),0)
end 'MaxDemand',max(f.CATEGORY)'Lean',max(f.SLOQ)'Slot',sum(f.StockValue/1000000)'StockValue',concat(a.COMPANY,a.ITEM)'CompanyItem'

--------------Related to TTDIPU001 table
from (

SELECT DISTINCT a.COMPANY,LTRIM(RTRIM(a.ITEM))AS ITEM,OTBP,BUYR,t_dsca,c.NAMA,d.NAMA'emp' fROM TTDIPU001ALL a
left join TTCIBD001400 b on LTRIM(RTRIM(b.t_item))=LTRIM(RTRIM(a.ITEM))
left join TTCCOM100ALL c ON A.OTBP =c.bpid and c.company='400'
LEFT JOIN (select  EMNO, NAMA  From TTCCOM001ALL where company=400 and nama is not null and NAMA <>'')d
ON A.BUYR =d.EMNO
WHERE a.COMPANY in (401,490,450) and BUYR in (100762,102672) 
--and LTRIM(RTRIM(a.ITEM)) not in (select distinct LTRIM(RTRIM(ITEM))  from inventorydetails where COMPANY in (401,490,450) and BUYR in (100762,102672))

and concat(LTRIM(RTRIM(a.ITEM)),a.COMPANY) not in 


(select distinct concat(LTRIM(RTRIM(ITEM)),COMPANY)  from inventorydetails where COMPANY in (401,490,450) and BuyerCode in (100762,102672)
and CWAR in ('102','251','157','161','164','209','210','211','212','246','251','252','253','257','258','273',
'274','291','294','346','351','353','357','373','391','453','457','464','553','557','L46','L53','L57','O53','U53','U57','CON','V53','V57','103')
and INVType not in ('Not considered')

)
)a

-------Consumption

left join (select company,a.Item,ItemDescr,max(Qty)'Qty' from (

select company,REPLACE(ItemCode,' ','')'Item',ItemDescr,calmonth,
(sum(Sales_Consumption)+sum(Production_Consumption))'Qty' 

from
Consumption where  --BuyrCode in (100762,102672)
 concat(RIGHT('00'+CAST(CalMonth AS VARCHAR(2)),2),cast(CalYear as varchar(4))) in (
select MonthYear from (
select 
RIGHT('00'+CAST(case when month(getdate()-1)-1=0 then 12 else month(getdate()-1)-1 end AS VARCHAR(2)),2)'CalMonth',case when month(getdate()-1)-1=0 then year(getdate()-1)-1 else year(getdate()-1) end'CalYear',
concat(RIGHT('00'+CAST(case when month(getdate()-1)-1=0 then 12 else month(getdate()-1)-1 end AS VARCHAR(2)),2),case when month(getdate()-1)-1=0 then year(getdate()-1)-1 else year(getdate()-1) end)'MonthYear'
union
select RIGHT('00'+CAST(case when month(getdate()-1)-2=0 then 12 else month(getdate()-1)-2 end AS VARCHAR(2)),2),case when month(getdate()-1)-2=0 then year(getdate()-1)-1 else year(getdate()-1) end,
concat(RIGHT('00'+CAST(case when month(getdate()-1)-2=0 then 12 else month(getdate()-1)-2 end AS VARCHAR(2)),2),case when month(getdate()-1)-2=0 then year(getdate()-1)-1 else year(getdate()-1) end)
union
select RIGHT('00'+CAST(case when month(getdate()-1)-3=0 then 12 else month(getdate()-1)-3 end AS VARCHAR(2)),2),case when month(getdate()-1)-3=0 then year(getdate()-1)-1 else year(getdate()-1) end,
concat(RIGHT('00'+CAST(case when month(getdate()-1)-3=0 then 12 else month(getdate()-1)-3 end AS VARCHAR(2)),2),case when month(getdate()-1)-3=0 then year(getdate()-1)-1 else year(getdate()-1) end)) a)

group by company,REPLACE(ItemCode,' ',''),ItemDescr,CalMonth) a group by company,a.Item,ItemDescr) b on b.Item=a.ITEM and b.COMPANY=a.COMPANY 

-----Triggers
left join (select company,replace(ITEM,' ','')'Item',SupplierNum,avg(RPLT) 'RPL',
sum(convert(float,sceduledqty))'Qty',avg(binqty)'BinQty' from ELGi_OverDue_Triggers where buyr in  (100762,102672)
group by TriggerType,company,replace(ITEM,' ',''),SupplierNum) c on c.company=a.COMPANY and c.Item=a.ITEM and c.SupplierNum=a.OTBP
-------Overdue triggers

left join (select company,replace(ITEM,' ','')'Item',SupplierNum,avg(RPLT) 'RPL',
sum(convert(float,sceduledqty))'Qty',avg(binqty)'BinQty'
from ELGi_OverDue_Triggers
where buyr in  (100762,102672) and  DueType='Over Due'
group by TriggerType,company,replace(ITEM,' ',''),SupplierNum) g on g.company=a.COMPANY and g.Item=a.ITEM and g.SupplierNum=a.OTBP

--------DEM Qty
left join [dbo].[PartwiseDEM] d on d.Company=a.COMPANY and d.ItemCode=a.ITEM

---Allocated qty

left join (
select COMPANY,replace(T$ITEM,' ','')'Item',sum(T$QANA)'AllocQty'  from TWHINP100ALL 
where COMPANY in(401,450,490)  and T$KOOR in (1,3) and T$KOTR=2
group by COMPANY,replace(T$ITEM,' ','')) e on e.company=a.company and e.Item=a.ITEM

---Excess inventory

left join (select COMPANY,replace(Item,' ','')'Item',CATEGORY,SLOQ,BinQty,round(StockValue,0)'StockValue' from Excess_Inventory) f
on f.Item=a.ITEM and f.COMPANY=a.COMPANY


--Monthly Consumption

left join (select company,a.Item,ItemDescr,max(Qty)'Qty' from (

select company,REPLACE(ItemCode,' ','')'Item',ItemDescr,calmonth,calyear,
(sum(Sales_Consumption)+sum(Production_Consumption))'Qty' 

from
Consumption where  --BuyrCode in (100762,102672)
 CalMonth =MONTH(getdate()-1) and CalYear=year(getdate()-1)

group by company,REPLACE(ItemCode,' ',''),ItemDescr,CalMonth,calyear) a group by company,a.Item,ItemDescr) h on h.Item=a.ITEM and h.COMPANY=a.COMPANY 

group by a.COMPANY,a.ITEM,a.t_dsca,a.BUYR,a.OTBP,a.NAMA,
BUYR,emp,Category,d.MonthQty,d.PrevQty
)b

) a 


-------Part 3 RRSClassification

left join (
select *, 
case when Sold_Count >=8  then 'Runner'
	 When Sold_Count between 4 and 7 then 'Repeater'
	 when Sold_Count <=3 then 'Stranger'
	 end 'RRSClassification'
from (

select distinct Company, ltrim(rtrim(item)) Item ,count(distinct concat(month(trdt),year(trdt))) 'Sold_Count'
from TWHINR110ALL 
where COMPANY in ('401','450','490') and kost=5 and koor in (3,1) 
--and ltrim(rtrim(item))='000112660'
group by  Company, ltrim(rtrim(item))  
--, month(trdt) ,year(trdt)
)a 

) b on a.COMPANY=b.COMPANY and a.ITEM=b.Item


-------Part 4 Blocked Stock

left join (

select COMPANY,TRIM(ITEM) 'ItemCode',SUM(QHND) 'QHND',SUM(QBLK) 'QBLK' from TWHWMD215ALL 

where COMPANY in ('401','450','490')

and CWAR in ('102','251','157','161','164','209','210','211','212','246','251','252','253','257','258','273',
'274','291','294','346','351','353','357','373','391','453','457','464','553','557','L46','L53','L57','O53','U53','U57','CON','V53','V57','103')


GROUP BY COMPANY,TRIM(ITEM)


) c on a.COMPANY=c.COMPANY and a.ITEM=c.ItemCode



order by a.ITEM



--7236

end

GO

