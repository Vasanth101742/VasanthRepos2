
CREATE proc [dbo].[sp_ATS_ClearanceOrder] as
begin

Truncate table ATS_ClearanceOrderTemp
Truncate table ATS_ClearanceOrder

-------------STEP-1 STOCK --------------
Insert into ATS_ClearanceOrderTemp(COMPANY,CWAR,ITEM,StockOnHnd,StockAct)
select COMPANY,CWAR,ITEM,sum(QHND) as OnHand,
sum(QHND-QBLK-QLAL) as ActualAvl
from twhwmd215all
where company=600 and CWAR in('657','649','670','639','661')
group by COMPANY,CWAR,ITEM
having sum(QHND)+ sum(QHND-QBLK-QLAL)<>0

-------------STEP-2 PO PLANNED --------------
Insert into ATS_ClearanceOrderTemp(COMPANY,CWAR,ITEM,cldt,POPlanned)
select COMPANY,CWAR,MITM,RDLD,sum(QRDR) QRDR from TTISFC001ALL 
where COMPANY=600 and CWAR in('657','649','670','639','661')
and OSTA in (1,2,3)
and month(RDLD)=month(getdate()-1)
and year(RDLD)=year(getdate()-1)
group by COMPANY,CWAR,MITM,RDLD

-------------STEP-3 PO UNDER PACKING --------------

Insert into ATS_ClearanceOrderTemp(COMPANY,CWAR,ITEM,cldt,POUnderPacking)
select COMPANY,CWAR,MITM,rdld,sum(QRDR) QRDR from TTISFC001ALL 
where COMPANY=600 and CWAR in('657','649','670','639','661')
and OSTA in (7)
and month(RDLD)=month(getdate()-1)
and year(RDLD)=year(getdate()-1)
group by COMPANY,CWAR,MITM,rdld

-------------STEP-4 PO WIP --------------

Insert into ATS_ClearanceOrderTemp(COMPANY,CWAR,ITEM,CLDT,POWIP)
select company,warehouse,item,DATE1,sum(WIP_qty) WIP_qty from ELGi_production_details where 
company=600 and warehouse in('657','649','670','639','661')
and WIP_qty<>0
and month(date1)=month(getdate()-1)
and year(date1)=year(getdate()-1)
group by company,warehouse,item,date1


-------------STEP-5 Monthly Plan --------------

Insert into ATS_ClearanceOrderTemp(COMPANY,CWAR,ITEM,MonthlyPlanQty)
select distinct company,warehouse,ltrim(rtrim(item)) item,MonthPlan from ELGi_production_details
where company=600 and warehouse in('657','649','670','639','661')
and month(date1)=month(getdate()-1)
and year(date1)=year(getdate()-1)
and MonthPlan is not null

-------------STEP-6 Cleared Qty --------------

-- Cleared qty for 657,670,639
insert into ATS_ClearanceOrderTemp(company,cwar,Item,CLDT,ClearedQty)
select a.company,b.t_cwar,Ltrim(rtrim(a.T$item)) 'Item',T$cldt,sum(T$CQTY) 't$cqty'
from TZZSLS331600 a
left join (select distinct company,t_orno,ltrim(rtrim(t_item)) 'Item',t_cwar,t_sqnb,t_pono from TTDSLS401ALL 
where Company=600 and t_cwar in ('657','670','639')
) b

on a.COMPANY=b.Company and a.T$ORNO=b.t_orno and ltrim(rtrim(a.t$item))= ltrim(rtrim(b.Item)) and a.T$SQNB=b.t_sqnb and a.T$PONO=b.t_pono
where T$STAT=1 and concat(month(T$CLDT),year(t$cldt)) = concat(month(GETDATE()-1),year(getdate()-1)) and t_cwar in ('657','670','639')
--and b.t_cwar is null
--and ltrim(rtrim(T$item)) like '%123456010%'
group by a.COMPANY,Ltrim(rtrim(a.T$item)),a.T$CLDT
,b.t_cwar
,a.T$SQNB,a.T$PONO
order by T$CLDT
--1692

---Cleared Qty for 661, 649 warehouse to consider all the inflow qty 
insert into ATS_ClearanceOrderTemp(company,cwar,Item,CLDT,ClearedQty)
select Company,WareHouse,ItemCode,OrderDate,sum(qty) 'OrdQty' from Sales_Inflow 
where Company='600' and warehouse in ('661','649') 
and concat(month(OrderDate),year(OrderDate)) = concat(month(GETDATE()-1),year(getdate()-1))
group by Company,ItemCode,WareHouse,OrderDate


-------------STEP-7 PENDING AO TOTAL--------------

Insert into ATS_ClearanceOrderTemp(COMPANY,CWAR,ITEM,PendingAOTotal,PendingAOClear)


select Company,WareHouse,ItemCode,sum(PendQty) PendQty,
sum(ClearOrderQty) ClearOrderQty
from (
select * from (
select a.Company,a.WareHouse,a.ItemCode,a.OrderDate,a.ordertype,a.OrderNum,PositionNum,
isnull(a.PendQty,0) 'PendQty',concat(b.Company,T$ORNO,b.T$PONO) as ColA,
case when concat(b.Company,T$ORNO,b.T$PONO) <>'' then isnull(PendQty,0) else 0 end as ClearOrderQty 
from
(select Company,WareHouse,ItemCode,Item_desc,OrderDate,ordertype,
OrderNum,PositionNum,isnull(PendQty,0)-isnull(Cancel_Qty,0) as PendQty
from Pending_Orders where company=600 and WareHouse in ('657','649','654','661')
and (isnull(PendQty,0)-isnull(Cancel_Qty,0))>0
)a
left outer join 
(select distinct COMPANY,T$ORNO,T$PONO from TZZSLS331600 where T$STAT=1)b
on a.Company=b.COMPANY
and a.OrderNum=b.T$ORNO
and a.PositionNum=b.T$PONO
--where ltrim(rtrim(a.ItemCode))='Z12119' --for testing
)a
--where (PendQty-ClearOrderQty)<>0
)a
group by Company,WareHouse,ItemCode

