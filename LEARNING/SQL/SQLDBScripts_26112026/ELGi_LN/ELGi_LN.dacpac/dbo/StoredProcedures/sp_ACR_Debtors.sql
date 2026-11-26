--exec sp_ACR_Debtors '2026-11-23'

CREATE proc [dbo].[sp_ACR_Debtors] (@AS_OF_DATE date) as 
Begin

--Declare @AS_OF_DATE date='2024-11-24'
Declare @Finyear varchar(10)=case when month(@AS_OF_DATE)<4 then year(@AS_OF_DATE)-1 else year(@AS_OF_DATE) end
declare @Finmonth varchar(10) =case when month(@AS_OF_DATE)<4 then month(@AS_OF_DATE)+9 else month(@AS_OF_DATE)-3 end
set  @Finmonth=RIGHT('00'+CAST(@Finmonth AS VARCHAR(2)),2) 
Declare @FinPeriod int=concat(@FinYear,@FinMonth)

Declare @CalYear varchar(10)=year(@AS_OF_DATE)
Declare @CalMonth varchar(10)=RIGHT('00'+CAST(month(@AS_OF_DATE) AS VARCHAR(2)),2)
Declare @CalPeriod int=concat(@CalYear,@CalMonth)

--Alter table ACR_Debtors_Details add Rate_USD float
----DeliveryDt date--AR_Plan float--Indent nvarchar(60) --SalesRepCode varchar(25),SalesRep varchar(50)
--Alter table ACR_Debtors_FOC add Rate_USD float 
----DeliveryDt date--AR_Plan float--Indent nvarchar(60)  --SalesRepCode varchar(25),SalesRep varchar(50)
--Alter table ACR_Debtors_Trial add Rate_USD float 
----DeliveryDt date--AR_Plan float--Indent nvarchar(60) --SalesRepCode varchar(25),SalesRep varchar(50)
--Alter table ACR_Debtors_BTA add Rate_USD float 
----DeliveryDt date--AR_Plan float--Indent nvarchar(60) --SalesRepCode varchar(25),SalesRep varchar(50)
--Alter table ACR_Debtors_complete add Rate_USD float 
----DeliveryDt date--AR_Plan float--Indent nvarchar(60) --SalesRepCode varchar(25),SalesRep varchar(50)
--Alter table acr_debtors_details_ID add Rate_USD float 
----DeliveryDt date--AR_Plan float--Indent nvarchar(60)  --SalesRepCode varchar(25),SalesRep varchar(50)
--Alter table acr_debtors_details_581 add Rate_USD float 
----DeliveryDt date--AR_Plan float--Indent nvarchar(60) --SalesRepCode varchar(25),SalesRep varchar(50)


--Alter table ACR_Debtors_FOC add DueSchedule int
--Alter table ACR_Debtors_FOC add DueAmnt float
--Alter table ACR_Debtors_FOC add DueAmnt_Received float
--Alter table ACR_Debtors_FOC add Due_ReceivedDate date

Truncate table ACR_Debtors_Details
Truncate table ACR_Debtors_FOC
Truncate table ACR_Debtors_Trial
Truncate table ACR_Debtors_BTA
Truncate table ACR_Debtors_complete
Truncate table acr_debtors_details_ID
Truncate table acr_debtors_details_581
Truncate table ACR_Original_Receipts
Truncate table ACR_Status

--Alter table ACR_Debtors_Details add DueStatus varchar(50)


--insert into ACR_Debtors_Details(Company,Trantyp,InvNo,AR_Plan,FinYear,FinMonth)
--select '581' as Company,TTYP,DCON,AMNT,FYER,FMON from TZZGLD304581

--Invoices without Due Schedules
Insert into ACR_Debtors_Details(Company,Trantyp,InvNo,Line,CustNo,CustName,FinCustGrp,VerticalOrdr,
Vertical1,Vertical,DPST,DpstName,AreaCode,AreaName,InvDate,DueDate,Currency,CurRate,InvAmt,PaidAmt,
BalanceAmt,InvAmti,PaidAmti,BalanceAmti,
--Ageing,Ageing_IAS,AgeingOrdr,
FinYear,FinMonth,--CalYear,CalMonth,AgeingOrdr_IAS,
Reference--,SalesCategory,SalesRepCode,SalesRep,CPAY,PayTYP_desc
)

--select * into ACR_Debtors_Details from(
SELECT a.Company,a.t_ttyp as Trantyp,a.t_ninv as InvNo,a.t_line as Line,
a.t_itbp as CustNo,null as CustName,null as FinCustGrp,
null as VerticalOrdr,null as Vertical1,null as Vertical ,
null as DPST,null as DpstName, null as AreaCode,null as AreaName,
a.t_docd as InvDate,a.DueDate,a.t_ccur as Currency,a.t_rate_1 as CurRate,
avg(a.InvAmt) as InvAmt,(sum(isnull(b.PaidAmt,0))) as PaidAmt,
null as BalanceAmt,
avg(a.InvAmti) as InvAmti,sum(isnull(b.PaidAmti,0)) as PaidAmti,
null as BalanceAmti,
--case when a.DueDate='9999-01-01 00:00:00.000' then 'NA'
--when a.DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,a.DueDate,@AS_OF_DATE) <30 then 'LessThan30' 
--when a.DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,a.DueDate,@AS_OF_DATE) between 30 and 60 then '30-60'
--when a.DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,a.DueDate,@AS_OF_DATE) between 61 and 90 then '61-90'
--when a.DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,a.DueDate,@AS_OF_DATE) between 91 and 120 then '91-120'
--when a.DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,a.DueDate,@AS_OF_DATE) between 121 and 150 then '121-150'
--when a.DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,a.DueDate,@AS_OF_DATE) between 151 and 180 then '151-180' 
----when a.DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,a.DueDate,getdate()-1) >180 then 'GreaterThan180' 
--when a.DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,a.DueDate,@AS_OF_DATE) between 181 and 366 then '181-366' 
--when a.DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,a.DueDate,@AS_OF_DATE) between 367 and 732 then 'Greater Than 1Yr' 
--when a.DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,a.DueDate,@AS_OF_DATE) between 733 and 1098 then 'Greater Than 2Yrs' 
--when a.DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,a.DueDate,@AS_OF_DATE) > 1098 then 'Greater Than 3Yrs' 
--end as Ageing,
--case when a.DueDate='9999-01-01 00:00:00.000' then 'NA'
--when a.DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,a.DueDate,@AS_OF_DATE) <15 then 'LessThan15' 
--when a.DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,a.DueDate,@AS_OF_DATE) between 15 and 30 then '15-30'
--when a.DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,a.DueDate,@AS_OF_DATE) between 30 and 45 then '30-45'
--when a.DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,a.DueDate,@AS_OF_DATE) between 45 and 60 then '45-60'
--when a.DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,a.DueDate,@AS_OF_DATE) between 60 and 90 then '60-90'
--when a.DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,a.DueDate,@AS_OF_DATE) >90 then 'GreaterThan90'  end as Ageing_IAS,
--null as AgeingOrdr,
a.t_year as FinYear,a.t_prod as FinMonth,
--null as CalYear,null as CalMonth,null as AgeingOrdr_IAS,
Reference--,null as SalesCategory,null as SalesRepCode,null as SalesRep,
--null as CPAY,null as DSCA


FROM 
(SELECT COMPANY,t_ttyp,t_ninv,t_line,t_itbp,t_ccur,t_rate_1,t_docd,
case when t_dued='9999-01-01 00:00:00.000' then t_docd
else t_dued end as DueDate,
t_prod,t_year,t_refr as Reference,
SUM(t_amth_1) InvAmt ,SUM(t_amti) InvAmti  
FROM TTFACR200ALL 
WHERE t_docn=0
and concat(convert(varchar,t_year),RIGHT('00'+CAST(t_prod AS VARCHAR(2)),2))<=CONCAT(@Finyear,@Finmonth) --Period Based
--and t_docd<=@AS_OF_DATE --Docdt based
--and company= 401 and t_ttyp ='C21' and t_ninv=	16000227
group by COMPANY,t_ttyp,t_ninv,t_line,t_itbp,t_ccur,t_rate_1,t_docd,t_dued,t_prod,t_year,t_refr
)A

LEFT OUTER JOIN

(SELECT COMPANY,t_ttyp,t_ninv,t_line,t_itbp,t_ccur,t_rate_1,t_docd,t_dued,t_prod,t_year,
SUM(t_amth_1+t_padh_1+t_dc1h_1+t_cdam_1) PaidAmt ,SUM(t_amti) PaidAmti FROM TTFACR200ALL 
WHERE t_docn<>0
and concat(convert(varchar,t_year),RIGHT('00'+CAST(t_prod AS VARCHAR(2)),2))<=CONCAT(@Finyear,@Finmonth) --Period Based
--and t_docd<=@AS_OF_DATE --Docdt based
--and company= 401 and t_ttyp ='C21' and t_ninv=	16000227
group by COMPANY,t_ttyp,t_ninv,t_line,t_itbp,t_ccur,t_rate_1,t_docd,t_dued,t_prod,t_year
)B
ON A.Company=B.Company
AND A.t_ttyp=B.t_ttyp
AND A.t_ninv=B.t_ninv
AND A.t_line=B.t_line
and a.t_itbp=b.t_itbp


group by a.Company,a.t_ttyp,a.t_ninv,a.t_line,a.t_itbp,a.t_docd,a.DueDate,
a.t_ccur,a.t_rate_1,a.t_year,a.t_prod,a.Reference
--)a



--Invoices with Due Schedules
Insert into ACR_Debtors_Details(Company,Trantyp,InvNo,Line,CustNo,CustName,FinCustGrp,VerticalOrdr,
Vertical1,Vertical,DPST,DpstName,AreaCode,AreaName,InvDate,DueDate,Currency,CurRate,InvAmt,PaidAmt,
BalanceAmt,InvAmti,PaidAmti,BalanceAmti,
--Ageing,Ageing_IAS,AgeingOrdr,
FinYear,FinMonth,
--CalYear,CalMonth,AgeingOrdr_IAS,
Reference,--SalesCategory,SalesRepCode,SalesRep,CPAY,PayTYP_desc,
DueSchedule,DueAmnt,DueAmnt_Received,Due_ReceivedDate
)

