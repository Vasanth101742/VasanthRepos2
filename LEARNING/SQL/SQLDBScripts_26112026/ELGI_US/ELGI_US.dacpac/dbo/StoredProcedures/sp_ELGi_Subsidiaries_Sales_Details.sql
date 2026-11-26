--exec sp_ELGi_Subsidiaries_Sales_Details

CREATE proc sp_ELGi_Subsidiaries_Sales_Details as 
begin



Truncate table ELGi_Subsidiaries_Sales_Details_stage1


Declare @InvoiceDate date=(select convert(date,convert(varchar,Datepart(yyyy,(dateadd(yyyy,-1,getdate()-1))))+'-04-01'))


--sp_rename 'ELGi_Subsidiaries_Sales_Details.Sales_amount','Sales_HC'

--Elgi_Sales_details
----company,trantype,                  --Completed
----warehouse
----,OrderNo,PositionNo,               --Completed
--Invoice,Invoice_Date,                --Completed
----Taxcode,                           --Completed
----Currency,Item,Item_desc,           --Completed
--custcode,custname,                   --Completed
--dpst,dpstname,                       --NA
--Organ,                               --Completed
--Vertical1,user_names,
--Division,productgrp,Region,
--Zone,
--areacode,                            --Completed
--areaname,                            --Completed
--t_rate_1,                            --Completed
--t_rate_2,
--ED_AMOUNT,
--t_amth_1,                            --Completed
--t_txah_1,                            --Completed
--Foreign_currency_amount,             
--UnitPrice,DeliveryQty,               --Completed
--cal_Month,cal_year,Fin_month,        --Completed
--Fin_year,Monthname,                  --Completed
--Sales_HC,                            --Completed
--SaleOrderType,                       --Completed
--sales_category,
--FinCustGrp,ShipmentNO,ShipmentLine,
--ShiptoAddress,SegmentCode,Segment,
--SalesRepCode,
--SalesRep,LOBCode,LineOfBusiness,
--OrderDate,                           --Completed
--Del_Address,Sales_USD,Rate_USD,
--SubDivision,BuyBack,
--DeliveryTerms,DelvDesc,
--CarrierCode,CarrierDesc,
--PaymentTerms,PaymentDesc,
--lead_days,itemclass,
--estimated_date,
--indent,                              --Completed
--CRM_AssemblyLine,CRM_Unit_Acc,
--CRM_Productgroup,CRM_Division,
--t_amti,
--FOC_Type,invoice_date2,
--CPAY,PayTYP_desc

--sp_rename 'ELGi_Subsidiaries_Sales_Details.DelQty','DeliveryQty'
--Alter table ELGi_Subsidiaries_Sales_Details add SalesRepCode nvarchar(18)
--Alter table ELGi_Subsidiaries_Sales_Details add SalesRep nvarchar(70)


----Method 1: Finance Logic
--insert into ELGi_Subsidiaries_Sales_Details(company,trantype,
--Invoice,InvDate,warehouse,OrderNo,PositionNo,Currency,rate_1,
--custcode,custname,Item,Item_desc,DeliveryQty,Unitprice,Sales_HC,
--SaleOrderType,txah_1,Taxcode,leac,areacode,cofc,ctyp
--)
----select * into ELGi_Subsidiaries_Sales_Details from (
--SELECT a.compnr as company,a.[tran] as trantype,a.idoc as Invoice,
----a.idat2 as InvDate,
--a.idat as InvDate,
--null as warehouse,b.orno as OrderNo,b.pono as PositionNo,
--a.ccur as Currency,a.rate_1,
--b.stbp as custcode,null as custname,
--ltrim(rtrim(b.item)) as Item,c.dsca as Item_desc,
--b.dqua as DeliveryQty,b.pric as Unitprice,
----b.amth_1 as Sales_HC, --Logic1
--case when b.rtbi<>b.amth_1 then b.rtbi else b.amth_1 end as Sales_HC,
--b.sotp,b.txah_1,b.cvat,b.leac,b.creg,b.cofc,c.ctyp
--FROM LN_cisli305 a 
--LEFT JOIN LN_cisli310 b
--ON a.compnr = b.compnr and a.[tran] = b.[tran] and a.idoc = b.idoc
--LEFT JOIN LN_tcibd001 c 
--ON ltrim(rtrim(b.item))=ltrim(rtrim(c.item))
--AND ((a.compnr IN ('3110','3120','3130','3140','3150') AND c.compnr = '3100')
--OR (a.compnr = '2000' AND c.compnr = '2000') 
--OR (a.compnr IN ('1100','1700') AND c.compnr = '1100'))

--WHERE a.compnr IN ('3110','3120','3130','3140','3150','2000') 
--AND a.deleted = 'N'
----and b.invt_KW not in ('tcinvt.cntr.instalment','tcinvt.installment')
--and a.stat = '80' --Commented on 17Mar2026 for Brazil data validation
----Data Validation
----and concat(a.[tran],a.idoc) in ('S2324000184','S2324000185','S2324000186','S2324000187','S2324000188')
----and concat(a.[tran],a.idoc) in ('S1124000802','S1124000803')
----and ltrim(rtrim(a.Item))=''--'238-0165535.1-S'
----and company='3110'
----and convert(date,InvDate) between '2025-01-01' and '2025-01-31'
----)a





