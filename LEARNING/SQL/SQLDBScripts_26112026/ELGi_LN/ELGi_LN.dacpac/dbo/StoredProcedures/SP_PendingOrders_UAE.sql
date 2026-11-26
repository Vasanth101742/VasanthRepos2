--exec [SP_PendingOrders_UAE]
CREATE proc [dbo].[SP_PendingOrders_UAE] as 

begin 

Declare @BlockClosureStartDate date ='2025-05-10'
Declare @BlockClosureEndDate date ='2025-05-18'

--update tzzsls158490 set t$item=replace(t$item,' ','')

----update pending_orders set ItemCode = replace (ItemCode,' ','')

declare @Saturday int
set @Saturday = DATEPART(weekday,'20230211');

truncate table PendingOrders_UAE

insert into  PendingOrders_UAE 

select a.*,b.PlanRecDate,0,'','',0,0,'',0,null,null,0,0,0,getdate(),'','','','','','','' From (
select * From (
select plan_recp_date,blocked,disc_origin,plan_del_date,Sales_Inv_Address,Cust_Inv_Address,Sales_GSTN_NO,Cust_GSTN_NO,SALES_SEQ,Cust_SEQ,cust_state,Sales_state,
state,sum(STOCK_401_onhand)'STOCK_401_onhand',Old_positionno,BP_SEQ_NO ,Tax_Desc,HSN_CODE,GSTN_NO,PRICE_ORIGIN,Ref,  
dpst,dpstname,PositionNum,OrderNum,ordertype,origin,Baan_orderno ,Baan_positionno,DeliveryDate,ItemCode,Item_desc
,TaxCode,Price,DiscPerc1,DiscPerc2,buyer,Indent ,OrderDate,CustCode,Custname,
sum(value)as value,sum(ord_qty_new)ord_qty,sum(delqty)delqty,sum(pendqty)as penqty,sum(STOCK_490_act)STOCK_490_act,sum(STOCK_490_onhand)STOCK_490_onhand
,Next_Due_Date1,Next_Due_Date2,Reason1,Reason2,Supplier ,sum(t_oamt)t_oamt
 from (
	select *,ord_qty-isnull(cancel_qty,0) as ord_qty_new From pending_orders where company in (500) AND DPST IN ('70238','70239','70240','70241') --where OrderNum ='236001180'and PositionNum=10
	 )a
group by plan_recp_date,blocked,
disc_origin,plan_del_date,Sales_Inv_Address,Cust_Inv_Address,Sales_GSTN_NO,Cust_GSTN_NO,SALES_SEQ,Cust_SEQ,cust_state,Sales_state,state
,Old_positionno,BP_SEQ_NO,Tax_Desc,HSN_CODE,GSTN_NO,PRICE_ORIGIN,Ref,  dpst,dpstname,PositionNum,OrderNum,ordertype,origin,Baan_orderno ,Baan_positionno,DeliveryDate,ItemCode,Item_desc
,TaxCode,Price,DiscPerc1,DiscPerc2,buyer ,OrderDate,CustCode,Custname,Indent,Next_Due_Date1,Next_Due_Date2,Reason1,Reason2,Supplier
)a
where penqty >0
and OrderDate>'20220331' and ItemCode not in ('FRT')

)a
left join (select max(PlanRecDate)PlanRecDate,OrderNum From Sales_Header where Company =500 group by OrderNum )b
on a.OrderNum =b.OrderNum 


update a set a.lead_days = isnull(b.leaddays,90)+25 from PendingOrders_UAE a
left join GSC_LeadTime b on  b.ItemCode=a.ItemCode

--alter table PendingOrders_UAE add ETA_Date datetime

update PendingOrders_UAE set ETA_Date = dateadd(d,Lead_days+15,orderdate) 


update a set seq=b.t_sqnb from PendingOrders_UAE a
inner join (select t_orno,t_pono,max(t_sqnb)'t_sqnb' from TTDSLS401ALL where company='500' and t_odat>'20220401'  and t_clyn<>1
						group by t_orno,t_pono) b on b.t_orno=a.ordernum and b.t_pono =a.positionnum 



