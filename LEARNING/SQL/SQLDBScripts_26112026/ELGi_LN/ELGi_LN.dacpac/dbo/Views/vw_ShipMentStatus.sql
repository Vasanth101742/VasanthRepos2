create view [dbo].[vw_ShipMentStatus]
as
select 1 as ShipmentCode, 'Open' as ShipmentDesc union
select 2 as ShipmentCode, 'Frozen' as ShipmentDesc union
select 3 as ShipmentCode, 'Confirmed' as ShipmentDesc union
select 10 as ShipmentCode, 'PartiallyFrozen' as ShipmentDesc union
select 20 as ShipmentCode, 'Confirming' as ShipmentDesc union
select 30 as ShipmentCode, 'Projected' as ShipmentDesc

GO

