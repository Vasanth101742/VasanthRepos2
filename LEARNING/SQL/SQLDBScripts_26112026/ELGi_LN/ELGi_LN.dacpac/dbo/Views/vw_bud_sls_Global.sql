CREATE view [dbo].[vw_bud_sls_Global]
as
select Global,organ,region,user_names,Division,
case when vertical1='OSEA AS' then 'AM'
when vertical1='OSEA UNITS' then 'Units'
else vertical1 end as vertical1 
,description,Dpstcode,dpstname,AreaCode,AreaName,
sum(budget_year) as budget_year,
sum(last_month_budget) as last_month_budget,
isnull(sum(ytd_budget),0) as ytd_budget,
sum(this_month_budget) as this_month_budget, 
sum(next_month_budget) as next_month_budget,
sum(nextof_next_month_budget) as 
nextof_next_month_budget,
sum(last_year_sale) as last_year_sale,
sum(last_year_ytd) as last_year_ytd,
sum(thr_month_sale) as
thr_month_sale,sum(this_month_sale) as this_month_sale,
sum(this_year_sale) as this_year_sale,
sum(last_month_sale) as last_month_sale,
sum(n1_month_sale) as n1_month_sale,
sum(n2_month_sale) as n2_month_sale,
sum(n3_month_sale) as n3_month_sale,
sum(Ondate_Inflow) as Ondate_Inflow,
sum(this_month_inflow) as this_month_inflow,
sum(YTD_INFLOW) YTD_INFLOW,
sum(SalesPlan_USD)/1000 Sales_Plan,
sum(this_month_PendValue) as this_month_PendValue,
sum(this_year_PendValue) as this_year_PendValue,
sum(ondate_sale) ondate_sale
from(

SELECT
isnull(bud.global,sls.global) Global,isnull(bud.organ,sls.organ) organ,isnull(bud.region,sls.region) region,
isnull(bud.user_names,sls.user_names) user_names,isnull(bud.Division,sls.Division) Division,isnull(bud.vertical1,sls.vertical1) vertical1,
isnull(bud.Area,sls.areacode) AreaCode,
isnull(bud.Areaname,sls.AreaName) AreaName,isnull(bud.Dpst,sls.Dpstcode) Dpstcode,isnull(bud.dpstname,sls.dpstname) dpstname,
sls.description,bud.budget_year,bud.last_month_budget, bud.ytd_budget,bud.this_month_budget, bud.next_month_budget,bud.nextof_next_month_budget,
sls.last_year_sale,case when sls.last_year_ytd = 0 then  0.01 else sls.last_year_ytd end as last_year_ytd,
sls.this_year_sale,sls.last_month_sale, sls.this_month_sale,sls.thr_month_sale,n1_month_sale,n2_month_sale,n3_month_sale
,sls.Ondate_Inflow,sls.inflow as this_month_inflow,sls.YTD_INFLOW,
P.SalesPlan_USD,pend.this_month_PendValue,pend.this_year_PendValue,sls.ondate_sale

FROM 
(select * from vw_bud_Global_USD) bud 
full JOIN
(select * from vw_sls_Global_USD) sls 
ON  isnull(bud.Dpst,'0')=isnull(sls.Dpstcode,'0')
and isnull(bud.Area,'0')=isnull(sls.Areacode,'0')

left outer join 
(select * from ELGi_Sales_Plan where CalMonth=month(getdate()-1) and CalYear=year(getdate()-1)) P
ON  
isnull(bud.Dpst,sls.Dpstcode)=p.DpstCode
and isnull(bud.Area,sls.Areacode)=P.AreaCode


left outer join
(
select Dpst,areacode,--OrderDate,
sum(PendQty) PendQty,sum(ord_qty- Cancel_Qty-delqty) as qty1,
SUM(CASE WHEN OrderDate BETWEEN 
CONVERT(varchar, datepart(mm, dateadd(dd, - 1, getdate()))) + '/1/' + datename(yy, dateadd(dd, - 1, getdate())) 
AND 
getdate() 
THEN (PendValue_USD) / 1000 ELSE 0 END) AS this_month_PendValue,

SUM(CASE WHEN OrderDate BETWEEN 
'04/01/' + convert(varchar,(case when month(getdate()-1) between 1 and 3 then year(getdate()-1) - 1 else year(getdate()-1) end )) 
AND 
getdate() 
THEN (PendValue_USD) / 1000 ELSE 0 END) AS this_year_PendValue

from Pending_Orders
where PendQty<>0
and company in (select company from ELGI_Companies_Master where CompanyGroup='ELGI')
group by Dpst,areacode
)pend
ON  
isnull(bud.Dpst,sls.Dpstcode)=pend.Dpst
and isnull(bud.Area,sls.Areacode)=Pend.AreaCode


where isnull(bud.organ,sls.organ)<>'India'


) BDM
--For Testing purpose
--where Dpstcode in (70090,70091,70092,70093,70094,70095)
group by Global,organ,region,user_names,Division,vertical1,AreaCode,AreaName,Dpstcode,dpstname,description

GO

