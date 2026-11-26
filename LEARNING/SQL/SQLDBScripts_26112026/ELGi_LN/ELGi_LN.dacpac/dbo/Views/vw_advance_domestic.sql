CREATE VIEW [dbo].[vw_advance_domestic] as 
SELECT    case when areaname is null or areaname ='' then ' OTHERS' else areaname end as areaname, sum(collection)/1000000 as advance, 
sum(case when description  = 'Compressor-Channel' then collection/1000000  else 0 end) as channel_adv,
sum(case when description  = 'after sales' then collection/1000000  else 0 end) as after_adv,
sum(case when description  = 'DPSAC' then collection/1000000  else 0 end) as dpsac_adv,
sum(case when description  = 'MED' then collection/1000000  else 0 end) as med_adv,
sum(case when description  = 'Compressor-Direct' then collection/1000000  else 0 end) as direct_adv,
sum(case when description  = 'Railways' then collection/1000000  else 0 end) as railways_adv,
sum(case when description  = 'Service Charges & Old DPST' then collection/1000000  else 0 end) as service_adv,
sum(case when description  = 'Engines' then collection/1000000  else 0 end) as engines_adv,
--sum(case when description  = 'After Sales' then collection/1000000  else 0 end) as AS_adv,
sum(case when description  = 'others' or description is null or description='' then collection/1000000  else 0 end) as others_adv,
month(docdt) as monthnum
FROM         Acc_Advance WITH (nolock)
WHERE     (custno NOT IN ('ZA0001', 'A03177'))   and 
case when description is not null   then description else 'others' end <> ('exports') and 
case when global is not null   then global else 'others' end <> ('International')
group by case when areaname is null or areaname ='' then ' OTHERS' else areaname end,month(docdt)

GO

