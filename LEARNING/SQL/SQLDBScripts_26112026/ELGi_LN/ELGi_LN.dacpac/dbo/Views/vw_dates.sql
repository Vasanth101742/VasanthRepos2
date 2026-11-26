--select * from vw_dates

CREATE view [vw_dates]
as
select *,
substring(convert(varchar,fromdate),7,4)+'-'+substring(convert(varchar,todate),9,2) CurrentYear,
substring(convert(varchar,lyfromdate),7,4)+'-'+substring(convert(varchar,lytodate),9,2) LastYear

 from(
select convert(date,'04/01/' + convert(varchar,(select case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end as year))) as fromdate,
convert(date,'03/31/' + convert(varchar,(select case when month(getdate()-1) between 1 and 3 then year(getdate()-1) else year(getdate()-1)+1 end as year))) as todate,
convert(date,'04/01/' + convert(varchar,(select case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 2 else year(getdate()-1)-1 end as year))) as lyfromdate,
convert(date,'03/31/' + convert(varchar,(select case when month(getdate()-1) between 1 and 3 then year(getdate()-1)-1 else year(getdate()-1) end as year))) as lytodate,
convert(varchar,dateadd(mm, - 1, CONVERT(varchar, datepart(mm, dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate()))),101) as LastMonthFirstday,
convert(varchar,dateadd(dd, - 1, CONVERT(varchar, datepart(mm, dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate()))),101)  as LastMonthlastday,
convert(date,getdate()-1 ) as ondate,
datename(mm,dateadd(mm,month(getdate()-1),-1)) as CurMonthName,
upper(substring(datename(mm,dateadd(mm,month(getdate()-1),-1)),1,3))+'-'+substring(convert(varchar,year(getdate()-1)),3,2)  as CurMonthName2,
DATEADD(mm, DATEDIFF(m,0,GETDATE()-1),0) as CurMonthFirstDate,
eomonth(getdate()-1) as CurMonthLastDate

)a

GO

