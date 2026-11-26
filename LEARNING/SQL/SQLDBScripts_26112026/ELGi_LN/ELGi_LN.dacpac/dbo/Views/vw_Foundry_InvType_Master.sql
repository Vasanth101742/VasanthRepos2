create view vw_Foundry_InvType_Master as
select 465 as Company,'RAW' as ItemGroup,'RM' as InvType
union
select 465,'GRA','RM'
union
select 465,'FIN','FG'
union
select 465,'WIP','WIP'

GO

