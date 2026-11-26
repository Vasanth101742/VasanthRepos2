--exec sp_ATS_Production_Summary

CREATE proc [dbo].[sp_ATS_Production_Summary] as
begin

Truncate table ATS_Production_Summary_Temp
Truncate table ATS_Production_Summary
Truncate table ATS_Production_ALC

Insert into ATS_Production_Summary_Temp(COMPANY,CWAR,ITEM,OnHandStk,ActualAvlStk)
select COMPANY,CWAR,ITEM,sum(QHND) as OnHand,
sum(QHND-QBLK-QLAL) as ActualAvl
from twhwmd215all
where company=600 and CWAR in('657','649','654','661')
group by COMPANY,CWAR,ITEM
having sum(QHND)+ sum(QHND-QBLK-QLAL)<>0

--update ATS_Production_Summary_Temp set OnHandStk=0 where cwar in ('654')


--update ATS_Production_Summary_Temp set OnHandStk=a.OnHandStk, ActualAvlStk=a.ActAvl from (
--select item,sum(OnHandStk) 'OnHandStk',sum(ActualAvlStk) 'ActAvl'
--from ATS_Production_Summary_Temp where company=600 and CWAR in('654','661')
--group by ITEM
--having sum(OnHandStk)+ sum(OnHandStk-ActualAvlStk)<>0
--)a where ltrim(rtrim(ATS_Production_Summary_Temp.item))=ltrim(rtrim(a.item)) and cwar='654'

Insert into ATS_Production_Summary_Temp(COMPANY,CWAR,ITEM,date1,PlannedQty)
select COMPANY,CWAR,MITM,RDLD,sum(QRDR) QRDR from TTISFC001ALL 
where COMPANY=600 and CWAR in('657','649','654','661')
and OSTA in (1,2,3)
and month(RDLD)=month(getdate()-1)
and year(RDLD)=year(getdate()-1)
group by COMPANY,CWAR,MITM,RDLD

Insert into ATS_Production_Summary_Temp(COMPANY,CWAR,ITEM,date1,ToBeCompletedQty)
select COMPANY,CWAR,MITM,RDLD,sum(QRDR) QRDR from TTISFC001ALL 
where COMPANY=600 and CWAR in('657','649','654','661')
and OSTA in (7)
and month(RDLD)=month(getdate()-1)
and year(RDLD)=year(getdate()-1)
group by COMPANY,CWAR,MITM,RDLD


Insert into ATS_Production_Summary_Temp(COMPANY,CWAR,ITEM,date1,WIP_qty)
select company,warehouse,item,date1,sum(WIP_qty) WIP_qty from ELGi_production_details where 
company=600 and warehouse in ('657','649','654','661')
and WIP_qty<>0
and month(date1)=month(getdate()-1)
and year(date1)=year(getdate()-1)
group by company,warehouse,item,date1



Insert into ATS_Production_Summary_Temp(COMPANY,CWAR,ITEM,date1,Actual_qty)
select company,warehouse,item,date1,sum(Actual_qty) Actual_qty from ELGi_production_details where 
company=600 and warehouse in ('657','649','654','661')
and Actual_qty<>0
and month(date1)=month(getdate()-1)
and year(date1)=year(getdate()-1)
group by company,warehouse,item,date1



Insert into ATS_Production_Summary_Temp(COMPANY,CWAR,ITEM,PendingQty,ClearedQty)
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
--having (sum(PendQty)-sum(ClearOrderQty))<>0


Insert into ATS_Production_Summary_Temp(COMPANY,CWAR,ITEM,Monthly_Plan)
select distinct company,warehouse,ltrim(rtrim(item)) item,MonthPlan from ELGi_production_details
where company=600 and warehouse in ('657','649','654','661')
and month(date1)=month(getdate()-1)
and year(date1)=year(getdate()-1)
and MonthPlan is not null


--alter table ATS_Production_Summary_Temp add MonthlyPlanValue float
Update ATS_Production_Summary_Temp set ProductGroup_MRP=a.[Group], Price=isnull(a.ASP_per_Unit,0)
from ATS_MRP_Itemwise_LeadTime a
where ltrim(rtrim(ATS_Production_Summary_Temp.ITEM))=ltrim(rtrim(a.TPL))


Update ATS_Production_Summary_Temp set MonthlyPlanValue=Monthly_Plan * Price

--alter table ATS_Production_Summary add MonthlyPlanValue float
----truncate table ATS_Production_Summary

