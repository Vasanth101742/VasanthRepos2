CREATE VIEW [dbo].[vw_collection_exports] as 
SELECT     max(areaname) as areaname, sum(collection)/1000000 as collection, 
case when global = 'International' then region else zone end as zone1,
sum(case when description  = 'exports' then collection/1000000  else 0 end) as exports_coll,month(docdt) as monthnum
FROM         Acc_Collection WITH (nolock)
WHERE     (custno NOT IN ('ZA0001', 'A03177'))  and description = 'exports'
group by case when global = 'International' then region else zone end,month(docdt)

GO

