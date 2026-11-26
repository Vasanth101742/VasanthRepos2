--exec sp_FOC_Summary
CREATE proc sp_FOC_Summary as
begin

--Alter table FOC_Summary add  Item nvarchar(25)
--Alter table FOC_Summary alter column Item_desc  nvarchar(50)
--Alter table FOC_Summary add  FinalApprovalDate date
--Alter table FOC_Summary drop column foc_validated_on date
--Alter table FOC_Summary add FOC_CreationDate date
--Alter table FOC_Summary add workorderno nvarchar(100)



Truncate Table FOC_Summary
Insert into FOC_Summary(Organ,Invoice_Date,Fabno,Model,Product,MC_Value2,
--Fin_year,Fin_month,Monthname,
Item,Item_desc,elgi_focnumber,
FinalApprovalDate,FOC_CreationDate,workorderno
)
--select * into FOC_Summary from(
select * from(
select Organ,Invoice_Date,
Fabno,Model,Product,sum(MC_Value2) MC_Value2,
--Fin_year,Fin_month,substring(MonthName,1,3) as Monthname,
Item,Item_desc,elgi_focnumber,FinalApprovalDate,
FOC_CreationDate,workorderno
from FOC_Details_Complete
where Invoice_Date is not null
and organ='India'
and vertical='Quality'
and invoice_date>='2025-04-01'
group by Organ,Invoice_Date,Fabno,Model,Product,
--Fin_year,Fin_month,Monthname,
Item,Item_desc,elgi_focnumber,FinalApprovalDate,
FOC_CreationDate,workorderno
)a
union
select * from(
select Region,null as Invoice_Date,Fabno,Model,prod_segment,sum(TotalWarrantyCost) TotalWarrantyCost,
--Finyear,FinMonth,substring(FinMonthName,1,3) FinMonthName,
partcode,Part_desc,focno,FinalApprovalDate,Log_Date,ccstrackno
from warranty_Tracker_complete
where foc_validated in ('Verified','Clarify')
and foc_type_desc not in ('MARKETING FOC','GOOD WILL FOC')
and FOC_Status2 in ('Approved')
and Log_Date>='2025-04-01'
group by Region,Fabno,Model,prod_segment,
--Finyear,FinMonth,FinMonthName,
partcode,Part_desc,focno,FinalApprovalDate,Log_Date,ccstrackno
)b
union
select * from(
select Region,null as Invoice_Date,Fabno,Model,prod_segment,sum(TotalWarrantyCost) TotalWarrantyCost,
--Finyear,FinMonth,substring(FinMonthName,1,3) FinMonthName,
partcode,Part_desc,focno,FinalApprovalDate,Log_Date,ccstrackno
from warranty_Tracker_complete
where foc_validated is null
and Region is not null
and foc_type_desc not in ('MARKETING FOC','GOOD WILL FOC')
and FOC_Status2 in ('Approved')
and Log_Date>='2025-04-01'
group by Region,Fabno,Model,prod_segment,
--Finyear,FinMonth,FinMonthName,
partcode,Part_desc,focno,FinalApprovalDate,Log_Date,ccstrackno
)b


update FOC_Summary set FinalApprovalDate=a.FinalApprovalDate
from (select distinct focno,FinalApprovalDate from CCS_FOC_Details)a
where FOC_Summary.elgi_focnumber=a.focno
and FOC_Summary.FinalApprovalDate is null



update FOC_Summary set Date1=coalesce(invoice_date,FinalApprovalDate,FOC_CreationDate)

--Alter table FOC_Summary add cal_year varchar(10)
--Alter table FOC_Summary add cal_Month int
--select * from FOC_Summary


update FOC_Summary set cal_year=year(Date1)
update FOC_Summary set cal_Month=month(Date1)
update FOC_Summary set Monthname=substring(datename(mm,dateadd(mm,cal_Month,-1)),1,3)

update FOC_Summary set Fin_year=cal_year-1 where cal_Month<4
update FOC_Summary set Fin_year=cal_year where cal_Month>=4

update FOC_Summary set Fin_month=cal_Month+9  where cal_Month<4
update FOC_Summary set Fin_month=cal_Month-3  where cal_Month>=4


update FOC_Summary set Col1=Concat(Monthname,'-',substring(Fin_year,3,2)) where Fin_month<10
update FOC_Summary set Col1=Concat(Monthname,'-',substring(convert(varchar,(convert(int,Fin_year)+1)),3,2)) where Fin_month>=10

update FOC_Summary set MonthName2=Col1

update FOC_Summary set Col1=Monthname + ' : Wk '+ convert(varchar,datepart(week,Date1)-datepart(week,dateadd(Month,datediff(Month,0,Date1),0))+1)
where year(Date1)=year(getdate()-1)
and month(Date1)=month(getdate()-1)


--Alter table FOC_Summary add Currency varchar(25)

update FOC_Summary set Currency='USD' where Organ in ('USA','Africa & ME','SEA','ID')
update FOC_Summary set Currency='AUD' where Organ in ('Oceania')
update FOC_Summary set Currency='EUR' where Organ in ('Europe')
update FOC_Summary set Currency='BRL' where Organ in ('Brazil')
update FOC_Summary set Currency='IND' where Organ in ('India')


--Currency Conversion


Truncate table FOC_Currency_Conversion
insert into FOC_Currency_Conversion(Date1,Currency,BCUR,CCUR,STDT,RATE,DaysDiff,Rnk)
--select * into FOC_Currency_Conversion from (
select Date1,Currency,BCUR,CCUR,STDT,RATE,DaysDiff,Rnk 
from (select *,datediff(dd,STDT,Date1) as DaysDiff,
row_number() over (partition by Currency,Date1 order by datediff(dd,STDT,Date1)) as Rnk 
from (select distinct Date1,Currency from FOC_Summary
where currency in ('DHI','AUD','IDR','MYR','BRL','USD','EUR')
)a
left outer join 
(select CCUR,BCUR,RTYP,convert(date,STDT) STDT,max(RATE) RATE 
from [ELGi_LN].dbo.TTCMCS008ALL 
where ccur in ('DHI','AUD','IDR','MYR','BRL','USD','EUR')
and bcur in ('IND','INR')
and RATE<>1
--and convert(date,stdt)='2024-01-08'
group by CCUR,BCUR,RTYP,convert(date,STDT)
)b
on a.currency=b.ccur
and a.Date1>=b.STDT
)a
where Rnk=1
--)a



--insert into FOC_Currency_Conversion(Invoice_Date,Currency,BCUR,CCUR,STDT,RATE,DaysDiff,Rnk)
----select * into FOC_Currency_Conversion from (
--select Invoice_Date,Currency,CCUR,BCUR,STDT,RATE,DaysDiff,Rnk 
--from (select *,datediff(dd,STDT,Invoice_Date) as DaysDiff,
--row_number() over (partition by Currency,Invoice_Date order by datediff(dd,STDT,Invoice_Date)) as Rnk 
--from (select distinct Invoice_Date,Currency from FOC_Summary
--where currency in ('EUR')
--)a
--left outer join 
--(select CCUR,BCUR,RTYP,convert(date,STDT) STDT,max(RATE) RATE 
--from [ELGi_LN].dbo.TTCMCS008ALL 
--where bcur in ('EUR')
--and ccur in ('IND','INR')
--and RATE<>1
----and convert(date,stdt)='2024-01-08'
--group by CCUR,BCUR,RTYP,convert(date,STDT)
--)b
--on a.currency=b.bcur
--and a.Invoice_Date>=b.STDT
--)a
--where Rnk=1
----)a

--select CCUR,BCUR,RTYP,convert(date,STDT) STDT,max(RATE) RATE 
--from [ELGi_LN].dbo.TTCMCS008ALL 
--where bcur in ('EUR')
--and ccur in ('IND','INR')
--and RATE<>1
----and convert(date,stdt)='2024-01-08'
--group by CCUR,BCUR,RTYP,convert(date,STDT)


--select CCUR,BCUR,RTYP,convert(date,STDT) STDT,max(RATE) RATE 
--from [ELGi_LN].dbo.TTCMCS008ALL 
--where ccur in ('USD')
--and bcur in ('IND','INR')
--and RATE<>1
----and convert(date,stdt)='2024-01-08'
--group by CCUR,BCUR,RTYP,convert(date,STDT)


--Alter table FOC_Summary add INR_Conv_Rate float
--Alter table FOC_Summary add MC_Value2_INR float

update FOC_Summary set INR_Conv_Rate=1 where Currency='IND'


update FOC_Summary set INR_Conv_Rate=a.RATE
from (select * from FOC_Currency_Conversion)a
where FOC_Summary.Currency=a.Currency
and FOC_Summary.Date1=a.Date1

update FOC_Summary set MC_Value2_INR=MC_Value2 * INR_Conv_Rate

end

--Select * from FOC_Currency_Conversion
Select * from FOC_Summary
where elgi_focnumber in (
'26519Q002'
--'FOC-00039871'
--'26419P833','26519P720'
)

--Select distinct currency,INR_Conv_Rate from FOC_Summary
--where INR_Conv_Rate is null

--Select distinct currency,invoice_date,INR_Conv_Rate from FOC_Summary
--order by currency,invoice_date

GO

