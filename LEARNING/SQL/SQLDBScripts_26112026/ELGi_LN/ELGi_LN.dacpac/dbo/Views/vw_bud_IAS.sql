CREATE view  [dbo].[vw_bud_IAS]
as
select Vertical_ordr,Vertical,SubVertical,Slsofc_ordr,Slsofc,Slsofc_desc,
SUM(CASE WHEN Fin_Year=case when datepart(mm, dateadd(dd, - 1, getdate())) <4 then YEAR(getdate()-1)-1 else YEAR(getdate()-1) end
THEN (Budget) ELSE 0 END) AS budget_year,  

SUM(CASE WHEN Fin_Year=case when datepart(mm, dateadd(dd, - 1, getdate())) <=4 then YEAR(getdate()-1)-1 else YEAR(getdate()-1) end
and Fin_Month<=case when 
(case when datepart(mm, dateadd(dd, - 1, getdate())) <4 then datepart(mm, dateadd(dd, - 1, getdate()))+9 
else datepart(mm, dateadd(dd, - 1, getdate()))-3 end)-1=0 then 12
else (case when datepart(mm, dateadd(dd, - 1, getdate())) <4 then datepart(mm, dateadd(dd, - 1, getdate()))+9 
else datepart(mm, dateadd(dd, - 1, getdate()))-3 end)-1 end
THEN (Budget) ELSE 0 END) AS last_month_budget,

SUM(CASE WHEN Fin_Year=case when datepart(mm, dateadd(dd, - 1, getdate())) <4 then YEAR(getdate()-1)-1 else YEAR(getdate()-1) end
and Fin_Month<=case when datepart(mm, dateadd(dd, - 1, getdate())) <4 then datepart(mm, dateadd(dd, - 1, getdate()))+9 
else datepart(mm, dateadd(dd, - 1, getdate()))-3 end
THEN (Budget) ELSE 0 END) AS ytd_budget, 

SUM(CASE WHEN Cal_Month =datepart(mm, dateadd(dd, - 1, getdate()))
and Cal_Year=year(getdate()-1)
THEN (Budget) ELSE 0 END) AS this_month_budget, 

SUM(CASE WHEN Cal_Month= datepart(mm, dateadd(mm, 1, dateadd(dd, - 1, getdate()))) AND 
Cal_Year = datepart(yy, dateadd(mm, 1, dateadd(dd, - 1, getdate()))) 
THEN (Budget) ELSE 0 END) AS next_month_budget,     

SUM(CASE WHEN Cal_Month = datepart(mm, dateadd(mm, 2, dateadd(dd, - 1,getdate()))) AND 
Cal_Year = datepart(yy, dateadd(mm, 2, dateadd(dd, - 1, getdate()))) 
THEN (Budget) ELSE 0 END) AS nextof_next_month_budget

FROM	IAS_Bud_DPSTwise a
group by Vertical_ordr,Vertical,SubVertical,Slsofc_ordr,Slsofc,Slsofc_desc





--select 
--SUM(CASE WHEN Cal_Month = datepart(mm, dateadd(dd, - 1, getdate()))
--THEN (Budget) ELSE 0 END) AS this_month_budget
--FROM	IAS_Bud_DPSTwise a
--where Slsofc_desc= 'LG SERIES'

GO

