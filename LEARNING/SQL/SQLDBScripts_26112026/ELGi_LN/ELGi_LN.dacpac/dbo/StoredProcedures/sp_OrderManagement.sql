CREATE proc [dbo].[sp_OrderManagement] as 
 
Truncate table OrderManagement 

Insert into OrderManagement 
(OrderNum,OrderDate,PositionNum,ItemCode,Item_desc,WareHouse,OrderQty,PendQty,Indent,region,ProdOrderNo)

select a.*,b.PDNO from (
select OrderNum,OrderDate,PositionNum,ItemCode,Item_desc,WareHouse,sum(ord_qty) 'OrderQty',sum(pendqty) 'PendQty',Indent,
case when WareHouse='A57' then 'USA' 
when WareHouse='E57' then 'EUROPE' 
when WareHouse='W57' then 'ID' 
WHEN WareHouse='B57' then 'Brazil'
when WareHouse='F57' then 'Africa'
when WareHouse='I57' then 'Indonesia'
when WareHouse='N57' then 'Malaysia'
when WareHouse='P57' then 'SA' 
when WareHouse='C57' then 'Australia'
when WareHouse='157' then 'ME'
when WareHouse='O57' then 'Rotair'
when WareHouse ='H57' then 'SEA'
else WareHouse end  'Region'
 from Pending_Orders

where warehouse in ('E57','A57','W57','B57','F57','I57','N57','P57','C57','157','O57','H57') 
and company in ('401')--and ordernum='290030492'
AND CUSTCODE <>'CU1E99999'
AND OrderDate > '20251001'
group by OrderNum,OrderDate,PositionNum,ItemCode,Item_desc,WareHouse,Indent
)a
left join 
(
    SELECT  COMPANY,ORNO,PONO,ItemCode,PDNO,ROW_NUMBER() OVER (PARTITION BY COMPANY, ORNO, PONO, ItemCode ORDER BY PDNO desc) AS RN
    FROM
    (
        SELECT DISTINCT
            COMPANY,
            ORNO,
            PONO,
            TRIM(ITEM) AS ItemCode,
            PDNO
        FROM TZZSFC289ALL
      --  WHERE PDNO NOT IN ('200045847')
    ) x
) b
on a.ItemCode=b.ItemCode and a.OrderNum=b.ORNO and a.PositionNum=b.PONO  AND b.RN <= a.PendQty


update OrderManagement set Status=a.status,reqdate=a.RDLD from (

select pdno, trim(mitm) 'Item',
case when osta='1' then 'Planned' --YTP
	 when osta='2' then 'Scheduled' --YTP
	 when osta='3' then 'Document Printed' --YTP
	 when osta='4' then 'In Prod' --WIP
	 when osta='6' then 'Active' --WIP
	 when osta='7' then 'To be Completed' --WIP
	 when osta='8' then 'Completed' --FG
	 when osta='9' then 'Closed' --FG
	 end 'Status',convert(date,RDLD) 'RDLD'

 from TTISFC001ALL 

WHERE Company='401'-- and trim(pdno)='210068765'
--419450
)a where OrderManagement.ProdOrderNo=a.pdno and OrderManagement.ItemCode=a.Item



update OrderManagement set NoOfProd =a.NoOFPDNO from (
select orno,pono,itemcode, isnull(max(rn),0) 'NoOFPDNO' from (
  SELECT  COMPANY,ORNO,PONO,ItemCode,PDNO,ROW_NUMBER() OVER (PARTITION BY COMPANY, ORNO, PONO, ItemCode ORDER BY PDNO desc) AS RN
    FROM
    (
        SELECT DISTINCT
            COMPANY,
            ORNO,
            PONO,
            TRIM(ITEM) AS ItemCode,
            PDNO
        FROM TZZSFC289ALL
      --  WHERE PDNO NOT IN ('200045847')
    ) x
) b
--WHERE trim(PDNO) not IN (SELECT DISTINCT PDNO FROM (
----select distinct COMPANY,CWAR,ITEM,IDAT,TRIM(SERL) 'FABNO',TRIM(ORNO) 'PDNO',
----case when BOUT=1 then 'Yes'
----when BOUT=2 then 'No' end as FG_BLK , 1 'QTY'
----from TWHLTC500ALL
----where OSER=2 and QHND<>0) A)
--where orno='204000656'

group by orno,pono,ItemCode
) a where OrderManagement.OrderNum=a.ORNO and OrderManagement.PositionNum=a.PONO and OrderManagement.ItemCode=a.ItemCode


