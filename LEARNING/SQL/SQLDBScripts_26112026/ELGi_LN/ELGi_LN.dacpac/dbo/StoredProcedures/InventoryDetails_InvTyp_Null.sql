CREATE procedure [InventoryDetails_InvTyp_Null] as
begin 
select distinct company,cwar,ltrim(rtrim(ITEM))'ITEM',ItemDescr,invtype from [dbo].[InventoryDetails] where INVType is null and company not in('500','551','581','951','553','552','600') order by COMPANY
end

GO