--Declare @AS_OF_DATE date='2026-11-17'
--select * into ACR_Debtors_Details from(
SELECT a.Company,a.t_ttyp as Trantyp,a.t_ninv as InvNo,a.t_line as Line,
a.t_itbp as CustNo,null as CustName,null as FinCustGrp,
null as VerticalOrdr,null as Vertical1,null as Vertical ,
null as DPST,null as DpstName, null as AreaCode,null as AreaName,
a.t_docd as InvDate,C.DOCD,a.t_ccur as Currency,a.t_rate_1 as CurRate,
avg(a.InvAmt) as InvAmt,
(sum(isnull(b.PaidAmt,0))) as PaidAmt,
null as BalanceAmt,
avg(a.InvAmti) as InvAmti,
sum(isnull(b.PaidAmti,0)) as PaidAmti,
null as BalanceAmti,
--case when C.DOCD='9999-01-01 00:00:00.000' then 'NA'
--when C.DOCD<>'9999-01-01 00:00:00.000' and  datediff(dd,C.DOCD,@AS_OF_DATE) <30 then 'LessThan30' 
--when C.DOCD<>'9999-01-01 00:00:00.000' and  datediff(dd,C.DOCD,@AS_OF_DATE) between 30 and 60 then '30-60'
--when C.DOCD<>'9999-01-01 00:00:00.000' and  datediff(dd,C.DOCD,@AS_OF_DATE) between 61 and 90 then '61-90'
--when C.DOCD<>'9999-01-01 00:00:00.000' and  datediff(dd,C.DOCD,@AS_OF_DATE) between 91 and 120 then '91-120'
--when C.DOCD<>'9999-01-01 00:00:00.000' and  datediff(dd,C.DOCD,@AS_OF_DATE) between 121 and 150 then '121-150'
--when C.DOCD<>'9999-01-01 00:00:00.000' and  datediff(dd,C.DOCD,@AS_OF_DATE) between 151 and 180 then '151-180' 
----when C.DOCD<>'9999-01-01 00:00:00.000' and  datediff(dd,C.DOCD,getdate()-1) >180 then 'GreaterThan180' 
--when C.DOCD<>'9999-01-01 00:00:00.000' and  datediff(dd,C.DOCD,@AS_OF_DATE) between 181 and 366 then '181-366' 
--when C.DOCD<>'9999-01-01 00:00:00.000' and  datediff(dd,C.DOCD,@AS_OF_DATE) between 367 and 732 then 'Greater Than 1Yr' 
--when C.DOCD<>'9999-01-01 00:00:00.000' and  datediff(dd,C.DOCD,@AS_OF_DATE) between 733 and 1098 then 'Greater Than 2Yrs' 
--when C.DOCD<>'9999-01-01 00:00:00.000' and  datediff(dd,C.DOCD,@AS_OF_DATE) > 1098 then 'Greater Than 3Yrs' 
--end as Ageing,
--case when C.DOCD='9999-01-01 00:00:00.000' then 'NA'
--when C.DOCD<>'9999-01-01 00:00:00.000' and  datediff(dd,C.DOCD,@AS_OF_DATE) <15 then 'LessThan15' 
--when C.DOCD<>'9999-01-01 00:00:00.000' and  datediff(dd,C.DOCD,@AS_OF_DATE) between 15 and 30 then '15-30'
--when C.DOCD<>'9999-01-01 00:00:00.000' and  datediff(dd,C.DOCD,@AS_OF_DATE) between 30 and 45 then '30-45'
--when C.DOCD<>'9999-01-01 00:00:00.000' and  datediff(dd,C.DOCD,@AS_OF_DATE) between 45 and 60 then '45-60'
--when C.DOCD<>'9999-01-01 00:00:00.000' and  datediff(dd,C.DOCD,@AS_OF_DATE) between 60 and 90 then '60-90'
--when C.DOCD<>'9999-01-01 00:00:00.000' and  datediff(dd,C.DOCD,@AS_OF_DATE) >90 then 'GreaterThan90'  end as Ageing_IAS,
--null as AgeingOrdr,
a.t_year as FinYear,a.t_prod as FinMonth,
--null as CalYear,null as CalMonth,null as AgeingOrdr_IAS,
Reference,
--null as SalesCategory,null as SalesRepCode,null as SalesRep,
--null as CPAY,null as DSCA,
C.SCHN,C.AMNT,C.RECA,c.RECD


FROM 
(SELECT COMPANY,t_ttyp,t_ninv,t_line,t_itbp,t_ccur,t_rate_1,t_docd,
case when t_dued='9999-01-01 00:00:00.000' then t_docd
else t_dued end as DueDate,
t_prod,t_year,t_refr as Reference,
SUM(t_amth_1) InvAmt ,SUM(t_amti) InvAmti  
FROM TTFACR200ALL 
WHERE t_docn=0
--and concat(convert(varchar,t_year),RIGHT('00'+CAST(t_prod AS VARCHAR(2)),2))<=CONCAT(@Finyear,@Finmonth) --Period Based
--and t_docd<=@AS_OF_DATE --Docdt based
--and company= 401 and t_ttyp ='C21' and t_ninv=	16000227
group by COMPANY,t_ttyp,t_ninv,t_line,t_itbp,t_ccur,t_rate_1,t_docd,t_dued,t_prod,t_year,t_refr
)A


LEFT OUTER JOIN

(SELECT COMPANY,t_ttyp,t_ninv,t_line,t_itbp,t_ccur,t_rate_1,t_docd,t_dued,t_prod,t_year,
SUM(t_amth_1+t_padh_1+t_dc1h_1+t_cdam_1) PaidAmt ,SUM(t_amti) PaidAmti FROM TTFACR200ALL 
WHERE t_docn<>0
--and concat(convert(varchar,t_year),RIGHT('00'+CAST(t_prod AS VARCHAR(2)),2))<=CONCAT(@Finyear,@Finmonth) --Period Based
----and t_docd<=@AS_OF_DATE --Docdt based
----and company= 401 and t_ttyp ='C21' and t_ninv=	16000227
group by COMPANY,t_ttyp,t_ninv,t_line,t_itbp,t_ccur,t_rate_1,t_docd,t_dued,t_prod,t_year
)B
ON A.Company=B.Company
AND A.t_ttyp=B.t_ttyp
AND A.t_ninv=B.t_ninv
AND A.t_line=B.t_line
and a.t_itbp=b.t_itbp


INNER JOIN

(
select * from (
select company,TTYP,NINV,ITBP,SCHN,DOCD,RECD,
case when month(RECD)<4 then year(RECD)-1 else year(RECD) end as Finyear,
case when month(RECD)<4 then month(RECD)+9 else month(RECD)-3 end as Finmonth,
sum(AMNT) AMNT,
sum(RECA) RECA 
from TTFACR201ALL
group by company,TTYP,NINV,ITBP,SCHN,DOCD,RECD
)a
--where concat(convert(varchar,Finyear),RIGHT('00'+CAST(Finmonth AS VARCHAR(2)),2))<=CONCAT(@Finyear,@Finmonth)
)C
ON A.Company=C.Company
AND A.t_ttyp=C.TTYP
AND A.t_ninv=C.NINV
and a.t_itbp=C.ITBP
group by a.Company,a.t_ttyp,a.t_ninv,a.t_line,a.t_itbp,a.t_docd,C.DOCD,
a.t_ccur,a.t_rate_1,a.t_year,a.t_prod,a.Reference,
C.SCHN,C.AMNT,C.RECA,c.RECD
--)a



delete from ACR_Debtors_Details where concat(company,Trantyp,InvNo) in 
(select distinct concat(company,ttyp,ninv) from TTFACR201ALL)
and DueSchedule is null


update ACR_Debtors_Details set 
DueDate=Due_ReceivedDate
where DueSchedule is not null

delete from ACR_Debtors_Details where InvAmti=PaidAmti and currency not in ('IND','INR') and ar_plan is null


update ACR_Debtors_Details set BalanceAmt= invamt+paidamt
update ACR_Debtors_Details set BalanceAmt= invamt where paidamt=0 or paidamt is null

update ACR_Debtors_Details set BalanceAmti= invamti+paidamti
update ACR_Debtors_Details set BalanceAmti= invamti where paidamti=0 or paidamti is null



--Method 1:
--update ACR_Debtors_Details set 
--InvAmt=null,InvAmti=null,
--PaidAmt=null,PaidAmti=null,
--BalanceAmt=null,BalanceAmti=null
--where DueSchedule is not null
--and DueSchedule>1


--Method 2:
update  ACR_Debtors_Details set DueRnk=a.DueRnk
from(select company,trantyp,invno,DueSchedule,
ROW_NUMBER() over(partition by company,trantyp,invno order by DueSchedule) as DueRnk 
from ACR_Debtors_Details
where DueSchedule is not null
and DueSchedule>=1
and isnull(DueAmnt,0) - isnull(DueAmnt_Received,0) not between -1 and 1
--and concat(company,trantyp,invno) ='40121136010523'
)a
where concat(ACR_Debtors_Details.company,
ACR_Debtors_Details.trantyp,ACR_Debtors_Details.invno,
ACR_Debtors_Details.DueSchedule)
=concat(a.company,a.trantyp,a.invno,a.DueSchedule)
and ACR_Debtors_Details.DueSchedule is not null

update ACR_Debtors_Details set 
InvAmt=null,InvAmti=null,
PaidAmt=null,PaidAmti=null,
BalanceAmt=null,BalanceAmti=null
where DueSchedule is not null 
and isnull(DueRnk,0)<>1


update ACR_Debtors_Details set BalanceAmt=DueAmnt - DueAmnt_Received
where DueSchedule is not null


--update ACR_Debtors_Details set Ageing='NA' where DueDate='9999-01-01 00:00:00.000'
--update ACR_Debtors_Details set Ageing='Not Due'
--where DueDate<>'9999-01-01 00:00:00.000' and datediff(dd,DueDate,@AS_OF_DATE)<0
--update ACR_Debtors_Details set Ageing='LessThan30'
--where DueDate<>'9999-01-01 00:00:00.000' and datediff(dd,DueDate,@AS_OF_DATE) between 0 and 29 

update ACR_Debtors_Details set Ageing='LessThan30'
where DueDate<>'9999-01-01 00:00:00.000' and datediff(dd,DueDate,@AS_OF_DATE) <30
update ACR_Debtors_Details set Ageing='30-60'
where DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,DueDate,@AS_OF_DATE) between 30 and 60 
update ACR_Debtors_Details set Ageing='61-90'
where DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,DueDate,@AS_OF_DATE) between 61 and 90
update ACR_Debtors_Details set Ageing='91-120'
where DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,DueDate,@AS_OF_DATE) between 91 and 120
update ACR_Debtors_Details set Ageing='121-150'
where DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,DueDate,@AS_OF_DATE) between 121 and 150
update ACR_Debtors_Details set Ageing='151-180'
where DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,DueDate,@AS_OF_DATE) between 151 and 180
update ACR_Debtors_Details set Ageing='181-366'
where DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,DueDate,@AS_OF_DATE) between 181 and 366
update ACR_Debtors_Details set Ageing='Greater Than 1Yr'
where DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,DueDate,@AS_OF_DATE) between 367 and 732
update ACR_Debtors_Details set Ageing='Greater Than 2Yrs'
where DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,DueDate,@AS_OF_DATE) between 733 and 1098
update ACR_Debtors_Details set Ageing='Greater Than 3Yrs'
where DueDate<>'9999-01-01 00:00:00.000' and  datediff(dd,DueDate,@AS_OF_DATE) > 1098




