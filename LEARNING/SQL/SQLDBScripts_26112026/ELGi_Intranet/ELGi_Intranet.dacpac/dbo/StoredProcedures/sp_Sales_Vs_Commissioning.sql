--exec sp_Sales_Vs_Commissioning

CREATE proc sp_Sales_Vs_Commissioning as
Begin


Truncate table Sales_Vs_Commissioning


insert into Sales_Vs_Commissioning (Company,Tpl,tpl_desc,Fabno,desp_dt,SaleYear,
SaleMonth,comm_date,CommYear,ar_code,Country,EndCustomerName,distributor_Name,distributor_city,
AE_item,AE_DESC,parent,child,item_desc,
List_Output,ae_item_new,AE_DESC_new,cu_code)
select Company,ltrim(rtrim(a.tpl)) as Tpl,a.tpl_desc,ltrim(rtrim(a.fabno))as Fabno,a.desp_dt,year(a.desp_dt)as SaleYear,
Left(DATENAME(m,a.desp_dt),3) as SaleMonth, 
a.comm_date ,year(a.comm_date) as CommYear,
a.ar_code,--a.ar_desc as Country,
null as Country,
a.end_cust as EndCustomerName,
a.distributor as distributor_Name,a.distributor_city,
b.SITM as AE_item,c.t_dsca as AE_DESC,
d.parent,d.child,d.item_desc,d.List_Output,
case when b.SITM is null then list_output else b.SITM end as ae_item_new,
case when c.t_dsca is null then item_desc else c.t_dsca end as AE_DESC_new,
a.cu_code
from (select distinct * from DESPDETAILS 
where pr_grp<>'6'
--and ltrim(rtrim(tpl)) like 's%' --obsolete
) a
left outer join (
select ltrim(rtrim(MITM)) MITM,ltrim(rtrim(SITM)) SITM from [ELGI_LN].dbo.TTIBOM010ALL 
where company=400
and (year(exdt)<2000 or  convert(date,exdt)>=convert(date,getdate()))
and ltrim(rtrim(SITM)) in (select distinct ltrim(rtrim(t_item))as item 
From [ELGI_LN].dbo.TTCIBD001400 where t_citg in ('p35','aed'))
)b
on ltrim(rtrim(tpl))=ltrim(rtrim(MITM))
left outer join (select distinct ltrim(rtrim(t_item))as item,t_dsca 
From [ELGI_LN].dbo.TTCIBD001400 where t_citg in ('p35','aed'))c
on ltrim(rtrim(b.SITM))=ltrim(rtrim(c.item))
left outer join (SELECT  parent,child,item_desc,
STUFF((SELECT ', ' + CAST(subchild AS VARCHAR(10))
FROM [ELGI_LN].dbo.item_parent_child 
WHERE item_parent_child.parent = t.parent
FOR XML PATH(''), TYPE).value('.','NVARCHAR(MAX)'),1,2,' ') List_Output
FROM [ELGI_LN].dbo.item_parent_child t
GROUP BY  parent,child,item_desc)d
on ltrim(rtrim(a.tpl))=ltrim(rtrim(d.parent))


update Sales_Vs_Commissioning set comm_date=a.commissioned_dt
from (select distinct fabno,commissioned_dt from CallHistory1)a
where Sales_Vs_Commissioning.Fabno=a.fabno
and Sales_Vs_Commissioning.comm_date is null



--Region Classification
--Old Method: based on Customer Code
--update Sales_Vs_Commissioning set Region='Australia' where cu_code in('E00804','CU1E00804')
--update Sales_Vs_Commissioning set Region='Europe' where cu_code in('R01967','CU1R01967','CRE000082')
--update Sales_Vs_Commissioning set Region='ME' where cu_code in('E00625','CU1E00625')
--update Sales_Vs_Commissioning set Region='USA' where cu_code in('E00847','CU1E00847')
--update Sales_Vs_Commissioning set Region='Africa' where cu_code in('M01386','CRR000129',
--'CRM000396','CUSI00011','CU1C01549','CU1A04090','CU1P03231')



