CREATE view [dbo].[vw_bud_Global_Foreign_Currency] as     

SELECT	Global,organ,region,Zone,user_names,Division,Vertical1,Area,AreaName,Dpst,DPSTName,
	SUM(budget_year) AS budget_year, 
	SUM(last_month_budget) AS last_month_budget, 
	SUM(ytd_budget) AS ytd_budget,     
	SUM(this_month_budget) AS this_month_budget, 
	SUM(next_month_budget) AS next_month_budget, 
	SUM(nextof_next_month_budget) AS nextof_next_month_budget    

FROM (

SELECT	ltrim(rtrim(b.Global)) Global,
case when ltrim(rtrim(isnull(a.organ,c.organ)))='ISAAME' then 'SAAME' else ltrim(rtrim(isnull(a.organ,c.organ))) end as organ,
ltrim(rtrim(c.region)) region,
ltrim(rtrim(c.Zone)) Zone,
ltrim(rtrim(c.user_names)) user_names,
ltrim(rtrim(c.Division)) as Division,
ltrim(rtrim(c.Vertical1)) as Vertical1,
a.Area,ltrim(rtrim(c.areaname)) areaname,c.DPSTCode as dpst,c.DPSTName,

SUM(CASE WHEN date BETWEEN 
('04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end ))) 
AND 
('03/31/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) else year(getdate()-1)+1 end )))
THEN (Budget_Foreign_Currency) ELSE 0 END) AS budget_year,  

SUM(CASE WHEN date BETWEEN 
('04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 4 then year(getdate()-1) - 1 else year(getdate()-1) end ))) 
AND 
convert(varchar,dateadd(dd, - 1, CONVERT(varchar, datepart(mm, dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate()))),101) 
THEN (Budget_Foreign_Currency) ELSE 0 END) AS last_month_budget,  

SUM(CASE WHEN date BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND 
dateadd(dd, - 1, getdate()) 
THEN (Budget_Foreign_Currency) ELSE 0 END) AS ytd_budget, 

SUM(CASE WHEN date BETWEEN 
CONVERT(varchar, datepart(mm, dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1,getdate())) 
AND 
convert(varchar,dateadd(dd, - 1, getdate()),101) 
THEN (Budget_Foreign_Currency) ELSE 0 END) AS this_month_budget, 

SUM(CASE WHEN month(date)= datepart(mm, dateadd(mm, 1, dateadd(dd, - 1, getdate()))) AND 
year(date) = datepart(yy, dateadd(mm, 1, dateadd(dd, - 1, getdate()))) 
THEN (Budget_Foreign_Currency) ELSE 0 END) AS next_month_budget,     

SUM(CASE WHEN month(date) = datepart(mm, dateadd(mm, 2, dateadd(dd, - 1,getdate()))) AND 
year(date) = datepart(yy, dateadd(mm, 2, dateadd(dd, - 1, getdate()))) 
THEN (Budget_Foreign_Currency) ELSE 0 END) AS nextof_next_month_budget

FROM	Sales_Budget a
	INNER JOIN vw_AREA_MASTER b
		ON ltrim(rtrim(b.AreaCode)) = ltrim(rtrim(a.Area))
	INNER JOIN vw_SALESMAPPING_MASTER c
		ON ltrim(rtrim(b.Areacode))=ltrim(rtrim(c.Areacode))    
		and ltrim(rtrim(a.Dpst)) = ltrim(rtrim(c.DPSTCode))

GROUP BY ltrim(rtrim(b.Global)),ltrim(rtrim(isnull(a.organ,c.organ))),
ltrim(rtrim(c.region)),ltrim(rtrim(c.Zone)),ltrim(rtrim(c.user_names)),ltrim(rtrim(c.Division)),ltrim(rtrim(c.Vertical1)),
a.Area,ltrim(rtrim(c.areaname)),c.DPSTCode,c.DPSTName
) AS budget    

GROUP BY Global,organ,region,Zone,user_names,Division,Vertical1,Area,AreaName,Dpst,DPSTName
HAVING      (SUM(budget_year) > 0) or (SUM(last_month_budget) > 0)

GO

