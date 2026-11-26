--exec sp_AM_Industrials_Performance
CREATE Procedure sp_AM_Industrials_Performance as
begin

Truncate Table AM_Industrials_Performance

Insert into AM_Industrials_Performance(ProductGroup,SubGroup,DPST,GSC_HO,
last_year_sales,last_year_ytd_sales,this_year_sales,last_year_ytd_Inflow,
ytd_inflow,this_year_budget,ytd_budget)
--select * into AM_Industrials_Performance from (
select a.ProductGroup,a.SubGroup,a.DPST,a.GSC_HO,
--coalesce(b.dpstname,c.dpstname,d.product) as dpstname,
b.last_year_sales,b.last_year_ytd_sales,b.this_year_sales,
c.last_year_ytd_Inflow,c.ytd_inflow,
d.this_year_budget,d.ytd_budget
from 
(select * from  AM_Industrials_Master)a
left outer join
(select dpst,dpstname,
SUM(CASE WHEN invoice_date BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 2 else year(getdate()-1)-1 end )) 
AND
'03/31/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1)-1 else year(getdate()-1) end ))
THEN (Sales_amount) / 1000000 ELSE 0 END) AS last_year_sales, 

SUM(CASE WHEN invoice_date BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 2 else year(getdate()-1)-1 end )) 
AND
convert(varchar ,dateadd(yy, - 1, dateadd(dd, - 1, getdate())),101) 
THEN (Sales_amount) / 1000000 ELSE 0 END) AS last_year_ytd_sales,

SUM(CASE WHEN invoice_date BETWEEN '04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND getdate() --enable it only on Monthend date
--dateadd(dd, - 1, getdate())  --disable it only on Monthend date
THEN (Sales_amount) / 1000000 ELSE 0 END) AS this_year_sales


FROM ELGi_Sales_Details
where sales_category not in (1)
group by dpst,dpstname 
)b
on a.dpst=b.dpst
left outer join (
select Dpst,DpstName,

SUM(CASE WHEN OrderDate BETWEEN '04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 2 else year(getdate()-1)-1 end )) 
AND convert(varchar ,dateadd(yy, - 1, dateadd(dd, - 1, getdate())),101) 
THEN (sales) / 1000000 ELSE 0 END) AS last_year_ytd_Inflow,

SUM(CASE WHEN OrderDate  BETWEEN '04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND getdate()-1  THEN (sales)/1000000  ELSE 0 END) AS ytd_inflow


from Sales_Inflow where organ='India'
and concat(company,ordertype) in (select concat(company,saleordertype) from saletype_master where Sales_Category not in (1) ) 
group by Dpst,DpstName
)c
on a.dpst=c.dpst
left outer join 
(select dpst,product,
sum(budget) as this_year_budget,
SUM(CASE WHEN [cal Month]<=month(getdate()-1) THEN budget ELSE 0 END) AS ytd_budget
from India_Regionwise_budget where zone in('north','east','west','south','Oil Royalty','India')
and [Fin year]=(select max([Fin year]) from India_Regionwise_budget)
group by dpst,product
)d
on a.DPST=d.dpst
--)a

end

select * from AM_Industrials_Performance

GO

