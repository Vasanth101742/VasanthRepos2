--select * from vw_sls_ATS

CREATE view [dbo].[vw_sls_ATS]
as 


SELECT SalesType,productgroup,
SUM(last_year_ytd) last_year_ytd,
SUM(last_year_this_month_sale) last_year_this_month_sale,
SUM(this_year_ytd) this_year_ytd,
SUM(last_month_sale) last_month_sale,
SUM(this_month_sale) this_month_sale,
SUM(last_day_sale) last_day_sale,
SUM(last_year_day_sale) last_year_day_sale

FROM (
select 
SalesType,
case when SalesType='International Sales' then 'International'
WHEN productgroups='SPTC' then 'TYRE INFLATORS'
else ltrim(rtrim(upper(productgroups))) end as productgroup,  
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


from 
(
select 
case 
when c.productgroups in ('SCRAP','PVD SALES','SS1/CCN','SUPPLIER SALES','SPECIAL PRODUCTS') then 'OTHER Sales'
WHEN c.productgroups in('SERVICE BILLING', 'SPARES / ACCESSORIES','Consumables', 'TOOLS SPARES') then 'After Sales'
ELSE 'Domestic Sales'
END as SalesType,
c.productgroups,a.dpst,a.Item,Invoice_Date,sum(a.Sales_amount) Sales_amount from ATS_Sales_Details a  
inner  join  (select DPSTcode from DPST_Master_ATS where description<>'Exports') b 
on ltrim(rtrim(a.dpst)) =ltrim(rtrim(b.DPSTcode))  
left outer join ATS_prd_master c 
on ltrim(rtrim(a.item)) =ltrim(rtrim(c.item))  

where 
dpst not in (--'90043',
'90046','90047','90049','90053')  
and Invoice_Date between '04/01/2016' and  dateadd(dd,-1,convert(date,getdate()))
AND a.SaleOrderType in (select SaleOrderType from SaleType_Master_ats where Sales_Category in (0,2,5,6))
group by c.productgroups,a.dpst,a.Item,Invoice_Date


union

select 'International Sales' as SalesType,c.productgroups,a.dpst,a.Item,Invoice_Date,sum(a.Sales_amount) Sales_amount from ATS_Sales_Details a  
inner  join  (select DPSTcode from DPST_Master_ATS where description='Exports') b 
on ltrim(rtrim(a.dpst)) =ltrim(rtrim(b.DPSTcode))  
left outer join ATS_prd_master c 
on ltrim(rtrim(a.item)) =ltrim(rtrim(c.item))  

where Invoice_Date between '04/01/2016' and dateadd(dd,-1,convert(date,getdate()))
AND a.SaleOrderType in (select SaleOrderType from SaleType_Master_ats where Sales_Category in (0,2,5,6))
group by c.productgroups,a.dpst,a.Item,Invoice_Date




union

select case 
when b.productgroups in ('SCRAP','PVD SALES','SS1/CCN','SUPPLIER SALES','SPECIAL PRODUCTS') then 'OTHER Sales'
WHEN b.productgroups in('SERVICE BILLING', 'SPARES / ACCESSORIES','Consumables' ,'TOOLS SPARES') then 'After Sales'
ELSE 'Domestic Sales'
END as SalesType,

b.productgroups,a.dpst,a.Item,Invoice_Date,sum(a.Sales_amount) Sales_amount from ATS_Sales_Details a  
inner join (
select 90047 as dpstcode,'COMMERCIAL VEHICLE (TRADED)' as productgroups   
union all  
select 90046,'COMMERCIAL VEHICLE(MFG)'  
union all  
select 90049,'SUPPLIER SALES'  
--union all  
--select 90053,'AUTO`SSURE'  
)b
on ltrim(rtrim(a.dpst)) =ltrim(rtrim(b.DPSTcode))  
where Invoice_Date between '04/01/2016' and  dateadd(dd,-1,convert(date,getdate()))
AND a.SaleOrderType in (select SaleOrderType from SaleType_Master_ats where Sales_Category in (0,2,5,6))
group by b.productgroups,a.dpst,a.Item,Invoice_Date


)a
group by SalesType,productgroups  
)B
GROUP BY SalesType,productgroup

GO

