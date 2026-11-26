CREATE view vw_bud_Vacuum_DPSTwise as   

select * from (  
SELECT Description,Dpst,dpstname, 
SUM(budget_year) AS budget_year, 
SUM(last_month_budget) AS last_month_budget, 
SUM(ytd_budget) AS ytd_budget,   
SUM(this_month_budget) AS this_month_budget, 
SUM(next_month_budget) AS next_month_budget, 
SUM(nextof_next_month_budget) AS nextof_next_month_budget  
FROM (

SELECT     

SUM(CASE WHEN date BETWEEN 
('04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end ))) 
AND 
('03/31/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) else year(getdate()-1)+1 end )))
THEN (target) / 1000000 ELSE 0 END) AS budget_year,   

SUM(CASE WHEN date BETWEEN 
('04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 4 then year(getdate()-1) - 1 else year(getdate()-1) end ))) 
AND 
convert(varchar,dateadd(dd, - 1, CONVERT(varchar, datepart(mm, dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate()))),101) 
THEN (target) / 1000000 ELSE 0 END) AS last_month_budget,   

SUM(CASE WHEN date BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND 
dateadd(dd, - 1, getdate()) 
THEN (target) / 1000000 ELSE 0 END) AS ytd_budget,   

SUM(CASE WHEN date BETWEEN 
CONVERT(varchar, datepart(mm, dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1,getdate())) 
AND 
convert(varchar,dateadd(dd, - 1, getdate()),101) 
THEN (target) / 1000000 ELSE 0 END) AS this_month_budget, 

SUM(CASE WHEN month(date)= datepart(mm, dateadd(mm, 1, dateadd(dd, - 1, getdate()))) AND 
year(date) = datepart(yy, dateadd(mm, 1, dateadd(dd, - 1, getdate()))) 
THEN (target) / 1000000 ELSE 0 END) AS next_month_budget, 

SUM(CASE WHEN month(date) = datepart(mm, dateadd(mm, 2, dateadd(dd, - 1,getdate()))) AND 
year(date) = datepart(yy, dateadd(mm, 2, dateadd(dd, - 1, getdate()))) 
THEN (target) / 1000000 ELSE 0 END) AS nextof_next_month_budget, 

b.Description,dpstname,a.Dpst

FROM dpstwise_budget a
 
INNER JOIN vw_DPST_MASTER b 
ON b.DpstCode = a.Dpst


WHERE ltrim(rtrim(b.Description)) IN ('VACUUM')
GROUP BY b.Description,dpstname,Dpst

) AS budget  
GROUP BY Description,dpstname,Dpst
)a  
where budget_year <> 0 or ( (last_month_budget) > 0)

GO