----------------------------------------From this where to take shipment number ????-----------------------------------------------------


--update a set ShipmentNO=replace(T$SHPM,' ',''),ShipQty=T$QPLI from PendingOrders_UAE a
--inner join TWHINH480ALL b on b.T$ORNO=a.ordernum and b.T$PONO =a.positionnum  and b.T$SEQN=a.seq


--update a set wh_orderdate=isnull(b.wh_orderdate,'1900-01-01') from PendingOrders_UAE a
--inner join Pending_orders_wms b on  b.COMPANY='490' 
--and replace(b.itemcode,' ','')=replace(a.ItemCode,' ','')
--and b.OrderNum=a.OrderNum and b.PositionNum=a.PositionNum

----Not needed this part
--update a set  a.subproduct=b.wh_orderdate from sales_report_LN a
--left join Pending_orders_wms b on  b.COMPANY=a.company 
--and replace(b.itemcode,' ','')=replace(a.ItemCode,' ','')
--and b.OrderNum=a.OrderNum and b.PositionNum=a.positionno 
------
--update PendingOrders_UAE set wh_orderdate= isnull(wh_orderdate,'1900-01-01')
--update PendingOrders_UAE set wh_orderdate=dateadd(dd,9,wh_orderdate) where wh_orderdate between @BlockClosureStartDate and @BlockClosureEndDate

--update PendingOrders_UAE set PlannedDelDate=(convert(datetime,wh_orderdate)+Lead_days)

--update PendingOrders_UAE set PlannedDelDate=dateadd(dd,9,PlannedDelDate) where PlannedDelDate between @BlockClosureStartDate and @BlockClosureEndDate


--------upto this not needed-------------------

--Customer name from which we need to take ?
update a set  custcode=b.t_stbp,custname=c.NAMA from PendingOrders_UAE a
left join TTDSLS400ALL b on b.t_orno=a.Ordernum and t_sotp=a.ordertype and b.company=500 and b.t_cofc=a.dpst
left join TTCCOM100All c on c.company=400 and bpid=b.t_stbp
where a.dpst in ('70238','70239','70240','70241')


--alter table pendingorders_uae add TOQ float
update PendingOrders_UAE set TOQ =a.TOQ from (
select itemcode,sum(ord_qty) 'TOQ' from PendingOrders_UAE 
group by ItemCode
)a where PendingOrders_UAE.ItemCode=a.ItemCode



--update a set  a.DeliveryDate=b.PlannedDelDate  from PendingOrders_UAE a
--left join ( select a.Ordernum,a.PositionNum,a.ItemCode,

--(select DATEADD(day,(lead_days/5)*7+(lead_days%5)+CASE WHEN
--	 (select top 1 MAX(CASE WHEN DATEPART(weekday,DATEADD(day,b.n,case when isnull(wh_orderdate,'1900-01-01')='1900-01-01' then getdate()+1000 else wh_orderdate end  ))=@Saturday THEN 1 ELSE 0 END) as HitWeekend
--		from    PendingOrders_UAE g 
--		left join WeekNumber b on (lead_days%5)>=b.n
--		where g.OrderNum=a.OrderNum and g.PositionNum=a.PositionNum and replace (g.ItemCode,' ','')=replace (a.ItemCode,' ','')

--		group by (lead_days/5),(lead_days%5))=1 THEN 2 ELSE 0 END,case when isnull(wh_orderdate,'1900-01-01')='1900-01-01' then getdate()+1000 else wh_orderdate end ))'PlannedDelDate'
		
--from PendingOrders_UAE a)b on  b.OrderNum=a.OrderNum and b.PositionNum=a.positionNum and b.ItemCode=a.ItemCode


