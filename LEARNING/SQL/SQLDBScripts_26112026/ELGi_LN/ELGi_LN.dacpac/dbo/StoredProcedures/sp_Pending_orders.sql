--Exec [sp_Pending_orders]
CREATE Proc [dbo].[sp_Pending_orders] as
begin

Truncate table Pending_orders
--alter table Pending_orders add Price_LN float

Insert into Pending_orders(Company,CustCode,ItemCode,OrderDate,OrderNum,PositionNum,seq,
ord_qty,BackorderQty,TaxCode,DeliveryDate,
WareHouse,Price,DiscPerc1,DiscPerc2,
t_rats_1,t_oamt,pendvalue_foreigncurrency,Value,diffdays,
SlsUnit,ConvFactorSales,SlsPriceUnit,ConvFactorPrice,Price_LN)
Select Company,CustCode,ItemCode,OrderDate,OrderNum,PositionNum,t_sqnb,
sum(t_qoor) t_qoor,sum(t_qbbo) t_qbbo,TaxCode,max(DeliveryDate) DeliveryDate,
WareHouse,sum(Price) Price,
DiscPerc1,DiscPerc2,t_rats_1,
sum(isnull(t_oamt,0)) t_oamt,
sum(isnull(t_oamt,0)) pendvalue_foreigncurrency,
sum(Value) Value,
sum(diffdays) diffdays,
SlsUnit,ConvFactorSales,SlsPriceUnit,ConvFactorPrice,sum(LN_Price)
from(
select L.Company,L.CustCode,L.ItemCode,convert(date,L.OrderDate) OrderDate,L.OrderNum ,L.PositionNum,L.t_sqnb,--L.invnum,
L.t_qoor,L.t_qbbo,L.TaxCode,L.DeliveryDate,L.WareHouse,
(l.Price* (case when h.t_rats_1=0 or h.t_rats_1 is null then 1 else h.t_rats_1 end)) as Price,
DiscPerc1,DiscPerc2,H.t_rats_1,L.t_oamt, 
(l.t_oamt* (case when h.t_rats_1=0 or h.t_rats_1 is null then 1 else h.t_rats_1 end)) as Value,
DATEDIFF(dd,L.OrderDate,getdate())as diffdays,
L.SlsUnit,L.ConvFactorSales,L.SlsPriceUnit,L.ConvFactorPrice,l.Price 'LN_Price'
From Sales_Header h
inner join (Select * from Sales_Lines where orderdate>='2022-04-01'
and t_clyn<>1
and t_qoor > 0
and t_dltp<>1
--and concat(company,ordernum)='401290028173'
) L
on H.Company =L.Company 
and ltrim(rtrim(H.OrderNum))=ltrim(rtrim(L.OrderNum))
)a
group by Company,CustCode,ItemCode,OrderDate,OrderNum,PositionNum,t_sqnb,TaxCode,
WareHouse,DiscPerc1,DiscPerc2,t_rats_1,
SlsUnit,ConvFactorSales,SlsPriceUnit,ConvFactorPrice

--Fetching Shipping Qty
Update Pending_orders set ShipQty=a.ShipQty
from (
select COMPANY,WORN as OrderNum , WPON as PosNum,WSEQ,--SHPM,
sum(convert(float,QSHP))as ShipQty 
from TWHINH431ALL 
where convert(float,QSHP)>0 and company in (401) and WORG =1
--and concat(COMPANY,WORN,WPON)='400210000281'
--'40120403525540'
--'40120403528630'
group by COMPANY,WORN,WPON,WSEQ--,SHPM
union all
select COMPANY,t$orno as OrderNum , t$pono as PosNum,T$SEQN,--T$SHPM,
sum(t$qpli)as ShipQty  from  TWHINH480ALL
where t$qpli>0 and COMPANY in (490) 
--and concat(COMPANY,WORN,WPON)='40120403528630'
group by COMPANY,t$orno ,t$pono,T$SEQN--,T$SHPM
)a
where Pending_orders.Company=a.COMPANY
and Pending_orders.OrderNum=a.OrderNum
and Pending_orders.PositionNum=a.PosNum
and Pending_orders.seq=a.WSEQ

--Fetching Deliverd Qty
Update Pending_orders set DelQty=c.DelQty,
SlsPriceUnit_Delivery=c.CUPS,
ConvFactorPrice_Delivery=c.CVPS,
CUNS_Delivery=c.CUNS,
DeliveryDate=c.DLDT
from (select COMPANY,ORNO,PONO,SQNB,CUPS,CVPS,CUNS,max(DLDT) DLDT,
sum(QIDL) as DelQty from 
sales_delivery
where DLDT>='2022-04-01'
and QIDL>0 
--and concat(company,ORNO)='401203009324'
--'40120300726510'
group by COMPANY,ORNO,PONO,SQNB,CUPS,CVPS,CUNS
)c
where Pending_orders.Company=c.COMPANY
and Pending_orders.OrderNum=c.ORNO
and Pending_orders.PositionNum=c.PONO
and Pending_orders.seq=c.SQNB
--and Pending_orders.DeliveryDate=c.DLDT



--update pending_orders set Cancel_Qty=a.qty 
--from (select company,OrderNum,PositionNum,t_clyn,sum(t_qoor)as qty 
--From Sales_Lines 
--where t_clyn=1 and t_qoor>0 
--group by OrderNum,PositionNum,t_clyn,Company 
--)a
--where a.Company =pending_orders.Company 
--and a.OrderNum =pending_orders.OrderNum 
--and a.PositionNum =pending_orders.PositionNum 

--update Pending_orders set BackorderQty=BackorderQty-t_qoor
--from (select company,ordernum,positionnum,t_clyn,t_qoor from sales_lines
--where t_clyn=1 and t_qoor <>0
----and concat(company,ordernum)='401203009324'
--)a
--where Pending_orders.company=a.company
--and Pending_orders.ordernum=a.ordernum
--and Pending_orders.positionnum=a.positionnum
--and Pending_orders.BackorderQty<>0




update Pending_orders set PendQty=ord_qty-isnull(BackorderQty,0)-isnull(DelQty,0)
delete from Pending_orders where PendQty between -0.5 and 0.5

--For UOM Mismatch Cases between OrderQty and Delivery Qty

update Pending_orders set DelQty=DelQty/ConvFactorPrice_Delivery
where SlsPriceUnit_Delivery<>CUNS_Delivery

update Pending_orders set PendQty=ord_qty-isnull(BackorderQty,0)-isnull(DelQty,0)

delete from Pending_orders where PendQty between -0.5 and 0.5



delete from Pending_Orders  where CONCAT(company,ordertype) in
(select distinct CONCAT(company,saleordertype)as type  From saletype_master where Sales_Category =1)
delete from  pending_orders where company=401 and ordertype in ('214','226','244','285')

update pending_orders set Cust_Req_Date=a.Cust_Date
from (select distinct SaleOrderno,PONO,item,Cust_Date from utn_ver1)a
where pending_orders.OrderNum=a.SaleOrderno
and pending_orders.PositionNum=a.PONO
and ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(a.Item))

update pending_orders set Cust_Req_Date=a.elgi_requesteddispatchdatebycustomer
from (select distinct substring(elgi_aonumber,11,3) as Company,--elgi_aonumber,
substring(elgi_aonumber,1,9) as elgi_aonumber ,elgi_requesteddispatchdatebycustomer 
from [ELGI_CRM].dbo.Salesorder_CRM
where elgi_requesteddispatchdatebycustomer is not null and elgi_aonumber is not null)a
where pending_orders.OrderNum=a.elgi_aonumber
and pending_orders.Company=a.Company

