--select * from vw_inflow_ATS_new
CREATE view [dbo].[vw_inflow_ATS_new]
as

SELECT SalesType,productgroup,Dpst,Zone,
SUM(last_year_ytd_inflow) last_year_ytd_inflow,
SUM(last_year_this_month_inflow) last_year_this_month_inflow,
SUM(this_year_ytd_inflow) this_year_ytd_inflow,
SUM(last_month_inflow) last_month_inflow,
SUM(this_month_inflow) this_month_inflow,
SUM(last_day_inflow) last_day_inflow,
SUM(last_year_day_inflow) last_year_day_inflow

FROM (
select 
SalesType,Dpst,Zone,
case when SalesType='International Sales' then 'International'
WHEN productgroups='SPTC' then 'TYRE INFLATORS'
else ltrim(rtrim(upper(productgroups))) end as productgroup,  

sum(case when OrderDate between 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 2 else year(getdate()-1)-1 end )) 
and  
dateadd(yy,-1,dateadd(dd,-1,convert(date,getdate()))) 
then (a.sales)/1000000 else 0 end)as last_year_ytd_inflow,  


sum(case when OrderDate between 
convert(datetime,convert(varchar,datepart(mm,dateadd(yy,-1,dateadd(dd,-1,convert(date,getdate()))))) + '/1/' + datename(yy,dateadd(yy,-1,dateadd(dd,-1,convert(date,getdate()))))) 
and 
dateadd(yy,-1,dateadd(dd,-1,convert(date,getdate())))  
then (a.sales)/1000000 else 0 end)as last_year_this_month_inflow,  



sum(case when OrderDate between 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
and  
dateadd(dd,-1,convert(date,getdate())) 
then (a.sales)/1000000 else 0 end)as this_year_ytd_inflow,  

sum(case when OrderDate between  
dateadd(mm,-1,convert(varchar,datepart(mm,dateadd(dd,-1,convert(date,getdate())))) + '/1/' + datename(yy,dateadd(dd,-1,convert(date,getdate())))) 
and 
dateadd(dd,-1,convert(varchar,datepart(mm,dateadd(dd,-1,convert(date,getdate())))) + '/1/' + datename(yy,dateadd(dd,-1,convert(date,getdate())))) 
then (a.sales)/1000000 else 0 end)as last_month_inflow,  


sum(case when OrderDate between  
convert(varchar,datepart(mm,dateadd(dd,-1,convert(date,getdate())))) + '/1/' + datename(yy,dateadd(dd,-1,convert(date,getdate()))) 
and  
dateadd(dd,-1,convert(date,getdate())) 
then (a.sales)/1000000 else 0 end)as this_month_inflow, 


sum(case when OrderDate = dateadd(dd,-1,convert(date,getdate())) 
--and  dateadd(dd,-1,convert(date,getdate())) 
then (a.sales)/1000000 else 0 end)as last_day_inflow,  

sum(case when OrderDate between  
dateadd(yy,-1,dateadd(dd,-1,convert(date,getdate()))) 
and 
dateadd(yy,-1,dateadd(dd,-1,convert(date,getdate()))) 
then (a.sales)/1000000 else 0 end)as last_year_day_inflow  

