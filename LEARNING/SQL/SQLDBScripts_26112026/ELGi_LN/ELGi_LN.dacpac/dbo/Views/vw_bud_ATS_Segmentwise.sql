CREATE view [dbo].[vw_bud_ATS_Segmentwise]
as

select Segment,ordering,
sum(case when convert(datetime,bud_date) between 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 2 else year(getdate()-1)-1 end )) 
and  
dateadd(yy,-1,dateadd(dd,-1,convert(date,getdate()))) 
then budget else 0 end)as last_year_ytd_bud,

sum(case when convert(datetime,bud_date) between 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
and  
dateadd(dd,-1,convert(date,getdate())) 
then budget else 0 end) as this_year_ytd_bud,

sum(case when convert(datetime,bud_date) between 
dateadd(mm,-1,convert(varchar,datepart(mm,dateadd(dd,-1,convert(date,getdate())))) + '/1/' + datename(yy,dateadd(dd,-1,convert(date,getdate())))) 
and 
dateadd(dd,-1,convert(varchar,datepart(mm,dateadd(dd,-1,convert(date,getdate())))) + '/1/' + datename(yy,dateadd(dd,-1,convert(date,getdate())))) 
then budget else 0 end)as last_month_bud,

sum(case when convert(datetime,bud_date) between 
convert(varchar,datepart(mm,dateadd(dd,-1,convert(date,getdate())))) + '/1/' + datename(yy,dateadd(dd,-1,convert(date,getdate()))) 
and  
dateadd(dd,-1,convert(date,getdate())) 
then  budget else 0 end)as this_month_bud,

sum(case when month(bud_date) = datepart(mm,dateadd(mm,1,dateadd(dd,-1,convert(date,getdate())))) and bud_date > dateadd(dd,-1,convert(date,getdate())) then budget else 0 end)as next_month_budget,
sum(case when month(bud_date) = datepart(mm,dateadd(mm,2,dateadd(dd,-1,convert(date,getdate())))) and bud_date > dateadd(dd,-1,convert(date,getdate())) then budget else 0 end)as nextof_next_month_budget

from ATS_Budget_Master_Segmentwise 
group by Segment,ordering

GO