insert into ACR_Original_Receipts
--select * into ACR_Original_Receipts from (
select t_cono,t_ttyp,t_docn,COMPANY,T$OTYP,T$ODOC,T$BPID,T$AMTH$1  from 
(select t_cono,t_ttyp,t_docn,t_comt,t_typt,t_doct 
from TTFGLD112ALL)a
inner join
(select distinct company,T$OTYP,T$ODOC,T$BPID,T$AMTH$1 from TTFGLD106ALL)b
on a.t_comt=b.COMPANY
and a.t_typt=b.T$OTYP
and a.t_doct=b.T$ODOC
--)a





Insert into ACR_Status
--select * into ACR_Status from (
select * ,
case 
when LatestPaidDate is not null and isnull(InvAmth,0)+isnull(RecvAmth,0) between -1 and 1 then 'FullyReceived'
when LatestPaidDate is not null and isnull(InvAmth,0)+isnull(RecvAmth,0) not between -1 and 1 then 'PartialReceived'
when LatestPaidDate is null then 'NotYetReceived'
end as ReceivedStatus,
case when LatestPaidDate is not null and LatestPaidDate<DueDate then 'WithinDue'
when LatestPaidDate is null and DueDate>getdate()-1 then 'WithinDue'
else 'OverDue' end as DueStatus
from (
select Company,TranType,InvNo,
min(case when invamth<>0 then EntryDate else null end) as InvDate,
sum(InvAmth) InvAmth,
min(case when Dueamth<>0 then EntryDate else null end) as DueDate,
sum(DueAmth) DueAmth,
sum(RecvAmth) RecvAmth,
max(case when recvamth<>0 then EntryDate else null end) as LatestPaidDate,
sum(InvBalh) InvBalh,
sum(DueBalh) DueBalh
from ACR_As_of_Date_Details
--where --InvAmth<>0 and 
--Company=401	and TranType='211' and InvNo=17012611 	
group by  Company,TranType,InvNo
)a
--)b


delete from ACR_Status where InvAmth is null and DueAmth is null and RecvAmth is not null

update ACR_Debtors_Details set DueStatus=a.DueStatus
from ACR_Status a
where ACR_Debtors_Details.Company=a.company
and ACR_Debtors_Details.TranTyp=a.TranType
and ACR_Debtors_Details.InvNo=a.InvNo







-----Updating DPST Data for Old Invoices(BAAN Invoices) for which DPST is Missing-----

update ACR_Debtors_Details set DPST=a.[DPST NRM]
from (select * from MissingDPST_for_AR where DPST<>[DPST NRM])a
where ACR_Debtors_Details.company=a.Company
and ACR_Debtors_Details.Trantyp=a.Trantyp
and ACR_Debtors_Details.InvNo=a.[Inv No]

update ACR_Debtors_Details set DPST=a.[DPST NRM]
from (select * from MissingDPST_for_AR where DPST is null)a
where ACR_Debtors_Details.company=a.Company
and ACR_Debtors_Details.Trantyp=a.Trantyp
and ACR_Debtors_Details.InvNo=a.[Inv No]

-----End : Updating DPST Data for Old Invoices(BAAN Invoices) for which DPST is Missing-----

update ACR_Debtors_Details set AgeingOrdr=1 where Ageing= 'Not Due' 
update ACR_Debtors_Details set AgeingOrdr=2 where Ageing= 'LessThan30' 
update ACR_Debtors_Details set AgeingOrdr=3 where Ageing= '30-60'
update ACR_Debtors_Details set AgeingOrdr=4 where Ageing= '61-90'
update ACR_Debtors_Details set AgeingOrdr=5 where Ageing= '91-120'
update ACR_Debtors_Details set AgeingOrdr=6 where Ageing= '121-150'
update ACR_Debtors_Details set AgeingOrdr=7 where Ageing= '151-180' 
update ACR_Debtors_Details set AgeingOrdr=8 where Ageing= '181-366' 
update ACR_Debtors_Details set AgeingOrdr=9 where Ageing= 'Greater Than 1Yr' 
update ACR_Debtors_Details set AgeingOrdr=10 where Ageing= 'Greater Than 2Yrs' 
update ACR_Debtors_Details set AgeingOrdr=11 where Ageing= 'Greater Than 3Yrs' 
update ACR_Debtors_Details set AgeingOrdr=12 where Ageing='NA'


--update ACR_Debtors_Details set AgeingOrdr_IAS=1 where Ageing_IAS= 'LessThan15' 
--update ACR_Debtors_Details set AgeingOrdr_IAS=2 where Ageing_IAS= '15-30'
--update ACR_Debtors_Details set AgeingOrdr_IAS=3 where Ageing_IAS= '30-45'
--update ACR_Debtors_Details set AgeingOrdr_IAS=4 where Ageing_IAS= '45-60'
--update ACR_Debtors_Details set AgeingOrdr_IAS=5 where Ageing_IAS= '60-90'
--update ACR_Debtors_Details set AgeingOrdr_IAS=6 where Ageing_IAS= 'GreaterThan90' 
--update ACR_Debtors_Details set AgeingOrdr_IAS=7 where Ageing_IAS= 'NA'



update ACR_Debtors_Details set CalMonth=FinMonth+3 where FinMonth<=9
update ACR_Debtors_Details set CalMonth=FinMonth-9 where FinMonth>9

update ACR_Debtors_Details set CalYear=FinYear where FinMonth<=9
update ACR_Debtors_Details set CalYear=FinYear+1 where FinMonth>9


update ACR_Debtors_Details set CustName=custname1,FinCustGrp=v.FinCustGrp,AreaCode=v.CustAreaCode
from vw_Business_Partner v
where ACR_Debtors_Details.CustNo=v.custcode
--and Company in (select Company from ELGI_Companies_Master where CompanyGroup='ELGI')


update ACR_Debtors_Details set CustName=custname1,FinCustGrp=v.FinCustGrp,AreaCode=v.CustAreaCode
from vw_Business_Partner_IAS v
where ACR_Debtors_Details.CustNo=v.custcode
and Company in (select Company from ELGI_Companies_Master where CompanyGroup='IAS')

----Area Updation based on IndentNo 

update ACR_Debtors_Details set AreaCode=a.areacode
from LN_Sales_Details_ver2 a
where ACR_Debtors_Details.Company=a.company
and ACR_Debtors_Details.Trantyp=a.trantype
and ACR_Debtors_Details.InvNo=a.Invoice
and ACR_Debtors_Details.InvDate>='2017-04-01'

update ACR_Debtors_Details set AreaName=v.AreaName
from (select distinct areacode,AreaName from  vw_AREA_MASTER where areacode not like '%[a-z]%') v
where ACR_Debtors_Details.AreaCode=v.Areacode

UPDATE ACR_Debtors_Details SET DPST=A.t_cofc
FROM (SELECT * FROM CI_Lines WHERE T_COFC NOT LIKE '%[A-Z]%') A
WHERE ACR_Debtors_Details.Company=A.Company
AND ACR_Debtors_Details.Trantyp=A.Trantype
AND ACR_Debtors_Details.InvNo=A.invnum
AND ACR_Debtors_Details.CustNo=A.CustCode


update ACR_Debtors_Details set dpst=a.Dpst
from (select distinct company,TranType,InvoiceNum,CustCode,Dpst from TmpSlsDespData_baan 
--where convert(date,Date)>='2000-04-01'
)a
where ACR_Debtors_Details.Company=a.Company
and ACR_Debtors_Details.Trantyp=a.TranType
and ACR_Debtors_Details.InvNo=a.InvoiceNum
AND SUBSTRING(ACR_Debtors_Details.CustNo,4,6)=a.CustCode
and ACR_Debtors_Details.DPST is null


UPDATE ACR_Debtors_Details SET DPST=A.ProductGrp
FROM AccReceivable_BAAN A
WHERE ACR_Debtors_Details.Company=A.company
AND ACR_Debtors_Details.Trantyp=A.Trantyp
AND ACR_Debtors_Details.InvNo=A.InvNo
AND SUBSTRING(ACR_Debtors_Details.CustNo,4,6)=A.CustNo
and ACR_Debtors_Details.DPST is null


UPDATE ACR_Debtors_Details SET DPST=a.t_dim5
from (select company,t_ttyp,t_ninv,t_dim5 from TTFACR200ALL where t_dim5 is not null and ltrim(rtrim(t_dim5)) <>'') A
WHERE ACR_Debtors_Details.Company=A.company
AND ACR_Debtors_Details.Trantyp=A.t_ttyp
AND ACR_Debtors_Details.InvNo=A.t_ninv
and ACR_Debtors_Details.DPST is null

--Special Case:DPST Updation for Manual Invoice billing

update ACR_Debtors_Details set DPST=b.DPST
from
(
select a.SFCP,ITYP,IDOC,line,a.MSID,isnull(b.COFC,a.DIM5) as DPST  from TCISLI225ALL a
left outer join
(select SFCP,MSID,COFC from TCISLI220ALL where cofc not like '%[A-Z]%') b
on a.SFCP=b.SFCP
and a.MSID=b.MSID
)b
where ACR_Debtors_Details.company=b.SFCP
and ACR_Debtors_Details.trantyp=b.ITYP
and ACR_Debtors_Details.InvNo=b.IDOC
and ACR_Debtors_Details.DPST is null





update ACR_Debtors_Details set dpstname=v.DPSTName,Vertical=v.Description
from vw_DPST_MASTER v
where ACR_Debtors_Details.dpst=v.DPSTcode
and company not like '6%'


update ACR_Debtors_Details set dpstname=v.DPSTName,Vertical=v.Description
from DPST_Master_ATS v
where ACR_Debtors_Details.dpst=v.DPSTcode
and company like '6%'


update ACR_Debtors_Details set dpstname=v.DPSTName,Vertical=v.Description
from DPST_Master_500 v
where ACR_Debtors_Details.dpst=v.DPSTcode
and company = '500'

update ACR_Debtors_Details set vertical1 ='International' where vertical='exports'
update ACR_Debtors_Details set vertical1 ='Channel'  where vertical='Compressor-Channel'
update ACR_Debtors_Details set vertical1 ='Compressor-C&M'  where vertical='Compressor-C&M'
update ACR_Debtors_Details set vertical1 ='Compressor-WW' where vertical='Compressor-WW'
update ACR_Debtors_Details set vertical1 ='Direct'  where vertical='Compressor-Direct'
update ACR_Debtors_Details set vertical1 ='Compressor-RLY' where vertical='Compressor-RLY'
update ACR_Debtors_Details set vertical1 ='After Sales' where vertical='After Sales'
update ACR_Debtors_Details set vertical1 ='VAYU' where vertical='VAYU'
update ACR_Debtors_Details set vertical1 ='Others' where vertical is null or 
vertical not in ('exports','Compressor-Channel','Compressor-C&M','Compressor-WW',
'Compressor-Direct','Compressor-RLY','After Sales','VAYU')

