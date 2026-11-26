--select * from vw_inflow_ATS_Segmentwise
CREATE view [dbo].[vw_inflow_ATS_Segmentwise]
as

select segment,Dpst,Zone,
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

from Sales_Inflow a
where company in (select company from ELGI_Companies_Master where CompanyGroup='ATS')
and concat(company,ordertype) not in (select concat(company,saleordertype) from SaleType_Master_ats where Sales_Category in (1))
and dpst in (select distinct dpstcode from ats_sales_performance where salestype='Domestic Sales')
--Commented on 3-Nov-2021 as Sales data missing due to delay in product group update..
--and concat(dpst,ltrim(rtrim(itemcode))) in (select distinct concat(dpst,ltrim(rtrim(item))) from ats_prd_master_new
--where productgroups is not null)



group by segment,Dpst,Zone

GO

