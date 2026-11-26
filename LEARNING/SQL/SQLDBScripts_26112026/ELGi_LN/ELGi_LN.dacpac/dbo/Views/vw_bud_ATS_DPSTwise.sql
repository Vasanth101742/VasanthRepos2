CREATE view [dbo].[vw_bud_ATS_DPSTwise]
as

select dpst,dpstname,division,
SUM(CASE WHEN date BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND 
'03/31/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) else year(getdate()-1)+1 end ))
THEN budget ELSE 0 END) AS budget_year, 

SUM(CASE WHEN date BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND 
dateadd(dd, - 1, CONVERT(varchar, datepart(mm, dateadd(dd, - 1, convert(date,getdate()))))+ '/1/' + datename(yy, dateadd(dd, - 1, convert(date,getdate())))) 
THEN budget ELSE 0 END) AS last_month_ytd_budget, 

sum(case when convert(datetime,date) between 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 2 else year(getdate()-1)-1 end )) 
and 
dateadd(yy,-1,dateadd(dd,-1,convert(date,getdate()))) 
then budget else 0 end)as last_year_ytd_bud,

sum(case when convert(datetime,date) between 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
and 
dateadd(dd,-1,convert(date,getdate())) 
then budget else 0 end)as this_year_ytd_bud,

sum(case when convert(datetime,date) between 
dateadd(mm,-1,convert(varchar,datepart(mm,dateadd(dd,-1,convert(date,getdate())))) + '/1/' + datename(yy,dateadd(dd,-1,convert(date,getdate())))) 
and 
dateadd(dd,-1,convert(varchar,datepart(mm,dateadd(dd,-1,convert(date,getdate())))) + '/1/' + datename(yy,dateadd(dd,-1,convert(date,getdate())))) 
then budget else 0 end)as last_month_bud,

sum(case when convert(datetime,date) between  
convert(varchar,datepart(mm,dateadd(dd,-1,convert(date,getdate())))) + '/1/' + datename(yy,dateadd(dd,-1,convert(date,getdate()))) 
and  
dateadd(dd,-1,convert(date,getdate())) 
then  budget else 0 end)as this_month_bud,

sum(case when month(date) = datepart(mm,dateadd(mm,1,dateadd(dd,-1,convert(date,getdate())))) and date > dateadd(dd,-1,convert(date,getdate())) then budget else 0 end)as next_month_budget,
sum(case when month(date) = datepart(mm,dateadd(mm,2,dateadd(dd,-1,convert(date,getdate())))) and date > dateadd(dd,-1,convert(date,getdate())) then budget else 0 end)as nextof_next_month_budget

from 
(select * from 
(select * from DPST_Master_ATS )a
inner join (select *,target as budget from DPSTwise_Budget_Master_ATS
where dpst in (select DPSTcode from DPST_Master_ATS)
) b
on  a.dpstcode =b.dpst 
)a
group by dpst,dpstname,division

GO