update pending_orders set plan_del_date=a.t_ddta,ISSS=A.InvIssStat  
from (select distinct Company,OrderNum,PositionNum,convert(date,t_ddta) t_ddta,InvIssStat from Sales_Lines) a
where pending_orders.Company =a.Company
and pending_orders.OrderNum =a.OrderNum
and pending_orders.PositionNum =a.PositionNum 

update pending_orders set plan_recp_date=a.planrecdate  
from (select distinct Company,OrderNum,PositionNum,convert(date,planrecdate) planrecdate from Sales_Lines) a
where pending_orders.Company =a.Company
and pending_orders.OrderNum =a.OrderNum
and pending_orders.PositionNum =a.PositionNum


update pending_orders set Dpst=h.Dpst,
ordertype=H.ordertype,
origin=h.origin,
Indent=case when h.t_corn=' ' then h.RefA else h.t_corn end
from (select distinct Company,OrderNum,ordertype,Dpst,origin,RefA,t_corn From Sales_Header where dpst not like '%[a-z]%') h
where pending_orders.OrderNum =h.OrderNum 
and pending_orders.Company =h.Company 

update pending_orders set orjn='EDI' where Origin=3 
update pending_orders set orjn='Manual' where Origin<>3 

-----------------DPST Update for 551,552---------------------------------
update Pending_Orders   set  dpst  = TTCIBD001551.dpst 
from 
(select b.dpst,item from TTCIBD001551 a 
inner join  producttype_aust_master b on a.CTYP = b.t$ctyp) TTCIBD001551
where Pending_Orders.Company=551
and ltrim(rtrim(TTCIBD001551.item)) = ltrim(rtrim(Pending_Orders.ItemCode )) 


update Pending_Orders  set  dpst  = TTCIBD001552.dpst from 
(select b.dpst,item from  TTCIBD001552 a
inner join  producttype_indo_master b on a.CTYP = b.t$ctyp) TTCIBD001552
where Pending_Orders.Company=552
and ltrim(rtrim(TTCIBD001552.item)) = ltrim(rtrim(Pending_Orders.ItemCode)) 


--------------End: DPST Update for 551,552--------------------------------
-----------------Buyer, Supplier Update-----------------------------------
	
update Pending_orders  set Buyer= a.BUYER,supplier=a.SUPPLIER 
From (
SELECT  A.ITEM ,B.NAMA  AS SUPPLIER ,C.NAMA AS BUYER 
FROM (SELECT DISTINCT LTRIM(RTRIM(ITEM))AS ITEM,OTBP,BUYR 
FROM TTDIPU001ALL WHERE COMPANY =490)A
LEFT OUTER JOIN (select * from TTCCOM100ALL where company=400) B
ON A.OTBP =B.bpid 
LEFT OUTER JOIN (select  EMNO, NAMA,COMPANY  From TTCCOM001ALL 
where company=400 and nama is not null and NAMA <>'')C
ON A.BUYR =C.EMNO
)a
where LTRIM(RTRIM(Pending_orders.ItemCode)) =LTRIM(RTRIM(a.ITEM)) 
AND Pending_orders.Company =490


update Pending_orders set Buyer= a.BUYER,supplier=a.SUPPLIER
from (
SELECT A.ITEM ,B.NAMA AS SUPPLIER ,C.NAMA AS BUYER 
FROM(SELECT DISTINCT LTRIM(RTRIM(ITEM))AS ITEM,OTBP,BUYR 
FROM TTDIPU001ALL WHERE COMPANY <>490)A
LEFT OUTER JOIN (select * from TTCCOM100ALL where company=400) B
ON A.OTBP =B.bpid 
LEFT OUTER JOIN (select  EMNO, NAMA,COMPANY 
From TTCCOM001ALL where company=400 and nama is not null and NAMA <>'')C
ON A.BUYR =C.EMNO
where c.NAMA is not null
--where ltrim(rtrim(A.ITEM))='S04208'
)a
where LTRIM(RTRIM(Pending_orders.ItemCode)) =LTRIM(RTRIM(a.ITEM)) 
AND Pending_orders.Company <>490

update Pending_orders set Buyer= a.BUYER,supplier=a.SUPPLIER
from (
SELECT A.ITEM ,B.NAMA AS SUPPLIER ,C.NAMA AS BUYER 
FROM(SELECT DISTINCT LTRIM(RTRIM(ITEM))AS ITEM,OTBP,BUYR 
FROM TTDIPU001ALL WHERE COMPANY =600)A
LEFT OUTER JOIN (select * from TTCCOM100ALL where company=600) B
ON A.OTBP =B.bpid 
LEFT OUTER JOIN (select  EMNO, NAMA,COMPANY 
From TTCCOM001ALL where company=600 and nama is not null and NAMA <>'')C
ON A.BUYR =C.EMNO
where c.NAMA is not null
--where ltrim(rtrim(A.ITEM))='S04208'
)a
where LTRIM(RTRIM(Pending_orders.ItemCode)) =LTRIM(RTRIM(a.ITEM)) 
AND Pending_orders.Company =600


-----------------End: Buyer, Supplier Update--------------------------------

update pending_orders set Baan_orderno=b.OORN,Baan_positionno=b.OPOS
from (select * From tsacom999all where type=2)b
where ltrim(rtrim(OrderNum)) =ltrim(rtrim(b.NORN ))
and ltrim(rtrim(PositionNum)) =ltrim(rtrim(b.NPOS))


update pending_orders set custname=a.custname1
from vw_Business_Partner a
where pending_orders.custcode=a.custcode

update pending_orders set custname=a.SEAK 
from (select * from TTCCOM110ALL where company=551) a
where pending_orders.custcode=a.OFBP 
and pending_orders.Company in (551)

update pending_orders set custname=a.SEAK 
from (select * from TTCCOM110ALL where company=552) a
where pending_orders.custcode=a.OFBP 
and pending_orders.Company in (552)


update pending_orders set dpstname=a.DPSTName
from vw_DPST_MASTER a
where pending_orders.dpst=a.dpstcode


update pending_orders set dpstname=a.DPSTName
from DPST_MASTER_ATS a
where pending_orders.dpst=a.dpstcode
and pending_orders.company like '6%'

-------------------------Area, Zone Update---------------------------------

update Pending_orders set areacode=''

update Pending_orders set areacode=a.Area  
from Sales_Header a
where Pending_orders.company =a.Company 
and Pending_orders.OrderNum =a.OrderNum 

update Pending_orders set areacode=a.CustAreaCode 
from vw_Business_Partner a
where ltrim(rtrim(Pending_orders.CustCode))=ltrim(rtrim(a.custcode)) 
and ltrim(rtrim(Pending_orders.areacode))=''
and Pending_orders.company not in (551,552,553,951)

update Pending_orders set areacode =b.IndentArea
from (select distinct concat('0',substring(RefA,2,2)) IndentArea,* From Sales_Header 
where len(ltrim(rtrim(RefA)))=9 and RefA is not null
and substring(Area,1,1)='0'
and concat('0',substring(ltrim(rtrim(RefA)),2,2)) in (select Areacode from vw_AREA_MASTER)
and LEN(CDF_MSID)<2  --Logic Added on 09-12-2020
--and concat('0',substring(RefA,2,2)) like '%[0-9]%'
--and concat('0',substring(RefA,2,2)) not like '%00%'
--and concat('0',substring(RefA,2,2)) not like '%[A-Z]%'
)b
where Pending_orders.company =b.Company 
and Pending_orders.OrderNum =b.OrderNum
and Pending_orders.areacode like '0%' 
AND Pending_orders.company not in (551,552,553,951)  and Pending_Orders.areacode=''