--fOR Vacuum, 

update ACR_Debtors_Details set vertical1 ='Vacuum' where vertical='Vacuum'

update ACR_Debtors_Details set vertical1 ='After Sales-Portables'
--a.vertical1
from (select * from vw_salesmapping_master
where vertical1 in (--'Industrials AfterMarket',
'Portables AfterMarket'
--,'Railways AfterMarket'
)
)a
where ACR_Debtors_Details.DPST=a.DPSTCode
--and ACR_Debtors_Details.areacode=a.areacode


--ATS AR Verticals based on Company and Trantypes
update ACR_Debtors_Details set vertical1=null where company in (select company from ELGI_Companies_Master where CompanyGroup='ATS')
update ACR_Debtors_Details set vertical1='Export AR' where concat(company,trantyp) in ('600633','600634')
update ACR_Debtors_Details set vertical1='PAYU Sales' where concat(company,trantyp) in ('600PPT','600PPW','600PDU','600PDT')
update ACR_Debtors_Details set vertical1='Demo Sales' where concat(company,trantyp) in ('6006C1','6006C2','6006C3','6006T7','6006T5','6007C1')
update ACR_Debtors_Details set vertical1='BTA Sales' where concat(company,trantyp) in ('612M64','616A64','600623','600624','600625')
update ACR_Debtors_Details set vertical1='FOC Sales' where concat(company,trantyp) in ('600654','616A54','612M54','600653','6006W1',
'6006A4','640653','640654')
update ACR_Debtors_Details set vertical1='High Value Spares' where concat(company,trantyp) in ('6006DS','6006M1')
update ACR_Debtors_Details set vertical1='High Value Spares' where concat(company,trantyp) in ('6006DS','6006M1')
update ACR_Debtors_Details set vertical1='PAYU AR' where concat(company,trantyp) in 
('600SW1','611SW1','612SW1','613SW1','614SW1','615SW1','616SW1','617SW1','618SW1','619SW1','620SW1','622SW1')


update ACR_Debtors_Details set vertical1='Direct' where (vertical1 ='Direct' or vertical1 ='Others'
or vertical1 is null) and dpst in ('90008','90009','90022','90093')
update ACR_Debtors_Details set vertical1='OFSAC' where (vertical1 ='Direct' or vertical1 ='Others'
or vertical1 is null) and dpst in ('90023','90030','90032','90094') --Mapped 90032 to MGPS based on Gershom mail confirmation

update ACR_Debtors_Details set vertical1='MGPS' where dpst='90032'


update ACR_Debtors_Details set VerticalOrdr =1  where vertical='Compressor-Channel'
update ACR_Debtors_Details set VerticalOrdr =2  where vertical='Compressor-C&M'
update ACR_Debtors_Details set VerticalOrdr =3 where vertical='Compressor-WW'
update ACR_Debtors_Details set VerticalOrdr =4  where vertical in ('Compressor-Direct','Direct')
update ACR_Debtors_Details set VerticalOrdr =5 where vertical='OFSAC'
update ACR_Debtors_Details set VerticalOrdr =6 where vertical='Compressor-RLY'
update ACR_Debtors_Details set VerticalOrdr =7 where vertical='After Sales'
update ACR_Debtors_Details set VerticalOrdr =8 where vertical1 ='After Sales-Portables'
update ACR_Debtors_Details set VerticalOrdr =9 where vertical='exports'
update ACR_Debtors_Details set VerticalOrdr =10 where vertical1 ='Others'



update ACR_Debtors_Details set Vertical2=vertical1

update ACR_Debtors_Details set Vertical2='ID' where company like '4%' and 
concat(DPST,AreaCode) in (select concat(DPSTCode,Areacode) from SalesMapping_Global where organ='ID')

update ACR_Debtors_Details set Vertical2='SEA - VPS'
where AreaCode in ('062','622','623','625','637','621')
and company not in ('551','552','553')
--update ACR_Debtors_Details set Vertical2='Australia' where company='551'
--update ACR_Debtors_Details set Vertical2='Indonesia' where company='552'
--update ACR_Debtors_Details set Vertical2='Malaysia' where company='553'

update ACR_Debtors_Details set Vertical2='Thailand' where AreaName='Thailand'
update ACR_Debtors_Details set Vertical2='C&M' where Vertical1='Compressor-C&M'
update ACR_Debtors_Details set Vertical2='WW' where Vertical1='Compressor-WW'
update ACR_Debtors_Details set Vertical2='Railways' where Vertical1='Compressor-RLY'
update ACR_Debtors_Details set vertical2='Vacuum' where Vertical1='Vacuum'


--update ACR_Debtors_Details set vertical2 ='TO ELGI BRAZIL' where company like '4%' 
--and AreaCode='663' and CustNo in ('CRE000013')

--Alter table ACR_Debtors_Details add Region varchar(50)

update ACR_Debtors_Details set Region='India' where AreaCode in (select AreaCode from Area_Master_Domestic)
update ACR_Debtors_Details set Region='SEA' where Areacode in ('062','622','623','625','637','621')
update ACR_Debtors_Details set Region='ID' where Vertical2='ID'
update ACR_Debtors_Details set Region ='Vacuum' where Vertical2='Vacuum'


update ACR_Debtors_Details set 
--Region=a.Organ,vertical2=a.Vertical1
Region='India Subsidiaries Sales',vertical2='India Subsidiaries Sales'
from (select DPSTcode,Areacode,Organ,Vertical1 from SalesMapping_Global
where organ='Subsidiary'
)a
where ACR_Debtors_Details.DPST=a.DPSTcode
and ACR_Debtors_Details.AreaCode=a.Areacode
and Region is null

update ACR_Debtors_Details set Region=a.Organ,vertical2=a.Vertical
from (select DPSTcode,Areacode,Organ,
case when User_names like '%SA%' then 'SA'
when User_names like '%Africa%' then 'AME'
when User_names like '%ME%' then 'AME'
when User_names like '%GULF%' then 'AME' end as Vertical
from SalesMapping_Global
where organ='SAAME'
)a
where ACR_Debtors_Details.DPST=a.DPSTcode
and ACR_Debtors_Details.AreaCode=a.Areacode
and Region is null





update ACR_Debtors_Details set SalesCategory=a.SalesCategory
from Trantype_Master a
where ACR_Debtors_Details.Company=a.Company
and ACR_Debtors_Details.Trantyp=a.Trantype


update ACR_Debtors_Details set SalesRepCode=a.SalesRepCode,SalesRep=a.SalesRep
from(select company,trantype,Invoice,SalesRepCode,SalesRep from LN_Sales_Details_ver2)a
where ACR_Debtors_Details.Company=a.company
and ACR_Debtors_Details.Trantyp=a.trantype
and ACR_Debtors_Details.InvNo=a.Invoice
--and ACR_Debtors_Details.recvdate is not null

update ACR_Debtors_Details set SalesRepCode=a.SalesRepCode,SalesRep=a.SalesRep
from(select company,trantype,Invoice,SalesRepCode,SalesRep from Sauer_Sales_Details)a
where ACR_Debtors_Details.Company=a.company
and ACR_Debtors_Details.Trantyp=a.trantype
and ACR_Debtors_Details.InvNo=a.Invoice

update ACR_Debtors_Details set SalesRepCode=a.SalesPerson
from vw_business_partner a
where ACR_Debtors_Details.CustNo=a.custcode
and ACR_Debtors_Details.SalesRepCode is null


update ACR_Debtors_Details set SalesRep=a.SalesRep
from(select distinct SalesRepCode,SalesRep from LN_Sales_Details_ver2)a
where ACR_Debtors_Details.salesrepcode=a.SalesRepCode
and ACR_Debtors_Details.SalesRep is null


--update ACR_Debtors_Details set SalesRepCode=a.SalesRepCode,SalesRep=a.SalesRep
--from(select company,trantyp,Invno,SalesRepCode,SalesRep from ACR_Debtors_Details where SalesRep is not null)a
--where ACR_Debtors_Details.Company=a.company
--and ACR_Debtors_Details.Trantyp=a.trantyp
--and ACR_Debtors_Details.InvNo=a.InvNo
--and ACR_Debtors_Details.recvdate is null


update acr_debtors_details set CPAY=a.t_cpay
from (select distinct concat(company,t_ttyp,t_ninv) as inv,t_cpay from TTFACR200ALL where len(t_cpay)>1) a
where concat(company,Trantyp,InvNo)=a.inv

update acr_debtors_details set PayTYP_desc=a.DSCA
from (select distinct CPAY,DSCA from TTCMCS013ALL) a
where acr_debtors_details.CPAY=a.CPAY


--Alter table acr_debtors_details add Segment	nvarchar(400)
--Alter table ACR_Debtors_complete add Segment	nvarchar(400)
--Alter table ACR_Debtors_FOC add Segment	nvarchar(400)
--Alter table ACR_Debtors_Trial add Segment	nvarchar(400)
--Alter table ACR_Debtors_BTA add Segment	nvarchar(400)
--Alter table acr_debtors_details_581 add Segment	nvarchar(400)
--Alter table acr_debtors_details_ID add Segment	nvarchar(400)

update acr_debtors_details set Segment=a.lineofbusiness
from
(select distinct company,trantype,invoice,lineofbusiness from elgi_sales_details)a
where acr_debtors_details.company=a.company
and acr_debtors_details.trantyp=a.trantype
and acr_debtors_details.invno=a.invoice

update acr_debtors_details set Segment=a.lineofbusiness
from
(select distinct company,trantype,invoice,lineofbusiness from sauer_sales_details)a
where acr_debtors_details.company=a.company
and acr_debtors_details.trantyp=a.trantype
and acr_debtors_details.invno=a.invoice


update acr_debtors_details set Segment=a.segment
from
(select distinct company,trantype,invoice,segment from ats_sales_details)a
where acr_debtors_details.company=a.company
and acr_debtors_details.trantyp=a.trantype
and acr_debtors_details.invno=a.invoice

update acr_debtors_details set Segment=a.Dept
from vw_ATS_DPST_based_Dept a
where acr_debtors_details.DPST=a.DPSTCODE
and acr_debtors_details.Company like '6%'
and Segment is null




--Part 1: Rate_USD Update for INR to USD----------------------
update acr_debtors_details set Rate_USD= a.CurRate
from (select distinct Invdate,currency,CurRate from acr_debtors_details 
where currency='USD'
and company not in (500,551,552,553)
and CurRate>1
)a
where acr_debtors_details.invdate=a.invdate
and acr_debtors_details.currency='USD'
and acr_debtors_details.company not in (500,551,552,553)


