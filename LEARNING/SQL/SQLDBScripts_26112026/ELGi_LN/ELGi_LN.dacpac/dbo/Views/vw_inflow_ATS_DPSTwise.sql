CREATE view [dbo].[vw_inflow_ATS_DPSTwise]
as

select 
--company,date,
dpst,a.dpstname,b.division,

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


sum(case when OrderDate between  
dateadd(dd,-1,convert(date,getdate())) 
and  
dateadd(dd,-1,convert(date,getdate())) 
then (a.sales)/1000000 else 0 end)as last_day_inflow,  

sum(case when OrderDate between  
dateadd(yy,-1,dateadd(dd,-1,convert(date,getdate()))) 
and 
dateadd(yy,-1,dateadd(dd,-1,convert(date,getdate()))) 
then (a.sales)/1000000 else 0 end)as last_year_day_inflow  

from (select * from Sales_Inflow where company in (select company from ELGI_Companies_Master where CompanyGroup='ATS')) a

inner  join DPST_Master_ATS b 
on  a.dpst = b.dpstcode
where a.orderdate between '04/01/2016' and  dateadd(dd,-1,getdate()) 
and concat(a.Company,a.ordertype) not in (select concat(company,saleordertype) from SaleType_Master_ats where Sales_Category in (1))

group by 
--company,date,
dpst,a.DpstName,b.division



--union all
--select 
----0,0,
--dpstcode,dpstname,division,0,0,0,0,0,0,0,0 from vw_DPST_MASTER where description  ='ATS' and  dpstcode not in (select distinct dpst from vw_Sales_Inflow)

GO