Insert into ATS_Production_Summary(COMPANY,CWAR,ITEM,OnHandStk,ActualAvlStk,PendingQty,
ClearedQty,date1,WIP_Qty,Actual_Qty,PlannedQty,ToBeCompletedQty,Monthly_Plan,Rnk,ProductGroup_MRP,MonthlyPlanValue,Price)
select COMPANY,CWAR,ltrim(rtrim(ITEM)) ITEM,sum(isnull(OnHandStk,0)) OnHandStk,
sum(isnull(ActualAvlStk,0)) ActualAvlStk,
sum(isnull(PendingQty,0)) PendingQty,
sum(isnull(ClearedQty,0)) ClearedQty,date1,
sum(isnull(WIP_Qty,0)) WIP_Qty,sum(isnull(Actual_Qty,0)) Actual_Qty,
sum(isnull(PlannedQty,0)) as PlannedQty,
sum(isnull(ToBeCompletedQty,0)) as ToBeCompletedQty,
sum(isnull(Monthly_Plan,0)) as Monthly_Plan,
row_number() over (partition by COMPANY,CWAR,ltrim(rtrim(ITEM)) order by COMPANY,CWAR,ltrim(rtrim(ITEM))) as Rnk,
ProductGroup_MRP,
sum(isnull(MonthlyPlanValue,0)) 'MonthlyPlanValue',
max(price) 'Price'

from ATS_Production_Summary_Temp
group by COMPANY,CWAR,ltrim(rtrim(ITEM)),date1,ProductGroup_MRP



--update ATS_Production_Summary set Monthly_Plan=a.MonthPlan
--from (select distinct company,warehouse,item,MonthPlan from ELGi_production_details
--where company=600 and warehouse in ('657','649')
--and month(date1)=month(getdate()-1)
--and year(date1)=year(getdate()-1)
--)a
--where ATS_Production_Summary.COMPANY=a.company
--and ltrim(rtrim(ATS_Production_Summary.CWAR))=ltrim(rtrim(a.warehouse))
--and ltrim(rtrim(ATS_Production_Summary.ITEM))=ltrim(rtrim(a.item))
--and ATS_Production_Summary.Rnk=1 

--alter table ATS_Production_Summary add ItemType nvarchar(100)


Update ATS_Production_Summary set ItemType=a.t_kitm
from TTCIBD001600 a
where ltrim(rtrim(ATS_Production_Summary.Item))=ltrim(rtrim(a.t_item))

update ATS_Production_Summary set ItemType='Purchase' where ItemType='1'

update ATS_Production_Summary set ItemType='Manufacture' where ItemType='2'

update ATS_Production_Summary set ItemType='Generic' where ItemType='3'

update ATS_Production_Summary set ItemType='Cost' where ItemType='4'

update ATS_Production_Summary set ItemType='Service' where ItemType='5'

update ATS_Production_Summary set ItemType='Subcontracting' where ItemType='6'

update ATS_Production_Summary set ItemType='List' where ItemType='10'

update ATS_Production_Summary set ItemType='Equipment' where ItemType='15'

update ATS_Production_Summary set ItemType='Engineering' where ItemType='20'


update ATS_Production_Summary set OnHandStk=null where OnHandStk=0
update ATS_Production_Summary set ActualAvlStk=null where ActualAvlStk=0
update ATS_Production_Summary set PendingQty=null where PendingQty=0
update ATS_Production_Summary set ClearedQty=null where ClearedQty=0
update ATS_Production_Summary set WIP_Qty=null where WIP_Qty=0
update ATS_Production_Summary set PlannedQty=null where PlannedQty=0
update ATS_Production_Summary set ToBeCompletedQty=null where ToBeCompletedQty=0


Update ATS_Production_Summary set itemdescr=ltrim(rtrim(a.t_dsca))
from TTCIBD001600 a
where ltrim(rtrim(ATS_Production_Summary.Item))=ltrim(rtrim(a.t_item))

----------As per Mail Convenrsation by Siva Kandan on 25-03-2026 , for Stock for 654 WH-  661+654 
--and pending orders  Pending AO clear -661 WH

--update ATS_Production_Summary set OnHandStk = 0 where CWAR='654'

--update ATS_Production_Summary set ActualAvlStk = 0 where CWAR='654'


