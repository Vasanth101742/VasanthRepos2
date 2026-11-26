CREATE VIEW [dbo].[vw_ats_prod_bqty] as
select ltrim(rtrim(tplcode)) as tplcode, pgdesc as pgdescr,month(dates) as monthnum,year(dates) as yearnum,
isnull([1],0) as day1_bqty,isnull([2],0) as day2_bqty,
isnull([3],0) as day3_bqty,isnull([4],0) as day4_bqty,
isnull([5],0) as day5_bqty,isnull([6],0) as day6_bqty,
isnull([7],0) as day7_bqty,isnull([8],0) as day8_bqty,
isnull([9],0) as day9_bqty,isnull([10],0) as day10_bqty,
isnull([11],0) as day11_bqty,isnull([12],0) as day12_bqty,
isnull([13],0) as day13_bqty,isnull([14],0) as day14_bqty,
isnull([15],0) as day15_bqty,isnull([16],0) as day16_bqty,
isnull([17],0) as day17_bqty,isnull([18],0) as day18_bqty,
isnull([19],0) as day19_bqty,isnull([20],0) as day20_bqty,
isnull([21],0) as day21_bqty,isnull([22],0) as day22_bqty,
isnull([23],0) as day23_bqty,isnull([24],0) as day24_bqty,
isnull([25],0) as day25_bqty,isnull([26],0) as day26_bqty,
isnull([27],0) as day27_bqty,isnull([28],0) as day28_bqty,
isnull([29],0) as day29_bqty,isnull([30],0) as day30_bqty,isnull([31],0) as day31_bqty,
isnull([1],0)+ isnull([2],0)+isnull([3],0)+ isnull([4],0)+
isnull([5],0)+ isnull([6],0)+isnull([7],0)+ isnull([8],0)+
isnull([9],0)+ isnull([10],0)+isnull([11],0)+isnull([12],0)+
isnull([13],0)+ isnull([14],0)+isnull([15],0)+ isnull([16],0)+
isnull([17],0)+ isnull([18],0)+isnull([19],0)+ isnull([20],0)+
isnull([21],0)+ isnull([22],0)+isnull([23],0)+ isnull([24],0)+
isnull([25],0)+ isnull([26],0)+isnull([27],0)+ isnull([28],0)+isnull([29],0)+ isnull([30],0)+isnull([31],0) as total_bqty,
isnull(monthly_plan,0) as month_bqty
from ats_production_plan

GO

