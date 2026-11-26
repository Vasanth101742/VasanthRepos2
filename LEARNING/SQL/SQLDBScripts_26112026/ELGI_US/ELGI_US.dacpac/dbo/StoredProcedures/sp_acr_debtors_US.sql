--exec sp_acr_debtors_US
CREATE proc [dbo].[sp_acr_debtors_US] as 

begin

Truncate table acr_debtors_US
          
--Alter table acr_debtors_US add CompName varchar(50)
--Alter table acr_debtors_US add SubCompName varchar(50)

--Alter table acr_debtors_US add DueYear_Fin Int
--Alter table acr_debtors_US add DueMonth Int
--Alter table acr_debtors_US add DueMonthName varchar(50)
--Alter table acr_debtors_US add trec bigint
--Alter table acr_debtors_US add trec_kw nvarchar(255)
--Alter table acr_debtors_US add orno nvarchar(10)



insert into acr_debtors_US(compnr,ttyp,ninv,line,itbp,ccur,rate_1,docd,
dued,prod,year,InvAmth,PaidAmth,OutstandingAmth,trec,trec_kw)
--select * into acr_debtors from (
select a.compnr,a.ttyp,a.ninv,a.line,a.itbp,a.ccur,a.rate_1,a.docd,
case when a.dued='0001-01-01' then null 
else a.dued end as dued,
a.prod,a.year,
avg(InvAmth) InvAmth,
sum(PaidAmth) PaidAmth,
convert(decimal(19,2),isnull(avg(InvAmth),0)+isnull(sum(PaidAmth),0)) as OutstandingAmth,
a.trec,a.trec_kw
from
(select  compnr,ttyp,ninv,line,itbp,ccur,rate_1,docd,dued,trec,trec_kw,
prod,year,
sum(convert(float,amth_1)) InvAmth
--sum(amti) InvAmti
from [ln_tfacr200]
where docn=0
and deleted='N'
group by compnr,ttyp,ninv,line,itbp,ccur,rate_1,docd,dued,trec,trec_kw,
prod,year
)a
left outer join
(select  compnr,ttyp,ninv,line,itbp,ccur,rate_1,docd,--trec,trec_kw,
prod,year,
sum(isnull(convert(float,amth_1),0)+isnull(convert(float,padh_1),0)+
isnull(convert(float,dc1h_1),0)+isnull(convert(float,cdam_1),0)) as PaidAmth
from [dbo].[ln_tfacr200]
where docn<>0
and deleted='N'
group by compnr,ttyp,ninv,line,itbp,ccur,rate_1,docd,--trec,trec_kw,
prod,year
)b
on a.compnr=b.compnr
and a.ttyp=b.ttyp
and a.ninv=b.ninv
and a.line=b.line
and a.itbp=b.itbp
--where  concat(a.compnr,a.ttyp,a.ninv)='3110HSI24000373'
group by a.compnr,a.ttyp,a.ninv,a.line,a.itbp,a.ccur,a.rate_1,a.docd,
a.dued,a.prod,a.year,a.trec,a.trec_kw
--)a

update acr_debtors_US set year='2023' where docd<'2023-04-01'
update acr_debtors_US set prod='1' where docd<'2023-04-01'
update acr_debtors_US set docd='2023-04-01' where docd<'2023-04-01'
update acr_debtors_US set dued='2023-04-01' where dued<'2023-04-01'


update acr_debtors_US set trec_kw=replace(trec_kw,'tfacr.trec.','')

update acr_debtors_US set CompName=a.CompName,SubCompName=a.SubCompName
from (select * from vw_ELGi_offshore_Companies)a
where acr_debtors_US.compnr=a.Company


update acr_debtors_US set BPName=a.Nama
from (select distinct bpid,Nama from ln_tccom100)a
where ltrim(rtrim(acr_debtors_US.itbp))=ltrim(rtrim(a.bpid))


update acr_debtors_US set BPType=a.BPType
from BPType_Master a
where ltrim(rtrim(acr_debtors_US.itbp))=ltrim(rtrim(a.BPCode))
and acr_debtors_US.compnr in (select company from vw_ELGi_offshore_Companies where CompName='ELGi-USA')

