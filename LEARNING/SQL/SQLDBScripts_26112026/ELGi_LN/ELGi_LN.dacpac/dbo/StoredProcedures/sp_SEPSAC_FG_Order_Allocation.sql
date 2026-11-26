
--exec [sp_SEPSAC_FG_Order_Allocation]
CREATE proc  [dbo].[sp_SEPSAC_FG_Order_Allocation] as

--alter table sepsac_pending_Orders add Ageing_days int
--alter table sepsac_pending_Orders add Ageing_Slab nvarchar(50)
--alter table sepsac_pending_Orders add Ageing_Slab_sorting int



truncate table SEPSAC_Pending_orders

insert into SEPSAC_Pending_orders 
select *,'','','','','','',''  From (
select ZONE,OrderMonth,areacode,areaname ,a.Company,dpst,dpstname,PositionNum,OrderNum,
ordertype,origin,Baan_orderno ,Baan_positionno,DeliveryDate,ItemCode,Item_desc
,TaxCode,Price,DiscPerc1,buyer,Indent ,OrderDate,CustCode,Custname,blocked,
sum(value)as value,sum(ord_qty_new)ord_qty,
sum(delqty)delqty,sum(PendQty) as penqty,sum(ShipQty)as ShipQty,sum(t_oamt)t_oamt,
currency,CurrRate,cust_req_date,Sales_Inv_Address,Cust_Inv_Address,
--,max(g.NAMA)'Sale',
PendingType
from (
select *,ord_qty-isnull(cancel_qty,0) as ord_qty_new,
case when  ord_qty-isnull(cancel_qty,0)-isnull(PendQty,0)=0 then 'Open'
else 'Partial Delivery' end as PendingType
From pending_orders 

where dpst in ('90016','90020') and 
ltrim(rtrim(custcode))not in ('CU1K02388','CU1E00893','CU1L00543','CU1E00015',
'CU1E00791','CU1E00008','CU1E00814','CU1E00914','CU1E00477','CU1E00679',
'CU1E00263','CU1E00926','CU1E00396','CU1E00887','CU1E99999','CU1E01015')
and  OrderType IN(select distinct saleordertype  from saletype_master where Sales_Category not in (1)) and Company ='401'

)a


group by dpst,dpstname,PositionNum,OrderNum,ordertype,origin,Baan_orderno ,
Baan_positionno,DeliveryDate,ItemCode,Item_desc,TaxCode,Price,DiscPerc1,
buyer ,OrderDate,CustCode,Custname,Indent,a.company,areacode,areaname,ZONE,OrderMonth,blocked,
currency,CurrRate,cust_req_date,Sales_Inv_Address,Cust_Inv_Address,PendingType
)a
where penqty  >0

and concat(a.Company,ordertype) not in ('490326','490346','490226','490246','401344','450244')
order by OrderDate

--Order classfication from SR- OSL00125046


update SEPSAC_Pending_orders set orderclassification= 'Unclear Orders' where 
ltrim(rtrim(ordernum)) in (select distinct ltrim(rtrim(orno)) 'Orno' from SEPSAC_FG_Order_Allocation_Order_Category)

update SEPSAC_Pending_orders set orderclassification= 'Clear Orders' where orderclassification is null or orderclassification =''

---Ageing to be calculated 
update SEPSAC_Pending_orders set ageing_days= DATEDIFF(DAY,OrderDate,getdate())

update SEPSAC_Pending_orders set Ageing_Slab = '0-7 days' where ageing_days between 0 and 7
update SEPSAC_Pending_orders set Ageing_Slab = '8-14 days' where ageing_days between 8 and 14
update SEPSAC_Pending_orders set Ageing_Slab = '15-21 days' where ageing_days between 15 and 21
update SEPSAC_Pending_orders set Ageing_Slab = '22-28 days' where ageing_days between 22 and 28
update SEPSAC_Pending_orders set Ageing_Slab = '29-35 days' where ageing_days between 29 and 35
update SEPSAC_Pending_orders set Ageing_Slab = '36-42 days' where ageing_days between 36 and 42
update SEPSAC_Pending_orders set Ageing_Slab = '43-49 days' where ageing_days between 43 and 49
update SEPSAC_Pending_orders set Ageing_Slab = '50-56 days' where ageing_days between 50 and 56
update SEPSAC_Pending_orders set Ageing_Slab = '>56 days' where ageing_days  > 56 

