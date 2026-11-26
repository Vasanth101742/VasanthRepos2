CREATE VIEW [dbo].[vw_collection_domestic] as 

SELECT    case when areaname is null or areaname ='' then ' OTHERS' else areaname end as areaname, sum(collection)/1000000 as collection, case when global = 'International' then region else zone end as zone1,
sum(case when description  = 'Compressor-Channel' then collection/1000000  else 0 end) as channel_coll,
sum(case when description  = 'after sales' then collection/1000000  else 0 end) as after_coll,
sum(case when description  = 'DPSAC' then collection/1000000  else 0 end) as dpsac_coll,
sum(case when description  = 'MED' then collection/1000000  else 0 end) as med_coll,
sum(case when description  = 'Compressor-Direct' then collection/1000000  else 0 end) as direct_coll,
sum(case when description  = 'Railways'  then collection/1000000  else 0 end) as railways_coll,
sum(case when description  = 'Service Charges & Old DPST' then collection/1000000  else 0 end) as service_coll,
sum(case when description  = 'Engines' then collection/1000000  else 0 end) as engines_coll,
sum(case when description  = 'others' or description is null then collection/1000000  else 0 end) as others_coll,
--sum(case when description  = 'After Sales'  then collection/1000000  else 0 end) as AS_coll,
month(docdt) as monthnum
FROM         Acc_Collection WITH (nolock)
WHERE     (custno NOT IN ('ZA0001', 'A03177')) and description <> 'exports'
group by areaname,case when global = 'International' then region else zone end,month(docdt)

GO