----update a set a.PlannedDelDate=b.DelDate from PendingOrders_UAE a 
----left join 
----(select OrderNum,max(PlannedDelDate)'DelDate' from PendingOrders_UAE where ordertype='250'
----group by OrderNum) b on b.OrderNum=a.OrderNum
----where a.ordertype='250'

--------------------------------------From this again it is related to 490 company -------------------------------------------------------------------

--update a set Ship_Status=(Case when (isnull(b.REMK,''))='Packing Completed' then 'Waiting For Invoice'
--when (isnull(b.REMK,''))='WAITING FOR ELGI PACKING' then 'In Packing'
--when (isnull(b.REMK,''))=' Waiting for Elgi Packing' then 'In Packing'
--when (isnull(b.REMK,''))='Packing In Process' then 'In Packing'
--when (isnull(b.REMK,''))='' then ''
--end) from PendingOrders_UAE a
--inner join TZZSLS602all b on b.COMPANY='490' and replace(SHPM,' ','') =ShipmentNO and replace(ITEM,' ','')=ItemCode


--update PendingOrders_UAE set Ship_Status='In-Packing / Billing' where isnull(Ship_Status,'')='' and ShipmentNO <>''

update PendingOrders_UAE set ItemCode = replace (ItemCode,' ','')

--alter table PendingOrders_UAE add Stock_Qty float
update PendingOrders_UAE set Stock_Qty=b.Stock
from 
(select item,sum(qhnd)-sum(qblk) 'Stock' from TWHWMD215ALL 
where company='500' and CWAR in ('G64','G84')
group by ITEM) b
where  replace(b.ITEM,' ','')=PendingOrders_UAE.ItemCode



update a set QtyBlock=b.QBLK,
STOCK_490_onhand=(case when isnull((QHND-QBLK-QLAL),0)<=0 then 0 else isnull((QHND-QBLK-QLAL),0) end)
from PendingOrders_UAE a
inner join TWHWMD215ALL b on  b.COMPANY='500' and b.CWAR in ('G64','G84') and replace(b.ITEM,' ','')=a.ItemCode

------------------
update a set a.itemtype=b.itemtype,areacode=b.areacode,areaname=b.areaname from PendingOrders_UAE a
inner join pending_orders b on b.OrderNum=a.OrderNum and b.PositionNum=a.positionNum and replace(b.ItemCode,' ','')=replace(a.ItemCode,' ','')

-----------------------------------------------------------------this is related to shipment -------------------------------------------
--update a set a.Reason1=b.updt from PendingOrders_UAE a 
--inner join TZZSLS602ALL b on b.Company='490' and b.SHPM=a.ShipmentNO and replace(b.item,' ','')=a.ItemCode and REMK='Packing Completed'

--update a set allocation= gr.Allocation,Next_Due_date2=AdviseDate from PendingOrders_UAE a
--inner join 

--(select replace(T$ITEM,' ','')'Itemcode',sum(cast(replace(T$QADV,':','0.') as float))'Allocation',max(T$PDDT)'AdviseDate',T$ORNO,T$PONO ,t$seqn
--	from TWHINH220490 
--			where COMPANY=490 and T$CWAR='102' 
--			group by replace(T$ITEM,' ',''), COMPANY,T$CWAR,T$ORNO,T$PONO,t$seqn) GR on GR.Itemcode=replace(A.ItemCode,' ','')
--			and gr.T$ORNO=OrderNum and gr.T$PONO=a.PositionNum and gr.t$seqn=a.seq


--update a set ship_status=b.Status1 from PendingOrders_UAE  a 
--inner join (
--select OrderNum,ItemCode,ShipmentNO,PositionNum,Allocation,ord_qty,penqty,delqty,Ship_Status,
--case when penqty<=Allocation then 'Fully Advised' 
--		when penqty>Allocation then 'Partialy Advised'end 'Status1'

--		from PendingOrders_UAE 
--where isnull(Allocation,0)>0 and isnull(ShipmentNO,'')='' and isnull(wh_orderdate,'1900-01-01')>'1900-01-01' 
--and convert(date,OrderDate)>'20220331'  and isnull(Ship_Status,'')='') b on b.ItemCode= a.ItemCode and b.OrderNum=a.OrderNum and b.PositionNum=a.PositionNum


