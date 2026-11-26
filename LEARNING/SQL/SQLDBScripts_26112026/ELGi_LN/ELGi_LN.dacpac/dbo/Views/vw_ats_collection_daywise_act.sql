CREATE VIEW [dbo].[vw_ats_collection_daywise_act] as

select sum(case when zone='East' and type='mfg' then collection else 0 end) as east_mkt_coll,
sum(case when zone='West' and type='mfg' then collection else 0 end) as west_mkt_coll,
sum(case when zone='North' and type='mfg' then collection else 0 end) as north_mkt_coll ,
sum(case when zone='South' and type='mfg' then collection else 0 end) as south_mkt_coll ,
sum(case when zone='East' and type='aftersale' then collection else 0 end) as east_aftsale_coll ,
sum(case when zone='North' and type='aftersale' then collection else 0 end) as north_aftsale_coll ,
sum(case when zone='West' and type='aftersale' then collection else 0 end) as west_aftsale_coll ,
sum(case when zone='South' and type='aftersale' then collection else 0 end) as south_aftsale_coll ,
sum(case when zone='Export' and type='Export' then collection else 0 end) as export_coll,
sum(case when zone='Others'  then collection else 0 end) as other_coll,date as date1

from (


select isnull(collection,0) as collection, isnull(a.zone,b.zone) as zone , isnull(a.type,b.type) as type , date from 
(
select sum(collection) as collection,zone,type,docdt from 
(
select docdt,isnull(a.collection,0) as collection,a.dpstname as dpstname,
UPPER(case when a.zone is null then 'Others' else a.zone end)  as zone,type 
from 
(
SELECT SUM(a.collection) / 1000000 AS collection, 
UPPER(CASE WHEN dpstname IS NULL OR dpstname = ' ' or dpstname='OTHERS' THEN 'OTHERS' ELSE LTRIM(dpstname) END) AS dpstname, 
CASE WHEN dpstcode in ('90041','90048','90045') THEN 'aftersale' ELSE 'mfg' end as type,
b.ord,ltrim(rtrim(a.zone)) as zone,a.docdt

FROM Acc_Collection_ATS a
LEFT OUTER JOIN ats_area_ord  b
ON LTRIM(RTRIM(a.areaname)) = LTRIM(RTRIM(b.areaname))

WHERE (a.global LIKE '%domestic%') 
AND (a.collection > 0) 
AND (a.docdt between CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(getdate()-1)-1),getdate()-1),101) and getdate()-1)
                      
GROUP BY a.dpstname, b.ord,a.zone,docdt,dpstcode,dpstname
)a
)a
group by zone,type,docdt
)a

right outer  JOIN

(
select * from
(select distinct date from companycalendar 
where date between CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(getdate()-1)-1),getdate()-1),101) and convert(datetime,convert(varchar,getdate()-1,106))
)a

cross join
(select 'Others' as zone,'mfg' as type 
union all 
select 'Others' as zone,'aftersale' as type 
union all select 'EAST' as zone , 'mfg' as type 
union all 
select 'NORTH', 'mfg' as type 
union all 
select 'SOUTH', 'mfg' as type 
union all 
select 'WEST', 'mfg' as type 
union all 
select 'EAST'  as zone, 'aftersale' as type 
union all 
select 'NORTH', 'aftersale' as type 
union all 
select 'SOUTH', 'aftersale' as type 
union all 
select 'WEST','Aftersale' as type 
)b

)b
on convert(datetime,a.docdt)=b.date 
and a.zone=b.zone and a.type=b.type


union all

select isnull(out_collection,0) / 1000000 as collection,
isnull(zone,'Export') as zone, 
isnull(type,'Export') as type,
isnull(docdt,date) as date 
from 
(
SELECT 
sum(case when doctyp = 2 then (c.Amnthome - c.BankCosthome )*-1 else 0 end) as out_collection,
'Export' as zone,'Export' as type,DocDt
FROM vw_AREA_MASTER a
INNER JOIN (select distinct t_ofbp as CustCode,t_creg as Area from TTCCOM110400) b 
ON a.areacode = b.Area 
RIGHT OUTER JOIN (select * from Collection_Stage1 where company in (select company from ELGI_Companies_Master where CompanyGroup='ATS')) c
ON LTRIM(RTRIM(b.CustCode)) = LTRIM(RTRIM(c.CustNo))

WHERE (c.Trantyp IN ('B29', 'B45', '633', '634', 'B28', 'B31', 'B46','B48','B49','B50','B51','B52','B53')) 
AND (c.DocDt between CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(getdate()-1)-1),getdate()-1),101) and getdate()-1) 
AND (c.DocTyp IN (2, 9)) AND (a.Global <> 'Domestic')
GROUP BY docdt
)a

right outer join
(select * from
(select distinct date from companycalendar where date between CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(getdate()-1)-1),getdate()-1),101) and convert(datetime,convert(varchar,getdate()-1,106)))a
)b
on convert(datetime,a.docdt)=b.date 

)a
group by date

GO

