CREATE view [dbo].[vw_sls_ATS_DPSTwise] as
select 
--date,
dpst,b.dpstname,b.division,
SUM(CASE WHEN a.Invoice_Date BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 2 else year(getdate()-1)-1 end ))  
AND 
'03/31/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1)-1 else year(getdate()-1) end ))
THEN (a.Sales_amount) / 1000000 ELSE 0 END) AS last_year_sale,

sum(case when a.Invoice_Date between 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 2 else year(getdate()-1)-1 end )) 
and  
dateadd(yy,-1,dateadd(dd,-1,convert(date,getdate())))
then (a.Sales_amount)/1000000 else 0 end)as last_year_ytd,

sum(case when a.Invoice_Date between 
convert(datetime,convert(varchar,datepart(mm,dateadd(yy,-1,dateadd(dd,-1,convert(date,getdate()))))) + '/1/' + datename(yy,dateadd(yy,-1,dateadd(dd,-1,convert(date,getdate()))))) 
and 
dateadd(dd,-1,dateadd(mm,1,convert(datetime,convert(varchar,datepart(mm,dateadd(yy,-1,dateadd(dd,-1,convert(date,getdate()))))) + '/1/' + datename(yy,dateadd(yy,-1,dateadd(dd,-1,convert(date,getdate()))))))) 
then (a.Sales_amount)/1000000 else 0 end)as last_year_this_month_sale,

sum(case when a.Invoice_Date between 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
and  
dateadd(dd,-1,convert(date,getdate())) then (a.Sales_amount)/1000000 else 0 end)as this_year_ytd,

sum(case when a.Invoice_Date between  
dateadd(mm,-1,convert(varchar,datepart(mm,dateadd(dd,-1,convert(date,getdate())))) + '/1/' + datename(yy,dateadd(dd,-1,convert(date,getdate())))) 
and 
dateadd(dd,-1,convert(varchar,datepart(mm,dateadd(dd,-1,convert(date,getdate())))) + '/1/' + datename(yy,dateadd(dd,-1,convert(date,getdate())))) 
then (a.Sales_amount)/1000000 else 0 end)as last_month_sale,

SUM(CASE WHEN a.Invoice_Date BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND 
dateadd(dd,- 1, CONVERT(varchar, datepart(mm, dateadd(dd, - 1, convert(date,getdate())))) + '/1/' + datename(yy, dateadd(dd, - 1, convert(date,getdate())))) 
THEN (a.Sales_amount)/ 1000000 ELSE 0 END) AS last_month_ytd_sale,

sum(case when a.Invoice_Date between  
convert(varchar,datepart(mm,dateadd(dd,-1,convert(date,getdate())))) + '/1/' + datename(yy,dateadd(dd,-1,convert(date,getdate()))) 
and  
dateadd(dd,-1,convert(date,getdate())) 
then (a.Sales_amount)/1000000 else 0 end)as this_month_sale,

sum(case when a.Invoice_Date between  
dateadd(dd,-1,convert(date,getdate())) 
and 
dateadd(dd,-1,convert(date,getdate())) 
then (a.Sales_amount)/1000000 else 0 end)as last_day_sale

from ATS_Sales_Details a
inner  join (select * from DPST_Master_ATS) b 
on  a.dpst = b.dpstcode
where a.Invoice_Date between '04/01/2016' and  dateadd(dd,-1,convert(date,getdate())) 
and concat(a.Company,a.SaleOrderType) not in (select concat(company,saleordertype) from SaleType_Master_ats where Sales_Category in (1))
--and ltrim(rtrim(a.Item))<>'FRT'
group by 
--date,
dpst,b.DPSTName,b.division

GO

