--select distinct product_group from  ATS_Budget_Master
--select * from vw_bud_ats order by ordering

CREATE view [dbo].[vw_bud_ATS]
as


select 
case when SalesType='Domestic Sales' then 1
when SalesType='International Sales' then 2
when SalesType='After Sales' then 3
when SalesType='OTHER Sales' then 4 
end as SalesTypeOrdering,*
from(

select 
SalesType,productgroup,ordering,
sum(last_year_ytd_bud) last_year_ytd_bud,
sum(this_year_ytd_bud) this_year_ytd_bud,
sum(last_month_bud) last_month_bud,
sum(this_month_bud) this_month_bud,
sum(next_month_budget) next_month_budget,
sum(nextof_next_month_budget) nextof_next_month_budget

from (
select case 
when productgroup in ('SCRAP','PVD SALES','SS1/CCN','SUPPLIER SALES','SPECIAL PRODUCTS') then 'OTHER Sales'
WHEN productgroup in('SERVICE BILLING', 'SPARES / ACCESSORIES', 'TOOLS SPARES','PAYU INCOME','TRAINING INCOME') then 'After Sales'
WHEN productgroup in('FRT') then 'FRT Sales'
ELSE 'Domestic Sales'

END as SalesType,*

from (


select productgroup,ordering,
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

from 
(
select CASE 
WHEN ltrim(rtrim(upper(product_group)))='SPTC' then 'TYRE INFLATORS'
WHEN ltrim(rtrim(upper(product_group)))='CLMS PIPING SERVICE CHARGES' then 'SERVICE BILLING'
else ltrim(rtrim(upper(product_group))) end as productgroup,
case 
when ltrim(rtrim(upper(product_group)))='SPTC' then 4
WHEN ltrim(rtrim(upper(product_group)))='CLMS PIPING SERVICE CHARGES' then 12
else ordering end as ordering,bud_date,budget 
from ATS_Budget_Master
where ltrim(rtrim(upper(product_group))) not in 
('COMMERCIAL VEHICLE (TRADED)' ,'COMMERCIAL VEHICLE(MFG)','Auto`ssure')

)
ATS_Budget_Master
group by productgroup,ordering


union 
select 'SCRAP',101,0,0,0,0,0,0
union 
select 'SS1/CCN',102,0,0,0,0,0,0
union 
select 'SUPPLIER SALES',103,0,0,0,0,0,0


)a
)b
group by SalesType,productgroup,ordering
)c

GO

