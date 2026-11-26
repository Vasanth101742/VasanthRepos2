CREATE view [dbo].[vw_bud_SEA] as     

SELECT	Organ,Areacode,CustCode,CustName,Vertical,
	SUM(budget_year) AS budget_year, 
	SUM(last_month_budget) AS last_month_budget, 
	SUM(ytd_budget) AS ytd_budget,     
	SUM(this_month_budget) AS this_month_budget, 
	SUM(next_month_budget) AS next_month_budget, 
	SUM(nextof_next_month_budget) AS nextof_next_month_budget    

FROM (

SELECT	Organ,Areacode,CustCode,CustName,Vertical,

SUM(CASE WHEN BudDate BETWEEN 
('04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end ))) 
AND 
('03/31/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) else year(getdate()-1)+1 end )))
THEN (Budget_USD) ELSE 0 END) AS budget_year,  

SUM(CASE WHEN BudDate BETWEEN 
('04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 4 then year(getdate()-1) - 1 else year(getdate()-1) end ))) 
AND 
convert(varchar,dateadd(dd, - 1, CONVERT(varchar, datepart(mm, dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate()))),101) 
THEN (Budget_USD) ELSE 0 END) AS last_month_budget,  

SUM(CASE WHEN BudDate BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND 
dateadd(dd, - 1, getdate()) 
THEN (Budget_USD) ELSE 0 END) AS ytd_budget, 

SUM(CASE WHEN BudDate BETWEEN 
CONVERT(varchar, datepart(mm, dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1,getdate())) 
AND 
convert(varchar,dateadd(dd, - 1, getdate()),101) 
THEN (Budget_USD) ELSE 0 END) AS this_month_budget, 

SUM(CASE WHEN month(BudDate)= datepart(mm, dateadd(mm, 1, dateadd(dd, - 1, getdate()))) AND 
year(BudDate) = datepart(yy, dateadd(mm, 1, dateadd(dd, - 1, getdate()))) 
THEN (Budget_USD) ELSE 0 END) AS next_month_budget,     

SUM(CASE WHEN month(BudDate) = datepart(mm, dateadd(mm, 2, dateadd(dd, - 1,getdate()))) AND 
year(BudDate) = datepart(yy, dateadd(mm, 2, dateadd(dd, - 1, getdate()))) 
THEN (Budget_USD) ELSE 0 END) AS nextof_next_month_budget

FROM	SalesBudgetMaster_SEA a
group by Organ,Areacode,CustCode,CustName,Vertical
) AS budget    

GROUP BY Organ,Areacode,CustCode,CustName,Vertical
HAVING      (SUM(budget_year) > 0) or (SUM(last_month_budget) > 0)

GO

