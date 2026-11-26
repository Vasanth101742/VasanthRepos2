CREATE VIEW [dbo].[vw_advance_bdm] as

select user_names,b.region,b.areaname,custno,custname1,month(docdt) as month_name,sum(collection) as collection 

from Acc_Advance a
left outer join (select * from vw_SALESMAPPING_MASTER where Organ is not null) b 
on ltrim(rtrim(a.region)) = ltrim(rtrim(b.region))
and a.dpst = b.DPSTCode
where global = 'international'
group by  user_names,b.region,b.areaname,custno,custname1,a.region,month(docdt)

GO