update Pending_orders set areacode=a.CustAreaCode 
from vw_Business_Partner  a
where ltrim(rtrim(Pending_orders.CustCode))=ltrim(rtrim(a.custcode)) 
and Pending_orders.areacode is null
and Pending_orders.company not in (551,552,553,951)

update Pending_orders set areacode=a.CustAreaCode 
from vw_Business_Partner_IAS a
where ltrim(rtrim(Pending_orders.CustCode))=ltrim(rtrim(a.custcode)) 
and ltrim(rtrim(Pending_orders.areacode))=''
and Pending_orders.company in (951)

update Pending_orders set areacode=a.CustAreaCode 
from vw_Business_Partner_IAS  a
where ltrim(rtrim(Pending_orders.CustCode))=ltrim(rtrim(a.custcode)) 
and Pending_orders.areacode is null
and Pending_orders.company in (951)


update Pending_orders set areacode=a.CustAreaCode 
from vw_Business_Partner_551 a
where ltrim(rtrim(Pending_orders.CustCode))=ltrim(rtrim(a.custcode)) 
and ltrim(rtrim(Pending_orders.areacode))=''
and Pending_orders.company in (551)

update Pending_orders set areacode=a.CustAreaCode 
from vw_Business_Partner_551  a
where ltrim(rtrim(Pending_orders.CustCode))=ltrim(rtrim(a.custcode)) 
and Pending_orders.areacode is null
and Pending_orders.company in (551)

update Pending_orders set areacode=a.CustAreaCode 
from vw_Business_Partner_552 a
where ltrim(rtrim(Pending_orders.CustCode))=ltrim(rtrim(a.custcode)) 
and ltrim(rtrim(Pending_orders.areacode))=''
and Pending_orders.company in (552)

update Pending_orders set areacode=a.CustAreaCode 
from vw_Business_Partner_552  a
where ltrim(rtrim(Pending_orders.CustCode))=ltrim(rtrim(a.custcode)) 
and Pending_orders.areacode is null
and Pending_orders.company in (552)

update Pending_orders set areacode=a.CustAreaCode 
from vw_Business_Partner_553 a
where ltrim(rtrim(Pending_orders.CustCode))=ltrim(rtrim(a.custcode)) 
and ltrim(rtrim(Pending_orders.areacode))=''
and Pending_orders.company in (553)

update Pending_orders set areacode=a.CustAreaCode 
from vw_Business_Partner_553  a
where ltrim(rtrim(Pending_orders.CustCode))=ltrim(rtrim(a.custcode)) 
and Pending_orders.areacode is null
and Pending_orders.company in (553)


update Pending_orders set areacode=a.Area  
from Sales_Header a 
where Pending_orders.company =a.Company and a.Company='490'
and Pending_orders.OrderNum =a.OrderNum 


--Special Case: Updating Areacode for Australia, Indonesia and Malaysia companies (551,552)
update Pending_orders set areacode='631' where company=551 and OrderDate >='2017-04-01' and ltrim(rtrim(areacode))='' 
update Pending_orders set areacode='624' where company=552 and OrderDate >='2017-04-01' and ltrim(rtrim(areacode))=''
update Pending_orders set areacode='622' where company=553 and OrderDate >='2017-04-01' and ltrim(rtrim(areacode))=''

update Pending_orders set areacode='631' where company=551 and OrderDate >='2017-04-01' and areacode is null
update Pending_orders set areacode='624' where company=552 and OrderDate >='2017-04-01' and areacode is null
update Pending_orders set areacode='622' where company=553 and OrderDate >='2017-04-01' and areacode is null

--Based on SR: 2SINR025297 dated on 02-03-2026, The areacode and Zone mapping is changed , since there is mismatch in Areacode mapping in CRM and LN.

update Pending_orders set  areacode='034', AreaName='Bhopal', Zone='North'  where concat(company,ordernum)='401303034214'

update Pending_orders set  areacode='034', AreaName='Bhopal', Zone='North'  where concat(company,ordernum)='401401009764'



update pending_orders set areaname=a.AreaName
from vw_AREA_MASTER  a
where ltrim(rtrim(pending_orders.Areacode)) =ltrim(rtrim(a.Areacode ))

update pending_orders set Zone=a.ATS_Zone 
from vw_AREA_MASTER  a
where ltrim(rtrim(pending_orders.Areacode)) =ltrim(rtrim(a.Areacode ))
and ltrim(rtrim(pending_orders.Company)) like '6%' 

update pending_orders set Zone=a.Zone 
from vw_AREA_MASTER  a
where ltrim(rtrim(pending_orders.Areacode)) =ltrim(rtrim(a.Areacode ))
and ltrim(rtrim(pending_orders.Company)) not like '6%' 


-------------------------End: Area,Zone Update---------------------------------
----------------------------Item Desc Update---------------------------------

update pending_orders set item_desc=ltrim(rtrim(a.t_dsca))
from TTCIBD001400 a
where pending_orders.company like '4%' and item_desc is null
and ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(a.t_item))

update pending_orders set item_desc=ltrim(rtrim(a.dsca))
from TTCIBD001465 a
where pending_orders.company =465
and ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(a.item))

update pending_orders set item_desc=ltrim(rtrim(a.dsca))
from ttcibd001470 a
where pending_orders.company =470
and ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(a.item))


update pending_orders set item_desc=ltrim(rtrim(a.dsca))
from TTCIBD001490 a
where pending_orders.company =490
and ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(a.item))

update pending_orders set item_desc=ltrim(rtrim(a.dsca))
from TTCIBD001500 a
where pending_orders.company =500
and ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(a.item))

update pending_orders set item_desc=ltrim(rtrim(a.dsca))
from TTCIBD001551 a
where pending_orders.company =551
and ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(a.item))


update pending_orders set item_desc=ltrim(rtrim(a.dsca))
from TTCIBD001552 a
where pending_orders.company =552
and ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(a.item))


update pending_orders set item_desc=ltrim(rtrim(a.t_dsca))
from TTCIBD001600 a
where pending_orders.company like '6%'
and ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(a.t_item))


------------------------End : Item Desc Update--------------------------------

update pending_orders set Origin_desc='Dealer Portal' WHERE pending_orders.origin=3
update pending_orders set Origin_desc='Manual' WHERE pending_orders.origin<>3
update pending_orders set Origin_desc='Converted' WHERE convert(date,OrderDate)='2017-07-03'
 
update pending_orders set Region='Exports' WHERE substring(OrderNum,1,2)='29'
update pending_orders set Region='Domestic' WHERE substring(OrderNum,1,2)<>'29'

update pending_orders set sale_type='NON FOC'
update pending_orders set sale_type='FOC'
WHERE CONCAT(COMPANY,ordertype) IN (SELECT CONCAT(COMPANY,SALEORDERTYPE) FROM saletype_master WHERE Sales_Category IN (1) )


update pending_orders set ref=b.t_corn 
from (select distinct company,OrderNum,PositionNum,ltrim(rtrim(ItemCode))as Item,t_corn from Sales_Lines )b
where pending_orders.Company =b.Company
and pending_orders.OrderNum=b.OrderNum 
and pending_orders.PositionNum =b.PositionNum 
and ltrim(rtrim(pending_orders.ItemCode)) =ltrim(rtrim(b.Item)) 

update pending_orders set HSN_CODE=b.t_hcod_l 
from (select distinct company,OrderNum,PositionNum,ltrim(rtrim(ItemCode))as Item,t_hcod_l from Sales_Lines )b
where pending_orders.Company =b.Company
and pending_orders.OrderNum=b.OrderNum 
and pending_orders.PositionNum =b.PositionNum 
and ltrim(rtrim(pending_orders.ItemCode)) =ltrim(rtrim(b.Item)) 