--Method 2:
------USA Dashboard Logic
insert into ELGi_Subsidiaries_Sales_Details_stage1(company,trantype,
Invoice,InvDate,OrderNo,PositionNo,Currency,rate_1,
custcode,Item,Item_desc,DeliveryQty,Unitprice,Sales_HC,
SaleOrderType,txah_1,Taxcode,leac,areacode,cofc,ctyp
)
select a.compnr,a.[tran],a.idoc,[Inv Date],
orno,pono,ccur,rate_1,stbp,
trim(item) as Item,ItemName,
dqua,pric,
sum(Sales_HC) Sales_HC,
sotp,txah_1,cvat,leac,creg,cofc,ctyp
from (
Select a.cofc,a.[tran],a.compnr,a.idoc,a.line, a.srtp,
a.orno,a.pono,b.ccur,b.rate_1,a.stbp,a.pric,
a.sotp,a.txah_1,a.cvat,a.leac,a.creg,e.ctyp,
replace(a.srtp_kw,'tcsli.srtp.','')'Order Type',
a.invt_kw 'Invt_KW',isnull(e.csel,'100')as csel
,convert(date,(CONVERT(datetime, b.idat) AT TIME ZONE 'UTC') AT TIME ZONE 'Eastern Standard Time') as"idat"
,convert(date,(CONVERT(datetime, b.idat) AT TIME ZONE 'UTC') AT TIME ZONE 'Eastern Standard Time') as 'Inv Date',
--(a.amti+a.txai) Sales_HC,
a.amth_1 as Sales_HC,
--case when a.rtbi<>b.amth_1 then a.rtbi else b.amth_1 end as Sales_HC,
isnull(isnull(c1.nama,c.nama),'NA')'EngName',
replace(replace(isnull(d.dsca,'NA'),
'Service Office - ',''),'Sales Office - ','')'Branch',
isnull(f.dsca,'NA')'ProductLine',
isnull(g.nama,'NA')'BPName',
--isnull(e1.dsca,'Service')"dsca",
year(convert(date,(CONVERT(datetime, b.idat) AT TIME ZONE 'UTC') AT TIME ZONE 'Eastern Standard Time'))'CurYear',
MONTH (convert(date,(CONVERT(datetime, b.idat) AT TIME ZONE 'UTC') AT TIME ZONE 'Eastern Standard Time'))'CurMonth',
--,replace(e.cdf_extd,' ','') as Item,
--isnull(e.dsca,'NA')'ItemName',
a.item,
e.dsca as ItemName,
case when a.compnr like '3%' and a.item like '%-120Q-%' then a.dqua*2 else a.dqua end as dqua, 
i.[desc] "Service"
,j1.teri_kw,j.cadr,b.stoa,upper(GG1.[user])"user",b.stat_kw
from ln_cisli310 a
left outer join ln_cisli305 b on b.compnr=a.compnr  and b.idoc=a.idoc and b.[tran]=a.[tran] and b.deleted='N'
left outer join ln_tccom001 c on c.emno=a.crep   and c.deleted='N'
left outer join ln_tcmcs065 d on d.cwoc=a.cofc and d.deleted='N'
left join LN_tcibd001 e on replace(e.item,' ','')=replace(a.item,' ','') and e.compnr ='3100' and e.deleted='N'
left join ln_tcmcs015 e1 on e1.ctyp=e.ctyp and e1.compnr='3100' and e1.deleted='N'
left join LN_tcmcs023 f on replace(f.citg,' ','')=replace(e.citg,' ','')  and f.compnr='3100' and f.deleted='N'
left join LN_TCCom100 g on replace(g.bpid,' ','')=replace(b.itbp,' ','') and g.deleted='N'
left join ln_tssoc200 h on h.orno=a.orno and h.compnr=a.compnr and a.srtp_kw='tcsli.srtp.service.order' and h.deleted='N'
left join ln_tsmdm030 i on i.cstp=h.cstp and i.compnr=h.compnr and i.deleted='N'
left join ln_tccom130 j on j.cadr=a.stoa and j.compnr='3100' and j.deleted='N' 
left join ln_txsls803 j1 on j1.ccty=j.ccty and j1.cste=j.cste and j1.compnr=b.compnr and j1.deleted='N'
left outer join ln_tccom001 c1 on c1.emno=j1.emno and c1.deleted='N'
left join ln_cisli200 GG1 on GG1.compnr=b.compnr and GG1.brid=b.brid and gg1.deleted='N'
where a.deleted='N'
)a
WHERE a.compnr IN ('3110','3120','3130','3140','3150','2000') 
and a.[tran] not in ('S23')
--where  a.compnr ='3140'  
--and idat between '2025-04-01' and '2026-03-31'
group by a.compnr,a.[tran],a.idoc,[Inv Date],
orno,pono,ccur,rate_1,stbp,
item,ItemName,
dqua,pric,sotp,txah_1,cvat,leac,creg,cofc,ctyp






--For Europe