update acr_debtors_US set BPType='Direct'
where acr_debtors_US.compnr in (select company from vw_ELGi_offshore_Companies where CompName='ELGi-USA')
and BPType is null


--alter table acr_debtors_US add ARContact nvarchar(100)
--update acr_debtors_US set BPCategory=a.BPCategory
--from (select * from BP_Category_Master)a
--where acr_debtors_US.compnr=a.Company
--and acr_debtors_US.itbp=a.BPCode

--As per SR 1618908 dated on Tue, 1 Sep 6:50 PM, BP category changed as per the excel and , Before August-31,2026 based on invoice wise and 
--from set1, 2026 based on custcode wise

update acr_debtors_US set BPCategory=a.new_inv_wise_assign,ARContact=a.New_Inv_Wise_AR_Contact
from (select  * from [dbo].ACR_Debtors_ItemWiseMaster)a
where  concat(acr_debtors_US.compnr,'-',acr_debtors_US.itbp,'-',acr_debtors_US.ttyp,'-',acr_debtors_US.ninv)=a.unique_inv

update acr_debtors_US set BPCategory=a.cust_wise_assign_to,ARContact=a.Cust_Wise_AR_Contact
from (select replace(unique_cust_Name,' ','') 'Key', * from [dbo].[ACRDebtors_BP_Category_Master])a
where  replace(concat(acr_debtors_US.itbp,'-',bpname),' ','')=a.[Key] and acr_debtors_US.BPCategory is null


update acr_debtors_US set OrderType=a.srtp_kw,AreaName=a.AreaName,SalesPersonCode=crep,SalesPersonName=nama
from(select distinct a.compnr,[tran],idoc,srtp_kw,a.orno,b.AreaName,c.crep,d.nama from LN_CISLI310 a
left outer join vw_US_AreaList b
on substring(a.orno,1,1)=b.id
left outer join LN_TDSLS400 c
on a.orno=c.orno
left outer join LN_TCCOM001 d
on c.crep=d.emno
--where concat(compnr,[tran],idoc)='3110S0124002433'
)a
where acr_debtors_US.compnr=a.compnr
and acr_debtors_US.ttyp=a.[tran]
and acr_debtors_US.ninv=a.idoc


--Alter table acr_debtors_US add SalesPersonCode varchar(50)
--Alter table acr_debtors_US add SalesPersonName varchar(50)

update acr_debtors_US set OrderType=replace(OrderType,'tcsli.srtp.','')

--select * from
--(select compnr,[tran],idoc,count(distinct srtp_kw) srtp_kw from LN_CISLI310
--where compnr like '3%'
--group by compnr,[tran],idoc
--having count(distinct srtp_kw)>1
--)a
--order by srtp_kw desc

--select * from LN_CISLI310 where concat(compnr,[tran],idoc)='3140S2024010817'


update acr_debtors_US set Duetype=a.DueType,payment_date=a.docd
from
(select a.compnr,a.ttyp,a.ninv,a.itbp,a.dued,b.docd,
case when a.dued is null then null
--when datediff(dd,a.dued,b.docd) >0 then 'OverDue' --Method1
when datediff(dd,a.dued,getdate()-1) >0 then 'OverDue'
else 'WithinDue' end as DueType
from acr_debtors_US a
left outer join(
select  compnr,ttyp,ninv,--line,
itbp,max(docd) docd
from [dbo].[ln_tfacr200]
where docn<>0
group by compnr,ttyp,ninv,--line,
itbp)b
on a.compnr=b.compnr
and a.ttyp=b.ttyp
and a.ninv=b.ninv
and a.itbp=b.itbp
)a
where acr_debtors_US.compnr=a.compnr
and acr_debtors_US.ttyp=a.ttyp
and acr_debtors_US.ninv=a.ninv
and acr_debtors_US.itbp=a.itbp

update acr_debtors_US set DueYear_Fin=year(dued)-1 where month(dued)<4
update acr_debtors_US set DueYear_Fin=year(dued) where month(dued)>=4

update acr_debtors_US set DueMonth=concat(convert(varchar,year(dued)),RIGHT('00'+CAST(month(dued) AS VARCHAR(2)),2))
update acr_debtors_US set DueMonthName=substring(datename(mm,dateadd(mm,month(dued),-1)),1,3)+'-'+substring(convert(varchar,year(dued)),3,2)