--Method1: Based on AreaCode
--update Sales_Vs_Commissioning set ar_code=a.T$CREG,Country=a.T$ADES
--from (select distinct T$CSER,COMPANY,T$TTYP,T$INVN,T$ORNO,T$PONO,T$CREG,T$ADES 
--from [ELGI_LN].dbo.tzzsls310All
--where len(T$CSER)>2
--and T$CSER='131X6356'
--)a
--where Sales_Vs_Commissioning.Fabno=a.T$CSER
--and Sales_Vs_Commissioning.Company=a.COMPANY


update Sales_Vs_Commissioning set Country=a.AreaName
from(select * from [ELGi_LN].dbo.vw_AREA_MASTER
--where areacode='644'
)a
where Sales_Vs_Commissioning.ar_code=a.Areacode 



update Sales_Vs_Commissioning set Region='USA' where ar_code in ('651' ,'653') 
update Sales_Vs_Commissioning set Region='BRAZIL' where ar_code= '663'  

update Sales_Vs_Commissioning set Region='Oceania' where ar_code in ('621','622','623','624','625','631','632','637')
and region is null

update Sales_Vs_Commissioning set Region='Domestic' where ar_code in 
('001','002','003','004','006','011','012','013','014','016','020','021',
'022','023','024','030','031','032','033','034','035','036','037','040',
'041','042','043','044','045','050','051','052','053','054','055','056',
'057','058','095','TST','099')
and region is null

update Sales_Vs_Commissioning set Region='Africa & ME'
where country in ('UAE','OMAN','KUWAIT','SAUDI ARABIA','Bahrain','QATAR')

update Sales_Vs_Commissioning set Region='Africa & ME' where ar_code in 
('671','672','673','674','675','676','677','684',
'690','691','692','693','694','698')



----Method2:Based on Entity Code --Commented on 12-03-2026 as Ent_codes are wrongly mapped in many cases
--update Sales_Vs_Commissioning set ent_code=a.ent_code
--from (select distinct fabno,trackno,convert(varchar,ar_code) ar_code,ent_code 
--from callhistory1)a
--where Sales_Vs_Commissioning.Fabno=a.fabno

--update Sales_Vs_Commissioning set Region=a.RegionName
--from (select * from Region_Entity_Master)a
--where Sales_Vs_Commissioning.ent_code=a.EntityCode


--Method3: Based on Dealer Code

Update Sales_Vs_Commissioning set Region='Europe'
where cu_code in ('CU1R01967','CRE000082','R01967') 


--Removing Return Invoices from Subssidiaries to HO based on Fabno 
delete from Sales_Vs_Commissioning where Fabno in 
(select distinct T$CSER  from
(select distinct COMPANY,WORN,WPON,WSEQ,SHPM 
from [ELGI_LN].dbo.TWHINH431ALL where WORG=1
--and concat(company,WORN)='500200051387' --Testing
)a
inner join (select distinct COMPANY,T$SHPM,T$CSER 
from [ELGI_LN].dbo.TWHINH433ALL)b
on a.company=b.company
and a.SHPM=b.T$SHPM
left outer join (select company,OrderNo,PositionNo,trantype,
Invoice,custcode,areacode,areaname,Item from [ELGI_LN].dbo.elgi_sales_details
--where concat(trantype,invoice)='73130000269' --Testing
)c
on a.COMPANY=c.COMPANY
and a.WORN=c.OrderNo
and a.WPON=c.PositionNo
--where ltrim(rtrim(Item))='S11053' --Testing
where areacode='051'
and a.COMPANY not like '4%'
)