--update PendingOrders_UAE set Ship_Status=(case when (STOCK_490_onhand+qtyblock)=0 and Allocation=0 and ItemType='P' then 'Stock Not Available'
--											when (STOCK_490_onhand+qtyblock)=0 and Allocation=0 and ItemType='M' then 'Stock Not Available' end) 
--							where isnull(Ship_Status,'')='' and ShipmentNO ='' and (isnull(STOCK_490_onhand,0)+isnull(qtyblock,0))=0 and Allocation=0 


update a set slno=b.SlNum from PendingOrders_UAE a
inner join (select OrderNum,ItemCode,OrderDate,ROW_NUMBER() over (partition by Itemcode order by orderdate,itemcode asc) 'SlNum'
from PendingOrders_UAE 
			--where convert(date,OrderDate)>'20220331'
			) b 
	on b.OrderNum=a.OrderNum and b.ItemCode=a.ItemCode


------update a set Ship_Status='Partially Available'	from PendingOrders_UAE a where isnull(wh_orderdate,'1900-01-01')>'2000-01-01' 
------and convert(date,OrderDate)>'20220331' and isnull(Ship_Status,'')=''and  isnull(Allocation,0)=0 and STock_Block<penqty  and slno=1


------update a set slno=b.SlNum,STock_Block=b.stock from PendingOrders_UAE a
------inner join (
------			select OrderNum,Allocation,PositionNum,ItemCode,plan_del_date,ROW_NUMBER() over (partition by Itemcode order by ItemCode,plan_del_date asc) 'SlNum',
------			(STOCK_490_onhand+qtyblock)stock
------			from PendingOrders_UAE where isnull(wh_orderdate,'1900-01-01')>'2000-01-01' 
------			and convert(date,OrderDate)>'20220331' and isnull(Ship_Status,'')=''and  isnull(Allocation,0)=0 ) b 
------	on b.OrderNum=a.OrderNum and b.PositionNum=a.PositionNum and b.ItemCode=a.ItemCode

update a set ship_status=b.Comment from PendingOrders_UAE a
inner join (

select OrderNum,itemcode,slno, sum(penqty) over (partition by itemcode order by Itemcode,slno rows between unbounded preceding and current row)'PenQty',

case 
when stock_qty=0  then 'Stock Not Available' 
when sum(penqty) over (partition by itemcode order by Itemcode,slno rows between unbounded preceding and current row) <= Stock_Qty then 'Stock Available'
when sum(penqty) over (partition by itemcode order by Itemcode,slno rows between unbounded preceding and current row) > Stock_Qty then 'Stock Allocated to oldest order' 

end'Comment'
 
from PendingOrders_UAE

) b on b.ItemCode=a.ItemCode and b.slno=a.slno and b.OrderNum=a.OrderNum


--update a set ship_status='Order Not released' from PendingOrders_UAE a where isnull(wh_orderdate,'1900-01-01')='1900-01-01' 

--update a set ship_status=
--	(case when replace(buyer,' ','') in ('SASIKUMARR')and  SUPPLIER like 'ELGI%'   then 'Stock Not Available - HO Manf Parts'
--	when replace(buyer,' ','') in ('VEERASAMYV')and  SUPPLIER like 'ELGI%'   then 'Stock Not Available - ACP Manf Parts'
--	else 'Stock Not Available' end) 

--from PendingOrders_UAE a where Ship_Status='Stock Not Available'

--------------------Reason 2------------

