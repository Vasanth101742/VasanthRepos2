CREATE VIEW [dbo].[vw_advance_exports] as 
SELECT     max(areaname) as areaname, sum(collection)/1000000 as advance, case when global = 'International' then region else zone end as zone1,
sum(case when description  = 'exports' then collection/1000000  else 0 end) as exports_adv,month(docdt) as monthnum
FROM         Acc_Advance WITH (nolock)
WHERE     (custno NOT IN ('ZA0001', 'A03177'))  and  global = 'international' 
--description = 'exports' 
and areaname is not null
group by case when global = 'International' then region else zone end,month(docdt)

GO

