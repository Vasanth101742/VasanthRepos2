--Exec sp_acp_creditors_US '2025-11-18'

CREATE proc sp_acp_creditors_US (@AS_OF_DATE date) as

begin


--declare @AS_OF_DATE date='2024-03-20'
Declare @Finyear varchar(10)=case when month(@AS_OF_DATE)<4 then year(@AS_OF_DATE)-1 else year(@AS_OF_DATE) end
declare @Finmonth varchar(10) =case when month(@AS_OF_DATE)<4 then month(@AS_OF_DATE)+9 else month(@AS_OF_DATE)-3 end
set  @Finmonth=RIGHT('00'+CAST(@Finmonth AS VARCHAR(2)),2)


Truncate table acp_creditors_US

--select * into acp_creditors_US from(
--Select compnr,ttyp,ninv,line,itbp as ifbp,ccur,rate_1,docd,
--prod,year,InvAmth,PaidAmth,OutstandingAmth,BPName,ID,
--refnumber,paymentstatus,payment_date,dued,Ageing,AgeingOrder,DueType from acr_debtors_US)a

--sp_rename 'acp_creditors_US.AgeingOrder','AgeingOrdr'
--sp_rename 'acp_creditors_US.year','FinYear'


--Alter table acp_creditors_US add ORNO nvarchar(25)
--Alter table acp_creditors_US add REFR nvarchar(100)


insert into acp_creditors_US(COMPANY,TranType,InvNo,line,SuppCode,Currency,rate_1,DocDt,
DueDate,FinMonth,FinYear,InvAmnt,PaidAmnt,BalanceAmt,ORNO,REFR)
--select * into acr_debtors from (
select a.compnr,a.ttyp,a.ninv,a.line,a.ifbp,a.ccur,a.rate_1,a.docd,
case when a.dued='0001-01-01' then null else a.dued end as dued,a.prod,a.year,
avg(InvAmth) InvAmth,
sum(PaidAmth) PaidAmth,
convert(decimal(19,2),isnull(avg(InvAmth),0)+isnull(sum(PaidAmth),0)) as OutstandingAmth,
orno,refr
from
(select  compnr,ttyp,ninv,line,ifbp,ccur,rate_1,docd,dued,
prod,year,
sum(convert(float,amth_1)) InvAmth,
--sum(amti) InvAmti
orno,refr
from [dbo].[ln_tfacp200]
where docn=0
group by compnr,ttyp,ninv,line,ifbp,ccur,rate_1,docd,dued,
prod,year,orno,refr
)a
left outer join
(select  compnr,ttyp,ninv,line,ifbp,ccur,rate_1,docd,
prod,year,
sum(isnull(convert(float,amth_1),0)+isnull(convert(float,padh_1),0)+
isnull(convert(float,dc1h_1),0)+isnull(convert(float,cdam_1),0)) as PaidAmth
from [dbo].[ln_tfacp200]
where docn<>0
group by compnr,ttyp,ninv,line,ifbp,ccur,rate_1,docd,
prod,year
)b
on a.compnr=b.compnr
and a.ttyp=b.ttyp
and a.ninv=b.ninv
--and a.line=b.line
and a.ifbp=b.ifbp
--where  concat(a.compnr,a.ttyp,a.ninv)='3110HSI24000373'
group by a.compnr,a.ttyp,a.ninv,a.line,a.ifbp,a.ccur,a.rate_1,a.docd,
a.dued,a.prod,a.year,a.orno,a.refr
--)a

update acp_creditors_US set SuppName=a.Nama
from (select distinct bpid,Nama from ln_tccom100)a
where ltrim(rtrim(acp_creditors_US.SuppCode))=ltrim(rtrim(a.bpid))

update acp_creditors_US set Duetype=a.DueType,payment_date=a.docd
from
(select a.COMPANY,a.TranType,a.InvNo,a.SuppCode,a.DueDate,b.docd,
case when a.DueDate is null then null
when datediff(dd,a.DueDate,b.docd) >0 then 'OverDue'
else 'WithinDue' end as DueType
from acp_creditors_US a
left outer join(
select  compnr,ttyp,ninv,--line,
ifbp,max(docd) docd
from [dbo].[ln_tfacp200]
where docn<>0
group by compnr,ttyp,ninv,--line,
ifbp)b
on a.COMPANY=b.compnr
and a.TranType=b.ttyp
and a.InvNo=b.ninv
and a.SuppCode=b.ifbp
)a
where acp_creditors_US.COMPANY=a.COMPANY
and acp_creditors_US.TranType=a.TranType
and acp_creditors_US.InvNo=a.InvNo
and acp_creditors_US.SuppCode=a.SuppCode