update SEPSAC_Pending_orders set Ageing_Slab_sorting =1 where Ageing_Slab='0-7 days' 
update SEPSAC_Pending_orders set Ageing_Slab_sorting =2 where Ageing_Slab= '8-14 days' 
update SEPSAC_Pending_orders set Ageing_Slab_sorting =3 where Ageing_Slab= '15-21 days'
update SEPSAC_Pending_orders set Ageing_Slab_sorting =4 where Ageing_Slab= '22-28 days'
update SEPSAC_Pending_orders set Ageing_Slab_sorting =5 where Ageing_Slab= '29-35 days'
update SEPSAC_Pending_orders set Ageing_Slab_sorting =6 where Ageing_Slab= '36-42 days'
update SEPSAC_Pending_orders set Ageing_Slab_sorting =7 where Ageing_Slab= '43-49 days'
update SEPSAC_Pending_orders set Ageing_Slab_sorting =8 where Ageing_Slab= '50-56 days'
update SEPSAC_Pending_orders set Ageing_Slab_sorting =9 where Ageing_Slab= '>56 days' 


--alter table SEPSAC_Pending_orders add FG_Stock float
update SEPSAC_Pending_orders set FG_Stock=a.FG_Stock  from (

select ltrim(rtrim(item)) 'Item',sum(convert(float,qhnd))-sum(convert(float,QBLK)) 'FG_Stock' from TWHWMD215ALL

where CWAR in ('257','246')
group by ltrim(rtrim(item)) 
 )a where ltrim(rtrim(SEPSAC_Pending_orders.itemcode))=a.Item

 --Since in this FG block not considered
-- update SEPSAC_Pending_orders set FG_Stock=a.FG_Stock  from (

--select ltrim(rtrim(item)) 'Item',sum(convert(float,qhnd))-sum(convert(float,QBLK)) 'FG_Stock' from TWHWMD215ALL

--where CWAR in ('257','246')
--group by ltrim(rtrim(item)) 
-- )a where ltrim(rtrim(SEPSAC_Pending_orders.itemcode))=a.Item

 update SEPSAC_Pending_orders set FG_Stock=a.FG_Stock_new  from (

SELECT ltrim(rtrim(a.item)) 'Item',

case when ltrim(rtrim(a.item))=ltrim(rtrim(b.Item))
	and  sum(convert(float,a.qhnd))-sum(convert(float,a.QBLK)) <> isnull(b.QHND,0) then  isnull(b.QHND,0)
	else sum(convert(float,a.qhnd))-sum(convert(float,a.QBLK)) end 'FG_Stock_new',
sum(convert(float,a.qhnd))-sum(convert(float,a.QBLK)) 'FG_Stock' ,
sum(convert(float,a.QHND)) 'WHWMD', isnull(b.QHND,0) 'QHND'
from TWHWMD215ALL a
left join (select distinct ltrim(rtrim(item)) 'Item',
case when sum(convert(float,qhnd))>0 and bout<>1 then sum(convert(float,qhnd))-sum(convert(float,QBLK)) end 'QHND' from TWHLTC500ALL
where  COMPANY='401' and CWAR in ('257','246') and bout<>1
group by item,BOUT
)b
on ltrim(rtrim(a.item))=ltrim(rtrim(b.item))

where a.CWAR in ('257','246') and a.COMPANY='401' 
--and ltrim(rtrim(a.item)) = 'B003308170003'

group by ltrim(rtrim(a.item)),b.QHND,b.Item
--order by Item

 )a where ltrim(rtrim(SEPSAC_Pending_orders.itemcode))=a.Item


 update SEPSAC_Pending_orders set Cust_Req_Date= OrderDate where Cust_Req_Date is null

--alter table SEPSAC_Pending_orders add SNo int 
--delete from SEPSAC_Pending_orders where shipmentno is not null

update SEPSAC_Pending_orders set SNo=a.SINo from (
select ordernum,orderdate,cust_req_date,ltrim(rtrim(itemcode)) 'Itemcode',ROW_NUMBER() over (partition by ltrim(rtrim(itemcode)) order by cust_req_date asc) 'SINo' 
from SEPSAC_Pending_orders 
where orderclassification='Clear Orders'
--where cust_req_date is not null
--order by ordernum,orderdate
)a 
where ltrim(rtrim(SEPSAC_Pending_orders.itemcode))=a.Itemcode and ltrim(rtrim(SEPSAC_Pending_orders.ordernum))=a.ordernum



--alter table SEPSAC_Pending_orders add stock_status nvarchar(150)
update SEPSAC_Pending_orders set stock_status=a.stock_status from (

select distinct ordernum,ltrim(rtrim(itemcode)) 'Itemcode',FG_Stock,SNo,orderdate,
sum(ord_qty) over (partition by itemcode order by sno rows between unbounded preceding and current row) 'Running_Ord_Qty',
case 
 when sum(ord_qty) over (partition by itemcode order by sno rows between unbounded preceding and current row) <= fg_stock then 'Avl'
else 'Not avl' end 'Stock_Status'
from SEPSAC_Pending_orders 
where orderclassification='Clear Orders'
--where orderdate between dateadd(d,-30,getdate()) and getdate () 
)a 
where ltrim(rtrim(SEPSAC_Pending_orders.itemcode))=a.Itemcode and ltrim(rtrim(SEPSAC_Pending_orders.ordernum))=a.ordernum





--select * from SEPSAC_Pending_orders

GO

