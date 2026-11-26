
CREATE view tablewithcount as

select t.[name] as 'table name',
 sum(p.rows) as 'Count'
from sys.objects t 
inner join sys.partitions p on t.object_id=p.object_id
where t.type='U' and p.index_id in (0,1)
group by t.name

GO