update pending_orders set PRICE_ORIGIN=case when  b.t_porg =4 then 'Manual' ELSE 'System' end
from (select distinct company,OrderNum,PositionNum,ltrim(rtrim(ItemCode))as Item,t_porg from Sales_Lines )b
where pending_orders.Company =b.Company
and pending_orders.OrderNum=b.OrderNum 
and pending_orders.PositionNum =b.PositionNum 
and ltrim(rtrim(pending_orders.ItemCode)) =ltrim(rtrim(b.Item)) 

update pending_orders set BP_SEQ_NO=b.t_rnsb_l 
from (select distinct company,OrderNum,PositionNum,ltrim(rtrim(ItemCode))as Item,t_rnsb_l from Sales_Lines )b
where pending_orders.Company =b.Company
and pending_orders.OrderNum=b.OrderNum 
and pending_orders.PositionNum =b.PositionNum 
and ltrim(rtrim(pending_orders.ItemCode)) =ltrim(rtrim(b.Item)) 


update pending_orders set shipment=a.shpm
from(select distinct * From (
select shpm,COMPANY,WORN as OrderNum , WPON as PosNum
from TWHINH431ALL 
where convert(float,QSHP)>0 and company in (401) and WORG =1
union all
select t$shpm,COMPANY,t$orno as OrderNum , t$pono as PosNum from  TWHINH480ALL
where t$qpli>0 and COMPANY in (490) 
)a)a
where pending_orders.Company =a.Company
and pending_orders.OrderNum=a.OrderNum 
and pending_orders.PositionNum =a.PosNum 


update pending_orders set GSTN_NO=b.FOVN  from (
select distinct A.company,A.OrderNum,A.PositionNum,ltrim(rtrim(A.ItemCode))as Item,A.t_rnsb_l,B.FOVN 
from Sales_Lines A 
LEFT OUTER JOIN (SELECT DISTINCT SEQN$L,FOVN,BPID  FROM TTCTAX400ALL where Company=400 and CATG$L =9) B
ON A.t_rnsb_l=B.SEQN$L
and a.CustCode =b.BPID 
)b
where pending_orders.Company =b.Company
and pending_orders.OrderNum=b.OrderNum 
and pending_orders.PositionNum =b.PositionNum 
and ltrim(rtrim(pending_orders.ItemCode)) =ltrim(rtrim(b.Item)) 


----------------------------Tax Update------------------------------------------

update Pending_Orders set TaxCode=a.TaxCode 
from (select distinct OrderNum,PositionNum,TaxCode from Sales_Lines 
where concat(OrderNum,PositionNum,t_sqnb) in 
(select concat(OrderNum,PositionNum,max(t_sqnb)) From Sales_Lines 
where Company =490 and invnum=0 group by OrderNum,PositionNum)   
and Company =490
)a
where Pending_Orders.OrderNum=a.OrderNum 
and Pending_Orders.PositionNum =a.PositionNum    
and Pending_Orders.Company =490 


update Pending_Orders set TaxCode=a.TaxCode 
from (select distinct OrderNum,PositionNum,TaxCode 
from Sales_Lines 
where concat(OrderNum,PositionNum,t_sqnb) in
(select concat(OrderNum,PositionNum,max(t_sqnb)) From Sales_Lines where Company =401  and invnum=0 group by OrderNum,PositionNum)   
and Company =401
)a
where Pending_Orders.OrderNum=a.OrderNum 
and Pending_Orders.PositionNum =a.PositionNum    
and Pending_Orders.Company =401 


update pending_orders set Tax_Desc= b.DSCA 
from  (SELECT DISTINCT CVAT,DSCA  fROM TTCMCS037ALL where company=400)b
where pending_orders.taxcode=b.CVAT 


------------------------End: Tax Update------------------------------------------

update pending_orders set Old_orderno=b.Old_ordernum 
from (select distinct company,T$ORNO as Old_ordernum,T$PONO as Old_positionnum,
T$NORN as new_ordernum,T$NPON as new_positionnum  From TZZPUR930All 
where T$SALE=1 and COMPANY =490) B
where pending_orders.Company =b.COMPANY 
and pending_orders.OrderNum =b.new_ordernum 
and pending_orders.PositionNum =b.new_positionnum 

update pending_orders set Old_positionno=b.Old_positionnum
from (select distinct company,T$ORNO as Old_ordernum,T$PONO as Old_positionnum,
T$NORN as new_ordernum,T$NPON as new_positionnum  From TZZPUR930All 
where T$SALE=1 and COMPANY =490) B
where pending_orders.Company =b.COMPANY 
and pending_orders.OrderNum =b.new_ordernum 
and pending_orders.PositionNum =b.new_positionnum 


update pending_orders set state=a.state 
from (select a.Company,a.OrderNum,b.CSTE as state
From (select distinct t_itad,Company,OrderNum  From Sales_Header)a
left outer join (select distinct CSTE,CADR from  TTCCOM130ALL where company=400)b
on ltrim(rtrim(a.t_itad)) =ltrim(rtrim(b.CADR)) 
)a
where pending_orders.Company =a.Company 
and pending_orders.OrderNum =a.OrderNum 


update pending_orders set cust_Inv_Address=cadr
from (select * from TTCCOM112ALL  where COMPANY =400)a
where pending_orders.CustCode =a.itbp

update pending_orders set Cust_GSTN_NO=b.FOVN,cust_SEQ=b.SEQN$L
from (SELECT DISTINCT FOVN,SEQN$L,BPID,CADR$L FROM  TTCTAX400ALL 
where company=400 and CATG$L =9)b
where pending_orders.CustCode =b.BPID
and pending_orders.cust_Inv_Address=b.CADR$L


update pending_orders set Sales_Inv_Address =b.Sales_Inv_Address,ExportOrder=b.t_expo_l 
from (select distinct COMPANY,t_itad as Sales_Inv_Address,CustCode,ORDERNUM,t_expo_l   from sales_header A)b
where pending_orders.company=b.COMPANY
and pending_orders.custcode=b.CustCode
and pending_orders.ordernum=b.ORDERNUM


update pending_orders set Sales_GSTN_NO =b.FOVN,SALES_SEQ =b.SEQN$L
from (SELECT DISTINCT FOVN,SEQN$L,BPID,CADR$L FROM  TTCTAX400ALL where company=400 and CATG$L =9)b
where pending_orders.CustCode =b.BPID
and pending_orders.Sales_Inv_Address =b.CADR$L

update pending_orders set cust_state=b.cste
from (select distinct cadr,cste  From TTCCOM130ALL where company=400)b
where pending_orders.Sales_Inv_Address =b.CADR 

	
update pending_orders set Sales_state=b.cste
from (select distinct cadr,cste  From TTCCOM130ALL where company=400)b
where pending_orders.Cust_Inv_Address =b.CADR 

update pending_orders set disc_origin=a.disc_origin from 
(select distinct OrderNum,PositionNum,Company,t_dorg_1,case when t_dorg_1 =2 then 'NA'
when t_dorg_1 =4 then 'Manual'
when t_dorg_1 =8 then 'Discount Structure'
when t_dorg_1 =10 then 'Price Book'
end as disc_origin From Sales_Lines ) a
where pending_orders.Company =a.Company
and pending_orders.OrderNum =a.OrderNum
and pending_orders.PositionNum =a.PositionNum 


update pending_orders set Blocked=a.status from 
(select distinct OrderNum,Company,Blocked,case when Blocked =1 then 'Yes'else 'No'End as status From Sales_Header)a
where pending_orders.Company =a.Company
and pending_orders.OrderNum =a.OrderNum
--and pending_orders.PositionNum =a.PositionNum 