insert into ELGi_Subsidiaries_Sales_Details_stage1(company,trantype,
Invoice,InvDate,warehouse,OrderNo,PositionNo,Currency,rate_1,
custcode,custname,Item,Item_desc,DeliveryQty,Unitprice,Sales_HC,
SaleOrderType,txah_1,Taxcode,leac,areacode,cofc,ctyp
)
--select * into ELGi_Subsidiaries_Sales_Details from (
SELECT a.compnr as company,a.[tran] as trantype,a.idoc as Invoice,
--a.idat2 as InvDate,
a.idat as InvDate,
null as warehouse,a.orno as OrderNo,b.pono as PositionNo,
a.ccur as Currency,a.rate_1,
b.stbp as custcode,null as custname,
ltrim(rtrim(b.item)) as Item,c.dsca as Item_desc,
--b.dqua as DeliveryQty,
case when replace(a.srtp_kw,'tcsli.srtp.','')='sales.order' then b.dqua
when replace(b.srtp_kw,'tcsli.srtp.','')='sales.order' then b.dqua
else null end as DeliveryQty,
b.pric as Unitprice,b.amth_1 as Sales_HC,
b.sotp,b.txah_1,b.cvat,b.leac,b.creg,b.cofc,c.ctyp
FROM LN_cisli305 a
LEFT JOIN LN_cisli310 b 
ON a.compnr = b.compnr and a.[tran] = b.[tran] and a.idoc = b.idoc
LEFT JOIN LN_tcibd001 c 
ON ltrim(rtrim(b.item))=ltrim(rtrim(c.item))
AND ((a.compnr IN ('3110','3120','3130','3140','3150') AND c.compnr = '3100')
OR (a.compnr = '2000' AND c.compnr = '2000') 
OR (a.compnr IN ('1100','1700') AND c.compnr = '1100'))

WHERE a.compnr IN ('1700') 
AND a.deleted = 'N'
and a.stat = '80' 
and leac not in ('025.049','312.550','370.057','309.591','309.761','304.012','365.500',
'038.010','370.041','370.019','370.055','958.002','361.024') --Non Sales Ledgers
and leac not in ('958.001') --Freight Ledger


--Rotair 

insert into ELGi_Subsidiaries_Sales_Details_stage1(company,trantype,
Invoice,InvDate,warehouse,OrderNo,PositionNo,Currency,rate_1,
custcode,custname,Item,Item_desc,DeliveryQty,Unitprice,Sales_HC,
SaleOrderType,txah_1,Taxcode,leac,areacode,cofc,ctyp
)
--select * into ELGi_Subsidiaries_Sales_Details from (
SELECT a.compnr as company,a.[tran] as trantype,a.idoc as Invoice,
--a.idat2 as InvDate,
a.idat as InvDate,
null as warehouse,a.orno as OrderNo,b.pono as PositionNo,
a.ccur as Currency,a.rate_1,
b.stbp as custcode,null as custname,
ltrim(rtrim(b.item)) as Item,c.dsca as Item_desc,
b.dqua as DeliveryQty,b.pric as Unitprice,b.amth_1 as Sales_HC,
b.sotp,b.txah_1,b.cvat,b.leac,b.creg,b.cofc,c.ctyp
FROM LN_cisli305 a
LEFT JOIN LN_cisli310 b 
ON a.compnr = b.compnr and a.[tran] = b.[tran] and a.idoc = b.idoc
LEFT JOIN LN_tcibd001 c 
ON ltrim(rtrim(b.item))=ltrim(rtrim(c.item))
AND ((a.compnr IN ('3110','3120','3130','3140','3150') AND c.compnr = '3100')
OR (a.compnr = '2000' AND c.compnr = '2000') 
OR (a.compnr IN ('1100','1700') AND c.compnr = '1100'))

WHERE a.compnr IN ('1100') 
AND a.deleted = 'N'
and a.stat = '80' 
--and b.invt_KW not in ('tcinvt.cntr.instalment','tcinvt.installment')
and leac not in ('038.010','361.024','361.025','025.049','370.055','304.010',
'301.001','303.018') --Non Sales Ledgers



----Service Contract Data Addition: part 1 --Commented on 24-08-2026
--insert into ELGi_Subsidiaries_Sales_Details(company,trantype,
--Invoice,InvDate,--warehouse,OrderNo,PositionNo,rate_1,
----custcode,custname,Item,
--Item_desc,--DeliveryQty,Unitprice,
--Sales_HC,--SaleOrderType
--Currency,ItemCategory,ProductGroup,ItemGroupingSource
--)
--select compnr,ityp,idoc,efdt,[desc],amnt,'USD' as Currency,
--'Service Charges / Contracts','Service Charges / Contracts','BI Logic' from LN_TSCTM400 
--where stin=20 and compnr in ('3140','3150')



--Service Contract Data Addition: part 2
insert into ELGi_Subsidiaries_Sales_Details_stage1(company,trantype,
Invoice,InvDate,--warehouse,OrderNo,PositionNo,rate_1,
custcode,--custname,Item,
--Item_desc,--DeliveryQty,Unitprice,
Sales_HC,--SaleOrderType
Currency,ItemCategory,ProductGroup,ItemGroupingSource,
leac
)
select compnr,otyp,odoc,
--dcdt,-- Not to be considered
[date],
--dbcr,dbcr_kw,
bpid,case when dbcr=1 then (-1)*amth_1 else amth_1 end as amth_1,
ccur,'Service Charges / Contracts','Service Charges / Contracts','BI Logic',
leac
from LN_TFGLD106
where compnr like '3%' 
and leac='4010204'
and otyp<>'GLJ'
and amth_1>0.1
--and odoc='24000484'
--and refr like '%DPM000025%'



--Removal of Initial Instalment Invoices for USA
delete from ELGi_Subsidiaries_Sales_Details_stage1
where company like '3%' and trantype in ('S19','S26','S30','S31')


--Removal of Initial Instalment Invoices for Europe
delete --select * 
from ELGi_Subsidiaries_Sales_Details_stage1
where company in ('1700') 
and SaleOrderType in ('V03') 
and concat(company,trantype,invoice) in (select distinct concat(compnr,[tran],idoc) from LN_CISLI310 where rrin in (2,3))


--Removal of Other Charges
delete from ELGi_Subsidiaries_Sales_Details_stage1 where company in ('1700') and ltrim(rtrim(leac))='' and ltrim(rtrim(item)) like '%025.049%'
delete from ELGi_Subsidiaries_Sales_Details_stage1 where company in ('1700') and ltrim(rtrim(leac))='' and ltrim(rtrim(item)) like '%312.550%'
delete from ELGi_Subsidiaries_Sales_Details_stage1 where company in ('1700') and ltrim(rtrim(leac))='' and ltrim(rtrim(item)) like '%370.055%'
delete from ELGi_Subsidiaries_Sales_Details_stage1 where company in ('1700') and ltrim(rtrim(leac))='' and ltrim(rtrim(item)) like '%370.057%'
delete from ELGi_Subsidiaries_Sales_Details_stage1 where company in ('1700') and ltrim(rtrim(leac))='' and ltrim(rtrim(item)) like '%309.591%'
delete from ELGi_Subsidiaries_Sales_Details_stage1 where company in ('1700') and ltrim(rtrim(leac))='' and ltrim(rtrim(item)) like '%309.761%'
delete from ELGi_Subsidiaries_Sales_Details_stage1 where company in ('1700') and ltrim(rtrim(leac))='' and ltrim(rtrim(item)) like '%304.012%'
delete from ELGi_Subsidiaries_Sales_Details_stage1 where company in ('1700') and ltrim(rtrim(leac))='' and ltrim(rtrim(item)) like '%365.500%'
delete from ELGi_Subsidiaries_Sales_Details_stage1 where company in ('1700') and ltrim(rtrim(leac))='' and ltrim(rtrim(item)) like '%038.010%'
delete from ELGi_Subsidiaries_Sales_Details_stage1 where company in ('1700') and ltrim(rtrim(leac))='' and ltrim(rtrim(item)) like '%370.041%'
delete from ELGi_Subsidiaries_Sales_Details_stage1 where company in ('1700') and ltrim(rtrim(leac))='' and ltrim(rtrim(item)) like '%370.019%'
delete from ELGi_Subsidiaries_Sales_Details_stage1 where company in ('1700') and ltrim(rtrim(leac))='' and ltrim(rtrim(item)) like '%958.001%'
delete from ELGi_Subsidiaries_Sales_Details_stage1 where company in ('1700') and ltrim(rtrim(leac))='' and ltrim(rtrim(item)) like '%958.002%'
delete from ELGi_Subsidiaries_Sales_Details_stage1 where company in ('1700') and ltrim(rtrim(leac))='' and ltrim(rtrim(item)) like '%361.024%'

delete from ELGi_Subsidiaries_Sales_Details_stage1 where company in ('1100') and ltrim(rtrim(leac))='' and ltrim(rtrim(item)) like '%038.010%'
delete from ELGi_Subsidiaries_Sales_Details_stage1 where company in ('1100') and ltrim(rtrim(leac))='' and ltrim(rtrim(item)) like '%361.024%'
delete from ELGi_Subsidiaries_Sales_Details_stage1 where company in ('1100') and ltrim(rtrim(leac))='' and ltrim(rtrim(item)) like '%361.025%'
delete from ELGi_Subsidiaries_Sales_Details_stage1 where company in ('1100') and ltrim(rtrim(leac))='' and ltrim(rtrim(item)) like '%025.049%'
delete from ELGi_Subsidiaries_Sales_Details_stage1 where company in ('1100') and ltrim(rtrim(leac))='' and ltrim(rtrim(item)) like '%370.055%'
delete from ELGi_Subsidiaries_Sales_Details_stage1 where company in ('1100') and ltrim(rtrim(leac))='' and ltrim(rtrim(item)) like '%304.010%'
delete from ELGi_Subsidiaries_Sales_Details_stage1 where company in ('1100') and ltrim(rtrim(leac))='' and ltrim(rtrim(item)) like '%301.001%'
delete from ELGi_Subsidiaries_Sales_Details_stage1 where company in ('1100') and ltrim(rtrim(leac))='' and ltrim(rtrim(item)) like '%303.018%'

delete from ELGi_Subsidiaries_Sales_Details_stage1 where company in ('1100','1700') and ltrim(rtrim(item)) like 'CV-%'
and  ltrim(rtrim(item)) not in ('CV-370.131_L02','CV-370.132_L02','CV-370.057_L02')


--Removal of Market Development Fees as one time activity
delete from ELGi_Subsidiaries_Sales_Details_stage1
where company in ('1700') 
and ltrim(rtrim(trantype,invoice))='C1B26000387'

--Remove shipping and Handling Charges
delete from ELGi_Subsidiaries_Sales_Details_stage1
where ltrim(rtrim(item)) in ('620-10-0000','620-10-0001','620-10-0002')

--Removing Customer Claims
delete from ELGi_Subsidiaries_Sales_Details_stage1
where company like '3%' and OrderNo like 'cc%'


--update ELGi_Subsidiaries_Sales_Details set AreaName=a.AreaName,SalesRepCode=crep,SalesRep=nama
--from(select distinct a.compnr,[tran],idoc,srtp_kw,a.orno,b.AreaName,c.crep,d.nama from LN_CISLI310 a
--left outer join vw_US_AreaList b
--on substring(a.orno,1,1)=b.id
--left outer join LN_TDSLS400 c
--on a.orno=c.orno
--left outer join LN_TCCOM001 d
--on c.crep=d.emno
----where concat(compnr,[tran],idoc)='3110S0124002433'
--)a
--where ELGi_Subsidiaries_Sales_Details.company=a.compnr
--and ELGi_Subsidiaries_Sales_Details.trantype=a.[tran]
--and ELGi_Subsidiaries_Sales_Details.Invoice=a.idoc

update ELGi_Subsidiaries_Sales_Details_stage1 set Areaname=a.dsca
from(select * from LN_tcmcs045 where deleted='N'
and compnr like '3%'
)a
where ELGi_Subsidiaries_Sales_Details_stage1.areacode=a.creg
and ELGi_Subsidiaries_Sales_Details_stage1.company like '3%'


update ELGi_Subsidiaries_Sales_Details_stage1 set Areaname=a.dsca
from(select * from LN_TCMCS045 where deleted='N'
and compnr like '1%'
)a
where ELGi_Subsidiaries_Sales_Details_stage1.areacode=a.creg
and ELGi_Subsidiaries_Sales_Details_stage1.company like '1%'



--update ELGi_Subsidiaries_Sales_Details set InvDate=DATEADD(MINUTE, -29, DATEADD(HOUR, -9, InvDate))
--where company like '3%'
--update ELGi_Subsidiaries_Sales_Details set InvDate=DATEADD(MINUTE, -29, DATEADD(HOUR, -8, InvDate))
--where company ='2000'
--update ELGi_Subsidiaries_Sales_Details set InvDate=dateadd(MINUTE ,-29,dateadd(hour,-3,InvDate))
--where company  in ('1100','1700')

update ELGi_Subsidiaries_Sales_Details_stage1 set cal_Month=month(InvDate)
update ELGi_Subsidiaries_Sales_Details_stage1 set cal_year=year(InvDate)

update ELGi_Subsidiaries_Sales_Details_stage1 set Fin_year=cal_year-1 where cal_Month<4
update ELGi_Subsidiaries_Sales_Details_stage1 set Fin_year=cal_year where cal_Month>=4

update ELGi_Subsidiaries_Sales_Details_stage1 set Fin_month=cal_Month+9 where cal_Month<4
update ELGi_Subsidiaries_Sales_Details_stage1 set Fin_month=cal_Month-3 where cal_Month>=4

update ELGi_Subsidiaries_Sales_Details_stage1 set Monthname=datename(MM,InvDate)


--update ELGi_Subsidiaries_Sales_Details set custname=a.nama
--from (select distinct compnr,bpid,nama from LN_TCCOM100)a
--where ltrim(rtrim(ELGi_Subsidiaries_Sales_Details.custcode))=ltrim(rtrim(a.bpid))
--AND ((ELGi_Subsidiaries_Sales_Details.company IN ('3110') AND a.compnr = '3100')
--OR (ELGi_Subsidiaries_Sales_Details.company = '2000' AND a.compnr = '2000') 
--OR (ELGi_Subsidiaries_Sales_Details.company IN ('1100','1700') AND a.compnr = '1100'))


update ELGi_Subsidiaries_Sales_Details_stage1 set OrderDate=a.odat--,Del_Address=a.DelAddress
from (
select * From (select compnr,odat,orno,ofbp,itad,creg as Areacode From LN_TDSLS400)a
--left join (select distinct CADR, concat(BLDG,BLFL,BLUN) as DelAddress  --NAMA,NAMB,NAMC  
--from ttccom130400 )b
--on ltrim(rtrim(a.t_itad))=ltrim(rtrim(b.CADR)) 
)a
where ELGi_Subsidiaries_Sales_Details_stage1.company =a.compnr 
and ELGi_Subsidiaries_Sales_Details_stage1.OrderNo =a.orno 
and ELGi_Subsidiaries_Sales_Details_stage1.custcode=a.ofbp


update ELGi_Subsidiaries_Sales_Details_stage1 set custname=a.custname1,FinCustGrp=a.FinCustGrp
from vw_Business_Partner_US a
where ELGi_Subsidiaries_Sales_Details_stage1.custcode=a.custcode
AND ((ELGi_Subsidiaries_Sales_Details_stage1.company IN ('3110','3120','3130','3140','3150') AND a.compnr = '3100')
OR (ELGi_Subsidiaries_Sales_Details_stage1.company = '2000' AND a.compnr = '2000') 
OR (ELGi_Subsidiaries_Sales_Details_stage1.company IN ('1100','1700') AND a.compnr = '1100'))


update ELGi_Subsidiaries_Sales_Details_stage1 set indent = a.indent
from(select compnr,orno,isnull(corn,refa) as indent from LN_TDSLS400)a
where ELGi_Subsidiaries_Sales_Details_stage1.company=a.compnr
and ELGi_Subsidiaries_Sales_Details_stage1.OrderNo =a.orno


update ELGi_Subsidiaries_Sales_Details_stage1 set Organ=a.Region
from (select * from vw_ELGi_offshore_Companies)a
where ELGi_Subsidiaries_Sales_Details_stage1.Company=a.Company


update ELGi_Subsidiaries_Sales_Details_stage1 set ItemGroupCode=a.citg,ProductLineCode=a.cpln
from (select distinct item,citg,cpln from LN_TCIBD001 where compnr='3100')a
where ltrim(rtrim(ELGi_Subsidiaries_Sales_Details_stage1.Item))=ltrim(rtrim(a.item))
and ELGi_Subsidiaries_Sales_Details_stage1.Company like '3%'


update ELGi_Subsidiaries_Sales_Details_stage1 set ItemGroupCode=a.citg,ProductLineCode=a.cpln
from (select distinct item,citg,cpln from LN_TCIBD001 where compnr='1100')a
where ltrim(rtrim(ELGi_Subsidiaries_Sales_Details_stage1.Item))=ltrim(rtrim(a.item))
and ELGi_Subsidiaries_Sales_Details_stage1.Company in ('1100','1700')


update ELGi_Subsidiaries_Sales_Details_stage1 set ItemGroupCode=a.citg,ProductLineCode=a.cpln
from (select distinct item,citg,cpln from LN_TCIBD001 where compnr='2000')a
where ltrim(rtrim(ELGi_Subsidiaries_Sales_Details_stage1.Item))=ltrim(rtrim(a.item))
and ELGi_Subsidiaries_Sales_Details_stage1.Company in ('2000')

update ELGi_Subsidiaries_Sales_Details_stage1 set ItemGroup=a.dsca
from (select distinct citg,dsca from LN_TCMCS023 where compnr='3100')a
where ltrim(rtrim(ELGi_Subsidiaries_Sales_Details_stage1.ItemGroupCode))=ltrim(rtrim(a.citg))
and ELGi_Subsidiaries_Sales_Details_stage1.Company like '3%'

update ELGi_Subsidiaries_Sales_Details_stage1 set ItemGroup=a.dsca
from (select distinct citg,dsca from LN_TCMCS023 where compnr='1100')a
where ltrim(rtrim(ELGi_Subsidiaries_Sales_Details_stage1.ItemGroupCode))=ltrim(rtrim(a.citg))
and ELGi_Subsidiaries_Sales_Details_stage1.Company in ('1100','1700')

update ELGi_Subsidiaries_Sales_Details_stage1 set ItemGroup=a.dsca
from (select distinct citg,dsca from LN_TCMCS023 where compnr='2000')a
where ltrim(rtrim(ELGi_Subsidiaries_Sales_Details_stage1.ItemGroupCode))=ltrim(rtrim(a.citg))
and ELGi_Subsidiaries_Sales_Details_stage1.Company in ('2000')


update ELGi_Subsidiaries_Sales_Details_stage1 set ProductLine=a.dsca
from (select distinct cpln,dsca from LN_TCMCS061 where compnr='3100')a
where ltrim(rtrim(ELGi_Subsidiaries_Sales_Details_stage1.ProductLineCode))=ltrim(rtrim(a.cpln))
and ELGi_Subsidiaries_Sales_Details_stage1.Company like '3%'

update ELGi_Subsidiaries_Sales_Details_stage1 set ProductLine=a.dsca
from (select distinct cpln,dsca from LN_TCMCS061 where compnr='1100')a
where ltrim(rtrim(ELGi_Subsidiaries_Sales_Details_stage1.ProductLineCode))=ltrim(rtrim(a.cpln))
and ELGi_Subsidiaries_Sales_Details_stage1.Company in ('1100','1700')


update ELGi_Subsidiaries_Sales_Details_stage1 set ProductLine=a.dsca
from (select distinct cpln,dsca from LN_TCMCS061 where compnr='2000')a
where ltrim(rtrim(ELGi_Subsidiaries_Sales_Details_stage1.ProductLineCode))=ltrim(rtrim(a.cpln))
and ELGi_Subsidiaries_Sales_Details_stage1.Company ='2000'


update ELGi_Subsidiaries_Sales_Details_stage1 set Department=c.dsca
from(select distinct compnr,cwoc,dsca from ln_tcmcs065)c
where ELGi_Subsidiaries_Sales_Details_stage1.cofc=c.cwoc
AND ((ELGi_Subsidiaries_Sales_Details_stage1.company IN ('3110','3120','3130','3140','3150') AND c.compnr = '3100')
OR (ELGi_Subsidiaries_Sales_Details_stage1.company = '2000' AND c.compnr = '2000') 
OR (ELGi_Subsidiaries_Sales_Details_stage1.company IN ('1100','1700') AND c.compnr = '1100'))


update ELGi_Subsidiaries_Sales_Details_stage1 set ctypdesc=c.dsca
from(select distinct compnr,ctyp,dsca from ln_tcmcs015)c
where ELGi_Subsidiaries_Sales_Details_stage1.ctyp=c.ctyp
AND ((ELGi_Subsidiaries_Sales_Details_stage1.company IN ('3110','3120','3130','3140','3150') AND c.compnr = '3100')
OR (ELGi_Subsidiaries_Sales_Details_stage1.company = '2000' AND c.compnr = '2000') 
OR (ELGi_Subsidiaries_Sales_Details_stage1.company IN ('1100','1700') AND c.compnr = '1100'))


--Alter table ELGi_Subsidiaries_Sales_Details add ctyp varchar(25)
--Alter table ELGi_Subsidiaries_Sales_Details add ctypdesc varchar(50)
--select * from ELGi_Subsidiaries_Sales_Details
--select * from ln_tcmcs015


update ELGi_Subsidiaries_Sales_Details_stage1 set INR_ConversionRate=a.INR_ConversionRate
from (select * from [ELGi_LN].dbo.CurrencyRateMaster_from_FinanceTeam)a
where ELGi_Subsidiaries_Sales_Details_stage1.Fin_year=a.FinYear
and ELGi_Subsidiaries_Sales_Details_stage1.Currency=a.SourceCurrency

update ELGi_Subsidiaries_Sales_Details_stage1 set USD_ConversionRate=a.USD_ConversionRate
from (select * from [ELGi_LN].dbo.CurrencyRateMaster_from_FinanceTeam)a
where ELGi_Subsidiaries_Sales_Details_stage1.Fin_year=a.FinYear
and ELGi_Subsidiaries_Sales_Details_stage1.Currency=a.SourceCurrency

update ELGi_Subsidiaries_Sales_Details_stage1 set Sales_INR=isnull(INR_ConversionRate,0)*Sales_HC
update ELGi_Subsidiaries_Sales_Details_stage1 set Sales_USD=isnull(USD_ConversionRate,0)*Sales_HC


--Alter table ELGi_Subsidiaries_Sales_Details add INR_ConversionRate_AER float
--Alter table ELGi_Subsidiaries_Sales_Details add USD_ConversionRate_AER float

--Alter table ELGi_Subsidiaries_Sales_Details add Sales_INR_AER float
--Alter table ELGi_Subsidiaries_Sales_Details add Sales_USD_AER float



update ELGi_Subsidiaries_Sales_Details_stage1 set USD_ConversionRate_AER=a.RATE
from (select distinct InvDate,Currency,BCUR,CCUR,STDT,RATE,Rnk--,DaysDiff
from (
select *,datediff(dd,STDT,InvDate) as DaysDiff,
row_number() over (partition by InvDate,Currency order by datediff(dd,STDT,InvDate)) as Rnk 
from (select distinct InvDate,Currency from ELGi_Subsidiaries_Sales_Details_stage1
--where currency='MYR'
)a
left outer join 
(select CCUR,BCUR,RTYP,convert(date,STDT) STDT,1/max(RATE) RATE
from [ELGi_LN].dbo.TTCMCS008ALL 
where BCUR in ('USD','EUR','BRL','GBP')
and CCUR in ('USD')
and RATE<>1
--and convert(date,stdt)='2024-01-08'
group by CCUR,BCUR,RTYP,convert(date,STDT)
--order by convert(date,STDT)
)b
on a.Currency=b.BCUR
and a.InvDate>=b.STDT
)a
where Rnk=1
--order by PostingDate
)a
where ELGi_Subsidiaries_Sales_Details_stage1.InvDate=a.InvDate
and ELGi_Subsidiaries_Sales_Details_stage1.Currency=a.Currency




update ELGi_Subsidiaries_Sales_Details_stage1 set INR_ConversionRate_AER=a.RATE
from (select distinct InvDate,Currency,BCUR,CCUR,STDT,RATE,Rnk--,DaysDiff
from (
select *,datediff(dd,STDT,InvDate) as DaysDiff,
row_number() over (partition by InvDate,Currency order by datediff(dd,STDT,InvDate)) as Rnk 
from (select distinct InvDate,Currency from ELGi_Subsidiaries_Sales_Details_stage1
--where currency='MYR'
)a
left outer join 
(select CCUR,BCUR,RTYP,convert(date,STDT) STDT,max(RATE) RATE
from [ELGi_LN].dbo.TTCMCS008ALL 
where ccur in ('USD','EUR','BRL','GBP')
and bcur in ('IND','INR')
and RATE<>1
--and convert(date,stdt)='2024-01-08'
group by CCUR,BCUR,RTYP,convert(date,STDT)
--order by convert(date,STDT)
)b
on a.Currency=b.CCUR
and a.InvDate>=b.STDT
)a
where Rnk=1
--order by PostingDate
)a
where ELGi_Subsidiaries_Sales_Details_stage1.InvDate=a.InvDate
and ELGi_Subsidiaries_Sales_Details_stage1.Currency=a.Currency





----Special Case: 
--update GLSalesMargin set INR_ConversionRate_AER=a.CurrencyRate
--from (select * from [ELGi_LN].dbo.CurrencyRateMaster a where company=551
--and UpdatedDate=(select max(UpdatedDate) from [ELGi_LN].dbo.CurrencyRateMaster where company=551 and FromCurrency=a.FromCurrency) 
--and ToCurrency='INR' )a
--where GLSalesMargin.CurrencyCode=a.FromCurrency
--and GLSalesMargin.PostingDate between a.validFromDate and a.ValidToDate
--and GLSalesMargin.INR_ConversionRate_AER is null

update ELGi_Subsidiaries_Sales_Details_stage1 set USD_ConversionRate_AER=1 where currency='USD'

update ELGi_Subsidiaries_Sales_Details_stage1 set Sales_INR_AER=INR_ConversionRate_AER*Sales_HC
update ELGi_Subsidiaries_Sales_Details_stage1 set Sales_USD_AER=USD_ConversionRate_AER*Sales_HC

------------------------------------------------------------------------------------------

update ELGi_Subsidiaries_Sales_Details_stage1 set ItemCategory=a.Item_Category,
ProductGroup=a.Product_group,ItemGroupingSource='S&OP'
from (select * from [ELGi_SOP].dbo.TPL_MASTER_REF where region='USA')a
where ELGi_Subsidiaries_Sales_Details_stage1.company like '3%'
and ltrim(rtrim(ELGi_Subsidiaries_Sales_Details_stage1.Item))=ltrim(rtrim(a.Item))


update ELGi_Subsidiaries_Sales_Details_stage1 set ItemCategory=a.Item_Category,
ProductGroup=a.Product_group,ItemGroupingSource='S&OP'
from (select * from [ELGi_SOP].dbo.TPL_MASTER_REF where region='Europe')a
where ELGi_Subsidiaries_Sales_Details_stage1.company in ('1100','1700')
and ltrim(rtrim(ELGi_Subsidiaries_Sales_Details_stage1.Item))=ltrim(rtrim(a.Item))

update ELGi_Subsidiaries_Sales_Details_stage1 set ItemCategory=a.Item_Category,
ProductGroup=a.Product_group,ItemGroupingSource='S&OP'
from (select * from [ELGi_SOP].dbo.TPL_MASTER_REF where region='Brazil')a
where ELGi_Subsidiaries_Sales_Details_stage1.company in ('2000')
and ltrim(rtrim(ELGi_Subsidiaries_Sales_Details_stage1.Item))=ltrim(rtrim(a.Item))

update ELGi_Subsidiaries_Sales_Details_stage1 set ItemCategory='Service Charges / Contracts',
ProductGroup='Service Charges / Contracts',ItemGroupingSource='BI Logic'
where company in ('1700')  and SaleOrderType in ('V03') 

--update ELGi_Subsidiaries_Sales_Details set ItemCategory='Service Charges / Contracts',
--ProductGroup= 'Service Charges / Contracts',ItemGroupingSource= 'BI Logic'
--where company like '3%' and trantype='S23'


update ELGi_Subsidiaries_Sales_Details_stage1 set ItemCategory=ctypdesc,ItemGroupingSource='LN Master'
where ItemCategory is null

update ELGi_Subsidiaries_Sales_Details_stage1 set ProductGroup=ItemGroup,ItemGroupingSource='LN Master'
where ProductGroup is null

update ELGi_Subsidiaries_Sales_Details_stage1 set ProductGroup='' where ProductGroup is null

update ELGi_Subsidiaries_Sales_Details_stage1 set CPAY=a.cpay
from (select distinct concat(compnr,ttyp,ninv) as inv,cpay from LN_TFACR200 where len(cpay)>1) a
where concat(company,Trantype,Invoice)=a.inv

update ELGi_Subsidiaries_Sales_Details_stage1 set PayTYP_desc=a.DSCA
from (select distinct CPAY,DSCA from LN_TCMCS013) a
where ELGi_Subsidiaries_Sales_Details_stage1.CPAY=a.CPAY



--update ELGi_Subsidiaries_Sales_Details set Organ='ELGi USA',vertical1='ELGi USA',Region='USA',[Zone]='USA',Areaname='USA'
--where company='3100'
update ELGi_Subsidiaries_Sales_Details_stage1 set Organ='ELGi USA',vertical1='ELGi USA',Region='USA',[Zone]='USA',Areaname='USA'
where company='3110'
update ELGi_Subsidiaries_Sales_Details_stage1 set Organ='Portables',vertical1='Portables',Region='USA',[Zone]='USA',Areaname='USA'
where company='3120'
update ELGi_Subsidiaries_Sales_Details_stage1 set Organ='Medical',vertical1='Medical',Region='USA',[Zone]='USA',Areaname='USA'
where company='3130'
update ELGi_Subsidiaries_Sales_Details_stage1 set Organ='Patton''s Inc',vertical1='Patton''s Inc',Region='USA',[Zone]='USA',Areaname='USA'
where company='3140'
update ELGi_Subsidiaries_Sales_Details_stage1 set Organ='MAS',vertical1='MAS',Region='USA',[Zone]='USA',Areaname='USA'
where company='3150'

update ELGi_Subsidiaries_Sales_Details_stage1 set Organ='USA to Interco',vertical1='Interco Sales',Region='USA',[Zone]='USA',Areaname='USA'
where company like '3%' and substring(ltrim(rtrim(custcode)),1,1) in ('I','G')


update ELGi_Subsidiaries_Sales_Details_stage1 set Organ=a.Organ,vertical1=a.[Business Vertical],Region=a.Region,[Zone]=a.Region
from (select * from SalesCategorizationMaster_Europe)a
where ELGi_Subsidiaries_Sales_Details_stage1.areacode=a.areacode
and ELGi_Subsidiaries_Sales_Details_stage1.company='1700'


--Below logic to be updated
update ELGi_Subsidiaries_Sales_Details_stage1 set Organ='Rotair',Region='Europe',[Zone]='Europe'--,vertical1='Rotair'
where company='1100'

update ELGi_Subsidiaries_Sales_Details_stage1 set vertical1='AIREND-Others' where company='1100' and ProductLineCode is null
update ELGi_Subsidiaries_Sales_Details_stage1 set vertical1='OTHERS' where company='1100' and ProductLineCode='L00'
update ELGi_Subsidiaries_Sales_Details_stage1 set vertical1='DPSAC' where company='1100' and ProductLineCode='L01'
update ELGi_Subsidiaries_Sales_Details_stage1 set vertical1='DPSAC' where company='1100' and ProductLineCode='L02'
update ELGi_Subsidiaries_Sales_Details_stage1 set vertical1='BREAKERS' where company='1100' and ProductLineCode='L04'
update ELGi_Subsidiaries_Sales_Details_stage1 set vertical1='RAMPICAR' where company='1100' and ProductLineCode='L05'
update ELGi_Subsidiaries_Sales_Details_stage1 set vertical1='AIREND' where company='1100' and ProductLineCode='L06'


update ELGi_Subsidiaries_Sales_Details_stage1 set vertical1='Rotair DPSAC & Airend' where company='1100' 
and vertical1 in ('AIREND-Others','DPSAC','AIREND','OTHERS')
update ELGi_Subsidiaries_Sales_Details_stage1 set vertical1='Rotair Breakers' where company='1100' and vertical1 in ('BREAKERS')
update ELGi_Subsidiaries_Sales_Details_stage1 set vertical1='Rotair Rampicar'  where company='1100' and vertical1 in ('RAMPICAR')


--update ELGi_Subsidiaries_Sales_Details set Organ='Rotair to Interco',vertical1='Rotair to Interco',Region='Europe',[Zone]='Europe',Areaname='Europe'
--where company ='1100'
--and custcode in (select custcode from vw_Rotair_Interco_customer_codes)



update ELGi_Subsidiaries_Sales_Details_stage1 set Organ='Brazil',vertical1='Brazil',Region='Brazil',[Zone]='Brazil',Areaname='Brazil'
where company='2000'

delete from ELGi_Subsidiaries_Sales_Details where InvDate>=@InvoiceDate

insert into ELGi_Subsidiaries_Sales_Details(company,trantype,Invoice,InvDate,warehouse,OrderNo,
PositionNo,Currency,rate_1,custcode,custname,Item,Item_desc,DeliveryQty,Unitprice,Sales_HC,
cal_Month,cal_year,Fin_month,Fin_year,Monthname,ItemGroup,ProductLine,Organ,SaleOrderType,OrderDate,
FinCustGrp,indent,ProductLineCode,INR_ConversionRate,USD_ConversionRate,Sales_INR,Sales_USD,
ItemCategory,ProductGroup,vertical1,Region,Zone,Areaname,txah_1,Taxcode,CPAY,PayTYP_desc,SalesRepCode,
SalesRep,leac,areacode,cofc,Department,ctyp,ctypdesc,ItemGroupCode,ItemGroupingSource,INR_ConversionRate_AER,
USD_ConversionRate_AER,Sales_INR_AER,Sales_USD_AER)
select company,trantype,Invoice,InvDate,warehouse,OrderNo,
PositionNo,Currency,rate_1,custcode,custname,Item,Item_desc,DeliveryQty,Unitprice,Sales_HC,
cal_Month,cal_year,Fin_month,Fin_year,Monthname,ItemGroup,ProductLine,Organ,SaleOrderType,OrderDate,
FinCustGrp,indent,ProductLineCode,INR_ConversionRate,USD_ConversionRate,Sales_INR,Sales_USD,
ItemCategory,ProductGroup,vertical1,Region,Zone,Areaname,txah_1,Taxcode,CPAY,PayTYP_desc,SalesRepCode,
SalesRep,leac,areacode,cofc,Department,ctyp,ctypdesc,ItemGroupCode,ItemGroupingSource,INR_ConversionRate_AER,
USD_ConversionRate_AER,Sales_INR_AER,Sales_USD_AER
from ELGi_Subsidiaries_Sales_Details_stage1

--update ELGi_Subsidiaries_Sales_Details set AreaName=a.AreaName,SalesRepCode=crep,SalesRep=nama
--from(select distinct a.compnr,[tran],idoc,srtp_kw,a.orno,b.AreaName,c.crep,d.nama from LN_CISLI310 a
--left outer join vw_US_AreaList b
--on substring(a.orno,1,1)=b.id
--left outer join LN_TDSLS400 c
--on a.orno=c.orno
--left outer join LN_TCCOM001 d
--on c.crep=d.emno
----where concat(compnr,[tran],idoc)='3110S0124002433'
--)a
--where ELGi_Subsidiaries_Sales_Details.company=a.compnr
--and ELGi_Subsidiaries_Sales_Details.trantype=a.[tran]
--and ELGi_Subsidiaries_Sales_Details.Invoice=a.idoc




end

--select distinct currency 
----InvDate,Currency,Sales_HC,
----INR_ConversionRate,USD_ConversionRate,Sales_INR,Sales_USD,
----INR_ConversionRate_AER,USD_ConversionRate_AER,Sales_INR_AER,Sales_USD_AER
--from ELGi_Subsidiaries_Sales_Details
--where invdate>='2025-04-01'
----and USD_ConversionRate_AER is null
----and INR_ConversionRate_AER is null
----order by InvDate

GO