--alter table OrderManagement add inFG nvarchar(10)

update OrderManagement set inFG= 'Yes' where OrderManagement.Status='Closed' and  ordermanagement.ProdOrderNo in (
select distinct TRIM(ORNO) 'PDNO'from TWHLTC500ALL
where OSER=2 and QHND<>0
)
--- REMOVE PENDING ORDER THAT STATUS IS CLOSED AND NOT AVAILABLE IN FG 

--select * FROM OrderManagement WHERE PendQty <> NoOfProd AND NoOfProd <> 0 and Status='Closed' and INFG is null
   


update OrderManagement set DFU=b.Demand_Forecasting_Unit_DFU,model=b.Model,ItemCategory=b.Item_Category  from ELGi_SOP.dbo.TPL_MASTER_REF b 
where OrderManagement.region =b.region and ordermanagement.Itemcode=b.item

--alter table OrderManagement add NoOfProd int

update OrderManagement set NoOFProd=0 where noofprod is null

--alter table OrderManagement add ReqDate datetime


update ordermanagement set YTP =a.qty  from (
select pdno, trim(mitm) 'Item',sum(qrdr) 'Qty' from TTISFC001ALL 

WHERE Company='401' and osta in ('1','2','3')
group by pdno,trim(mitm)

)a where OrderManagement.ProdOrderNo=a.pdno and OrderManagement.ItemCode=a.Item



update ordermanagement set WIP =a.qty  from (
select pdno, trim(mitm) 'Item',sum(qrdr) 'Qty' from TTISFC001ALL 

WHERE Company='401' and osta in ('4','6','7')
group by pdno,trim(mitm)

)a where OrderManagement.ProdOrderNo=a.pdno and OrderManagement.ItemCode=a.Item


--update ordermanagement set FG =a.qty  from (
--select pdno, trim(mitm) 'Item',sum(qrdr) 'Qty' from TTISFC001ALL 

--WHERE Company='401' and osta in ('8','9')
--group by pdno,trim(mitm)

--)a where OrderManagement.ProdOrderNo=a.pdno and OrderManagement.ItemCode=a.Item

--ALter table OrderManagement add FabNo nvarchar(100)

update ordermanagement set FG =a.qty,fabno=a.FabNo from (
select distinct COMPANY,CWAR,ITEM,IDAT,TRIM(SERL) 'FABNO',TRIM(ORNO) 'PDNO',
case when BOUT=1 then 'Yes'
when BOUT=2 then 'No' end as FG_BLK , 1 'QTY'
from TWHLTC500ALL
where OSER=2 and QHND<>0
)a where  trim(OrderManagement.ItemCode)=trim(a.Item) and trim(OrderManagement.ProdOrderNo)=a.pdno and OrderManagement.WareHouse=a.cwar 
and OrderManagement.ProdOrderNo is not null and OrderManagement.ProdOrderNo<>'' --and Status='Closed'

update OrderManagement set ProdOrderNo='No Production Order' where ProdOrderNo ='' or ProdOrderNo is null

update OrderManagement set Status='Deleted' where Status ='' or Status is null

update OrderManagement set Status='' where ProdOrderNo ='No Production Order'

update OrderManagement set FabNo='Link broken' where Status in ('Closed','To be completed') and fabno is null or fabno=''

update OrderManagement set FG=0 where Status in('In Prod' ,'Active','To be Completed')

--ALTER TABLE OrderManagement add ProductGroup nvarchar(250) 


update OrderManagement set ProductGroup=a.product_group from  (
select * from elgi_sop.dbo.TPL_MASTER_REF ) a
where OrderManagement.Region=a.region and OrderManagement.ItemCode=a.item


--Alter table orderManagement add SLA int
Update OrderManagement set SLA =5  where productgroup IN ('SEPSAC','Portables (PG)','ENCAP','ENCAP- Air Station')

Update OrderManagement set SLA =9  where productgroup in ('LEPSAC','AB')

Update OrderManagement set SLA =12  where productgroup='OFSAC'

Update OrderManagement set SLA =7  where productgroup='RCD'

UPDATE OrderManagement set DateOfShipment=dbo.UFN_working_wkdays(reqdate,sla)

--Alter table OrderManagement add NewPendQty float
update OrderManagement set NewPendQty= case when pendqty <>0 and noofprod<>0 then CEILING(PendQty * 1.0 / NoOfProd) else PendQty end

GO