---------------------Stock Update-----------------------------------------------

update pending_orders set STOCK_440_act=b.qhnd from 
(select company,item, ((sum(qhnd))-(sum(QlAL)+sum(QBLK)))as qhnd
from twhwmd215all
where Company=440  
and cwar in ('024','290','291','591','e91','287')
group by company,item
) b
WHERE ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(b.item)) 
and pending_orders.company=490--b.COMPANY
--and pending_orders.warehouse=b.CWAR



update pending_orders set STOCK_440_onhand=b.qhnd from 
(select company,item,sum(qhnd)qhnd
from twhwmd215all
where Company=440  
and cwar in ('024','290','291','591','e91','287')
group by company,item
) b
WHERE ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(b.item)) 
and pending_orders.company=490--b.COMPANY
--and pending_orders.warehouse=b.CWAR



update pending_orders set STOCK_401_act=b.qhnd from 
(select company,item,((sum(qhnd))-(sum(QlAL)+sum(QBLK)))as qhnd
from twhwmd215all
where Company=401  
and cwar in ('253','353','453','553','209','210','211','O53','L46','246','346','L53','252','901','212','561')
group by company,item
) b
where ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(b.item)) 
and pending_orders.company=490--=b.COMPANY
--and pending_orders.warehouse=b.CWAR



update pending_orders set STOCK_401_onhand=b.qhnd from 
(select company,item,sum(qhnd)qhnd
from twhwmd215all
where Company=401  
and cwar in ('253','353','453','553','209','210','211','O53','L46','246','346','L53','252','901','212','561')
group by company,item
) b
where ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(b.item)) 
and pending_orders.company=490--b.COMPANY
--and pending_orders.warehouse=b.CWAR


update pending_orders set STOCK_416_act=b.qhnd from  
(select company,item,((sum(qhnd))-(sum(QlAL)+sum(QBLK)))as qhnd
from twhwmd215all
where Company=416  
and cwar in ('049')
group by company,item
) b
where ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(b.item)) 
and pending_orders.company=490 --b.COMPANY
--and pending_orders.warehouse=b.CWAR


update pending_orders set STOCK_416_onhand=b.qhnd from 
(select company,item,sum(qhnd)qhnd
from twhwmd215all
where Company=416  
and cwar in ('049')
group by company,item
) b
where ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(b.item)) 
and pending_orders.company=490--b.COMPANY
--and pending_orders.warehouse=b.CWAR


update pending_orders set STOCK_450_act=b.qhnd from 
(select company,item,((sum(qhnd))-(sum(QlAL)+sum(QBLK)))as qhnd
from twhwmd215all
where Company=450  
and cwar in ('251','174')
group by company,item
) b
where ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(b.item)) 
and pending_orders.company=490 --b.COMPANY
--and pending_orders.warehouse=b.CWAR



update pending_orders set STOCK_450_onhand=b.qhnd from 
(select company,item,sum(qhnd)qhnd
from twhwmd215all
where Company=450
and cwar in ('251','174')
group by company,item
) b
where ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(b.item)) 
and pending_orders.company=490--b.COMPANY
--and pending_orders.warehouse=b.CWAR



update pending_orders set STOCK_490_act=b.qhnd from
(select company,item,((sum(qhnd))-(sum(QlAL)+sum(QBLK)))as qhnd
from twhwmd215all
where Company=490  
and cwar in ('102','202','103')
group by company,item
) b
where ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(b.item)) 
and pending_orders.company=490--b.COMPANY
--and pending_orders.warehouse=b.CWAR


update pending_orders set STOCK_490_onhand=b.qhnd from 
(select company,item,sum(qhnd)qhnd
from twhwmd215all
where Company=490  
and cwar in ('102','202','103')
group by company,item
) b
where ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(b.item)) 
and pending_orders.company=490 --b.COMPANY
--and pending_orders.warehouse=b.CWAR


update pending_orders set STOCK_490_blocked=b.QBLK from 
(select company,item,sum(QBLK)QBLK
from twhwmd215all
where Company=490  
and cwar in ('102','202')
group by company,item
) b
where ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(b.item)) 
and pending_orders.company=490 --b.COMPANY
--and pending_orders.warehouse=b.CWAR



update pending_orders set STOCK_DEL_act=b.qhnd from 
(select company,item,((sum(qhnd))-(sum(QlAL)+sum(QBLK)))as qhnd
from twhwmd215all
where Company=490  
and LTRIM(RTRIM(cwar)) in ('DEL')
group by company,item
) b
where ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(b.item)) 
and pending_orders.company=490 --b.COMPANY
--and pending_orders.warehouse=b.CWAR


update pending_orders set STOCK_DEL_onhand=b.qhnd from 
(select company,item,sum(qhnd)qhnd
from twhwmd215all
where Company=490  
and LTRIM(RTRIM(cwar)) in ('DEL')
group by company,item
) b
where ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(b.item)) 
and pending_orders.company=490 --b.COMPANY
--and pending_orders.warehouse=b.CWAR

	

update pending_orders set STOCK_CAL_act=b.qhnd from 
(select company,item,((sum(qhnd))-(sum(QlAL)+sum(QBLK)))as qhnd
from twhwmd215all
where Company=490  
and LTRIM(RTRIM(cwar)) in ('CAL')
group by company,item
) b
where ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(b.item)) 
and pending_orders.company=490 --b.COMPANY
--and pending_orders.warehouse=b.CWAR

		
update pending_orders set STOCK_CAL_onhand=b.qhnd from 
(select company,item,sum(qhnd)qhnd
from twhwmd215all
where Company=490  
and LTRIM(RTRIM(cwar)) in ('CAL')
group by company,item
) b
where ltrim(rtrim(pending_orders.ItemCode))=ltrim(rtrim(b.item)) 
and pending_orders.company=490 --b.COMPANY
--and pending_orders.warehouse=b.CWAR

---------------------End : Stock Update-----------------------------------------------


update pending_orders set OrderMonthNo=month(OrderDate)
update pending_orders set OrderMonthYear=year(OrderDate)
update pending_orders set OrderMonth=datename(m,orderdate) 


update Pending_Orders set currency=a.Currency,CurrRate=a.t_rats_1  from 
(select distinct company,OrderNum,Currency,t_rats_1 From Sales_Header)a 
where Pending_Orders .Company =a.Company 
and Pending_Orders .OrderNum =a.OrderNum  

update Pending_Orders set MaxQty =a.Max_Qty  from Itemwise_Qty  a
where ltrim(rtrim(Pending_Orders.ItemCode)) =ltrim(rtrim(a.Item)) 

update Pending_Orders set Monthwise_Ordqty  =a.qty   
from (select sum(qty)qty,ItemCode  from Sales_Inflow 
where  month(OrderDate)=month(getdate()-1) and year(OrderDate)=year(getdate()-1)
and concat(company,ordertype) in (select CONCAT(company,saleordertype) 
from saletype_master where Sales_Category not in (1)) 
group by ItemCode) a
where ltrim(rtrim(Pending_Orders.ItemCode)) =ltrim(rtrim(a.ItemCode))
and ltrim(rtrim(Pending_Orders.ItemCode)) in (select distinct Item from Itemwise_qty)

update Pending_Orders set invoice =a.invnum,trantype=a.Trantype 
from (select distinct company,OrderNum,PositionNum,Trantype,invnum from  CI_Lines)a
where Pending_Orders.Company =a.company
and Pending_Orders.OrderNum =a.OrderNum 
and Pending_Orders.PositionNum =a.PositionNum 
 
update Pending_Orders set inv_date  =a.invdate 
from (select distinct company,invnum,Trantyp,max(t_idat) as invdate from  CI_Header group by invnum,company,Trantyp)a
where Pending_Orders.invoice=a.invnum 
and Pending_Orders.company=a.company
and Pending_Orders.trantype=a.Trantyp


