--select * from vw_sls_Domestic_DPSTwise

CREATE view [dbo].[vw_sls_Domestic_DPSTwise] as   


select a.* ,
b.Inflow,b.Ondate_Inflow,YTD_INFLOW,n1_month_inflow,n2_month_inflow,n3_month_inflow,INFLOW_Opening,
case when row_number() over(partition by a.description order by a.description) =1 then c.Sales_Plan else 0 end as Sales_Plan
from (
SELECT	c.Description, c.DPSTcode,c.dpstname,

sum(CASE WHEN day(a.invoice_date)=day(getdate()-1)and month(a.invoice_date)=month(getdate()-1)
and year(a.invoice_date)=year(getdate()-1)THEN (a.Sales_amount) / 1000000 ELSE 0 END) AS ondate_sale,

SUM(CASE WHEN a.invoice_date BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 2 else year(getdate()-1)-1 end )) 
AND
'03/31/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1)-1 else year(getdate()-1) end ))
THEN (a.Sales_amount) / 1000000 ELSE 0 END) AS last_year_sale, 


SUM(CASE WHEN a.invoice_date BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 2 else year(getdate()-1)-1 end )) 
AND
convert(varchar ,dateadd(yy, - 1, dateadd(dd, - 1, getdate())),101) 
THEN (a.Sales_amount) / 1000000 ELSE 0 END) AS last_year_ytd, 


SUM(CASE WHEN a.invoice_date BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND 
getdate() --enable it only on Monthend date
--dateadd(dd, - 1, getdate())  --disable it only on Monthend date
THEN (a.Sales_amount) / 1000000 ELSE 0 END) AS this_year_sale, 


SUM(CASE WHEN a.invoice_date BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 4 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND 
convert(varchar,dateadd(dd, - 1, CONVERT(varchar, datepart(mm, dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate()))),101) 
THEN (a.Sales_amount)/ 1000000 ELSE 0 END) AS last_month_sale,


SUM(CASE WHEN a.invoice_date BETWEEN 
CONVERT(varchar, datepart(mm, dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())) 
AND 
getdate() --enable it only on Monthend date
--dateadd(dd, - 1, getdate())  --disable it only on Monthend date
THEN (a.Sales_amount) / 1000000 ELSE 0 END) AS this_month_sale,


SUM(CASE WHEN a.invoice_date BETWEEN  
dateadd(mm, - 3, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())))   
AND 
dateadd(dd, - 1, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate()))) 
THEN (a.Sales_amount) / 1000000 ELSE 0 END) AS thr_month_sale,


SUM(CASE WHEN a.invoice_date BETWEEN  
dateadd(mm, - 1, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())))    
AND 
dateadd(dd, - 1, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate()))) 
THEN (a.Sales_amount) / 1000000 ELSE 0 END)AS n1_month_sale,


SUM(CASE WHEN a.invoice_date BETWEEN  
dateadd(mm, - 2, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())))   
AND 
dateadd(dd,-1,dateadd(mm, - 1, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())))) 
THEN (a.Sales_amount) / 1000000 ELSE 0 END)AS n2_month_sale,


SUM(CASE WHEN a.invoice_date BETWEEN  
dateadd(mm, - 3, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())))   
AND 
dateadd(dd,-1,dateadd(mm, - 2, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())))) 
THEN (a.Sales_amount) / 1000000 ELSE 0 END)AS n3_month_sale,

sum(case when a.invoice_date between 
convert(datetime,convert(varchar,datepart(mm,dateadd(yy,-1,dateadd(dd,-1,getdate())))) + '/1/' + datename(yy,dateadd(yy,-1,dateadd(dd,-1,getdate())))) 
and 
dateadd(yy,-1,dateadd(dd,-1,convert(date,getdate()))) 
then (a.Sales_amount)/1000000 else 0 end)as last_year_this_month_sale  



FROM 	
ELGi_Sales_Details a 
left JOIN vw_AREA_MASTER b
ON b.AreaCode = a.areacode
left JOIN vw_DPST_MASTER c 
ON c.DpstCode = a.Dpst  


WHERE	(c.Description IN ('Compressor-RLY','After Sales', 'Compressor-WW','Compressor-C&M', 'Compressor-Channel', 'Compressor-Direct')) 
AND (a.Invoice_Date BETWEEN '04/01/2015' AND GETDATE()) 
--AND a.SaleOrderType in 
--(
--select SaleOrderType from SaleType_Master where Sales_Category in (0,2,5,6)
--union all
--select '' as SaleOrderType from SaleType_Master
--)
and a.sales_category not in (1)


GROUP BY c.Description,c.DPSTName,c.DPSTcode


)a
--	--Newly added on 18 Dec 2017

left outer join 
(
select Dpst,
--sum(sales) as Inflow
 SUM(CASE WHEN OrderDate  BETWEEN CONVERT(varchar, datepart(mm, dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())) 
AND getdate()-1 THEN (sales) ELSE 0 END) AS Inflow,

SUM(CASE WHEN convert(date,OrderDate) =convert(date,getdate()-1) THEN (sales/1000000) ELSE 0 END) AS Ondate_Inflow,

SUM(CASE WHEN OrderDate  BETWEEN '04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND getdate()-1  THEN (sales)/1000000  ELSE 0 END) AS YTD_INFLOW,

SUM(CASE WHEN OrderDate  BETWEEN '04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND (dateadd(dd,- day(getdate()),convert(date,getdate())))  THEN (sales)/1000000  ELSE 0 END) AS INFLOW_Opening,

SUM(CASE WHEN OrderDate  BETWEEN  
dateadd(mm, - 1, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())))    
AND 
dateadd(dd, - 1, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate()))) 
THEN (sales) / 1000000 ELSE 0 END)AS n1_month_inflow,

SUM(CASE WHEN OrderDate BETWEEN  
dateadd(mm, - 2, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())))   
AND 
dateadd(dd,-1,dateadd(mm, - 1, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) +'/1/' + datename(yy, dateadd(dd, - 1, getdate())))) 
THEN (sales) / 1000000 ELSE 0 END)AS n2_month_inflow,

SUM(CASE WHEN OrderDate BETWEEN  
dateadd(mm, - 3, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())))   
AND 
dateadd(dd,-1,dateadd(mm, - 2, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) +'/1/' + datename(yy, dateadd(dd, - 1, getdate())))) 
THEN (sales) / 1000000 ELSE 0 END)AS n3_month_inflow 

	from Sales_Inflow where organ='India'
and concat(company,ordertype) in (select concat(company,saleordertype) from saletype_master where Sales_Category not in (1) ) 
--and month(OrderDate)=month(getdate()-1) and year(OrderDate)=year(getdate()-1)
group by Dpst
)b
on a.DPSTcode=b.Dpst


left outer join (select Vertical1,Cal_Month,cal_year,sum([plan]) as Sales_Plan from ISAAME_SALES_PLAN 
where Cal_Month=month(getdate()-1) and cal_year=year(getdate()-1)
and organ1='India'
group by Vertical1,Cal_Month,cal_year
)c
on a.Description=c.Vertical1
--where a.DPSTcode in ('90082','90083')

GO