--update a set Reason2=(Case when (isnull(b.REMK,''))='Packing Completed' then 'Waiting For Invoice'
--when (isnull(b.REMK,''))='WAITING FOR ELGI PACKING' then 'In Packing'
--when (isnull(b.REMK,''))=' Waiting for Elgi Packing' then 'In Packing'
--when (isnull(b.REMK,''))='Packing In Process' then 'In Packing'
--when (isnull(b.REMK,''))='' then ''
--end) from PendingOrders_UAE a
--inner join TZZSLS602All b on b.COMPANY='490' and replace(SHPM,' ','') =ShipmentNO and replace(ITEM,' ','')=ItemCode


--update PendingOrders_UAE set Reason2='In-Packing / Billing' where isnull(Reason2,'')='' and ShipmentNO <>''


--update a set Reason2=b.Status1 from PendingOrders_UAE  a 
--inner join (
--select OrderNum,ItemCode,ShipmentNO,PositionNum,Allocation,ord_qty,penqty,delqty,Ship_Status,
--case when penqty<=Allocation then 'Fully Advised' 
--		when penqty>Allocation then 'Partialy Advised'end 'Status1'

--from PendingOrders_UAE 
--where isnull(Allocation,0)>0 and isnull(ShipmentNO,'')='' --and isnull(wh_orderdate,'1900-01-01')>'1900-01-01' 
--and convert(date,OrderDate)>'20220331'  and isnull(Reason2,'')='') b on b.ItemCode= a.ItemCode and b.OrderNum=a.OrderNum and b.PositionNum=a.PositionNum


--update PendingOrders_UAE set Reason2=(case when (STOCK_490_onhand+qtyblock)=0 and Allocation=0 and ItemType='P' then 'Stock Not Available'
--											when (STOCK_490_onhand+qtyblock)=0 and Allocation=0 and ItemType='M' then 'Stock Not Available' end) 
--							where isnull(Ship_Status,'')='' and ShipmentNO ='' and (isnull(STOCK_490_onhand,0)+isnull(qtyblock,0))=0 and Allocation=0 


--update PendingOrders_UAE set SlNo=0

--update a set slno=b.SlNum,STock_Block=b.stock from PendingOrders_UAE a
--inner join (select OrderNum,Allocation,PositionNum,ItemCode,PlannedDelDate,ROW_NUMBER() over (partition by Itemcode order by ItemCode,DeliveryDate asc) 'SlNum',
--			(STOCK_490_onhand+qtyblock)stock
--			from PendingOrders_UAE where --isnull(wh_orderdate,'1900-01-01')>'2000-01-01' and
--			 convert(date,OrderDate)>'20220331' and  isnull(Allocation,0)=0 and isnull(Reason2,'')=''
--			) b 
--	on b.OrderNum=a.OrderNum and b.PositionNum=a.PositionNum and b.ItemCode=a.ItemCode


--update a set Reason2=b.Comment from PendingOrders_UAE a
--inner join (

--select OrderNum,PositionNum,itemcode,slno,penqty,stock_block, 

--sum(penqty) over (partition by itemcode order by Itemcode,slno rows between unbounded preceding and current row)'StockIn',
--case  when (sum(penqty) over (partition by itemcode order by Itemcode,slno rows between unbounded preceding and current row))-penqty>stock_block then 'Stock Not Available' 
--when sum(penqty) over (partition by itemcode order by Itemcode,slno rows between unbounded preceding and current row)>stock_block then 'Partially Available'
--when (sum(penqty) over (partition by itemcode order by Itemcode,slno rows between unbounded preceding and current row))-penqty>stock_block then 'Stock Not Available' 
--when sum(penqty) over (partition by itemcode order by Itemcode,slno rows between unbounded preceding and current row)<=stock_block then 'Stock Available' end'Comment'
 
--from PendingOrders_UAE a 

--where convert(date,OrderDate)>'20220331' and isnull(Reason2,'')=''  and  isnull(Allocation,0)=0 

--) b on b.ItemCode=a.ItemCode and b.slno=a.slno and b.OrderNum=a.OrderNum and b.PositionNum=a.PositionNum



