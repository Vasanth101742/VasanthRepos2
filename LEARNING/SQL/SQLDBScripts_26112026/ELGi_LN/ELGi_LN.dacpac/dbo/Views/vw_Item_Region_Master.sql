--select * from vw_Item_Line_Master
--select * from vw_Item_SubLine_Master
--select * from vw_Item_Region_Master

CREATE view [dbo].[vw_Item_Region_Master] as 
select 1 as RegionNum,'INDIA & INDIA LIKE' as Region
union
select 2,'USA'
union
select 3,'BRAZIL'
union
select 4,'BELAIR/AUSTRALIA'
union
select 5,'ROTAIR'
union
select 6,'ME/OSEA'

GO

