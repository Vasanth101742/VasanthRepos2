--EXEC sp_AM_Billing_Visibility


CREATE proc [dbo].[sp_AM_Billing_Visibility] as
begin 

truncate table AM_Billing_Visibility

insert into AM_Billing_Visibility 

select custcode,Custname,Division 'Region',areacode,areaname,Baan_orderno 'Zone',OrderNum,OrderDate,Indent 'PO_Ref',
itemcode,Item_desc,ord_qty,delqty,penqty,STOCK_490_onhand 'Stock_qty',QtyBlock 'Block_Qty',Allocation 'Advised_Qty',ShipmentNO,ShipQty,ItemType,ordertype,
ship_status,dpst,dpstname,Lead_days,CurrentDate,Wh_orderDate,PlannedDelDate,FinalPrice,Amount,Order_status,ExpecDay,Comment,'' 'Blockstatus','GSC' GSC_HO

,'','','','','','','','','','','','',''
from GR_GSC_SupplyPlan

where dpst in (90013,90028,90031,90063,90075,90082,90083,90084,90025) and ordertype in ('215','242','250','315','342')

update AM_Billing_Visibility set blockstatus= a.block_status from
(select COMPANY,hdst,orno,SOTP, 
case when HDST='40' then 'Yes' else 'No' end 'Block_Status'
from [ELGi_WMS].dbo.[TTDSLS400490] where company='490') a
where AM_Billing_Visibility.ordernum=a.orno and AM_Billing_Visibility.OrderType=a.sotp

--HO

insert into AM_Billing_Visibility

SELECT CUSTCODE,CUSTNAME,''REGION,AREACODE,AREANAME,ZONE,ORDERNUM,ORDERDATE,Indent 'PO_REF',ITEMCODE,ITEM_DESC,SUM(ORD_QTY)'Ord_qty',sum(delqty) 'Del_Qty'
,sum(penqty) 'Pend_qty',0 'Stock_qty',0 'Block_qty',0 'Advised_Qty','' 'Shipment_no' ,sum(shipqty) 'Ship_qty','' Item_type,ordertype,
'' p_status,dpst,dpstname,lead_time, getdate() currentdate, null whs_orderdate,null 'Planned_del_date',SUM(T_OAMT) 'Pend_Value',SUM(T_OAMT)/1000000 'Amount','' Order_Status,
'' 'Expec Day','' 'Comment',blocked 'BlockStatus', 'HO' 'GSC_HO'
,'','','','','','','','','','','','',''
FROM (
select A.*, isnull(b.LEADTIME,90) as LEAD_TIME,
datediff(dd,OrderDate,getdate()) as Age,isnull(b.ABCclass,'C')'ABCclass'
 from (
	select * From (
select ZONE,OrderMonth,areacode,areaname ,company,dpst,dpstname,PositionNum,OrderNum,ordertype,origin,Baan_orderno ,Baan_positionno,DeliveryDate,ItemCode,Item_desc
,TaxCode,Price,DiscPerc1,buyer,Indent ,OrderDate,CustCode,Custname,blocked,t_rats_1,
sum(value)as value,sum(ord_qty_new)ord_qty,
sum(delqty)delqty,sum(PendQty)as penqty,sum(ShipQty)as ShipQty,sum(t_oamt)t_oamt
 from (
	select *,ord_qty-isnull(cancel_qty,0) as ord_qty_new From pending_orders 
	WHERE  ltrim(rtrim(custcode))not in ('CU1K02388','CU1E00893','CU1L00543','CU1E00015','CU1E00791',
'CU1E00008','CU1E00814','CU1E00914','CU1E00477','CU1E00679','CU1E00263','CU1E00926','CU1E00396','CU1E00887','CU1E99999','CU1E01015')
and concat(company,ordertype) not in('450a16','450285','401246')
and  OrderType IN(select distinct saleordertype  from saletype_master where Sales_Category not in (1))
and convert(date,OrderDate) >='2017-07-01'
and OrderNum NOT IN ('242053591','235001986','235002010','235002178','201004166','235002479','343012156','343012158',
'242031446','235002919','235003190','235003230','343017074')   -- Modified by raviprasath
	 )a
group by dpst,dpstname,PositionNum,OrderNum,ordertype,origin,Baan_orderno ,Baan_positionno,DeliveryDate,ItemCode,Item_desc
,TaxCode,Price,DiscPerc1,buyer ,OrderDate,CustCode,Custname,Indent,company,areacode,areaname,ZONE,OrderMonth,blocked,t_rats_1
)a
where penqty  >0
AND company in (401,450)
and 	dpst in ('90015','90034','90038','90079','90084','90085','90029','90025')
AND ordertype IN ('211','311','SER')
--and OrderDate between @fromdate and @todate
)A
--	LEFT JOIN (select ltrim(rtrim(elgi_itemcode))elgi_itemcode,max(elgi_leadtimeindays)LEADTIME From Product
--where (elgi_leadtimeindays is not null and elgi_leadtimeindays>0) group by ltrim(rtrim(elgi_itemcode)))b
--Gokul
	LEFT JOIN (select ltrim(rtrim(ItemCode))ItemCode,max(LeadDays)LEADTIME,max(ABCclass)'ABCclass' From GSC_LeadTime
where (LeadDays is not null and LeadDays>0) group by ltrim(rtrim(ItemCode)))b

ON LTRIM(RTRIM(A.ITEMCODE))=LTRIM(RTRIM(B.ItemCode))
)A

		where concat(company,ordertype) not in ('490326','490346','490226','490246','401344','450244')