update Pending_Orders set dest_type ='OPEN AT HOME OFFICE' WHERE invoice is null 
update Pending_Orders set dest_type ='IN TRANSIT TO SUBSIDIARIES' WHERE CONVERT(DATE,GETDATE()) BETWEEN CONVERT(DATE,inv_date) AND CONVERT(DATE,inv_date+51)
update Pending_Orders set dest_type ='REACHED TO SUBSIDIARY' WHERE GETDATE() >=CONVERT(DATE,inv_date+52)  

update Pending_Orders set issue_item=a.InvIssStat 
from (select distinct company,OrderNum,PositionNum,InvIssStat from Sales_Lines )a
where Pending_Orders.Company =a.Company 
and Pending_Orders.OrderNum =a.OrderNum 
and Pending_Orders.PositionNum =a.PositionNum 

update Pending_Orders set issue_item ='Main Item' where Pending_Orders.issue_item='1'
update Pending_Orders set issue_item ='Component' where Pending_Orders.issue_item='2'

update Pending_Orders set itemclass=a.Category from (select distinct ltrim(rtrim(item)) as Item,Category 
From ITEM_ABC_CLASIFICATION_MASTER)a
where ltrim(rtrim(Pending_Orders.ItemCode)) =a.Item


update Pending_Orders set lead_days=elgi_leadtimeindays from(select ltrim(rtrim(elgi_itemcode))elgi_itemcode,
max(elgi_leadtimeindays)elgi_leadtimeindays From [ELGi_CRM].dbo.product_CRM
where (elgi_leadtimeindays is not null and elgi_leadtimeindays>0) group by ltrim(rtrim(elgi_itemcode)))a
where ltrim(rtrim(Pending_Orders.ItemCode))=ltrim(rtrim(a.elgi_itemcode))

update Pending_Orders set lead_days=30 where lead_days <1 and Company =490
update Pending_Orders set lead_days=30 where lead_days is null and Company =490

update Pending_Orders set itemtype=b.KITM from (SELECT DISTINCT LTRIM(RTRIM(ITEM))AS ITEM,
CASE WHEN KITM=1 THEN 'P'when KITM=2 then 'M' when KITM=4 then 'C'when KITM=5 then 'S' end as KITM
FROM TTCIBD001490)b
WHERE ltrim(rtrim(Pending_Orders.ItemCode)) =b.ITEM 


update Pending_Orders set estimated_date=dbo.UFN_working_wkdays(convert(date,orderdate),lead_days)

update Pending_Orders set NATIONAL_HOLIDAYS=(select count(*) from TTCCCP020400
where datepart(dw,date) not in(1,7) and DFCA='4'
and date between Pending_Orders.OrderDate and Pending_Orders.estimated_date)

update Pending_Orders set estimated_date=dbo.UFN_working_wkdays(estimated_date,NATIONAL_HOLIDAYS)

--Commented on 24-May-2024 due to WMS Integration not done in Azure
--update Pending_Orders set typ=A.BDI 
--from (select distinct t$sotp,t$cofc,
--CASE WHEN T$BDIO=1 THEN 'BDI' END BDI From  [WMS].DBO.TZZSLS608490 WHERE T$BDIO=1)a
--where Pending_Orders.ordertype=a.t$sotp
--and Pending_Orders.dpst=a.t$cofc



update Pending_Orders set typ='TYP'  where company in(490)and ordertype  in ('516','AMC')
update Pending_Orders set typ='DOM' WHERE (Pending_Orders.Dpst  BETWEEN '90000' AND '90091') AND TYP<>'BDI'  
update Pending_Orders set typ='EXP' WHERE DPST in ('90231','90213','90257','90293') AND TYP<>'BDI' AND TYP<>'DOM'
update Pending_Orders set typ='SUB' WHERE (DPST BETWEEN '70000' AND '70099') AND TYP<>'BDI' AND TYP<>'DOM' AND TYP<>'EXP'
update Pending_Orders set typ='RLY' WHERE (DPST='90092') AND TYP<>'BDI' AND TYP<>'DOM' AND TYP<>'EXP' AND TYP<>'SUB'



----Commented on 24-May-2024  due to WMS Integration not done in Azure
--update Pending_Orders set ShipmentNo=T$SHPM FROM(SELECT distinct T$SHPM,T$ORNO,T$PONO  fROM [WMS].dbo.TWHINH480490)A
--WHERE Pending_Orders.OrderNum=A.T$ORNO  
--AND Pending_Orders.PositionNum =A.T$PONO
--and Pending_Orders.Company=490

--update Pending_Orders set shpment_date=A.orderdate 
--from (select min(orderdate)orderdate,substring(ltrim(rtrim(externorderkey)),5,20) as shpm From [wms].dbo.wmwhse1_ORDERS
--group by substring(ltrim(rtrim(externorderkey)),5,20))a
--WHERE Pending_Orders.ShipmentNo=A.SHPM 
--and Pending_Orders.Company =490


update Pending_Orders set packingslip_comp_Date=A.CDAT 
from (select distinct COMPANY,shpm,CDAT From TWHINH430ALL)a
WHERE Pending_Orders.ShipmentNo=A.SHPM 
and Pending_Orders.Company =a.COMPANY 


update Pending_Orders  set Delay_days=(select count(*) from TTCCCP020400 where CCAL ='COMPANY' and DFCA <>4
and date between Pending_Orders.OrderDate  and Pending_Orders.inv_date)

delete from Pending_Orders where 
concat(ordernum,positionnum) in ('252000876230','34200083540','34200083640','34200087610','352000180200','24100510520','24100510580',
'98000027610','99000140410','98000031010','95000067210','341003829630','99000149320','99000152030','341003896120','34100393350',
'99000162710','98000035310','96000006620','99000174520','95000088230','98000037620','95000103840','96000009820','98000040410','96000008920')
and company in (490)

update Pending_orders set next_due_date1=a.next_due_date,next_due_date2=a.next_due_date2,reason1=a.reason,reason2=a.reason2
from(select next_due_date,next_due_date2,reason,reason2,ordernum,positionnum From GSC_OVERDUE_PARTS)a
where Pending_orders.ordernum=a.ordernum
and Pending_orders.positionnum=a.PositionNum
and Pending_orders.company=490 


--update Pending_orders set PendValue_USD=null
--update Pending_orders set PendValue_ForeignCurrency=null

--Truncate table Pendvalue_USD_Conversion
--Insert into Pendvalue_USD_Conversion
----select * into Pendvalue_USD_Conversion from(
--select *,Value/RATE as value_in_USD from (
--select *,row_number() over (partition by Company, ordertype,OrderNum,PositionNum,PendQty,DelQty,Value order by daysdiff) as Rnk from 
--(select *,datediff(dd,STDT,OrderDate) as DaysDiff from 
--(select Company, ordertype,OrderNum,PositionNum,currency,OrderDate,PendQty,DelQty,Value from Pending_Orders
--where PendQty<>0
--and Currency<>'USD'
----and year(OrderDate)>=(select year(getdate()-1)-2)
----where company=490 and Trantype='432' and invnum='18000778'-- and OrderNum='292004614'
--)a
--left outer join 
--(select BCUR,CCUR,STDT,RATE from TTCMCS008ALL 
--where RTYP='SLS' and bcur='IND' and ccur='USD' and RATE>10)b
--on convert(date,a.OrderDate)<>convert(date,b.STDT)
--)a
--where DaysDiff >=0--is not null
--)b
--where rnk=1
----)a


