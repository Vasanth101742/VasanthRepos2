CREATE view [dbo].[vw_sales_cube]
as 
select isnull(upper(organ),'')as organ,isnull(region,'')region,isnull(Dpstcode,'')Dpstcode,isnull(description,'')as Description,
isnull(dpstname,'')Dpstname,isnull(AreaCode,'')AreaCode,isnull(AreaName,'')AreaName,
case 
when organ ='India' then 1
when organ ='SAAME' then 2
when organ ='COSEA' then 3
when organ ='ID' then 4
else 5
end as ordr,
sum(isnull(budget_year,0)) as budget_year,
sum(isnull(last_month_budget,0)) as last_month_budget,
sum(isnull(ytd_budget,0)) as ytd_budget,
sum(isnull(this_month_budget,0)) as this_month_budget, 
sum(isnull(next_month_budget,0)) as next_month_budget,
sum(isnull(nextof_next_month_budget,0)) as nextof_next_month_budget,
sum(isnull(last_year_sale,0)) as last_year_sale,
sum(isnull(last_year_ytd,0)) as last_year_ytd,
sum(isnull(thr_month_sale,0)) as thr_month_sale,
sum(isnull(this_month_sale,0)) as this_month_sale,
sum(isnull(this_year_sale,0)) as this_year_sale,
sum(isnull(last_month_sale,0)) as last_month_sale,
sum(isnull(n1_month_sale,0)) as n1_month_sale,
sum(isnull(n2_month_sale,0)) as n2_month_sale,
sum(isnull(n3_month_sale,0)) as n3_month_sale

from(

SELECT
isnull(bud.global,sls.global) Global,isnull(bud.organ,sls.organ) organ,isnull(bud.region,sls.region) region,
isnull(bud.user_names,sls.user_names) user_names,isnull(bud.Division,sls.Division) Division,isnull(bud.Area,sls.areacode) AreaCode,
isnull(bud.Areaname,sls.AreaName) AreaName,isnull(bud.Dpst,sls.Dpstcode) Dpstcode,isnull(bud.dpstname,sls.dpstname) dpstname,
sls.description,bud.budget_year,bud.last_month_budget, bud.ytd_budget,bud.this_month_budget, bud.next_month_budget,bud.nextof_next_month_budget,
sls.last_year_sale,case when sls.last_year_ytd = 0 then  0.01 else sls.last_year_ytd end as last_year_ytd,
sls.this_year_sale,sls.last_month_sale, sls.this_month_sale,sls.thr_month_sale,n1_month_sale,n2_month_sale,n3_month_sale

FROM 
(select * from vw_bud_Global) bud 
full JOIN
(select * from vw_sls_Global) sls 
ON  
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
sls.this_year_sale,sls.last_month_sale, sls.this_month_sale,sls.thr_month_sale,n1_month_sale,n2_month_sale,n3_month_sale


from vw_bud_Domestic_DPSTwise bud
full join vw_sls_Domestic_DPSTwise sls
on bud.dpst=sls.dpstcode

) BDM
group by Global,organ,region,user_names,Division,AreaCode,AreaName,Dpstcode,dpstname,description

GO

