
--exec sp_acr_debtors_US_ver2
CREATE proc [sp_acr_debtors_US_ver2] as 

begin

Truncate table acr_debtors_US_ver2

insert into acr_debtors_US_ver2(compnr,ttyp,ninv,itbp,trec,trec_kw,line,tdoc,docn,
ccur,rate_1,docd,dued,year,prod,InvAmth,OutstandingAmth)
select compnr,ttyp,ninv,itbp,trec,trec_kw,
line,tdoc,docn,
ccur,rate_1,docd,
case when dued='0001-01-01' then null 
else dued end as dued,
year,prod,
convert(decimal(19,2),amth_1) as InvAmth,
convert(decimal(19,2),amth_1) as OutstandingAmth
from [ln_tfacr200]
where docn=0


insert into acr_debtors_US_ver2(compnr,ttyp,ninv,itbp,trec,trec_kw,line,tdoc,docn,
ccur,rate_1,docd,dued,year,prod,PaidAmth,OutstandingAmth)
select compnr,ttyp,ninv,itbp,trec,trec_kw,line,tdoc,docn,
ccur,rate_1,docd,
case when dued='0001-01-01' then null 
else dued end as dued,
year,prod,
isnull(convert(decimal(19,2),amth_1),0)+isnull(convert(float,padh_1),0)+
isnull(convert(float,dc1h_1),0)+isnull(convert(float,cdam_1),0) as PaidAmth,
isnull(convert(decimal(19,2),amth_1),0)+isnull(convert(float,padh_1),0)+
isnull(convert(float,dc1h_1),0)+isnull(convert(float,cdam_1),0) as OutstandingAmth
from [ln_tfacr200]
where docn<>0
and concat(compnr,ttyp,ninv,itbp) in (select concat(compnr,ttyp,ninv,itbp) from acr_debtors_US_ver2 where docn=0)

update acr_debtors_US_ver2 set dued=a.dued
from (select compnr,ttyp,ninv,itbp,dued from LN_TFACR200 
where dued is not null
and dued<>'0001-01-01'
)a
where acr_debtors_US_ver2.compnr=a.compnr
and acr_debtors_US_ver2.ttyp=a.ttyp
and acr_debtors_US_ver2.ninv=a.ninv
and acr_debtors_US_ver2.itbp=a.itbp


--select * from acr_debtors_US_ver2
--where compnr like '3%'
--order by compnr,ttyp,ninv


update acr_debtors_US_ver2 set year='2023' where docd<'2023-04-01'
update acr_debtors_US_ver2 set prod='1' where docd<'2023-04-01'
update acr_debtors_US_ver2 set docd='2023-04-01' where docd<'2023-04-01'
update acr_debtors_US_ver2 set dued='2023-04-01' where dued<'2023-04-01'


update acr_debtors_US_ver2 set trec_kw=replace(trec_kw,'tfacr.trec.','')

update acr_debtors_US_ver2 set CompName=a.CompName,SubCompName=a.SubCompName
from (select * from vw_ELGi_offshore_Companies)a
where acr_debtors_US_ver2.compnr=a.Company


update acr_debtors_US_ver2 set BPName=a.Nama
from (select distinct bpid,Nama from ln_tccom100)a
where ltrim(rtrim(acr_debtors_US_ver2.itbp))=ltrim(rtrim(a.bpid))


update acr_debtors_US_ver2 set BPType=a.BPType
from BPType_Master a
where ltrim(rtrim(acr_debtors_US_ver2.itbp))=ltrim(rtrim(a.BPCode))
and acr_debtors_US_ver2.compnr in (select company from vw_ELGi_offshore_Companies where CompName='ELGi-USA')

update acr_debtors_US_ver2 set BPType='Direct'
where acr_debtors_US_ver2.compnr in (select company from vw_ELGi_offshore_Companies where CompName='ELGi-USA')
and BPType is null

update acr_debtors_US_ver2 set BPCategory=a.BPCategory
from (select * from BP_Category_Master)a
where acr_debtors_US_ver2.compnr=a.Company
and acr_debtors_US_ver2.itbp=a.BPCode

update acr_debtors_US_ver2 set OrderType=a.srtp_kw,AreaName=a.AreaName,SalesPersonCode=crep,SalesPersonName=nama
from(select distinct a.compnr,[tran],idoc,srtp_kw,a.orno,b.AreaName,c.crep,d.nama from LN_CISLI310 a
left outer join vw_US_AreaList b
on substring(a.orno,1,1)=b.id
left outer join LN_TDSLS400 c
on a.orno=c.orno
left outer join LN_TCCOM001 d
on c.crep=d.emno
--where concat(compnr,[tran],idoc)='3110S0124002433'
)a
where acr_debtors_US_ver2.compnr=a.compnr
and acr_debtors_US_ver2.ttyp=a.[tran]
and acr_debtors_US_ver2.ninv=a.idoc


