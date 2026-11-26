--select * from vw_Item_Line_Master

create view [dbo].[vw_Item_SubLine_Master] as
select 1 as SubLineNum,'S0 - EN53' as SubLine
union
select 2,'S0 - EN73'
union
select 3,'S0 - EN102'
union
select 4,'S1 - F2'
union
select 5,'S1 - F3'
union
select 6,'S2 - F4'
union
select 7,'R1'
union
select 8,'R2'
union
select 9,'LG'
union
select 10,'VAYU'
union
select 11,'BW'
union
select 12,'DPSAC - L1'
union
select 13,'DPSAC - L2'
union
select 14,'DPSAC - L3'
union
select 15,'L - 20 SERIES'
union
select 16,'L - 20/12'
union
select 17,'L - AXIS 225'
union
select 18,'L - AXIS 284'
union
select 19,'L - AXIS 284/159'
union
select 20,'S - AXIS 102'
union
select 21,'S - AIXS 159B'
union
select 22,'S - AXIS 159G'
union
select 23,'S - AXIS 159GDS'
union
select 24,'S - AXIS 159SB'
union
select 25,'S - AXIS 159BZ'
union
select 26,'RCD'
union
select 27,'ENGC'
union
select 28,'HIGH VOLUME'
union
select 29,'S0 - EN159'
union
select 30,'L0'
union
select 31,'Skin packing small- L1'
union
select 32,'Skin packing Big- L2'
union
select 33,'RCD/ROCD Kitting- L3'
union
select 34,'RLY Kitting- L4'
union
select 35,'S0'
union
select 36,'CRANKSHAFT SPARES'

GO