--Data Reconciliation
update acr_debtors_details set Rate_USD =a.Rate_USD 
from (
select InvDate,Rate_USD,Rnk1 from (
select a.InvDate,b.Rate_USD,row_number() over(partition by a.Invdate order by datediff(dd,b.Invdate,a.InvDate) desc ) as Rnk1 from
(select distinct Invdate,Rate_USD from acr_debtors_details 
where Rate_USD is null
and company not in (500,551,552,553)
)a
left outer join
(select distinct Invdate,Rate_USD from acr_debtors_details 
where Rate_USD is not null
and company not in (500,551,552,553)
)b
on a.Invdate<=b.Invdate
)a
where Rnk1=1
)a
where acr_debtors_details.InvDate=a.InvDate
and acr_debtors_details.Rate_USD is null
and acr_debtors_details.company not in (500,551,552,553)

--End: Part 1: Rate_USD Update for INR to USD----------------------

--Part 2: Rate_USD Update for Home Currency of Subsidiary Companies to USD---------------------------
update acr_debtors_details set Rate_USD=a.CurRate
from (select distinct company,Invdate,currency,CurRate from acr_debtors_details 
where currency='USD'
and company in (500,551,552,553)
)a
where acr_debtors_details.company=a.company
and acr_debtors_details.invdate=a.invdate
and acr_debtors_details.currency='USD'


--Data Reconciliation
update acr_debtors_details set Rate_USD =a.Rate_USD 
from (
select company,InvDate,Rate_USD,Rnk1 from (
select a.company,a.InvDate,b.Rate_USD,row_number() over(partition by a.company,a.Invdate order by datediff(dd,b.Invdate,a.InvDate) desc ) as Rnk1 from
(select distinct Company,Invdate,Rate_USD from acr_debtors_details 
where Rate_USD is null
and company in (500,551,552,553)
)a
left outer join
(select distinct Company,Invdate,Rate_USD from acr_debtors_details 
where Rate_USD is not null
and company in (500,551,552,553)
)b
on a.company=b.company
and a.Invdate<=b.Invdate
)a
where Rnk1=1
)a
where acr_debtors_details.company=a.company
and acr_debtors_details.InvDate=a.InvDate
and acr_debtors_details.Rate_USD is null



------
--Method 2:
--Alter table acr_debtors_details add USD_ConversionRate_AER float
--Alter table acr_debtors_details add INR_ConversionRate_AER float
--Alter table acr_debtors_details add InvAmt_INR float
--Alter table acr_debtors_details add PaidAmt_INR float
--Alter table acr_debtors_details add BalanceAmt_INR float

--select * from acr_debtors_details

update acr_debtors_details set USD_ConversionRate_AER=a.RATE
from (select distinct InvDate,Currency,BCUR,CCUR,STDT,RATE,Rnk--,DaysDiff
from (
select *,datediff(dd,STDT,InvDate) as DaysDiff,
row_number() over (partition by InvDate,Currency order by datediff(dd,STDT,InvDate)) as Rnk 
from (select distinct InvDate,case when Currency='INR' then 'IND' else Currency end as Currency 
from acr_debtors_details
--where currency='MYR'
)a
left outer join 
(
select CCUR,BCUR,RTYP,STDT,
case when BCUR in ('INR','IND') then RATE1 else RATE2 end as RATE
from( 
select CCUR,BCUR,RTYP,convert(date,STDT) STDT,
1/max(RATE) RATE1,
max(RATE) RATE2
from [ELGi_LN].dbo.TTCMCS008ALL 
--where BCUR in ('USD','EUR','BRL','GBP')
where BCUR in ('IND','INR','IDR','USD',
'AUD','MYR','EUR','BRL','SLR','THB','DHI')
and CCUR in ('USD')
and RATE<>1
--and convert(date,stdt)='2024-01-08'
group by CCUR,BCUR,RTYP,convert(date,STDT)
--order by convert(date,STDT)
)b)c
on a.Currency=c.BCUR
and a.InvDate>=c.STDT
)a
where Rnk=1
--order by PostingDate
)a
where acr_debtors_details.InvDate=a.InvDate
and (case when acr_debtors_details.Currency='INR' then 'IND' 
else acr_debtors_details.Currency end)=a.Currency


