
CREATE view vw_Inventory_all_companies as 
select * from 
(select * from [elgi_LN].dbo.inventorydetails where Region is not null
union all
select * from [elgi_US].dbo.inventorydetails_subsidiaries where Region is not null)a

GO