from (

select 
case 
when c.productgroups in ('SCRAP','PVD SALES','SS1/CCN','SUPPLIER SALES','SPECIAL PRODUCTS') then 'OTHER Sales'
WHEN c.productgroups in('SERVICE BILLING', 'SPARES / ACCESSORIES', 'TOOLS SPARES','PAYU INCOME','TRAINING INCOME') then 'After Sales'
when c.ProductGroups is null then null
ELSE 'Domestic Sales'
END as SalesType,
c.productgroups,a.dpst,a.Zone,a.Itemcode,orderdate,sum(a.sales) Sales

from (select * from Sales_Inflow where company in (select company from ELGI_Companies_Master where CompanyGroup='ATS')) a
inner  join  (select DPSTcode from DPST_Master_ATS where description<>'Exports') b 
on ltrim(rtrim(a.dpst)) =ltrim(rtrim(b.DPSTcode))  
left outer join ATS_Prd_Master_New c 
on ltrim(rtrim(a.itemcode)) =ltrim(rtrim(c.item)) 
and a.Dpst=c.dpst 

where 
a.Dpst not in ('90049','90053')  
and ltrim(rtrim(a.ItemCode))<>'FRT'
and a.OrderDate between '04/01/2016' and  dateadd(dd,-1,getdate()) 
and concat(company,ordertype) not in (select concat(company,saleordertype) from SaleType_Master_ats where Sales_Category in (1))
group by productgroups,a.dpst,a.Zone,a.itemcode,orderdate  



union

select 'International Sales' as SalesType,c.productgroups,a.dpst,a.Zone,a.ItemCode,OrderDate,sum(a.sales) Sales
from (select * from Sales_Inflow where company in (select company from ELGI_Companies_Master where CompanyGroup='ATS')) a
inner  join  (select DPSTcode from DPST_Master_ATS where description='Exports') b 
on ltrim(rtrim(a.dpst)) =ltrim(rtrim(b.DPSTcode))  
left outer join ATS_Prd_Master_New c 
on ltrim(rtrim(a.itemcode)) =ltrim(rtrim(c.item))  
and a.Dpst=c.dpst 

where OrderDate between '04/01/2016' and  dateadd(dd,-1,convert(date,getdate()))
and concat(company,ordertype) not in (select concat(company,saleordertype) from SaleType_Master_ats where Sales_Category in (1))
group by c.productgroups,a.dpst,a.Zone,a.ItemCode,a.OrderDate

union

select case 
when b.productgroups in ('SCRAP','PVD SALES','SS1/CCN','SUPPLIER SALES','SPECIAL PRODUCTS') then 'OTHER Sales'
WHEN b.productgroups in('SERVICE BILLING', 'SPARES / ACCESSORIES', 'TOOLS SPARES') then 'After Sales'
ELSE 'Domestic Sales'
END as SalesType,
b.productgroups,a.dpst,a.Zone,a.ItemCode,OrderDate,sum(a.Sales) Sales
from (select * from Sales_Inflow where company in (select company from ELGI_Companies_Master where CompanyGroup='ATS')) a
inner join (
--select 90047 as dpstcode,'COMMERCIAL VEHICLE (TRADED)' as productgroups   
--union all  
--select 90046  as dpstcode,'COMMERCIAL VEHICLE(MFG)'  as productgroups
--union all  
select 90049  as dpstcode,'SUPPLIER SALES'  as productgroups 
union all  
select 90043  as dpstcode,'SERVICE BILLING'  as productgroups
)b
on ltrim(rtrim(a.dpst)) =ltrim(rtrim(b.DPSTcode))  
where OrderDate between '04/01/2016' and  dateadd(dd,-1,convert(date,getdate()))
and concat(company,ordertype) not in (select concat(company,saleordertype) from SaleType_Master_ats where Sales_Category in (1))

group by b.productgroups,a.dpst,a.Zone,a.ItemCode,OrderDate



----FRT Sales
union
select 'FRT Sales' as SalesType,'FRT' as productgroups,a.dpst,a.Zone,a.ItemCode,OrderDate,sum(a.sales) Sales
from (select * from Sales_Inflow where company in (select company from ELGI_Companies_Master where CompanyGroup='ATS')) a
--inner  join  (select DPSTcode from DPST_Master_ATS where description='Exports') b 
--on ltrim(rtrim(a.dpst)) =ltrim(rtrim(b.DPSTcode))  
left outer join ATS_Prd_Master_New c 
on ltrim(rtrim(a.itemcode)) =ltrim(rtrim(c.item))  
and a.Dpst=c.dpst 

where OrderDate between '04/01/2016' and  dateadd(dd,-1,convert(date,getdate()))
--and concat(company,ordertype) in (select concat(company,saleordertype) from SaleType_Master_ats where Sales_Category in (1))
and ltrim(rtrim(a.ItemCode))='FRT'
group by c.productgroups,a.dpst,a.Zone,a.ItemCode,a.OrderDate




)a
group by SalesType,productgroups,Dpst,Zone
)B
GROUP BY SalesType,productgroup,Dpst,Zone

GO