--Commented as fabno allocation against sales order has some deviations.
--insert into Salesorder_with_Fabno
----select * into Salesorder_with_Fabno from (
--select distinct a.Company,a.WareHouse,a.ItemCode,a.OrderDate,a.ordertype,a.OrderNum, 
--a.PositionNum,a.CustCode,a.CustName,b.PDNO,c.CWAR,c.ITEM,c.IDAT,c.SERL
--from 
--(select distinct Company,WareHouse,ItemCode,
--OrderDate,ordertype,OrderNum,PositionNum,CustCode,CustName from Sales_Inflow)a
--inner join (select distinct COMPANY,ORNO,PONO,PDNO from TZZSFC289ALL
--where concat(company,PDNO) in (select distinct concat(COMPANY,PDNO) from TTISFC001ALL)
--)b
--on a.Company=b.COMPANY
--and ltrim(rtrim(a.OrderNum))=ltrim(rtrim(b.ORNO))
--and ltrim(rtrim(a.PositionNum))=ltrim(rtrim(b.PONO))
--inner join (select distinct COMPANY,CWAR,ITEM,IDAT,SERL,ORNO
----,case when BOUT=1 then 'Yes'
----when BOUT=2 then 'No' end as FG_BLK 
--from TWHLTC500ALL
--where OSER=2 --and QHND<>0
--)c
--on b.company=c.company
--and b.PDNO=c.ORNO
----where year(OrderDate)>=2022
----order by OrderDate
----)a


--Alter table Sales_Vs_Commissioning add UnitStatus varchar(50)
--Alter table Sales_Vs_Commissioning add CommStatus varchar(50)
--Alter table Sales_Vs_Commissioning add prod_segment nvarchar(50)


--Method1
--Update Sales_Vs_Commissioning set UnitStatus='In Transit'
--from(
--select a.* from
--(select distinct company,ordertype,ordernum,PositionNum,serl from Salesorder_with_Fabno)a
--inner join
--(select distinct company,SaleOrderType,OrderNo,positionNo from ELGi_Sales_Details
--where ShipmentNO is not null
--)b
--on a.Company=b.company
--and a.ordertype=b.SaleOrderType
--and a.OrderNum=b.OrderNo
--and a.PositionNum=b.PositionNo
--)a
--where Sales_Vs_Commissioning.Fabno=a.SERL



--Method2

--Update Sales_Vs_Commissioning set UnitStatus='Not yet Shipped'
--from(select distinct company,T$ORNO,T$PONO,T$TTYP,T$INVN,T$INVD,T$BPID,T$SHPM,T$CSER from tzzsls310All
--where T$CSER is not null and T$SHPM is null
--)a
--where ltrim(rtrim(Sales_Vs_Commissioning.Fabno))=ltrim(rtrim(a.T$CSER))


Update Sales_Vs_Commissioning set UnitStatus='Machines in Transit'
from(select distinct company,T$ORNO,T$PONO,T$TTYP,T$INVN,T$INVD,T$BPID,T$SHPM,T$CSER 
from [ELGI_LN].dbo.tzzsls310All
where T$CSER is not null and T$SHPM is not null
)a
where ltrim(rtrim(Sales_Vs_Commissioning.Fabno))=ltrim(rtrim(a.T$CSER))


Update Sales_Vs_Commissioning set UnitStatus='Machines in Transit'
from(select distinct * from --[ELGI_Rotair].dbo.[ln_whltc500]
[ELGI_US].dbo.[ln_whltc500]
where qhnd=1 and cwar='170981'
--and (isdt<>'1970-01-01 00:00:00.000' or isdt<>'Jan  1 1970 12:00AM')
)a
where Sales_Vs_Commissioning.Fabno=a.serl

Update Sales_Vs_Commissioning set UnitStatus='Machines in Transit'
from(select distinct * from [ELGI_US].dbo.[ln_whltc500]
where qhnd=1
--and (isdt<>'1970-01-01 00:00:00.000' or isdt<>'Jan  1 1970 12:00AM')
)a
where Sales_Vs_Commissioning.Fabno=a.serl


Update Sales_Vs_Commissioning set UnitStatus='Dispatched from Subsidiary'
from(select distinct SERL from [ELGI_LN].dbo.TWHLTC500ALL where qhnd=0 and COMPANY in (500,551,552))a
where convert(varchar(50),ltrim(rtrim(Sales_Vs_Commissioning.Fabno)))=convert(varchar(50),ltrim(rtrim(a.serl)))

Update Sales_Vs_Commissioning set UnitStatus='Dispatched from Subsidiary'
from(select distinct * from --[ELGI_Rotair].dbo.[ln_whltc500]
[ELGI_US].dbo.[ln_whltc500]
where qhnd=0
and isdt<>'Jan  1 1970 12:00AM'
and isdt<>'1970-01-01 00:00:00.000'
and convert(date,isdt)<>'1970-01-01'
)a
where Sales_Vs_Commissioning.Fabno=a.serl