--Alter table acr_debtors_US add CalYear int
--Alter table acr_debtors_US add CalMonth int
--Alter table acr_debtors_US add InvPeriod int


update acr_debtors_US set CalMonth=prod+3 where prod<=9
update acr_debtors_US set CalMonth=prod-9 where prod>9

update acr_debtors_US set CalYear=Year where prod<=9
update acr_debtors_US set CalYear=Year+1 where prod>9

--update acr_debtors_US set InvPeriod=concat(convert(varchar,CalYear),RIGHT('00'+CAST(CalMonth AS VARCHAR(2)),2))
update acr_debtors_US set InvPeriod=concat(convert(varchar,[Year]),RIGHT('00'+CAST(prod AS VARCHAR(2)),2))

--update acr_debtors_US set InvMonthName=substring(datename(mm,dateadd(mm,month(docd),-1)),1,3)+'-'+substring(convert(varchar,year(docd)),3,2)
update acr_debtors_US set InvMonthName=substring(datename(mm,dateadd(mm,CalMonth,-1)),1,3)+'-'+substring(convert(varchar,CalYear),3,2)



update acr_debtors_US set paymentstatus='Closed' where PaidAmth is not null and OutstandingAmth between -1 and 1
update acr_debtors_US set paymentstatus='Pending' where paymentstatus is null
--where PaidAmth is not null and OutstandingAmth not between -1 and 1

--alter table acr_debtors_US add AgeingDays int
update acr_debtors_US set AgeingDays= datediff(dd,dued,getdate()-1)


update acr_debtors_US set Ageing='Advances' where dued is null
update acr_debtors_US set Ageing='NotDue' where datediff(dd,dued,getdate()-1)<0
update acr_debtors_US set Ageing='Lessthan30' where datediff(dd,dued,getdate()-1) between 0 and 30
update acr_debtors_US set Ageing='31-60' where datediff(dd,dued,getdate()-1) between 31 and 60
update acr_debtors_US set Ageing='61-90' where datediff(dd,dued,getdate()-1) between 61 and 90
update acr_debtors_US set Ageing='91-120' where datediff(dd,dued,getdate()-1) between 91 and 120
--update acr_debtors_US set Ageing='121-150' where datediff(dd,dued,getdate()-1) between 121 and 150
--update acr_debtors_US set Ageing='151-180' where datediff(dd,dued,getdate()-1) between 151 and 180
update acr_debtors_US set Ageing='121-180' where datediff(dd,dued,getdate()-1) between 121 and 180
update acr_debtors_US set Ageing='181-366' where datediff(dd,dued,getdate()-1) between 181 and 366
update acr_debtors_US set Ageing='Greater than 1Yr' where datediff(dd,dued,getdate()-1) >= 367
--update acr_debtors_US set Ageing='Greater than 2Yrs' where datediff(dd,dued,getdate()-1) between 733 and 1098
--update acr_debtors_US set Ageing='Greater than 3Yrs' where datediff(dd,dued,getdate()-1) >1098

update acr_debtors_US set AgeingOrder=1 where Ageing='Advances'
update acr_debtors_US set AgeingOrder=2 where Ageing='NotDue'
update acr_debtors_US set AgeingOrder=3 where Ageing='Lessthan30'
update acr_debtors_US set AgeingOrder=4 where Ageing='31-60'
update acr_debtors_US set AgeingOrder=5 where Ageing='61-90'
update acr_debtors_US set AgeingOrder=6 where Ageing='91-120'
update acr_debtors_US set AgeingOrder=7 where Ageing='121-180'
--update acr_debtors_US set AgeingOrder=8 where Ageing='151-180'
update acr_debtors_US set AgeingOrder=9 where Ageing='181-366'
update acr_debtors_US set AgeingOrder=10 where Ageing='Greater than 1Yr'
--update acr_debtors_US set AgeingOrder=11 where Ageing='Greater than 2Yrs'
--update acr_debtors_US set AgeingOrder=12 where Ageing='Greater than 3Yrs'

--Alter table acr_debtors_US add LastUpdated Datetime




update acr_debtors_US set LastUpdated=dateadd(hour,-5,getdate())
update acr_debtors_US set LastUpdated=dateadd(minute,-30,LastUpdated)