update acr_debtors_details set INR_ConversionRate_AER=a.RATE
from (select distinct InvDate,Currency,BCUR,CCUR,STDT,RATE,Rnk--,DaysDiff
from (
select *,datediff(dd,STDT,InvDate) as DaysDiff,
row_number() over (partition by InvDate,Currency order by datediff(dd,STDT,InvDate)) as Rnk 
from (select distinct InvDate,Currency from acr_debtors_details
--where currency='MYR'
)a
left outer join 
(select CCUR,BCUR,RTYP,convert(date,STDT) STDT,max(RATE) RATE
from [ELGi_LN].dbo.TTCMCS008ALL 
where CCUR in ('IDR','USD','AUD','MYR','EUR','BRL','SLR','THB','DHI')
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
where acr_debtors_details.InvDate=a.InvDate
and acr_debtors_details.Currency=a.Currency

update acr_debtors_details set USD_ConversionRate_AER=1 where currency='USD'
update acr_debtors_details set INR_ConversionRate_AER=1 where currency in ('IND','INR')






--Part 2: Rate_USD Update for Home Currency of Subsidiary Companies to USD---------------------------

--Method 1:
update acr_debtors_details set InvAmt_USD=invAmti where currency='USD'
update acr_debtors_details set PaidAmt_USD=PaidAmti  where currency='USD'
update acr_debtors_details set BalanceAmt_USD=BalanceAmti  where currency='USD'


update acr_debtors_details set InvAmt_USD=invAmt/Rate_USD where currency<>'USD' and CurRate>1 and Rate_USD is not null
update acr_debtors_details set PaidAmt_USD=PaidAmt/Rate_USD where currency<>'USD' and CurRate>1 and Rate_USD is not null
update acr_debtors_details set BalanceAmt_USD=BalanceAmt/Rate_USD where currency<>'USD' and CurRate>1 and Rate_USD is not null


update acr_debtors_details set InvAmt_USD=invAmt*Rate_USD where currency<>'USD' and CurRate<1 and Rate_USD is not null
update acr_debtors_details set PaidAmt_USD=PaidAmt*Rate_USD where currency<>'USD' and CurRate<1 and Rate_USD is not null
update acr_debtors_details set BalanceAmt_USD=BalanceAmt*Rate_USD where currency<>'USD' and CurRate<1 and Rate_USD is not null


--Method 2:
--update acr_debtors_details set InvAmt_USD=invamti*USD_ConversionRate_AER
--update acr_debtors_details set PaidAmt_USD=PaidAmti*USD_ConversionRate_AER
--update acr_debtors_details set BalanceAmt_USD=BalanceAmti*USD_ConversionRate_AER


--update acr_debtors_details set InvAmt_INR=invamti*INR_ConversionRate_AER
--update acr_debtors_details set PaidAmt_INR=PaidAmti*INR_ConversionRate_AER
--update acr_debtors_details set BalanceAmt_INR=BalanceAmti*INR_ConversionRate_AER

--Code to be Updated
--select distinct a.PASH,a.DSCA,b.SEQN,b.NODS,b.PERC from
--(select * from TTCMCS220ALL where PTYP=1) a
--left outer join (select * from TTCMCS221ALL)b
--on a.PASH=b.PASH




Insert into ACR_Debtors_complete(Company,Trantyp,InvNo,Line,CustNo,CustName,FinCustGrp,VerticalOrdr,
Vertical1,Vertical,DPST,DpstName,AreaCode,AreaName,InvDate,DueDate,Currency,CurRate,InvAmt,PaidAmt,
BalanceAmt,InvAmti,PaidAmti,BalanceAmti,Ageing,Ageing_IAS,AgeingOrdr,FinYear,FinMonth,CalYear,CalMonth,
AgeingOrdr_IAS,Reference,SalesCategory,SalesRepCode,SalesRep,CPAY,PayTYP_desc,Segment,Duestatus,Rate_USD,
InvAmt_USD,PaidAmt_USD,BalanceAmt_USD,Vertical2,Region,USD_ConversionRate_AER,INR_ConversionRate_AER,
InvAmt_INR,PaidAmt_INR,BalanceAmt_INR,DueSchedule,DueAmnt,DueAmnt_Received,Due_ReceivedDate) 
select Company,Trantyp,InvNo,Line,CustNo,CustName,FinCustGrp,VerticalOrdr,
Vertical1,Vertical,DPST,DpstName,AreaCode,AreaName,InvDate,DueDate,Currency,CurRate,InvAmt,PaidAmt,
BalanceAmt,InvAmti,PaidAmti,BalanceAmti,Ageing,Ageing_IAS,AgeingOrdr,FinYear,FinMonth,CalYear,CalMonth,
AgeingOrdr_IAS,Reference,SalesCategory,SalesRepCode,SalesRep,CPAY,PayTYP_desc,Segment,Duestatus,Rate_USD,
InvAmt_USD,PaidAmt_USD,BalanceAmt_USD,Vertical2,Region,USD_ConversionRate_AER,INR_ConversionRate_AER,
InvAmt_INR,PaidAmt_INR,BalanceAmt_INR,DueSchedule,DueAmnt,DueAmnt_Received,Due_ReceivedDate
from ACR_Debtors_Details







insert into ACR_Debtors_FOC(Company,Trantyp,InvNo,Line,CustNo,CustName,FinCustGrp,VerticalOrdr,
Vertical1,Vertical,DPST,DpstName,AreaCode,AreaName,InvDate,DueDate,Currency,CurRate,InvAmt,PaidAmt,
BalanceAmt,InvAmti,PaidAmti,BalanceAmti,Ageing,Ageing_IAS,AgeingOrdr,FinYear,FinMonth,CalYear,CalMonth,
AgeingOrdr_IAS,Reference,SalesCategory,SalesRepCode,SalesRep,CPAY,PayTYP_desc,Indent,Segment,Rate_USD,
InvAmt_USD,PaidAmt_USD,BalanceAmt_USD,Vertical2,Region,USD_ConversionRate_AER,INR_ConversionRate_AER,
InvAmt_INR,PaidAmt_INR,BalanceAmt_INR,DueSchedule,DueAmnt,DueAmnt_Received,Due_ReceivedDate)
select Company,Trantyp,InvNo,Line,CustNo,CustName,FinCustGrp,VerticalOrdr,
Vertical1,Vertical,DPST,DpstName,AreaCode,AreaName,InvDate,DueDate,Currency,CurRate,InvAmt,PaidAmt,
BalanceAmt,InvAmti,PaidAmti,BalanceAmti,Ageing,Ageing_IAS,AgeingOrdr,FinYear,FinMonth,CalYear,CalMonth,
AgeingOrdr_IAS,Reference,SalesCategory,SalesRepCode,SalesRep,CPAY,PayTYP_desc,Indent,Segment,Rate_USD,
InvAmt_USD,PaidAmt_USD,BalanceAmt_USD,Vertical2,Region,USD_ConversionRate_AER,INR_ConversionRate_AER,
InvAmt_INR,PaidAmt_INR,BalanceAmt_INR,DueSchedule,DueAmnt,DueAmnt_Received,Due_ReceivedDate
from ACR_Debtors_Details where company =401 and ltrim(rtrim(trantyp))  in ('251','351','451','551','252','352','452','552')
union
select Company,Trantyp,InvNo,Line,CustNo,CustName,FinCustGrp,VerticalOrdr,
Vertical1,Vertical,DPST,DpstName,AreaCode,AreaName,InvDate,DueDate,Currency,CurRate,InvAmt,PaidAmt,
BalanceAmt,InvAmti,PaidAmti,BalanceAmti,Ageing,Ageing_IAS,AgeingOrdr,FinYear,FinMonth,CalYear,CalMonth,
AgeingOrdr_IAS,Reference,SalesCategory,SalesRepCode,SalesRep,CPAY,PayTYP_desc,Indent,Segment,Rate_USD,
InvAmt_USD,PaidAmt_USD,BalanceAmt_USD,Vertical2,Region,USD_ConversionRate_AER,INR_ConversionRate_AER,
InvAmt_INR,PaidAmt_INR,BalanceAmt_INR,DueSchedule,DueAmnt,DueAmnt_Received,Due_ReceivedDate
from ACR_Debtors_Details where company =490 and ltrim(rtrim(trantyp))  in ('256','356','456','556')
union
select Company,Trantyp,InvNo,Line,CustNo,CustName,FinCustGrp,VerticalOrdr,
Vertical1,Vertical,DPST,DpstName,AreaCode,AreaName,InvDate,DueDate,Currency,CurRate,InvAmt,PaidAmt,
BalanceAmt,InvAmti,PaidAmti,BalanceAmti,Ageing,Ageing_IAS,AgeingOrdr,FinYear,FinMonth,CalYear,CalMonth,
AgeingOrdr_IAS,Reference,SalesCategory,SalesRepCode,SalesRep,CPAY,PayTYP_desc,Indent,Segment,Rate_USD,
InvAmt_USD,PaidAmt_USD,BalanceAmt_USD,Vertical2,Region,USD_ConversionRate_AER,INR_ConversionRate_AER,
InvAmt_INR,PaidAmt_INR,BalanceAmt_INR,DueSchedule,DueAmnt,DueAmnt_Received,Due_ReceivedDate
from ACR_Debtors_Details where company =450 and ltrim(rtrim(trantyp))  in ('855')



insert into ACR_Debtors_FOC(Company,Trantyp,InvNo,Line,CustNo,CustName,FinCustGrp,VerticalOrdr,
Vertical1,Vertical,DPST,DpstName,AreaCode,AreaName,InvDate,DueDate,Currency,CurRate,InvAmt,PaidAmt,
BalanceAmt,InvAmti,PaidAmti,BalanceAmti,Ageing,Ageing_IAS,AgeingOrdr,FinYear,FinMonth,CalYear,CalMonth,
AgeingOrdr_IAS,Reference,SalesCategory,SalesRepCode,SalesRep,CPAY,PayTYP_desc,Indent,Segment,Rate_USD,
InvAmt_USD,PaidAmt_USD,BalanceAmt_USD,Vertical2,Region,USD_ConversionRate_AER,INR_ConversionRate_AER,
InvAmt_INR,PaidAmt_INR,BalanceAmt_INR,DueSchedule,DueAmnt,DueAmnt_Received,Due_ReceivedDate)
select Company,Trantyp,InvNo,Line,CustNo,CustName,FinCustGrp,VerticalOrdr,
Vertical1,Vertical,DPST,DpstName,AreaCode,AreaName,convert(date,InvDate),convert(date,DueDate),Currency,CurRate,InvAmt,PaidAmt,
BalanceAmt,InvAmti,PaidAmti,BalanceAmti,Ageing,Ageing_IAS,AgeingOrdr,FinYear,FinMonth,CalYear,CalMonth,
AgeingOrdr_IAS,Reference,SalesCategory,SalesRepCode,SalesRep,CPAY,PayTYP_desc,Indent,Segment,Rate_USD,
InvAmt_USD,PaidAmt_USD,BalanceAmt_USD,Vertical2,Region,USD_ConversionRate_AER,INR_ConversionRate_AER,
InvAmt_INR,PaidAmt_INR,BalanceAmt_INR,DueSchedule,DueAmnt,DueAmnt_Received,Due_ReceivedDate
from ACR_Debtors_Details
where concat(Company,Trantyp,InvNo,CustNo) in
(
select distinct concat(company,trantype,Invoice,custcode) from (
select * from LN_Sales_Details_ver2 where
company = 490 and SaleOrderType in ('226','236','246','270','284','326','332','346','384','516','544','526','546')
union
select * from LN_Sales_Details_ver2 where
company = 401 and saleordertype in ('223','240','244','246','225','252','344','523','RGS','516','526','544','546')
union
select * from LN_Sales_Details_ver2 where
company = 440 and saleordertype in ('225','244','344')
union
select * from LN_Sales_Details_ver2 where
company = 450 and saleordertype in ('A14','244')
union
select * from LN_Sales_Details_ver2 where
company = 465 and saleordertype in ('212','214','715')
union
select * from LN_Sales_Details_ver2 where
company = 470 and saleordertype in ('P13')
)a
)



Insert into ACR_Debtors_BTA(Company,Trantyp,InvNo,Line,CustNo,CustName,FinCustGrp,VerticalOrdr,
Vertical1,Vertical,DPST,DpstName,AreaCode,AreaName,InvDate,DueDate,Currency,CurRate,InvAmt,PaidAmt,
BalanceAmt,InvAmti,PaidAmti,BalanceAmti,Ageing,Ageing_IAS,AgeingOrdr,FinYear,FinMonth,CalYear,CalMonth,
AgeingOrdr_IAS,Reference,SalesCategory,SalesRepCode,SalesRep,CPAY,PayTYP_desc,Indent,Segment,Rate_USD,
InvAmt_USD,PaidAmt_USD,BalanceAmt_USD,Vertical2,Region,USD_ConversionRate_AER,INR_ConversionRate_AER,
InvAmt_INR,PaidAmt_INR,BalanceAmt_INR,DueSchedule,DueAmnt,DueAmnt_Received,Due_ReceivedDate)
select Company,Trantyp,InvNo,Line,CustNo,CustName,FinCustGrp,VerticalOrdr,
Vertical1,Vertical,DPST,DpstName,AreaCode,AreaName,InvDate,DueDate,Currency,CurRate,InvAmt,PaidAmt,
BalanceAmt,InvAmti,PaidAmti,BalanceAmti,Ageing,Ageing_IAS,AgeingOrdr,FinYear,FinMonth,CalYear,CalMonth,
AgeingOrdr_IAS,Reference,SalesCategory,SalesRepCode,SalesRep,CPAY,PayTYP_desc,Indent,Segment,Rate_USD,
InvAmt_USD,PaidAmt_USD,BalanceAmt_USD,Vertical2,Region,USD_ConversionRate_AER,INR_ConversionRate_AER,
InvAmt_INR,PaidAmt_INR,BalanceAmt_INR,DueSchedule,DueAmnt,DueAmnt_Received,Due_ReceivedDate
from ACR_Debtors_Details where  company like '4%' 
and ltrim(rtrim(Custno))  in 
(select distinct ltrim(rtrim(CustCode)) from vw_ELGi_BTA_Customers)



insert into ACR_Debtors_Trial(Company,Trantyp,InvNo,Line,CustNo,CustName,FinCustGrp,VerticalOrdr,
Vertical1,Vertical,DPST,DpstName,AreaCode,AreaName,InvDate,DueDate,Currency,CurRate,InvAmt,PaidAmt,
BalanceAmt,InvAmti,PaidAmti,BalanceAmti,Ageing,Ageing_IAS,AgeingOrdr,FinYear,FinMonth,CalYear,CalMonth,
AgeingOrdr_IAS,Reference,SalesCategory,SalesRepCode,SalesRep,CPAY,PayTYP_desc,Indent,Segment,Rate_USD,
InvAmt_USD,PaidAmt_USD,BalanceAmt_USD,Vertical2,Region,USD_ConversionRate_AER,INR_ConversionRate_AER,
InvAmt_INR,PaidAmt_INR,BalanceAmt_INR,DueSchedule,DueAmnt,DueAmnt_Received,Due_ReceivedDate)
select Company,Trantyp,InvNo,Line,CustNo,CustName,FinCustGrp,VerticalOrdr,
Vertical1,Vertical,DPST,DpstName,AreaCode,AreaName,InvDate,DueDate,Currency,CurRate,InvAmt,PaidAmt,
BalanceAmt,InvAmti,PaidAmti,BalanceAmti,Ageing,Ageing_IAS,AgeingOrdr,FinYear,FinMonth,CalYear,CalMonth,
AgeingOrdr_IAS,Reference,SalesCategory,SalesRepCode,SalesRep,CPAY,PayTYP_desc,Indent,Segment,Rate_USD,
InvAmt_USD,PaidAmt_USD,BalanceAmt_USD,Vertical2,Region,USD_ConversionRate_AER,INR_ConversionRate_AER,
InvAmt_INR,PaidAmt_INR,BalanceAmt_INR,DueSchedule,DueAmnt,DueAmnt_Received,Due_ReceivedDate
from ACR_Debtors_Details where company like '4%' and ltrim(rtrim(trantyp))  in 
(select * from vw_TrialSales_Trantype)


delete from ACR_Debtors_Trial where  company like '4%' 
and ltrim(rtrim(Custno))  in (select distinct ltrim(rtrim(CustCode)) from vw_ELGi_BTA_Customers)


Insert into acr_debtors_details_581(Company,Trantyp,InvNo,Line,CustNo,CustName,FinCustGrp,VerticalOrdr,
Vertical1,Vertical,DPST,DpstName,AreaCode,AreaName,InvDate,DueDate,Currency,CurRate,InvAmt,PaidAmt,
BalanceAmt,InvAmti,PaidAmti,BalanceAmti,Ageing,Ageing_IAS,AgeingOrdr,FinYear,FinMonth,CalYear,CalMonth,
AgeingOrdr_IAS,Reference,SalesCategory,SalesRepCode,SalesRep,
CPAY,PayTYP_desc,Indent,Segment,AR_Plan,Rate_USD,
InvAmt_USD,PaidAmt_USD,BalanceAmt_USD,Vertical2,Region,USD_ConversionRate_AER,INR_ConversionRate_AER,
InvAmt_INR,PaidAmt_INR,BalanceAmt_INR,DueSchedule,DueAmnt,DueAmnt_Received,Due_ReceivedDate)
select Company,Trantyp,InvNo,Line,CustNo,CustName,FinCustGrp,VerticalOrdr,
Vertical1,Vertical,DPST,DpstName,AreaCode,AreaName,InvDate,DueDate,Currency,CurRate,InvAmt,PaidAmt,
BalanceAmt,InvAmti,PaidAmti,BalanceAmti,Ageing,Ageing_IAS,AgeingOrdr,FinYear,FinMonth,CalYear,CalMonth,
AgeingOrdr_IAS,Reference,SalesCategory,SalesRepCode,SalesRep,
CPAY,PayTYP_desc,Indent,Segment,AR_Plan,Rate_USD,
InvAmt_USD,PaidAmt_USD,BalanceAmt_USD,Vertical2,Region,USD_ConversionRate_AER,INR_ConversionRate_AER,
InvAmt_INR,PaidAmt_INR,BalanceAmt_INR,DueSchedule,DueAmnt,DueAmnt_Received,Due_ReceivedDate
from acr_debtors_details where company=581

--update acr_debtors_details_581 set SalesRepCode=a.t_crep
--from (select distinct company,t_ttyp,t_ninv,t_crep from TTFACR200ALL 
--where len(t_crep) >2)a
--where acr_debtors_details_581.Company=a.Company
--and acr_debtors_details_581.Trantyp=a.t_ttyp
--and acr_debtors_details_581.InvNo=a.t_ninv
--and acr_debtors_details_581.SalesRepCode is null


--update acr_debtors_details_581 set SalesRepCode=a.t_crep
--from (select distinct company,t_ttyp,t_ninv,t_crep from TTFACR200ALL 
--where len(t_crep) >2
--)a
--where acr_debtors_details_581.Company=a.Company
--and acr_debtors_details_581.Trantyp=a.t_ttyp
--and acr_debtors_details_581.InvNo=a.t_ninv
--and ltrim(rtrim(acr_debtors_details_581.SalesRepCode)) =''

--update acr_debtors_details_581 set SalesRepCode=a.SalesRepCode
--from (select distinct company,Trantyp,InvNo,SalesRepCode from acr_debtors_details_581
--where len(ltrim(rtrim(acr_debtors_details_581.SalesRepCode))) >2
--)a
--where acr_debtors_details_581.Company=a.Company
--and acr_debtors_details_581.Trantyp=a.Trantyp
--and acr_debtors_details_581.InvNo=a.InvNo
--and len(ltrim(rtrim(acr_debtors_details_581.SalesRepCode))) <2
--and len(acr_debtors_details_581.SalesRepCode)<2


--update acr_debtors_details_581 set salesRep=a.NAMA
--from TTCCOM001ALL a
--where acr_debtors_details_581.salesrepcode=a.EMNO 
--and acr_debtors_details_581.salesrep is null


--update acr_debtors_details_581 set SalesRepCode='300053',SalesRep='JEBARAJ' where SalesRepCode in ('14224','16400','110')

--Old Method
--update acr_debtors_details_581 set SalesRepCode=a.SalesRepCode,SalesRep=a.SalesRep  
--from (select * from Sauer_InvNo_Engineer_Master)a
--where acr_debtors_details_581.company=a.company
--and acr_debtors_details_581.trantyp=a.trantype
--and acr_debtors_details_581.InvNo=a.Invoice

--New Method
update acr_debtors_details_581 set SalesRepCode=a.ECOD
from (select * from TZZGLD308581)a
where acr_debtors_details_581.trantyp=a.TTYP
and acr_debtors_details_581.InvNo=a.DCON


update acr_debtors_details_581 set SalesRep=a.emp_name
from (select distinct new_emp_code,emp_name from [ELGi_Intranet].dbo.Employee_Detail)a
where acr_debtors_details_581.SalesRepCode=a.new_emp_code


update acr_debtors_details_581 set SalesRepCode=a.t_crep,SalesRep=a.emp_name
from( select a.Company,a.t_ttyp,a.t_ninv,t_crep,b.emp_name from
(select Company,t_ttyp,t_ninv,t_crep from TTFACR200ALL 
where Company=581 and t_crep not like '%[a-z]%'
and len(t_crep)>2
) a
inner join (select distinct emp_code,emp_name from [ELGi_Intranet].dbo.Employee_Detail) b
on a.t_crep=b.emp_code
where Company=581 
)a
where acr_debtors_details_581.Company=a.company
and acr_debtors_details_581.Trantyp=a.t_ttyp
and acr_debtors_details_581.InvNo=a.t_ninv
and acr_debtors_details_581.SalesRepCode is null


--Temporary Fix
--update acr_debtors_details_581 set SalesRepCode=a.NewEmpCode,SalesRep=a.NewEmpName
--from ELGiSauer_Employee_Master a
--where acr_debtors_details_581.SalesRepCode=a.OldEmpCode


--update acr_debtors_details_581 set salesRep=a.NAMA
--from TTCCOM001ALL a
--where acr_debtors_details_581.salesrepcode=a.EMNO 
--and acr_debtors_details_581.salesrep is null


update acr_debtors_details_581 set DeliveryDt=a.DDAT
from(select * from TZZGLD306581)a
where acr_debtors_details_581.Trantyp=a.TTYP
and acr_debtors_details_581.InvNo=a.DCON

--declare @Finyear varchar(10)='2024'
--declare @Finmonth varchar(10)='03'


--Update AR Plan for Existing Invoices
update acr_debtors_details_581 set AR_Plan=a.AMNT
from (
select * from (
select '581' as Company,TTYP,DCON,AMNT,FYER,FMON,
case when FMON<=9 then FYER else FYER+1 end as CalYear,
case when FMON<=9 then FMON+3 else FMON-9 end as CalMonth
from TZZGLD304581
)a1
where 
--FYER=@Finyear and
--FMON=@Finmonth and 
concat(convert(varchar,FYER),RIGHT('00'+CAST(FMON AS VARCHAR(2)),2))=CONCAT(@Finyear,@Finmonth) --Period Based
)a
where acr_debtors_details_581.Trantyp=a.TTYP
and acr_debtors_details_581.InvNo=a.DCON



--Insert AR Plan for New Invoices
insert into acr_debtors_details_581(Company,Trantyp,InvNo,AR_Plan,FinYear,FinMonth,CalYear,CalMonth)
select a.* from (
select * from (
select '581' as Company,TTYP,DCON,AMNT,FYER,FMON,
case when FMON<=9 then FYER else FYER+1 end as CalYear,
case when FMON<=9 then FMON+3 else FMON-9 end as CalMonth
from TZZGLD304581)a1
where 
--FYER=@Finyear and 
--FMON=@Finmonth and
concat(convert(varchar,FYER),RIGHT('00'+CAST(FMON AS VARCHAR(2)),2))=CONCAT(@Finyear,@Finmonth) --Period Based
and concat(TTYP,DCON) not in (select distinct concat(Trantyp,InvNo) from acr_debtors_details_581)
)a





--Collection FTM

--declare @Finyear varchar(10)=2021
--declare @Finmonth varchar(10)=10

--Alter table acr_debtors_details_581 add Collection_FTM float


--Declare @Finyear varchar(10)='2025'
--Declare @Finmonth varchar(10)='4'

update acr_debtors_details_581 set Collection_FTM=a.PaidAmt
from (
SELECT COMPANY,t_ttyp,t_ninv,t_line,--t_itbp,t_ccur,t_rate_1,t_docd,t_dued,t_prod,t_year,
SUM(t_amth_1+t_padh_1+t_dc1h_1+t_cdam_1) PaidAmt ,SUM(t_amti) PaidAmti FROM TTFACR200ALL 
WHERE COMPANY=581 
and t_docn<>0
and t_tdoc not in ('DMY')
--and t_year=@Finyear
--and t_prod=@Finmonth
and concat(convert(varchar,t_year),RIGHT('00'+CAST(t_prod AS VARCHAR(2)),2))=CONCAT(@Finyear,@Finmonth) --Period Based
--and t_docd<=@AS_OF_DATE --Docdt based
--and company= 401 and t_ttyp ='C21' and t_ninv=	16000227
group by COMPANY,t_ttyp,t_ninv,t_line
--t_itbp,t_ccur,t_rate_1,t_docd,t_dued,t_prod,t_year
)a
where acr_debtors_details_581.Company=a.Company
and acr_debtors_details_581.Trantyp=a.t_ttyp
and acr_debtors_details_581.InvNo=a.t_ninv
and acr_debtors_details_581.Line=a.t_line

--update acr_debtors_details_581 set Collection_FTM=PaidAmt *(-1)
----,BalanceAmti=BalanceAmti*(-1),
----PaidAmti=PaidAmti*(-1),
----InvAmti=InvAmti*(-1),
----BalanceAmt=BalanceAmt*(-1),
----PaidAmt=PaidAmt*(-1),
----InvAmt=InvAmt*(-1)
--where InvAmt<0
--and concat(Company,Trantyp,InvNo,Line) in
--(SELECT distinct concat(COMPANY,t_ttyp,t_ninv,t_line)
--FROM TTFACR200ALL 
--WHERE COMPANY=581 
--and t_docn<>0
--and concat(convert(varchar,t_year),RIGHT('00'+CAST(t_prod AS VARCHAR(2)),2))=CONCAT(@Finyear,@Finmonth) --Period Based
--) 


update acr_debtors_details_581 set Collection_FTM=a.PaidAmt*(-1)
from (
SELECT COMPANY,t_ttyp,t_ninv,t_line,--t_itbp,t_ccur,t_rate_1,t_docd,t_dued,t_prod,t_year,
SUM(t_amth_1+t_padh_1+t_dc1h_1+t_cdam_1) PaidAmt ,SUM(t_amti) PaidAmti FROM TTFACR200ALL 
WHERE COMPANY=581 
and t_docn<>0
and t_tdoc not in ('DMY')
--and t_year=@Finyear
--and t_prod=@Finmonth
and concat(convert(varchar,t_year),RIGHT('00'+CAST(t_prod AS VARCHAR(2)),2))=CONCAT(@Finyear,@Finmonth) --Period Based
--and t_docd<=@AS_OF_DATE --Docdt based
--and company= 401 and t_ttyp ='C21' and t_ninv=	16000227
group by COMPANY,t_ttyp,t_ninv,t_line
--t_itbp,t_ccur,t_rate_1,t_docd,t_dued,t_prod,t_year
)a
where acr_debtors_details_581.Company=a.Company
and acr_debtors_details_581.Trantyp=a.t_ttyp
and acr_debtors_details_581.InvNo=a.t_ninv
and acr_debtors_details_581.Line=a.t_line
and acr_debtors_details_581.InvAmt<0


delete from acr_debtors_details_581
where BalanceAmt between -1 and 1
and AR_Plan is null and Collection_FTM is null

--delete from acr_debtors_details_581_History
--Declare @AS_OF_DATE date='2024-06-07'
--Declare @Finyear varchar(10)=case when month(@AS_OF_DATE)<4 then year(@AS_OF_DATE)-1 else year(@AS_OF_DATE) end
--declare @Finmonth varchar(10) =case when month(@AS_OF_DATE)<4 then month(@AS_OF_DATE)+9 else month(@AS_OF_DATE)-3 end
--set  @Finmonth=RIGHT('00'+CAST(@Finmonth AS VARCHAR(2)),2)
--Declare @FinPeriod int=concat(@FinYear,@FinMonth)

--Declare @CalYear varchar(10)=year(@AS_OF_DATE)
--Declare @CalMonth varchar(10)=RIGHT('00'+CAST(month(@AS_OF_DATE) AS VARCHAR(2)),2)
--Declare @CalPeriod int=concat(@CalYear,@CalMonth)

--select * into acr_debtors_details_581_History_bkp_28Feb2024 from acr_debtors_details_581_History


if exists ( select * from acr_debtors_details_581_History where CalPeriod= @CalPeriod)
begin
delete from acr_debtors_details_581_History where CalPeriod>= @CalPeriod
end

Insert into acr_debtors_details_581_History 
select Company,Trantyp,InvNo,Line,CustNo,CustName,FinCustGrp,VerticalOrdr,Vertical1,Vertical,
DPST,DpstName,AreaCode,AreaName,InvDate,DueDate,Currency,CurRate,InvAmt,PaidAmt,BalanceAmt,
InvAmti,PaidAmti,BalanceAmti,Ageing,Ageing_IAS,AgeingOrdr,FinYear,FinMonth,CalYear,CalMonth,
AgeingOrdr_IAS,Reference,SalesCategory,SalesRepCode,SalesRep,CPAY,PayTYP_desc,Indent,
Segment,AR_Plan,DeliveryDt,Collection_FTM,--'202202','202111'
@CalPeriod,@FinPeriod
from acr_debtors_details_581


--select * from acr_debtors_details_581_History





--Removing 581 company details
delete from acr_debtors_details where company=581

--Removing FOC
--Commented on 5 July 2018
--delete from ACR_Debtors_details where company =401 and ltrim(rtrim(trantyp))  in ('251','351','451','551','252','352','452','552')
--delete from ACR_Debtors_details where company =490 and ltrim(rtrim(trantyp))  in ('256','356','456','556')

delete from ACR_Debtors_Details where invdate<='1950-01-01'

delete from ACR_Debtors_Details
where concat(Company,Trantyp,InvNo,CustNo) in
(
select distinct concat(company,trantype,Invoice,custcode) from (
select * from LN_Sales_Details_ver2 where
company = 490 and SaleOrderType in ('226','236','246','270','284','326','332','346','384','516','544','526','546')
union
select * from LN_Sales_Details_ver2 where
company = 401 and saleordertype in ('223','240','244','246','225','252','344','523','RGS','516','526','544','546')
union
select * from LN_Sales_Details_ver2 where
company = 440 and saleordertype in ('225','244','344')
union
select * from LN_Sales_Details_ver2 where
company = 450 and saleordertype in ('A14','244')
--union
--select * from LN_Sales_Details_ver2 where
--company = 465 and saleordertype in ('212','214','715')  --Commented As per request of RajaMohan, Accounts 
union
select * from LN_Sales_Details_ver2 where
company = 470 and saleordertype in ('P13')
)a
)



--Removing Trial
--delete from ACR_Debtors_details where company like '4%' and  ltrim(rtrim(trantyp))  in ('2C1','2C2','2C3','2C4','2T1','2T2','22A','32A')
--delete from ACR_Debtors_details where company like '4%' and  ltrim(rtrim(trantyp))  in ('3C1','3C2','3C3','3C4','3T1','3T2','4T1')
delete from ACR_Debtors_details where company like '4%' and  ltrim(rtrim(trantyp))  in (select * from vw_TrialSales_Trantype)

--Removing FOC for India
delete from ACR_Debtors_details where company like '4%' and Trantyp in ('22A','32A')

--Removing FOC for GULF
delete from ACR_Debtors_details where company=500 and Trantyp in ('7A1','751')

--Removing BTA Customers


delete from ACR_Debtors_details where company like '4%' 
and ltrim(rtrim(Custno))  in (select distinct ltrim(rtrim(CustCode)) from vw_ELGi_BTA_Customers)



Insert into acr_debtors_details_ID(Company,Trantyp,InvNo,Line,CustNo,CustName,FinCustGrp,VerticalOrdr,
Vertical1,Vertical,DPST,DpstName,AreaCode,AreaName,InvDate,DueDate,Currency,CurRate,InvAmt,PaidAmt,
BalanceAmt,InvAmti,PaidAmti,BalanceAmti,Ageing,Ageing_IAS,AgeingOrdr,FinYear,FinMonth,CalYear,CalMonth,
AgeingOrdr_IAS,Reference,SalesCategory,SalesRepCode,SalesRep,CPAY,PayTYP_desc,Indent,Segment,Rate_USD,
InvAmt_USD,PaidAmt_USD,BalanceAmt_USD,Vertical2,Region,USD_ConversionRate_AER,INR_ConversionRate_AER,
InvAmt_INR,PaidAmt_INR,BalanceAmt_INR,DueSchedule,DueAmnt,DueAmnt_Received,Due_ReceivedDate)
select Company,Trantyp,InvNo,Line,CustNo,CustName,FinCustGrp,VerticalOrdr,
Vertical1,Vertical,DPST,DpstName,AreaCode,AreaName,InvDate,DueDate,Currency,CurRate,InvAmt,PaidAmt,
BalanceAmt,InvAmti,PaidAmti,BalanceAmti,Ageing,Ageing_IAS,AgeingOrdr,FinYear,FinMonth,CalYear,CalMonth,
AgeingOrdr_IAS,Reference,SalesCategory,SalesRepCode,SalesRep,CPAY,PayTYP_desc,Indent,Segment,Rate_USD,
InvAmt_USD,PaidAmt_USD,BalanceAmt_USD,Vertical2,Region,USD_ConversionRate_AER,INR_ConversionRate_AER,
InvAmt_INR,PaidAmt_INR,BalanceAmt_INR,DueSchedule,DueAmnt,DueAmnt_Received,Due_ReceivedDate
from acr_debtors_details where 
company like '4%'and
concat(DPST,AreaCode) in (select concat(DPSTCode,Areacode) from SalesMapping_Global where organ='ID')

--Data removal based on Rajamohan's request through mail dated 21-Jun-2021
delete from acr_debtors_details_ID where CustNo like 'su1%'
delete from acr_debtors_details_ID where CustNo like 'sup%'

update acr_debtors_details_ID set ageing ='>1Yr' where Ageing= 'Greater Than 1Yr'
update acr_debtors_details_ID set ageing ='>2Yrs' where Ageing= 'Greater Than 2Yrs'
update acr_debtors_details_ID set ageing ='<30' where Ageing= 'LessThan30'



--Debits Classification

--Alter table acr_debtors_complete add Credits_Debits varchar(10)

update acr_debtors_complete set Credits_Debits='Debits'
from (
SELECT CustNo FROM acr_debtors_complete
where company like '4%'
GROUP BY CustNo
HAVING sum(BalanceAmt)>=0
)a
where acr_debtors_complete.CustNo=a.CustNo
and acr_debtors_complete.company like '4%'

update acr_debtors_complete set Credits_Debits='Debits'
from (
SELECT CustNo FROM acr_debtors_complete
where company like '6%'
GROUP BY CustNo
HAVING sum(BalanceAmt)>=0
)a
where acr_debtors_complete.CustNo=a.CustNo
and acr_debtors_complete.company like '6%'


--Credits Classification

update acr_debtors_complete set Credits_Debits='Credits'
from (
SELECT CustNo FROM acr_debtors_complete
where company like '4%'
GROUP BY CustNo
HAVING sum(BalanceAmt)<0
)a
where acr_debtors_complete.CustNo=a.CustNo
and acr_debtors_complete.company like '4%'

update acr_debtors_complete set Credits_Debits='Credits'
from (
SELECT CustNo FROM acr_debtors_complete
where company like '6%'
GROUP BY CustNo
HAVING sum(BalanceAmt)<0
)a
where acr_debtors_complete.CustNo=a.CustNo
and acr_debtors_complete.company like '6%'



---Unlinked Debits---------------------------------------------------------------

--Below script is moved as a seperate stored procedure. Hence commented here.

--exec sp_UnlinkedDebits


--update ACR_Debtors_Details set UnlinkedCredits=a.TempBalance
--from (select * from ACR_Debtors_complete_Advances)a
--where ACR_Debtors_Details.COMPANY=a.Company
--and ACR_Debtors_Details.TranTyp=a.Trantyp
--and ACR_Debtors_Details.InvNo=a.InvNo
--and ACR_Debtors_Details.CustNo=a.CustNo
--and ACR_Debtors_Details.InvDate=a.InvDate

--update ACR_Debtors_complete set UnlinkedCredits=a.TempBalance
--from (select * from ACR_Debtors_complete_Advances)a
--where ACR_Debtors_complete.COMPANY=a.Company
--and ACR_Debtors_complete.TranTyp=a.Trantyp
--and ACR_Debtors_complete.InvNo=a.InvNo
--and ACR_Debtors_complete.CustNo=a.CustNo
--and ACR_Debtors_complete.InvDate=a.InvDate


---End: Unlinked Credits------------------------------------




--update acr_debtors_complete set BalanceAmt=ROUND(BalanceAmt,2)



exec sp_ACR_Debtors_complete_ver2


End



--select avg(InvAmt) as InvAmt,sum(PaidAmt) as PaidAmt,sum(BalanceAmt) as BalanceAmt,avg(InvAmti) as InvAmti,
--sum(PaidAmti) as PaidAmti,sum(BalanceAmti) as BalanceAmti
--from ACR_Debtors_Details
--where company like '4%'
--having sum(BalanceAmt) >50  or sum(BalanceAmt) <-50 


--select Vertical1,Company,Trantyp,InvNo,CustNo,CustName,FinCustGrp,DPST,DpstName,AreaCode,AreaName,
--InvDate,DueDate,Currency,CurRate,InvAmt,PaidAmt,BalanceAmt,CalYear,CalMonth,FinYear,FinMonth
--from acr_debtors_complete 
--and BalanceAmt not between -1 and 1
--order by CustNo,FinYear,FinMonth


--select * from ACR_Debtors_Details_581
--select InvDate,Company,Trantyp,InvNo,SalesRepCode,SalesRep from acr_debtors_details_581
--order by InvDate


--select distinct EMNO,NAMA from TTCCOM001ALL
--where emno in (select distinct SalesRepCode from acr_debtors_details_581)

GO