Update Sales_Vs_Commissioning set UnitStatus='Dispatched from Subsidiary'
from(select distinct * from [ELGI_US].dbo.[ln_whltc500] where qhnd=0
and isdt<>'1970-01-01 00:00:00.000' 
and isdt<>'Jan  1 1970 12:00AM'
and convert(date,isdt)<>'1970-01-01'
)a
where Sales_Vs_Commissioning.Fabno=a.serl



Update Sales_Vs_Commissioning set UnitStatus='Machines in Stock'
from(select distinct * from --[ELGI_Rotair].dbo.[ln_whltc500]
[ELGI_US].dbo.[ln_whltc500]
where qhnd<>0 and cwar<>'170981'
and (isdt='1970-01-01 00:00:00.000' or isdt='Jan  1 1970 12:00AM' or convert(date,isdt)='1970-01-01')
)a
where Sales_Vs_Commissioning.Fabno=a.serl


Update Sales_Vs_Commissioning set UnitStatus='Machines in Stock'
from(select distinct * from [ELGI_US].dbo.[ln_whltc500] where qhnd<>0
and (isdt='1970-01-01 00:00:00.000' or isdt='Jan  1 1970 12:00AM' or convert(date,isdt)='1970-01-01')
)a
where Sales_Vs_Commissioning.Fabno=a.serl


Update Sales_Vs_Commissioning set UnitStatus='Dispatched from Subsidiary'
from (select * from [ELGI_US].dbo.vw_Sales_with_Fabno )a
where Sales_Vs_Commissioning.Fabno=a.sern


--Update Sales_Vs_Commissioning set UnitStatus='Dispatched from Subsidiary'
--where Fabno not in (select distinct TransitFabNo from vw_USA_TransitFabNo_from_User)
--and region='USA'

--alter table Sales_Vs_Commissioning add UnitStatusOrdr int

--Method1
--Update Sales_Vs_Commissioning set UnitStatus='Machines in Stock'
--from(select distinct serl from [192.168.221.130].[rotair].dbo.[ln_whltc500] where qhnd<>0)a
--where Sales_Vs_Commissioning.Fabno=a.serl
--Method2
--Update Sales_Vs_Commissioning set UnitStatus='Machines in Stock'
--from(select distinct serl from [Rotair].dbo.[Rotair_receipt_Issues_Testing] where qhnd<>0)a
--where Sales_Vs_Commissioning.Fabno=a.serl




Update Sales_Vs_Commissioning set UnitStatus='Dispatched from Subsidiary' where desp_dt<='2017-04-01' 
Update Sales_Vs_Commissioning set UnitStatus='Dispatched from Subsidiary' where desp_dt<='2023-04-01' and region in ('Europe')
Update Sales_Vs_Commissioning set UnitStatus='Dispatched from Subsidiary' where desp_dt<='2024-01-01' and region in ('USA')

Update Sales_Vs_Commissioning set CommStatus='Machines Commissioned' where comm_date is not null and UnitStatus='Dispatched from Subsidiary'
Update Sales_Vs_Commissioning set CommStatus='Machines Not Commissioned' where comm_date is null and UnitStatus='Dispatched from Subsidiary'
Update Sales_Vs_Commissioning set CommStatus='Machines Not Commissioned (Others)' where CommStatus is null

--and UnitStatus='Dispatched from Subsidiary' --New logic to be added

Update Sales_Vs_Commissioning set Comm_Count=1 where CommStatus='Machines Commissioned'
Update Sales_Vs_Commissioning set not_Comm_Count=1 where CommStatus='Machines Not Commissioned' 
Update Sales_Vs_Commissioning set Comm_Count_TOTAL=1





--Special Case: added on 09-Jan-2024
--Update Sales_Vs_Commissioning set UnitStatus='Dispatched from Subsidiary' where CommStatus='Machines Commissioned'