--Alter table acr_debtors_US add Email varchar(50)

update acr_debtors_US set SalesPersonName=a.EmpName,Email=a.Email
from (select * from ELGI_US_Area_Access)a
where acr_debtors_US.AreaName=a.AreaName
and orderType='service.order'
and SalespersonName is null

update acr_debtors_US set Email=a.Email
from (select distinct a.salespersonName,b.email from acr_debtors_US a
left outer join [Elgi_Intranet].dbo.Employee_detail b
on a.salespersonName=b.emp_name)a
where acr_debtors_US.salespersonName=a.salespersonName
and orderType<>'service.order'

--Alter table acr_debtors_US alter column Email nvarchar(100)
--Alter table acr_debtors_US add Contact nvarchar(32)


update acr_debtors_US set Email=a.Email,Contact=a.Contact
from (select distinct a.compnr,a.itbp,a.salespersonName,b.Contact,b.email from acr_debtors_US a
left outer join vw_Business_Partner_US b
on((a.compnr = 2000 AND b.compnr = 2000) OR (a.compnr IN (1100,1700) AND b.compnr = 1100) OR
(a.compnr like '3%' AND b.compnr = '3100'))
and ltrim(rtrim(a.itbp))=ltrim(rtrim(b.custcode))
)a
where acr_debtors_US.compnr=a.compnr
and ltrim(rtrim(acr_debtors_US.itbp))=ltrim(rtrim(a.itbp))
--and acr_debtors_US.Email is null
--and orderType<>'service.order'

update acr_debtors_US set orno=a.orno
from (select distinct compnr,ttyp,ninv,orno from LN_TFACR200)a
where acr_debtors_US.compnr=a.compnr
and acr_debtors_US.ttyp=a.ttyp
and acr_debtors_US.ninv=a.ninv


delete from acr_debtors_US where OutstandingAmth =0

--Alter Table acr_debtors_US add CustomerOrderNo varchar(255)
--Alter Table acr_debtors_US add PayTYP_desc	varchar(50)
--Alter Table acr_debtors_US add BP_Status	varchar(50)

update acr_debtors_US set CPAY=a.cpay
from (select distinct concat(compnr,ttyp,ninv) as inv,cpay from LN_TFACR200 where len(cpay)>1) a
where concat(compnr,ttyp,ninv)=a.inv

update acr_debtors_US set PayTYP_desc=a.DSCA
from (select distinct CPAY,DSCA from LN_TCMCS013) a
where acr_debtors_US.CPAY=a.CPAY

update acr_debtors_US set BP_Status=a.status
from (select * from vw_Business_Partner_US)a
where ((acr_debtors_US.compnr = 2000 AND a.compnr = '2000') OR 
(acr_debtors_US.compnr IN (1100,1700) AND a.compnr = 1100) OR
(acr_debtors_US.compnr like '3%' AND a.compnr = '3100'))
and ltrim(rtrim(acr_debtors_US.itbp))=ltrim(rtrim(a.custcode))


update acr_debtors_US set CustomerOrderNo = a.refr

from (select * from ln_tfacr200 ) a 
where a.compnr=acr_debtors_us.compnr and a.NINV= trim(acr_debtors_us.ninv) 
and trim(a.itbp)=trim(acr_debtors_US.itbp)


end

select * from acr_debtors_US
where compnr like '3%'
--where ordertype is not null --='service.order'
----where concat(compnr,ttyp,ninv)='3110OAR24000012'

--select a.compnr,[tran],idoc,srtp_kw,count(distinct a.orno) from LN_CISLI310 a
--left outer join LN_TDSLS400 c
--on a.orno=c.orno
--where a.compnr like '3%'
--group by a.compnr,[tran],idoc,srtp_kw
--having count(distinct a.orno)>2


--select a.compnr,[tran],idoc,srtp_kw, c.orno
--from LN_CISLI310 a
--left outer join LN_TDSLS400 c
--on a.orno=c.orno
--where concat(a.compnr,[tran],idoc)='3110S0124004310'
----group by a.compnr,[tran],idoc,srtp_kw
----having count(distinct a.orno)>2

--select * from LN_TFACR200
--where concat(compnr,ttyp,ninv)='3110S0124004310'

GO

