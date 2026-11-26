CREATE view [dbo].[vw_Item_Master]
as
select 400 as company,ltrim(rtrim(t_item))as Item,t_dsca as Item_desc From TTCIBD001400
union 
select 401 as company,ltrim(rtrim(t_item))as Item,t_dsca as Item_desc From TTCIBD001400
union 
select 450 as company,ltrim(rtrim(t_item))as Item,t_dsca as Item_desc From TTCIBD001400
union
select 465 as company,ltrim(rtrim(ITEM))as Item,dsca as Item_desc From TTCIBD001465
union 
select 470 as company,ltrim(rtrim(item))as Item,dsca as Item_desc From TTCIBD001470
union 
select 490 as company,ltrim(rtrim(item))as Item,dsca as Item_desc From TTCIBD001490
union 
select 500 as company,ltrim(rtrim(item))as Item,dsca as Item_desc From TTCIBD001500
union 
select 551 as company,ltrim(rtrim(item))as Item,dsca as Item_desc From TTCIBD001551
union 
select 552 as company,ltrim(rtrim(item))as Item,dsca as Item_desc From TTCIBD001552
union 
select 600 as company,ltrim(rtrim(t_item))as Item,t_dsca as Item_desc From TTCIBD001600

GO