update acp_creditors_US set paymentstatus='Closed' where PaidAmnt is not null and BalanceAmt between -1 and 1
update acp_creditors_US set paymentstatus='Pending' where paymentstatus is null
--where PaidAmth is not null and OutstandingAmth not between -1 and 1

--Alter table acp_creditors_US add SuppInvNo varchar(100)

update acp_creditors_US set SuppInvNo=a.ISUP--,SuppInvDate=a.SIDT$L
from (
select compnr,TTYP,NINV,IFBP,ISUP--,SIDT$L 
from LN_TFACP200 where len(isup)>2)a
where acp_creditors_US.COMPANY=a.compnr
and ltrim(rtrim(acp_creditors_US.TranType))=ltrim(rtrim(a.TTYP))
and ltrim(rtrim(acp_creditors_US.InvNo))=ltrim(rtrim(a.NINV))
and ltrim(rtrim(acp_creditors_US.SuppCode))=ltrim(rtrim(a.IFBP))


--update acp_creditors_US set PaidStatus=a.PaidStatus,DueStatus=a.DueStatus
--from (select * from acp_status)a
--where acp_creditors_US.compnr=a.Company
--and acp_creditors_US.ttyp=a.TranType
--and acp_creditors_US.ninv=a.InvNo
--and acp_creditors_US.ifbp=a.SuppCode

--Alter table acp_creditors_US add CalYear int
--Alter table acp_creditors_US add CalMonth int

update acp_creditors_US set CalMonth=FinMonth+3 where FinMonth<=9
update acp_creditors_US set CalMonth=FinMonth-9 where FinMonth>9

update acp_creditors_US set CalYear=FinYear where FinMonth<=9
update acp_creditors_US set CalYear=FinYear+1 where FinMonth>9



update acp_creditors_US set Ageing='Lessthan30' where datediff(dd,DueDate,getdate()-1)<=30
update acp_creditors_US set Ageing='31-60' where datediff(dd,DueDate,getdate()-1) between 31 and 60
update acp_creditors_US set Ageing='61-90' where datediff(dd,DueDate,getdate()-1) between 61 and 90
update acp_creditors_US set Ageing='91-120' where datediff(dd,DueDate,getdate()-1) between 91 and 120
update acp_creditors_US set Ageing='121-150' where datediff(dd,DueDate,getdate()-1) between 121 and 150
update acp_creditors_US set Ageing='151-180' where datediff(dd,DueDate,getdate()-1) between 151 and 180
update acp_creditors_US set Ageing='181-366' where datediff(dd,DueDate,getdate()-1) between 181 and 366
update acp_creditors_US set Ageing='Greater than 1Yr' where datediff(dd,DueDate,getdate()-1) between 367 and 732
update acp_creditors_US set Ageing='Greater than 2Yrs' where datediff(dd,DueDate,getdate()-1) between 733 and 1098
update acp_creditors_US set Ageing='Greater than 3Yrs' where datediff(dd,DueDate,getdate()-1) >1098

update acp_creditors_US set AgeingOrdr=1 where Ageing='Lessthan30'
update acp_creditors_US set AgeingOrdr=2 where Ageing='31-60'
update acp_creditors_US set AgeingOrdr=3 where Ageing='61-90'
update acp_creditors_US set AgeingOrdr=4 where Ageing='91-120'
update acp_creditors_US set AgeingOrdr=5 where Ageing='121-150'
update acp_creditors_US set AgeingOrdr=6 where Ageing='151-180'
update acp_creditors_US set AgeingOrdr=7 where Ageing='181-366'
update acp_creditors_US set AgeingOrdr=8 where Ageing='Greater than 1Yr'
update acp_creditors_US set AgeingOrdr=9 where Ageing='Greater than 2Yrs'
update acp_creditors_US set AgeingOrdr=10 where Ageing='Greater than 3Yrs'

end


Select * from acp_creditors_US
where DocDt<='2025-11-17'
order by DocDt
--where concat(compnr,ttyp,ninv)= '1100F1023003876'
--'3130APE24000550'
--where paidamth is not null

--Alter table acp_creditors_US alter column docd date
--Alter table acp_creditors_US alter column dued date


--select * from ln_tfacp200
--where concat(compnr,ttyp,ninv)= '3130APE24000550'

GO

