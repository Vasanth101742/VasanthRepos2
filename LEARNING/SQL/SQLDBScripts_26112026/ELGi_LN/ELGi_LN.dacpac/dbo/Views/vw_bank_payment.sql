

create VIEW [dbo].[vw_bank_payment] as 
select a.fyer,case when a.fprd > 9 then a.fprd - 9 else a.fprd + 3 end as monthnum,sum(nor_pay+advice_pay)/1000000 as payment from (
select a.company,a.leac,a.fprd,a.fyer,
nor_rec - isnull(amth_adj_rec,0) as nor_rec,
nor_pay + isnull(amth_adj_pay,0) as nor_pay,
advice_rec,advice_pay,
fnd_rec + isnull(amth_adj_rec,0) as fnd_rec,
fnd_pay - isnull(amth_adj_pay,0) as fnd_pay,
anticp_rec,anticip_pay,reco_rec,reco_pay,cms_rec,cms_pay
 from (
select company,leac,fyer,fprd, 
sum(case when type = 1 then amth else 0 end) as nor_rec,
sum(case when type = 2 then amth else 0 end) as nor_pay,
sum(case when type = 3 then amth else 0 end) as advice_rec,
sum(case when type = 4 then amth else 0 end) as advice_pay,
sum(case when type = 5 then amth else 0 end) as fnd_rec,
sum(case when type = 6 then amth else 0 end) as fnd_pay,
sum(case when type = 7 then amth else 0 end) as anticp_rec,
sum(case when type = 8 then amth else 0 end) as anticip_pay,
sum(case when type = 9 then amth else 0 end) as reco_rec,
sum(case when type = 10 then amth else 0 end) as reco_pay,
sum(case when type = 13 then amth else 0 end) as cms_rec,
sum(case when type = 14 then amth else 0 end) as cms_pay

 from (
select company,dbcr,pleac as leac,sum(amth) as amth,type,isnull(fnd_leac,'') as fnd_leac,fyer,fprd 
from bank_balance a 
inner join bank_balance_gl b 
on a.leac = b.leac
group by company,dbcr,pleac,type,isnull(fnd_leac,''),fyer,fprd
)a
group by company,leac,fyer,fprd) a

left outer join

(select company,sum(case when type = 6 then amth else 0 end) as amth_adj_rec ,
sum(case when type = 5 then -amth else 0 end) as amth_adj_pay,
isnull(fnd_leac,'') as leac,fyer,fprd 
from bank_balance a 
where isnull(fnd_leac,'') <> ''  
group by company,isnull(fnd_leac,''),fyer,fprd
) b
on a.leac = b.leac 
and a.company = b.company 
and a.fyer = b.fyer 
and a.fprd  =b.fprd
)a 
group by a.fyer,case when a.fprd > 9 then a.fprd - 9 else a.fprd + 3 end

GO