group by CustCode,Custname,areacode,areaname,zone,ordernum,OrderDate,Indent,ItemCode,item_desc,ordertype,Dpst,Dpstname,LEAD_TIME,Blocked

	
UPDATE AM_Billing_Visibility SET Zone='North' where AM_Billing_Visibility.ordernum in ('204063700','251025833','204063699')

--alter table AM_Billing_Visibility add App1status nvarchar(50)
--alter table AM_Billing_Visibility add App1Name nvarchar(100)

update AM_Billing_Visibility set App1Status=a.App1Status_def,App1Name=a.App1Name,
								 App2Status=a.App2Status_def,App2Name=a.App2Name,
								 App3Status=a.App3Status_def,App3Name=a.App3Name,
								 App4Status=a.App4Status_def,App4Name=a.App4Name,
								 App5Status=a.App5Status_def,App5Name=a.App5Name,
							     App6Status=a.App6Status_def,App6Name=a.App6Name
									  from  (
select *,
case when App1Status=1 then 'Pending'
	 when App1Status=2 then 'Approved'
	 when App1Status=3 then 'Rejected' end 'App1Status_def',
case when App2Status=1 then 'Pending'
	 when App2Status=2 then 'Approved'
	 when App2Status=3 then 'Rejected' end 'App2Status_def',
case when App3Status=1 then 'Pending'
	 when App3Status=2 then 'Approved'
	 when App3Status=3 then 'Rejected' end 'App3Status_def',
case when App4Status=1 then 'Pending'
	 when App4Status=2 then 'Approved'
	 when App4Status=3 then 'Rejected' end 'App4Status_def',
case when App5Status=1 then 'Pending'
	 when App5Status=2 then 'Approved'
	 when App5Status=3 then 'Rejected' end 'App5Status_def',
case when App6Status=1 then 'Pending'
	 when App6Status=2 then 'Approved'
	 when App6Status=3 then 'Rejected' end 'App6Status_def'
from [dbo].[GR_CreditBlock_LN] 
)a where AM_Billing_Visibility.ordernum=a.OrderNum



update AM_Billing_Visibility set App1status='' where App1Name is null
update AM_Billing_Visibility set App2status='' where App2Name is null
update AM_Billing_Visibility set App3status='' where App3Name is null

update AM_Billing_Visibility set App4status='' where App4Name is null
update AM_Billing_Visibility set App5status='' where App5Name is null
update AM_Billing_Visibility set App6status='' where App6Name is null







end

GO

