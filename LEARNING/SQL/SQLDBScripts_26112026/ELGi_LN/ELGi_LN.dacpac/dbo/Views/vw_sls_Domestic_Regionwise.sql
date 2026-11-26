CREATE VIEW [dbo].[vw_sls_Domestic_Regionwise] as   

select *
--,case when row_number() over(partition by user_names order by user_names ) =1 then sp else 0 end as Sales_Plan
from (
SELECT coalesce(inf.zone,sls.zone) zone,
--coalesce(b.Areacode,sls.areacode,inf.areacode) as Areacode,b.AreaName, 
coalesce(d.Dpstcode,sls.dpst,inf.dpst) as Dpstcode ,d.dpstname,d.description,
ondate_sale,last_year_sale,last_year_ytd,this_year_sale,last_month_sale,last_year_this_month_sale,this_month_sale,
thr_month_sale,n1_month_sale,n2_month_sale,n3_month_sale,
inflow,Ondate_Inflow,YTD_INFLOW,last_month_inflow,last_month_inflow_Qty,Inflow_Qty,this_month_Sale_Qty,YTD_INFLOW_Qty,
n1_month_inflow,n2_month_inflow,n3_month_inflow,INFLOW_Opening
from vw_DPST_MASTER d


full outer join

(
select Dpst,Zone,--AreaCode,
SUM(CASE WHEN OrderDate  BETWEEN CONVERT(varchar, datepart(mm, dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())) 
AND getdate()-1 THEN (sales) ELSE 0 END) AS Inflow,

SUM(CASE WHEN convert(date,OrderDate) =convert(date,getdate()-1) THEN (sales/1000000) ELSE 0 END) AS Ondate_Inflow,

SUM(CASE WHEN OrderDate  BETWEEN '04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND getdate()-1  THEN (sales)/1000000  ELSE 0 END) AS YTD_INFLOW ,

SUM(CASE WHEN OrderDate  BETWEEN '04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND (dateadd(dd,- day(getdate()),convert(date,getdate())))  THEN (sales)/1000000  ELSE 0 END) AS INFLOW_Opening,


SUM(CASE WHEN OrderDate BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 4 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND 
dateadd(dd, - 1, CONVERT(varchar, datepart(mm, dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy,dateadd(dd, - 1, getdate()))) 
THEN (sales) / 1000000 ELSE 0 END) AS last_month_inflow,

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
THEN (sales) / 1000000 ELSE 0 END)AS n3_month_inflow,

SUM(CASE WHEN OrderDate BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 4 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND 
dateadd(dd, - 1, CONVERT(varchar, datepart(mm, dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy,dateadd(dd, - 1, getdate()))) 
THEN qty ELSE 0 END) AS last_month_inflow_Qty,

SUM(CASE WHEN OrderDate  BETWEEN CONVERT(varchar, datepart(mm, dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())) 
AND getdate()-1 
THEN qty ELSE 0 END) AS Inflow_Qty,


SUM(CASE WHEN OrderDate  BETWEEN '04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND getdate()-1  
THEN qty ELSE 0 END) AS YTD_INFLOW_Qty

from 
(select OrderDate,Dpst,Zone,sales,
case when concat(dpst,ltrim(rtrim(ItemCode))) in (select concat(dpst,ltrim(rtrim(TPL))) from India_Regionwise_Sales_TPL_Master) 
then qty else 0 end as qty
from Sales_Inflow 
where ltrim(rtrim(organ))='India' and 
concat(company,ordertype) not in (select concat(company,saleordertype) from saletype_master where Sales_Category in (1) ) 

)a
group by Dpst,Zone--,AreaCode
)inf
on d.DPSTcode=inf.Dpst


full outer join

(select dpst,Zone,--areacode,
sum(CASE WHEN day(a.invoice_date)=day(getdate()-1)and month(a.invoice_date)=month(getdate()-1)
and year(a.invoice_date)=year(getdate()-1)THEN (a.Sales_amount) / 1000000 ELSE 0 END) AS ondate_sale,

SUM(CASE WHEN a.Invoice_Date BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 2 else year(getdate()-1)-1 end )) 
AND 
'03/31/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1)-1 else year(getdate()-1) end ))
THEN (a.Sales_amount) / 1000000 ELSE 0 END) AS last_year_sale, 

SUM(CASE WHEN a.Invoice_Date BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 2 else year(getdate()-1)-1 end )) 
AND 
dateadd(yy, - 1, dateadd(dd, - 1, getdate())) 
THEN (a.Sales_amount) / 1000000 ELSE 0 END) AS last_year_ytd, 

SUM(CASE WHEN a.Invoice_Date BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND 
getdate() 
THEN (a.Sales_amount) / 1000000 ELSE 0 END) AS this_year_sale,   

SUM(CASE WHEN a.Invoice_Date BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 4 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND 
dateadd(dd, - 1, CONVERT(varchar, datepart(mm, dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy,dateadd(dd, - 1, getdate()))) 
THEN (a.Sales_amount) / 1000000 ELSE 0 END) AS last_month_sale,

SUM(CASE WHEN a.Invoice_Date BETWEEN 
 CONVERT(varchar, datepart(mm, dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy,dateadd(yy,-1, dateadd(dd, - 1, getdate()))) 
AND 
 dateadd(yy,-1,dateadd(dd, - 1, convert(date,getdate())))
THEN (a.Sales_amount) / 1000000 ELSE 0 END) AS last_year_this_month_sale,


SUM(CASE WHEN a.Invoice_Date BETWEEN 
CONVERT(varchar, datepart(mm, dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())) 
AND 
getdate() 
THEN (a.Sales_amount) / 1000000 ELSE 0 END) AS this_month_sale,

SUM(CASE WHEN a.Invoice_Date BETWEEN  
dateadd(mm, - 3, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())))   
AND 
dateadd(dd, - 1, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate()))) 
THEN (a.Sales_amount) / 1000000 ELSE 0 END)AS thr_month_sale,