Truncate table Pendvalue_USD_Conversion_ver2
insert into Pendvalue_USD_Conversion_ver2(OrderDate,Currency,BCUR,CCUR,STDT,RATE,DaysDiff,Rnk)
select OrderDate,Currency,BCUR,CCUR,STDT,RATE,DaysDiff,Rnk from (
select *,datediff(dd,STDT,OrderDate) as DaysDiff,
row_number() over (partition by OrderDate,currency order by datediff(dd,STDT,OrderDate)) as Rnk 
from (select distinct OrderDate,Currency from Pending_orders
--where currency='MYR'
)a
left outer join 
(select BCUR,CCUR,convert(date,STDT) STDT,max(RATE) RATE from TTCMCS008ALL 
where RTYP='SLS' 
--and bcur in ('IND')
and ccur='USD'
--and convert(date,stdt)='2024-01-08'
group by BCUR,CCUR,convert(date,STDT))b
on a.currency=b.bcur
and a.OrderDate>=b.STDT
)a
where Rnk=1



delete from  Pendvalue_USD_Conversion_ver2
where Currency='INR' and BCUR is null

Insert into Pendvalue_USD_Conversion_ver2
Select OrderDate,'INR' as Currency,'INR' as BCUR,CCUR,STDT,RATE,DaysDiff,Rnk 
from Pendvalue_USD_Conversion_ver2
where Currency='IND' 


--Alter table Pending_orders add CurrencyRate_HomeCurr float
----------INR Currency Conversion rate-----
update Pending_orders set homecurrency='INR' where company not in ('500','551','552','553')

Update Pending_orders set HomeCurrency ='DHI' where company='500'

Update Pending_orders set HomeCurrency ='AUD' where company='551'

Update Pending_orders set HomeCurrency ='IDR' where company='552'

Update Pending_orders set HomeCurrency ='MYR' where company='553'


update Pending_orders set  CurrencyRate_INR= t_rats_1 where company not in ('500','551','552','553')

update Pending_orders  set CurrencyRate_INR=a.CurrencyRate
from (select * from CurrencyRateMaster a where company in ('500','551','552','553') and ToCurrency='INR')a
where Pending_orders.company=a.Company
and Pending_orders.Currency=a.FromCurrency
and Pending_orders.Orderdate between a.validFromDate and a.ValidToDate

update Pending_orders set  CurrencyRate_HomeCurr = t_rats_1 where company not in ('500','551','552','553')

update Pending_Orders set CurrencyRate_HomeCurr=1 where HomeCurrency=currency

update Pending_orders  set CurrencyRate_HomeCurr=a.CurrencyRate
from (select * from CurrencyRateMaster a where company in ('500','551','552','553') )a
where Pending_orders.company=a.Company
and Pending_orders.Currency=a.FromCurrency
and Pending_orders.HomeCurrency=a.ToCurrency
and Pending_orders.Orderdate between a.validFromDate and a.ValidToDate

update Pending_orders  set CurrencyRate_HomeCurr=1/t_rats_1 where CurrencyRate_HomeCurr is null 
--since in LN , currency rate is given for 1 Home currency= that equavalent Currency

--Check this case for tomorrow and then enable/disable

update pending_orders set t_oamt = price_ln * pendqty where t_oamt=0 and price_ln<>0
--Method1 : Rate_USD from LN Currency Rate Master Table 

update Pending_orders set Rate_USD=a.RATE
from Pendvalue_USD_Conversion_ver2 a
where Pending_orders.OrderDate=a.OrderDate
and Pending_orders.Currency=a.Currency
and Pending_orders.company not in (500,551,552,553)


----Updating IND to USD Rate for all the Sales Transactions whose currency not in ('IND','INR')
update Pending_orders set Rate_USD=a.RATE
from (select * from Pendvalue_USD_Conversion_ver2 where currency in ('IND','INR')) a
where Pending_orders.OrderDate=a.OrderDate
and Pending_orders.currency not in ('IND','INR')
and Pending_orders.company not in (500,551,552,553)

update Pending_orders set PendValue_USD=Value/Rate_USD

update Pending_orders set PendValue_USD=PendValue_ForeignCurrency where Currency='USD'

--End: Method1 : Rate_USD from LN Currency Rate Master Table 
--Method2 : Rate_USD from Subsidiary Users Provided Data through mail

update Pending_orders  set Rate_USD=a.CurrencyRate
from (select * from CurrencyRateMaster a where company=500 and FromCurrency='USD' and ToCurrency='INR')a
where Pending_orders.company=a.Company
--and LN_Sales_Details_ver2.Currency=a.FromCurrency
and Pending_orders.OrderDate between a.validFromDate and a.ValidToDate

update Pending_orders  set Rate_USD=a.CurrencyRate
from (select * from CurrencyRateMaster a where company=551 and FromCurrency='USD' and ToCurrency='INR')a
where Pending_orders.company=a.Company
--and LN_Sales_Details_ver2.Currency=a.FromCurrency
and Pending_orders.OrderDate between a.validFromDate and a.ValidToDate

update Pending_orders  set Rate_USD=a.CurrencyRate
from (select * from CurrencyRateMaster a where company=552 and FromCurrency='USD' and ToCurrency='INR')a
where Pending_orders.company=a.Company
--and LN_Sales_Details_ver2.Currency=a.FromCurrency
and Pending_orders.OrderDate between a.validFromDate and a.ValidToDate

update Pending_orders  set Rate_USD=a.CurrencyRate
from (select * from CurrencyRateMaster a where company=553 and FromCurrency='USD' and ToCurrency='INR')a
where Pending_orders.company=a.Company
--and LN_Sales_Details_ver2.Currency=a.FromCurrency
and Pending_orders.OrderDate between a.validFromDate and a.ValidToDate

update Pending_orders  set PendValue_USD=Value/Rate_USD where company in (500,551,552,553)

update Pending_orders set PendValue_USD=PendValue_ForeignCurrency where Currency='USD'



----Updating the Home Currency Amt of Foreign Companies like 551,552,etc in our 
----Pending_orders.PendValue_ForeignCurrency column.
----This amt will be in AUD,IDR,DHI with respect to those company's billing.


--To be validated
update Pending_orders set PendValue_ForeignCurrency= a.t_oamt
from (SELECT company,OrderNum,PositionNum,
sum(isnull(t_oamt,0)) t_oamt
FROM sales_lines 
where company not like '4%'
group by company,OrderNum,PositionNum
)a
where Pending_orders.company=a.company
and Pending_orders.ordernum=a.OrderNum
and Pending_orders.PositionNum=a.PositionNum
and Pending_orders.company not like '4%'


--Method3: Rate_USD column update based on Foreign Currency to USD Currency Rate 
--(Note: Rate_USD implies the INR to USD Conversion Rate)


update Pending_orders set Rate_USD=a.Rate
from(select * from Pendvalue_USD_Conversion_ver2)a
where Pending_orders.currency=a.bcur
and Pending_orders.Orderdate=a.Orderdate
--and ln_sales_details_ver2.company=553
and Pending_orders.currency in ('MYR')

update Pending_orders set Pendvalue_USD=PendValue_ForeignCurrency*Rate_USD where 
--company=553
currency='MYR'

--End: Method3 : Rate_USD column update based on Foreign Currency to USD Currency Rate (Note: Rate_USD implies the INR to USD Conversion Rate)


----End: USD Rate Caculation--------------------------------------------------------------------


------------- Organ Updation  --Needed for Orderbook classification-----------------

--alter table Pending_orders add Region nvarchar(150) 

update pending_orders set Organ=a.Organ,
Vertical1=a.Vertical1,
user_names=a.User_names,
Division=a.Division,
productgrp=a.ProductGrp,
Region=a.Region
from (select * from vw_salesmapping_master where organ in ('India','Subsidiary') and organ is not null) a
where pending_orders.dpst=a.DPSTCode