--Alter table acr_debtors_US_ver2 add SalesPersonCode varchar(50)
--Alter table acr_debtors_US_ver2 add SalesPersonName varchar(50)

update acr_debtors_US_ver2 set OrderType=replace(OrderType,'tcsli.srtp.','')

--select * from
--(select compnr,[tran],idoc,count(distinct srtp_kw) srtp_kw from LN_CISLI310
--where compnr like '3%'
--group by compnr,[tran],idoc
--having count(distinct srtp_kw)>1
--)a
--order by srtp_kw desc

--select * from LN_CISLI310 where concat(compnr,[tran],idoc)='3140S2024010817'


update acr_debtors_US_ver2 set Duetype=a.DueType,Last_Payment_Date=a.docd
from
(select a.compnr,a.ttyp,a.ninv,a.itbp,a.dued,b.docd,
case when a.dued is null then null
--when datediff(dd,a.dued,b.docd) >0 then 'OverDue' --Method1
when datediff(dd,a.dued,getdate()-1) >0 then 'OverDue'
else 'WithinDue' end as DueType
from acr_debtors_US_ver2 a
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
where acr_debtors_US_ver2.compnr=a.compnr
and acr_debtors_US_ver2.ttyp=a.ttyp
and acr_debtors_US_ver2.ninv=a.ninv
and acr_debtors_US_ver2.itbp=a.itbp

update acr_debtors_US_ver2 set DueYear_Fin=year(dued)-1 where month(dued)<4
update acr_debtors_US_ver2 set DueYear_Fin=year(dued) where month(dued)>=4

update acr_debtors_US_ver2 set DueMonth=concat(convert(varchar,year(dued)),RIGHT('00'+CAST(month(dued) AS VARCHAR(2)),2))
update acr_debtors_US_ver2 set DueMonthName=substring(datename(mm,dateadd(mm,month(dued),-1)),1,3)+'-'+substring(convert(varchar,year(dued)),3,2)

--Alter table acr_debtors_US_ver2 add CalYear int
--Alter table acr_debtors_US_ver2 add CalMonth int
--Alter table acr_debtors_US_ver2 add InvPeriod int


update acr_debtors_US_ver2 set CalMonth=prod+3 where prod<=9
update acr_debtors_US_ver2 set CalMonth=prod-9 where prod>9

update acr_debtors_US_ver2 set CalYear=Year where prod<=9
update acr_debtors_US_ver2 set CalYear=Year+1 where prod>9

--update acr_debtors_US_ver2 set InvPeriod=concat(convert(varchar,CalYear),RIGHT('00'+CAST(CalMonth AS VARCHAR(2)),2))
update acr_debtors_US_ver2 set InvPeriod=concat(convert(varchar,[Year]),RIGHT('00'+CAST(prod AS VARCHAR(2)),2))

--update acr_debtors_US_ver2 set InvMonthName=substring(datename(mm,dateadd(mm,month(docd),-1)),1,3)+'-'+substring(convert(varchar,year(docd)),3,2)
update acr_debtors_US_ver2 set InvMonthName=substring(datename(mm,dateadd(mm,CalMonth,-1)),1,3)+'-'+substring(convert(varchar,CalYear),3,2)

--Alter Table acr_debtors_US_ver2 add MonthBeginDate date
--Alter Table acr_debtors_US_ver2 add MonthEndDate date


Update acr_debtors_US_ver2 set MonthBeginDate=convert(date,concat(convert(varchar,CalYear),'-',RIGHT('00'+CAST(calmonth AS VARCHAR(2)),2),'-01'))
Update acr_debtors_US_ver2 set MonthEndDate=eomonth(convert(date,concat(convert(varchar,CalYear),'-',RIGHT('00'+CAST(calmonth AS VARCHAR(2)),2),'-01')))


--Update acr_debtors_US_ver2 set MonthBeginDate=dateadd(dd,1,eomonth(dued,-1))
Update acr_debtors_US_ver2 set MonthEndDate2=eomonth(dued)



update acr_debtors_US_ver2 set paymentstatus=a.PaymentStatus
from (select *,case when OutstandingAmth between -1 and 1 then 'Closed'
else 'Pending' end as PaymentStatus
from (select compnr,ttyp,ninv,itbp,sum(OutstandingAmth) OutstandingAmth 
from acr_debtors_US_ver2
group by compnr,ttyp,ninv,itbp)a1
)a
where acr_debtors_US_ver2.compnr=a.compnr
and acr_debtors_US_ver2.ttyp=a.ttyp
and acr_debtors_US_ver2.ninv=a.ninv
and acr_debtors_US_ver2.itbp=a.itbp


update acr_debtors_US_ver2 set Ageing='Advances' where dued is null
update acr_debtors_US_ver2 set Ageing='NotDue' where datediff(dd,dued,getdate()-1)<0
update acr_debtors_US_ver2 set Ageing='Lessthan30' where datediff(dd,dued,getdate()-1) between 0 and 30
update acr_debtors_US_ver2 set Ageing='31-60' where datediff(dd,dued,getdate()-1) between 31 and 60
update acr_debtors_US_ver2 set Ageing='61-90' where datediff(dd,dued,getdate()-1) between 61 and 90
update acr_debtors_US_ver2 set Ageing='91-120' where datediff(dd,dued,getdate()-1) between 91 and 120
--update acr_debtors_US_ver2 set Ageing='121-150' where datediff(dd,dued,getdate()-1) between 121 and 150
--update acr_debtors_US_ver2 set Ageing='151-180' where datediff(dd,dued,getdate()-1) between 151 and 180
update acr_debtors_US_ver2 set Ageing='121-180' where datediff(dd,dued,getdate()-1) between 121 and 180
update acr_debtors_US_ver2 set Ageing='181-366' where datediff(dd,dued,getdate()-1) between 181 and 366
update acr_debtors_US_ver2 set Ageing='Greater than 1Yr' where datediff(dd,dued,getdate()-1) >= 367
--update acr_debtors_US_ver2 set Ageing='Greater than 2Yrs' where datediff(dd,dued,getdate()-1) between 733 and 1098
--update acr_debtors_US_ver2 set Ageing='Greater than 3Yrs' where datediff(dd,dued,getdate()-1) >1098

update acr_debtors_US_ver2 set AgeingOrder=1 where Ageing='Advances'
update acr_debtors_US_ver2 set AgeingOrder=2 where Ageing='NotDue'
update acr_debtors_US_ver2 set AgeingOrder=3 where Ageing='Lessthan30'
update acr_debtors_US_ver2 set AgeingOrder=4 where Ageing='31-60'
update acr_debtors_US_ver2 set AgeingOrder=5 where Ageing='61-90'
update acr_debtors_US_ver2 set AgeingOrder=6 where Ageing='91-120'
update acr_debtors_US_ver2 set AgeingOrder=7 where Ageing='121-180'
--update acr_debtors_US_ver2 set AgeingOrder=8 where Ageing='151-180'
update acr_debtors_US_ver2 set AgeingOrder=9 where Ageing='181-366'
update acr_debtors_US_ver2 set AgeingOrder=10 where Ageing='Greater than 1Yr'
--update acr_debtors_US_ver2 set AgeingOrder=11 where Ageing='Greater than 2Yrs'
--update acr_debtors_US_ver2 set AgeingOrder=12 where Ageing='Greater than 3Yrs'

--Alter table acr_debtors_US_ver2 add LastUpdated Datetime

update acr_debtors_US_ver2 set LastUpdated=dateadd(hour,-5,getdate())
update acr_debtors_US_ver2 set LastUpdated=dateadd(minute,-30,LastUpdated)

--Alter table acr_debtors_US_ver2 add Email varchar(50)

update acr_debtors_US_ver2 set SalesPersonName=a.EmpName,Email=a.Email
from (select * from ELGI_US_Area_Access)a
where acr_debtors_US_ver2.AreaName=a.AreaName
and orderType='service.order'
and SalespersonName is null

update acr_debtors_US_ver2 set Email=a.Email
from (select distinct a.salespersonName,b.email from acr_debtors_US_ver2 a
left outer join [Elgi_Intranet].dbo.Employee_detail b
on a.salespersonName=b.emp_name)a
where acr_debtors_US_ver2.salespersonName=a.salespersonName
and orderType<>'service.order'

--delete from acr_debtors_US_ver2 where OutstandingAmth =0

end

--BPType Field to be validated
--BPCategory Field to be validated

--sp_rename 'acr_debtors_US_ver2.payment_date','Last_Payment_Date'

select * from acr_debtors_US_ver2
where compnr like '3%'
and concat(compnr,ttyp,ninv,itbp)='3110OAR24000957I00000006'
order by docn


select * from LN_TFACR200
where concat(compnr,ttyp,ninv,itbp)='3110HSI24000005C00005755'

GO

