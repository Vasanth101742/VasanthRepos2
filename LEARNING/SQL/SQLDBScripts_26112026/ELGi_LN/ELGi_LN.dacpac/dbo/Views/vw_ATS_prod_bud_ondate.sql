CREATE VIEW [dbo].[vw_ATS_prod_bud_ondate] as
select * from (
select tplcode,pgdesc,isnull([1],0) as bqty,substring(dates,1,3)+ '01'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([2],0) as bqty, substring(dates,1,3)+'02'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([3],0) as bqty, substring(dates,1,3)+'03'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([4],0) as bqty, substring(dates,1,3)+'04'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([5],0) as bqty, substring(dates,1,3)+'05'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([6],0) as bqty, substring(dates,1,3)+'06'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([7],0) as bqty, substring(dates,1,3)+'07'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([8],0) as bqty, substring(dates,1,3)+'08'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([9],0) as bqty, substring(dates,1,3)+'09'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([10],0) as bqty, substring(dates,1,3)+'10'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([11],0) as bqty, substring(dates,1,3)+'11'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([12],0) as bqty, substring(dates,1,3)+'12'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([13],0) as bqty, substring(dates,1,3)+'13'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([14],0) as bqty, substring(dates,1,3)+'14'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([15],0) as bqty, substring(dates,1,3)+'15'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([16],0) as bqty, substring(dates,1,3)+'16'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([17],0) as bqty, substring(dates,1,3)+'17'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([18],0) as bqty, substring(dates,1,3)+'18'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([19],0) as bqty, substring(dates,1,3)+'19'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([20],0) as bqty, substring(dates,1,3)+'20'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([21],0) as bqty, substring(dates,1,3)+'21'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([22],0) as bqty, substring(dates,1,3)+'22'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([23],0) as bqty, substring(dates,1,3)+'23'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([24],0) as bqty, substring(dates,1,3)+'24'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([25],0) as bqty, substring(dates,1,3)+'25'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([26],0) as bqty, substring(dates,1,3)+'26'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([27],0) as bqty, substring(dates,1,3)+'27'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([28],0) as bqty, substring(dates,1,3)+'28'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([29],0) as bqty, substring(dates,1,3)+'29'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([30],0) as bqty, substring(dates,1,3)+'30'+substring(dates,6,5) as date  from ats_production_plan
union all
select tplcode,pgdesc,isnull([31],0) as bqty, substring(dates,1,3)+'31'+substring(dates,6,5) as date  from ats_production_plan)
a where isdate(date) = 1

GO