update pending_orders set Organ =a.Organ,
Vertical1=a.Vertical1,
user_names=a.User_names,
Division=a.Division,
productgrp=a.ProductGrp,
Region=a.Region
from (select * from vw_salesmapping_master where organ not in ('India','Subsidiary') and organ is not null) a
where pending_orders.dpst=a.DPSTCode
and pending_orders.areacode=a.Areacode 


------------- Sales engineer name Updation  -- #SR-1610746 dated on 25-08-2026-----------------

--alter table pending_orders add EngineerCode nvarchar(100)


--Sales rep for special indents

update pending_orders set EngineerCode=a.SalesRep
from
(select distinct T$ORNO,T$REM2 as SalesRep from tzzsls320600 )a
where LTRIM(RTRIM(pending_orders.OrderNum))=LTRIM(RTRIM(a.T$ORNO)) 
and pending_orders.company='600'

--SalesRepCode for Other Cases
update pending_orders set EngineerCode=a.SalesRep
from
(select distinct Company,OrderNum,t_oref as Segment,SalesRep from sales_header)a
where pending_orders.company=a.Company
and pending_orders.OrderNum=a.OrderNum
--and LN_Sales_Details_ver2.company<>'600'
and pending_orders.EngineerCode is null


update pending_orders set Engineername=a.NAMA from TTCCOM001ALL a
where pending_orders.EngineerCode=a.EMNO 



--To address the issue of missing DPST based on Itemgroup from LN Item Master
update pending_orders set Organ='COSEA' where company in ('551','552','553') 

--Special Case against SR : OSL00112512 (sales made from 552 company to be considered under ID)

update pending_orders set Organ='ID',
Vertical1=null,
user_names='Nitin Sharma',
Division='ROCD',
productgrp='EPSAC',
Region='SOUTH EAST ASIA',
Zone=null
where concat(company,ordertype,OrderNum) in 
('552220200003196','552220200003197','552220200003198','552221200003199')


--Based ON SR # 1569197 dated on Wed, 29 Jul 11:29 AM, the ordernum 600006239 has been removed from sales inflow, so in pending order it is removed 
--This error occurred due to an incorrect currency calculation while raising the Service Revenue in the Intranet system. As a result, the inflow value of USD 353K has been incorrectly recorded.
delete from pending_orders where  OrderNum='600006239' and ItemCode like '%SCIN0004%' 


----Based on mail dated on 18-08-2026, Since this is invoiced but backened is not updated confirmed mail from Joseph and ATS Santhosh kumar
delete from pending_orders where  OrderNum='603069647' and company='600'

------------------------------------------
--Updating LOB Code and Line of business and Segment from Sales_header

update pending_orders set  LOBCode=a.LineOfBusiness ,Segment=a.t_oref from (
select * from sales_header
)a where a.company=pending_orders.company and a.Ordernum=Pending_orders.ordernum  

update pending_orders set lineofbusiness=a.DSCA
from (select * from TTCMCS031ALL where company=400) a 
where trim(pending_orders.lobcode)=trim(a.CBRN)

--alter table pending_orders add Segment nvarchar(255)

update pending_orders set Segment=b.T$REM1
from tzzsls320600 b
where ltrim(rtrim(pending_orders.OrderNum))=ltrim(rtrim(b.T$ORNO))
and pending_orders.company in (select company from ELGI_Companies_Master where CompanyGroup='ATS') 

update pending_orders set Segment=a.SEGM
from (select distinct COMPANY,LORN,SEGM from tzzsls885all)a
where pending_orders.company=a.COMPANY
and pending_orders.OrderNum=a.LORN
and pending_orders.Segment is null
and pending_orders.company in (select company from ELGI_Companies_Master where CompanyGroup='ATS')

delete from pending_orders where ordernum in ('603069535','603069532','603069536','603069534','603069533','634185169','204068434','632386939')

delete from pending_orders where ordernum in ('800000036','800000047','800000089','800000088','800000096','800000119','800000135')
--update Pending_orders set PendValue_USD=a.value_in_USD,Rate_USD=a.RATE
--from Pendvalue_USD_Conversion a
--where Pending_orders.Company=a.Company
--and Pending_orders.ordertype=a.OrderType
--and Pending_orders.OrderNum=a.OrderNum
--and Pending_orders.PositionNum=a.PositionNum
----and Pending_orders.DelQty=a.DelQty
--and Pending_orders.company<>552



--------------------------------
------New Logic under development:

----insert into Pendvalue_USD_Conversion(OrderDate,Currency,BCUR,CCUR,STDT,RATE,DaysDiff,Rnk)
----select OrderDate,Currency,BCUR,CCUR,STDT,RATE,DaysDiff,Rnk from (
----select *,datediff(dd,STDT,OrderDate) as DaysDiff,
----row_number() over (partition by OrderDate,currency order by datediff(dd,STDT,OrderDate)) as Rnk 
----from (select distinct convert(date,OrderDate) OrderDate,Currency from pending_orders
------where currency='MYR'
----)a
----left outer join 
----(select BCUR,CCUR,convert(date,STDT) STDT,max(RATE) RATE from TTCMCS008ALL 
----where RTYP='SLS' 
----and ccur='USD'
------and convert(date,stdt)='2024-01-08'
----group by BCUR,CCUR,convert(date,STDT))b
----on a.currency=b.bcur
----and a.OrderDate>=b.STDT
----)a
----where Rnk=1

-----------------------------

--update Pending_orders  set PendValue_USD=Value/a.CurrencyRate,
--Rate_USD=a.CurrencyRate
--from (select * from CurrencyRateMaster a where company=552
--and UpdatedDate=(select max(UpdatedDate) from CurrencyRateMaster where company=552)
--and FromCurrency='USD' and ToCurrency='INR'
--)a
--where Pending_orders.company=a.Company
----and LN_Sales_Details_ver2.Currency=a.Currency
--and Pending_orders.company=552

----update Pending_orders set t_rats_1=a.t_rats_1
----from(select distinct currency,orderdate,t_rats_1 from Pending_orders where t_rats_1 <>0 and Currency='USD' )a
----where Pending_orders.Currency='USD'
----and Pending_orders.t_rats_1=0
----and Pending_orders.currency=a.currency
----and convert(date,Pending_orders.OrderDate)=convert(date,a.OrderDate)


--update Pending_orders set t_rats_1=1 where t_rats_1=0 and  Currency in ('IND','INR')

--update Pending_orders set PendValue_USD=t_oamt where Currency='USD'  and Rate_USD is null 
--update Pending_orders set PendValue_ForeignCurrency=value/(case when t_rats_1 =0 then 1 else t_rats_1 end)



end 

Select * from Pending_orders 
--where delqty is not null

--select Cancel_Qty,currency,* from Pending_orders
--where concat(company,OrderNum,PositionNum)='40021000028110'
--'40120403528630'
--'40120403525540'
--'40120403833810'
--'490343016388150'


--Test Case Data
--Select DeliveryDate,t_sqnb,t_clyn,t_qoor,* from Sales_Lines where orderdate>='2022-04-01'
----and t_sqnb=0 --and t_clyn<>1--and t_qoor > 0
----and concat(Company,OrderNum)='401204035286'
--and concat(company,OrderNum,PositionNum)='40120403525540'
----'40120403528630'
----'490343016388150'

--select DLDT,* from sales_delivery where concat(Company,ORNO,pono)='40120403525540'


--select * from Pendvalue_USD_Conversion
--where concat(company,OrderNum,PositionNum)='40120403833810'

GO

