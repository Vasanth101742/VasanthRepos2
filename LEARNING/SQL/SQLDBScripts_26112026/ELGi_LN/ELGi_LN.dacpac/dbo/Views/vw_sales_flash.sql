CREATE view  [dbo].[vw_sales_flash] as
select Global,upper(organ)organ,region,user_names,Division,description,Dpstcode,dpstname,AreaCode,AreaName,
case 
when organ ='India' then 1
when organ ='SAAME' then 2
when organ ='COSEA' then 3
when organ ='ID' then 4
else 5
end as ordr,
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
sum(inflow/1000000)as inflow,
sum(YTD_INFLOW)as YTD_INFLOW,
sum(n1_month_inflow)as n1_month_inflow,
sum(n2_month_inflow)as n2_month_inflow,
sum(n3_month_inflow)as n3_month_inflow,
sum(INFLOW_Opening)as INFLOW_Opening

from(

SELECT
isnull(bud.global,sls.global) Global,isnull(bud.organ,sls.organ) organ,isnull(bud.region,sls.region) region,
isnull(bud.user_names,sls.user_names) user_names,isnull(bud.Division,sls.Division) Division,isnull(bud.Area,sls.areacode) AreaCode,
isnull(bud.Areaname,sls.AreaName) AreaName,isnull(bud.Dpst,sls.Dpstcode) Dpstcode,isnull(bud.dpstname,sls.dpstname) dpstname,
sls.description,bud.budget_year,bud.last_month_budget, bud.ytd_budget,bud.this_month_budget, bud.next_month_budget,bud.nextof_next_month_budget,
sls.last_year_sale,case when sls.last_year_ytd = 0 then  0.01 else sls.last_year_ytd end as last_year_ytd,
sls.this_year_sale,sls.last_month_sale, sls.this_month_sale,sls.thr_month_sale,n1_month_sale,n2_month_sale,n3_month_sale,
sls.inflow,sls.YTD_INFLOW,sls.n1_month_inflow,sls.n2_month_inflow,sls.n3_month_inflow,INFLOW_Opening   

FROM 
(select * from vw_bud_Global) bud 
full JOIN
(select * from vw_sls_Global) sls 
ON  
--isnull(bud.Global,'0')=isnull(sls.global,'0')
--and isnull(bud.organ,'0')=isnull(sls.organ,'0')
--and isnull(bud.region,'0')=isnull(sls.region,'0')
--and isnull(bud.user_names,'0') =isnull(sls.user_names,'0')
--and isnull(bud.division,'0') = isnull(sls.division,'0') 
isnull(bud.Dpst,'0')=isnull(sls.Dpstcode,'0')
and isnull(bud.Area,'0')=isnull(sls.Areacode,'0')
where isnull(bud.organ,sls.organ)<>'India'


union

SELECT
'Domestic' as Global,'India' as organ,'India' as region,
null as  user_names,null as  Division,null as AreaCode,
null as AreaName,isnull(bud.Dpst,sls.Dpstcode) Dpstcode,isnull(bud.dpstname,sls.dpstname) dpstname,
sls.description,bud.budget_year,bud.last_month_budget, bud.ytd_budget,bud.this_month_budget, bud.next_month_budget,bud.nextof_next_month_budget,
sls.last_year_sale,case when sls.last_year_ytd = 0 then  0.01 else sls.last_year_ytd end as last_year_ytd,
sls.this_year_sale,sls.last_month_sale, sls.this_month_sale,sls.thr_month_sale,n1_month_sale,n2_month_sale,n3_month_sale,
sls.inflow,sls.YTD_INFLOW,sls.n1_month_inflow,sls.n2_month_inflow,sls.n3_month_inflow,INFLOW_Opening    

from vw_bud_Domestic_DPSTwise bud
full join vw_sls_Domestic_DPSTwise sls
on bud.dpst=sls.dpstcode

) BDM

group by Global,organ,region,user_names,Division,AreaCode,AreaName,Dpstcode,dpstname,description

GO