--select Company,WareHouse,ItemCode,count(distinct ordernum) 'AOCount'
--from Pending_Orders where company=600 and warehouse in('657','649','670','639','661')
--group by company,WareHouse,ItemCode
--order by ItemCode

---------------STEP-8 PENDING AO CLEAR --------------

--Insert into ATS_ClearanceOrderTemp(COMPANY,CWAR,ITEM,PendingAOClear)
--select a.company,b.t_cwar,Ltrim(rtrim(a.T$item)) 'Item',Count(distinct a.T$ORNO) 'ClearedAO'
--from TZZSLS331600 a
--left join (select distinct company,t_orno,ltrim(rtrim(t_item)) 'Item',t_cwar,t_sqnb,t_pono from TTDSLS401ALL 
--where Company=600 and t_cwar in ('657','670','639','661','649')
--) b

--on a.COMPANY=b.Company and a.T$ORNO=b.t_orno and ltrim(rtrim(a.t$item))= ltrim(rtrim(b.Item)) and a.T$SQNB=b.t_sqnb and a.T$PONO=b.t_pono

--where T$STAT=1 AND
--CONCAT(Ltrim(rtrim(a.T$item)),A.T$ORNO,B.t_cwar) IN 

--(SELECT DISTINCT CONCAT(ItemCode,ORDERNUM,Warehouse) FROM Pending_Orders WHERE Company='600' AND t_cwar in ('657','670','639','661','649'))
----and concat(month(T$CLDT),year(t$cldt)) = concat(month(GETDATE()-1),year(getdate()-1)) 

----and ltrim(rtrim(T$item)) like '%S15052%'
--group by a.COMPANY,Ltrim(rtrim(a.T$item))
--,b.t_cwar
--order by Item
----,a.T$SQNB,a.T$PONO


-------------STEP-9 UPDATING PRODUCT GROUP --------------

Update ATS_ClearanceOrderTemp set productgroup=a.[Group],Price=isnull(a.ASP_per_Unit,0)
from ATS_MRP_Itemwise_LeadTime a
where ltrim(rtrim(ATS_ClearanceOrderTemp.ITEM))=ltrim(rtrim(a.TPL))

Update ATS_ClearanceOrderTemp set MonthlyPlanValue=MonthlyPlanQty * Price

-------------STEP-10 DELETING NULL WAREHOUSE --------------

delete from ATS_ClearanceOrderTemp where cwar is null
--alter table ATS_ClearanceOrderTemp add ClearedQty float


-------------STEP-11 INSERTING INTO ATS_CLEARANCE ORDER --------------


Insert into ATS_ClearanceOrder(COMPANY,CWAR,ITEM,StockOnhnd,StockAct,PendingAOTotal,
POWIP,POPlanned,POUnderPacking,MonthlyPlanQty,ProductGroup,clearedQty,CLDT,rnk,PendingAOClear,MonthlyPlanValue,Price)
select COMPANY,CWAR,ltrim(rtrim(ITEM)) ITEM,sum(isnull(StockOnhnd,0)) OnHandStk,
sum(isnull(StockAct,0)) ActualAvlStk,
sum(isnull(PendingAOTotal,0)) PendingQty,
--sum(isnull(ClearedQty,0)) ClearedQty,date1,
sum(isnull(POWIP,0)) WIP_Qty,
sum(isnull(POPlanned,0)) as PlannedQty,
sum(isnull(POUnderPacking,0)) as POPackingQty,
sum(isnull(MonthlyPlanQty,0)) as Monthly_Plan,
ProductGroup,
sum(isnull(ClearedQty,0)) as ClearedQty,CLDT,
row_number() over (partition by COMPANY,CWAR,ltrim(rtrim(ITEM)) order by COMPANY,CWAR,ltrim(rtrim(ITEM))) as Rnk,
SUM(isnull(PendingAOClear,0)) AS 'PendingAOCLear',
sum(isnull(MonthlyPlanValue,0)) 'MonthlyPlanValue',
max(price) 'Price'
from ATS_ClearanceOrderTemp
--where cwar is not null
group by COMPANY,CWAR,ltrim(rtrim(ITEM)),ProductGroup,CLDT

Update ATS_ClearanceOrder set TPLDescription=ltrim(rtrim(a.t_dsca)),ItemType=a.t_kitm
from TTCIBD001600 a
where ltrim(rtrim(ATS_ClearanceOrder.Item))=ltrim(rtrim(a.t_item))

update ATS_ClearanceOrder set ItemType='Purchase' where ItemType='1'

update ATS_ClearanceOrder set ItemType='Manufacture' where ItemType='2'

update ATS_ClearanceOrder set ItemType='Generic' where ItemType='3'

update ATS_ClearanceOrder set ItemType='Cost' where ItemType='4'

update ATS_ClearanceOrder set ItemType='Service' where ItemType='5'

update ATS_ClearanceOrder set ItemType='Subcontracting' where ItemType='6'

update ATS_ClearanceOrder set ItemType='List' where ItemType='10'

update ATS_ClearanceOrder set ItemType='Equipment' where ItemType='15'

update ATS_ClearanceOrder set ItemType='Engineering' where ItemType='20'
--alter table ATS_ClearanceOrder alter column itemType nvarchar(50)


end

GO