--update a set Reason2=
--	(case when replace(buyer,' ','') in ('SASIKUMARR')and  SUPPLIER like 'ELGI%'   then 'Stock Not Available - HO Manf Parts'
--	when replace(buyer,' ','') in ('VEERASAMYV')and  SUPPLIER like 'ELGI%'   then 'Stock Not Available - ACP Manf Parts'
--	else 'Stock Not Available' end) 

--from PendingOrders_UAE a where Ship_Status='Stock Not Available'


--update a set Next_Due_Date1=ReleaseDate from PendingOrders_UAE a
--left  join (select t$orno,T$pono,replace(t$Item,' ','' )'item',MAX(t$lddt) as ReleaseDate from wms.dbo.wms_order_status group by t$orno,T$pono,replace(t$Item,' ','' )) b
--on b.t$orno=a.ordernum and b.T$pono=a.positionnum and b.item=a.itemcode 

--create  table #temp(
--parentitem nvarchar(30),
--Qty decimal(19,2)
--) 

--insert into #temp
--select b.parentitem,sum(parentqty) from 
-- (select  substring(referencedocument,3,40) as prodorder,parentitem, avg(parentqty)parentqty
--	from WMS.DBO.line_po WHERE (status_desc <>'Shipped complete' AND lnordstatus <>'Closed')
--	group by substring(referencedocument,3,40),parentitem)b 
--	group by b.parentitem

	
--update PendingOrders_UAE set slno=0 where ItemType='M'

--update a set slno=b.SlNum from PendingOrders_UAE a
--inner join (select OrderNum,Allocation,PositionNum,ItemCode,PlannedDelDate,ROW_NUMBER() over (partition by Itemcode order by ItemCode,DeliveryDate asc) 'SlNum'
--			from PendingOrders_UAE
--			where convert(date,OrderDate)>'20220331' and ItemType='M' and Ship_Status in ('Stock Not Available','Partially Available','Partially Advised')
--			) b 
--	on b.OrderNum=a.OrderNum and b.PositionNum=a.PositionNum and b.ItemCode=a.ItemCode


--update a set Reason2=b.Comment,Ship_Status=b.Comment from PendingOrders_UAE a
--inner join (

--		select OrderNum,PositionNum,itemcode,slno,penqty, 
--		sum(penqty) over (partition by itemcode order by Itemcode,slno rows between unbounded preceding and current row)'CummulativeQty',
--		case  when (sum(penqty) over (partition by itemcode order by Itemcode,slno rows between unbounded preceding and current row))>b.Qty then 'Stock Not Available' 
--		when sum(penqty) over (partition by itemcode order by Itemcode,slno rows between unbounded preceding and current row)<=b.Qty then 'Kits-WIP'
--		end'Comment'
--		from PendingOrders_UAE a 
--		inner join #temp b on b.parentitem=a.ItemCode
--		where convert(date,OrderDate)>'20220331' and ItemType='M' 
--		and Ship_Status in ('Stock Not Available','Partially Available','Partially Advised') 

--) b on b.ItemCode=a.ItemCode and b.slno=a.slno and b.OrderNum=a.OrderNum and b.PositionNum=a.PositionNum


update a set a.Custname=isnull(c.t_nama,Custname) from PendingOrders_UAE a
left join TTDSLS400ALL b on b.t_orno=a.OrderNum and b.t_sotp=a.ordertype
left join TTCCOM100400 c on c.t_bpid=b.t_stbp
where a.Custname<>c.t_nama

--alter table PendingOrders_UAE add Order_status nvarchar(30)
update PendingOrders_UAE set order_status =a.Order_status  from (
select ordernum,itemcode,
case when 
DATEADD(DAY,Lead_days,OrderDate) >=convert(date,getdate()) and 
Ship_Status = 'Stock Available' then 'Within due'
else 'Overdue' end 'Order_status'
from PendingOrders_UAE
)a where PendingOrders_UAE.OrderNum=a.OrderNum and pendingorders_uae.ItemCode=a.itemcode


end

GO