SUM(CASE WHEN a.Invoice_Date BETWEEN  
dateadd(mm, - 1, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())))    
AND 
dateadd(dd, - 1, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate()))) 
THEN (a.Sales_amount) / 1000000 ELSE 0 END)AS n1_month_sale,

SUM(CASE WHEN a.Invoice_Date BETWEEN  
dateadd(mm, - 2, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())))   
AND 
dateadd(dd,-1,dateadd(mm, - 1, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) +'/1/' + datename(yy, dateadd(dd, - 1, getdate())))) 
THEN (a.Sales_amount) / 1000000 ELSE 0 END)AS n2_month_sale,

SUM(CASE WHEN a.Invoice_Date BETWEEN  
dateadd(mm, - 3, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())))   
AND 
dateadd(dd,-1,dateadd(mm, - 2, CONVERT(varchar, datepart(mm,dateadd(dd, - 1, getdate()))) +'/1/' + datename(yy, dateadd(dd, - 1, getdate())))) 
THEN (a.Sales_amount) / 1000000 ELSE 0 END)AS n3_month_sale,

SUM(CASE WHEN a.Invoice_Date BETWEEN 
CONVERT(varchar, datepart(mm, dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())) 
AND getdate() 
THEN DeliveryQty ELSE 0 END) AS this_month_Sale_Qty


FROM 	
(select Invoice_Date,dpst,Zone,Sales_amount,
case when concat(dpst,ltrim(rtrim(Item))) in (select concat(dpst,ltrim(rtrim(TPL))) from India_Regionwise_Sales_TPL_Master)
then DeliveryQty else 0 end as DeliveryQty
from ELGi_Sales_Details a 
WHERE	(Invoice_Date BETWEEN '04/01/2016' AND GETDATE()) 
and organ='India'
and sales_category not in (1)
AND areacode IS NOT NULL
)a
group by dpst,Zone--,areacode
)sls
on sls.dpst=d.DPSTCode
and sls.Zone=inf.Zone




--left outer join (select Vertical1,Cal_Month,cal_year,sum([plan]) as Sales_Plan from ISAAME_SALES_PLAN 
--where Cal_Month=month(getdate()-1) and cal_year=year(getdate()-1)
--and organ1='SAAME'
--group by Vertical1,Cal_Month,cal_year
--)Sls_plan
--on ltrim(rtrim(c.User_names))=ltrim(rtrim(Sls_plan.Vertical1))
----where c.User_names ='Africa-Spares'
)a

where concat(a.Dpstcode,Zone) in 
(select distinct concat(Dpst,Zone) from Sales_Inflow
union
select distinct concat(dpst,Zone) from ELGi_Sales_Details
)
and isnull(last_month_sale,0)+isnull(this_year_sale,0)<>0

GO

