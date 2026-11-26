CREATE VIEW [dbo].[vw_collection_bdm] as
select user_names,b.region,b.areaname,custno,custname1,month(docdt) as month_name,sum(collection) as collection 
from Acc_Collection a 
left outer join (select * from vw_SALESMAPPING_MASTER where organ is not null) as  b 
on ltrim(rtrim(a.region)) = ltrim(rtrim(b.region))
and a.dpstcode = b.DPSTCode
where global = 'international'
group by  user_names,b.region,b.areaname,b.areacode,custno,custname1,a.region,month(docdt)

GO