update Sales_Vs_Commissioning set UnitStatusOrdr =1 where UnitStatus='Machines in Transit'
update Sales_Vs_Commissioning set UnitStatusOrdr =2 where UnitStatus='Machines in Stock'
update Sales_Vs_Commissioning set UnitStatusOrdr =3 where UnitStatus='Dispatched from Subsidiary'

--Alter table Sales_Vs_Commissioning add CommStatusOrdr int

update Sales_Vs_Commissioning set CommStatusOrdr =1 where UnitStatus='Machines Commissioned'
update Sales_Vs_Commissioning set CommStatusOrdr =2 where UnitStatus='Machines Not Commissioned'
update Sales_Vs_Commissioning set CommStatusOrdr =3 where UnitStatus='Machines Not Commissioned(Others)'




----------------------------
--Product segment Update

update Sales_Vs_Commissioning set prod_segment =a.prod_segment
from (select distinct tpl,prod_segment,tpl_rev from [ELGi_CDOC].dbo.crd_attribs a
where tpl_rev in (select max(tpl_rev) from [ELGi_CDOC].dbo.crd_attribs b
where a.tpl=b.tpl
))a
where ltrim(rtrim(Sales_Vs_Commissioning.Tpl))=ltrim(rtrim(a.tpl))


update Sales_Vs_Commissioning set prod_segment =a.prod_segment
from (select distinct tpl,prod_segment,tpl_rev from [ELGi_CDOC].dbo.dpsac1 a
where tpl_rev in (select max(tpl_rev) from [ELGi_CDOC].dbo.dpsac1 b
where a.tpl=b.tpl
))a
where ltrim(rtrim(Sales_Vs_Commissioning.Tpl))=ltrim(rtrim(a.tpl))



update Sales_Vs_Commissioning set prod_segment =a.ProductSegment
from (select distinct tpl,ProductSegment from TPLClassification_from_user)a
where ltrim(rtrim(Sales_Vs_Commissioning.Tpl))=ltrim(rtrim(a.tpl))


delete from Sales_Vs_Commissioning where prod_segment in ('ACCESSORIES','SPARE') and Region='Domestic'



--ProductCategory Classification
update Sales_Vs_Commissioning set ProductCategory='Units' where TPL Like 'S%'
update Sales_Vs_Commissioning set ProductCategory='Units' where TPL Like 'Z%'
update Sales_Vs_Commissioning set ProductCategory='Others'where ProductCategory is null



--CustomerName Updation


update Sales_Vs_Commissioning set CustomerName=a.custname1
from (select * from [ELGi_LN].dbo.vw_business_partner)a
where ltrim(rtrim(cu_code))=ltrim(rtrim(a.custcode))

update Sales_Vs_Commissioning set CustomerName=a.custname1
from (select * from [ELGi_LN].dbo.vw_business_partner)a
where concat('cu1',ltrim(rtrim(cu_code)))=ltrim(rtrim(a.custcode))
and CustomerName is null

update Sales_Vs_Commissioning set CustomerName=a.custname1
from (select * from [ELGi_LN].dbo.vw_business_partner)a
where concat('SU1',ltrim(rtrim(cu_code)))=ltrim(rtrim(a.custcode))
and CustomerName is null

update Sales_Vs_Commissioning set CustomerName=a.custname1
from (select * from [ELGi_LN].dbo.vw_business_partner_551)a
where ltrim(rtrim(cu_code))=ltrim(rtrim(a.custcode))
and CustomerName is null

update Sales_Vs_Commissioning set CustomerName=a.custname1
from (select * from [ELGi_LN].dbo.vw_business_partner_552)a
where ltrim(rtrim(cu_code))=ltrim(rtrim(a.custcode))
and CustomerName is null

update Sales_Vs_Commissioning set CustomerName=a.custname1
from (select * from [ELGi_LN].dbo.vw_business_partner_553)a
where ltrim(rtrim(cu_code))=ltrim(rtrim(a.custcode))
and CustomerName is null





End

select * from Sales_Vs_Commissioning 
where fabno in ('MYDS045231')
--where fabno in ('DRhS042224','X990722')
-- UnitStatus is null
--and region='Europe'

GO

