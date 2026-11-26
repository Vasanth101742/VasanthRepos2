--select * from vw_ats_prod_pqty

CREATE VIEW [dbo].[vw_ats_prod_pqty] as 
select item as item_code,pgdesc,mnum,ynum,
sum(case when dnum = 1 then pqty else 0 end) as day1_pqty,
sum(case when dnum = 2 then pqty else 0 end) as day2_pqty,
sum(case when dnum = 3 then pqty else 0 end) as day3_pqty,
sum(case when dnum = 4 then pqty else 0 end) as day4_pqty,
sum(case when dnum = 5 then pqty else 0 end) as day5_pqty,
sum(case when dnum = 6 then pqty else 0 end) as day6_pqty,
sum(case when dnum = 7 then pqty else 0 end) as day7_pqty,
sum(case when dnum = 8 then pqty else 0 end) as day8_pqty,
sum(case when dnum = 9 then pqty else 0 end) as day9_pqty,
sum(case when dnum = 10 then pqty else 0 end) as day10_pqty,
sum(case when dnum = 11 then pqty else 0 end) as day11_pqty,
sum(case when dnum = 12 then pqty else 0 end) as day12_pqty,
sum(case when dnum = 13 then pqty else 0 end) as day13_pqty,
sum(case when dnum = 14 then pqty else 0 end) as day14_pqty,
sum(case when dnum = 15 then pqty else 0 end) as day15_pqty,
sum(case when dnum = 16 then pqty else 0 end) as day16_pqty,
sum(case when dnum = 17 then pqty else 0 end) as day17_pqty,
sum(case when dnum = 18 then pqty else 0 end) as day18_pqty,
sum(case when dnum = 19 then pqty else 0 end) as day19_pqty,
sum(case when dnum = 20 then pqty else 0 end) as day20_pqty,
sum(case when dnum = 21 then pqty else 0 end) as day21_pqty,
sum(case when dnum = 22 then pqty else 0 end) as day22_pqty,
sum(case when dnum = 23 then pqty else 0 end) as day23_pqty,
sum(case when dnum = 24 then pqty else 0 end) as day24_pqty,
sum(case when dnum = 25 then pqty else 0 end) as day25_pqty,
sum(case when dnum = 26 then pqty else 0 end) as day26_pqty,
sum(case when dnum = 27 then pqty else 0 end) as day27_pqty,
sum(case when dnum = 28 then pqty else 0 end) as day28_pqty,
sum(case when dnum = 29 then pqty else 0 end) as day29_pqty,
sum(case when dnum = 30 then pqty else 0 end) as day30_pqty,
sum(case when dnum = 31 then pqty else 0 end) as day31_pqty,
sum(pqty) as total_pqty
from (
select 
month(pkdt) as mnum,
year(pkdt) as ynum,
ltrim(rtrim(item)) as item,
day(pkdt) as dnum,
count(*) as pqty,
pgdesc from 
(
select * from 
(select *
,convert(date,getdate()-1) as pkdt  --This need to be modified once pkdt info is available in LN
,pack=1  --This need to be modified once pkdt info is available in LN
from TWHLTC500ALL 
where company in (select company from ELGI_Companies_Master where CompanyGroup='ATS'))a
where pkdt <> '9999-01-01 00:00:00' 
and convert(datetime,pkdt) >= '04/01/2011' 
and pack = 1 
and cwar <> '664'
)a
inner join ats_production_master b
on ltrim(rtrim(a.item)) =  ltrim(rtrim(b.tplcode)) 
group by ltrim(rtrim(item)),pgdesc,month(pkdt) ,year(pkdt) ,day(pkdt)

union all

select mnum,ynum,ltrim(rtrim(tplcode)) as item,dnum,0 as pqty,pgdesc from 
(select month(pkdt) as mnum,year(pkdt) as ynum,day(pkdt) as dnum 
from(select *
,convert(date,getdate()-1) as pkdt  --This need to be modified once pkdt info is available in LN
,pack=1  --This need to be modified once pkdt info is available in LN
from TWHLTC500ALL 
where company in (select company from ELGI_Companies_Master where CompanyGroup='ATS'))a
where pkdt <> '9999-01-01 00:00:00' 
and convert(datetime,pkdt) >= '04/01/2011'
group by month(pkdt) ,year(pkdt) ,day(pkdt)
)a,ats_production_master

)a
group by item,mnum,ynum,pgdesc

GO

