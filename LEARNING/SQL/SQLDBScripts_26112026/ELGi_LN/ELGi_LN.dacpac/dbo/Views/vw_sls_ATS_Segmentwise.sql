CREATE view [dbo].[vw_sls_ATS_Segmentwise]
as 

select Segment,dpst,Zone,
sum(case when Invoice_Date between 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 2 else year(getdate()-1)-1 end )) 
and  
dateadd(yy,-1,dateadd(dd,-1,convert(date,getdate()))) 
then (a.Sales_amount)/1000000 else 0 end)as last_year_ytd,  

sum(case when Invoice_Date between 
convert(datetime,convert(varchar,datepart(mm,dateadd(yy,-1,dateadd(dd,-1,convert(date,getdate()))))) + '/1/' + datename(yy,dateadd(yy,-1,dateadd(dd,-1,convert(date,getdate()))))) 
and 
dateadd(yy,-1,dateadd(dd,-1,convert(date,getdate())))  
then (a.Sales_amount)/1000000 else 0 end)as last_year_this_month_sale,  

sum(case when Invoice_Date between 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
and  
dateadd(dd,-1,convert(date,getdate())) 
then (a.Sales_amount)/1000000 else 0 end)as this_year_ytd,  

sum(case when Invoice_Date between  
dateadd(mm,-1,convert(varchar,datepart(mm,dateadd(dd,-1,convert(date,getdate())))) + '/1/' + datename(yy,dateadd(dd,-1,convert(date,getdate())))) 
and 
dateadd(dd,-1,convert(varchar,datepart(mm,dateadd(dd,-1,convert(date,getdate())))) + '/1/' + datename(yy,dateadd(dd,-1,convert(date,getdate())))) 
then (a.Sales_amount)/1000000 else 0 end)as last_month_sale,  

sum(case when Invoice_Date between  
convert(varchar,datepart(mm,dateadd(dd,-1,convert(date,getdate())))) + '/1/' + datename(yy,dateadd(dd,-1,convert(date,getdate()))) 
and  
dateadd(dd,-1,convert(date,getdate())) 
then (a.Sales_amount)/1000000 else 0 end)as this_month_sale,  

sum(case when Invoice_Date between  
dateadd(dd,-1,convert(date,getdate())) 
and  
dateadd(dd,-1,convert(date,getdate())) 
then (a.Sales_amount)/1000000 else 0 end)as last_day_sale,  

sum(case when Invoice_Date between  
dateadd(yy,-1,dateadd(dd,-1,convert(date,getdate()))) 
and 
dateadd(yy,-1,dateadd(dd,-1,convert(date,getdate()))) 
then (a.Sales_amount)/1000000 else 0 end)as last_year_day_sale  

from ATS_Sales_Details a
--where  SaleOrderType not in (select SaleOrderType from saletype_master_ATS where Sales_Category in (1))
----concat(company,SaleOrderType) not in (select concat(company,saleordertype) from SaleType_Master_ats where Sales_Category in (1))
--and ltrim(rtrim(a.Item))<>'FRT'
--and dpst in (select dpstcode from ats_sales_performance where salestype='Domestic Sales')

where company in (select company from ELGI_Companies_Master where CompanyGroup='ATS')
and SaleOrderType not in (select SaleOrderType from saletype_master_ATS where Sales_Category in (1))
--and concat(company,SaleOrderType) not in (select concat(company,saleordertype) from SaleType_Master_ats where Sales_Category in (1))
and dpst in (select distinct dpstcode from ats_sales_performance where salestype='Domestic Sales')
and ltrim(rtrim(a.Item))<>'FRT'
--Commented on 3-Nov-2021 as Sales data missing due to delay in product group update..
--and concat(dpst,ltrim(rtrim(item))) in (select distinct concat(dpst,ltrim(rtrim(item))) from ats_prd_master_new
--where productgroups is not null)



group by Segment,dpst,Zone

GO