--update  ATS_Production_Summary set OnHandStk =a.OnHandStock, ActualAvlStk=a.AvlStock  from (
--select item,date1,ProductGroup_MRP, sum(isnull(OnHandStk,0))  'OnHandStock',
--sum(isnull(ActualAvlStk,0)) 'AvlStock'
--from ATS_Production_Summary_Temp
--where CWAR in ('654','661')
--group by item,date1,ProductGroup_MRP

--)a where ltrim(rtrim(ATS_Production_Summary.ITEM))=ltrim(rtrim(A.ITEM)) AND isnull(ATS_Production_Summary.DATE1,'1900-01-01')=
--isnull(a.date1,'1900-01-01') 
--and isnull(ATS_Production_Summary.ProductGroup_MRP,'Others')=isnull(a.ProductGroup_MRP,'Others') and ATS_Production_Summary.CWAR='654'


--update ATS_Production_Summary set PendingQty = 0 where CWAR='654'

--update ATS_Production_Summary set ClearedQty = 0 where CWAR='654'

--update  ATS_Production_Summary set PendingQty =a.Pendqty, ClearedQty=a.ClearedQty  from (
--select item,date1,ProductGroup_MRP, sum(isnull(PendingQty,0))  'Pendqty',
--sum(isnull(ClearedQty,0)) 'ClearedQty'
--from ATS_Production_Summary_Temp
--where CWAR in ('661')
--group by item,date1,ProductGroup_MRP


--)a where ltrim(rtrim(ATS_Production_Summary.ITEM))=ltrim(rtrim(A.ITEM)) AND isnull(ATS_Production_Summary.DATE1,'1900-01-01')=
--isnull(a.date1,'1900-01-01') 
--and isnull(ATS_Production_Summary.ProductGroup_MRP,'Others')=isnull(a.ProductGroup_MRP,'Others') and ATS_Production_Summary.CWAR='654'





--------ATS_Production_ALC---------


--WIP

Insert into ATS_Production_ALC(COMPANY,CWAR,MITM,ProductionDate,PDNO,WIP_Qty)
--select * into ATS_Production_ALC from(
select COMPANY,CWAR,MITM,WIP_Date,PDNO,sum(convert(float,QRDR)) WIP_Qty from 
(
select a.COMPANY,a.CWAR,a.MITM,a.PDNO,b.date as WIP_Date,b.QRDR from  TTISFC001ALL a 
left outer join
(
select * from (
select company,PDNO,QRDR,convert(date,date) as date,row_number() over (partition by company,pdno order by date) dateRank 
from TTICST151ALL
where OSTA in (6)
--and PDNO='230009816' --for testing Purpose
)b1
where dateRank=1
)b
on a.company=b.company
and a.PDNO=b.PDNO
) a
where company='600' and CWAR='657'
and WIP_Date>='2019-11-01'
group by COMPANY,CWAR,MITM,PDNO,WIP_Date
--)a
order by WIP_Date


--Closed

update ATS_Production_ALC set ClosedQty=a.Actual_qty
from(
select company,warehouse,item,date1,Prodorderno,sum(Actual_qty) Actual_qty from ELGi_production_details
where company='600' and warehouse='657'
and date1>='2019-11-01'
group by company,warehouse,item,Prodorderno,date1
--order by date1,item
)a
where ATS_Production_ALC.company=a.company
and ATS_Production_ALC.CWAR=a.warehouse
and ltrim(rtrim(ATS_Production_ALC.MITM))=ltrim(rtrim(a.item))
and ATS_Production_ALC.ProductionDate=a.date1
and ATS_Production_ALC.PDNO=a.Prodorderno


--Insert into ATS_Production_ALC(COMPANY,CWAR,MITM,ProductionDate,PDNO,ClosedQty)
--select company,warehouse,item,date1,Prodorderno,sum(Actual_qty) Actual_qty from ELGi_production_details
--where company='600' and warehouse='657'
--and date1>='2019-11-01'
--group by company,warehouse,item,Prodorderno,date1
--order by date1,item

Update ATS_Production_ALC set ItemDescr=ltrim(rtrim(a.t_dsca))
from TTCIBD001600 a
where ltrim(rtrim(ATS_Production_ALC.MITM))=ltrim(rtrim(a.t_item))


Update ATS_Production_ALC set ProductGroup_MRP=a.[Group]
from ATS_MRP_Itemwise_LeadTime a
where ltrim(rtrim(ATS_Production_ALC.MITM))=ltrim(rtrim(a.TPL))

delete from ATS_Production_ALC where isnull(WIP_Qty,0)+isnull(ClosedQty,0)=0  --Planned Qty deletion

------End: ATS_Production_ALC------


end

GO

