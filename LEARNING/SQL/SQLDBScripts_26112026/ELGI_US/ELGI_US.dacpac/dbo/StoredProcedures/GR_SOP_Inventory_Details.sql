
--exec [dbo].[GR_SOP_Inventory_Details]

CREATE proc [dbo].[GR_SOP_Inventory_Details]
as
begin

--alter table [GR_SOP_Inventory] add  Demand_Forecasting_Unit_DFU nvarchar(max)
--alter table [GR_SOP_Inventory] add HP nvarchar(100)
--alter table [GR_SOP_Inventory] add KW nvarchar(100)
--alter table [GR_SOP_Inventory] add Pressure_bar nvarchar(100)
--alter table [GR_SOP_Inventory] add Pressure_psi nvarchar(100)
--alter table [GR_SOP_Inventory] add Master_Model nvarchar(100)
--alter table [GR_SOP_Inventory] add Variant nvarchar(100)
--alter table [GR_SOP_Inventory] add Region nvarchar(100)
--alter table [GR_SOP_Inventory] add item_category nvarchar(50)
--alter table [GR_SOP_Inventory] add product_group nvarchar(150)

truncate table [GR_SOP_Inventory]

insert into [GR_SOP_Inventory]

select a.*  from (
select distinct case when a.compnr=3100 then'ELGI NA'
 when a.compnr=3110 then'Industrial'
 when a.compnr=3120 then'Portables'
 when a.compnr=3130 then'Pattons Medical'
 when a.compnr=3140 then'Pattons INC'
 when a.compnr=3150 then'Michigan' end "company"
,a.compnr,replace(a.item, ' ','')"Item",b.dsca as "descr",c.stock "OnHand",c.Differ,
case when c.Differ between 0 and 30 then '1. 0-30 Days'
	when c.Differ between 31 and 60 then '2. 31-60 Days'
	when c.Differ between 61 and 90 then '3. 61-90 Days'
	when c.Differ between 91 and 120 then '4. 91-120 Days'
	when c.Differ between 121 and 150 then '5. 121-150 Days'
	when c.Differ between 151 and 180 then '6. 151-180 Days'
	when c.Differ between 181 and 360 then '7. 181-360 Days'
	when c.Differ> 360 then '8. >360 Days' end "Ageing"
	,e1.dsca"dsca",isnull(f.dsca,'NA')"ProductLine",b.seab"Supplier",b.dscd"Model",c.cwar"cwar",(c.StockVal)"StockVal"
,b.seak,b1.cdf_extd"AlterName"
,mas.Demand_Forecasting_Unit_DFU,mas.HP,mas.KW,mas.Pressure_bar,mas.Pressure_psi,mas.Model 'Master_Model',mas.Variant,mas.Region,mas.Item_Category,mas.Product_group
from LN_whwmd215 a
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item, ' ','') and b.compnr=3100
left join LN_tcibd001 b1 on replace(b1.item,' ','')=b.seak and b1.compnr=3100
left join ln_tcmcs015 e1 on e1.ctyp=b.ctyp
left join LN_tcmcs023 f on replace(f.citg,' ','')=replace(b.citg,' ','')
--Joining master
left join elgi_sop.dbo.[TPL_MASTER_REF] mas on ltrim(rtrim(a.item))=ltrim(rtrim(mas.Item)) and mas.Region=(case when a.compnr='3110' then 'USA' end )

left join (select replace(a.item, ' ','')"Item",a.compnr,
	Datediff(DAY,dateadd(MINUTE,-29,dateadd(HOUR,-9,a.trdt)),getdate())"Differ",sum(a.qskt) "stock",sum(b.amnt_1)"StockVal",a.cwar
	from LN_whina112 a
	left join LN_whina113 b on b.compnr=a.compnr
			and replace(b.item, ' ','')=replace(a.item, ' ','') and b.cwar=a.cwar and b.trdt=a.trdt and b.seqn=1
where  a.qskt>0
	group by replace(a.item, ' ',''),a.compnr,Datediff(DAY,dateadd(MINUTE,-29,dateadd(HOUR,-9,a.trdt)),getdate()),a.cwar)
	c on c.item=replace(a.item, ' ','') and c.compnr=a.compnr
where c.stock>0
and a.compnr in (3110)  
--order by item



union all 

select distinct 'Brazil' "company"
,a.compnr,replace(a.item, ' ','')"Item",b.dsca as "descr",c.stock "OnHand",c.Differ,
case when c.Differ between 0 and 30 then '1. 0-30 Days'
	when c.Differ between 31 and 60 then '2. 31-60 Days'
	when c.Differ between 61 and 90 then '3. 61-90 Days'
	when c.Differ between 91 and 120 then '4. 91-120 Days'
	when c.Differ between 121 and 150 then '5. 121-150 Days'
	when c.Differ between 151 and 180 then '6. 151-180 Days'
	when c.Differ between 181 and 360 then '7. 181-360 Days'
	when c.Differ> 360 then '8. >360 Days' end "Ageing"
	,e1.dsca"dsca",isnull(f.dsca,'NA')"ProductLine",b.seab"Supplier",b.dscd"Model",c.cwar"cwar",(c.StockVal)"StockVal"
,b.seak,b1.cdf_extd"AlterName"
--Master data 
,mas.Demand_Forecasting_Unit_DFU,mas.HP,mas.KW,mas.Pressure_bar,mas.Pressure_psi,mas.Model 'Master_Model',mas.Variant,mas.Region,mas.Item_Category,mas.Product_group
from LN_whwmd215 a
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item, ' ','') and b.compnr=2000
left join LN_tcibd001 b1 on replace(b1.item,' ','')=b.seak and b1.compnr=2000
left join ln_tcmcs015 e1 on e1.ctyp=b.ctyp
left join LN_tcmcs023 f on replace(f.citg,' ','')=replace(b.citg,' ','')
--Joining master
left join elgi_sop.dbo.[TPL_MASTER_REF] mas on ltrim(rtrim(a.item))=ltrim(rtrim(mas.Item)) and mas.Region=(case when b.compnr='2000' then 'Brazil' end )


left join (select replace(a.item, ' ','')"Item",a.compnr,
	Datediff(DAY,dateadd(MINUTE,-29,dateadd(HOUR,-9,a.trdt)),getdate())"Differ",sum(a.qskt) "stock",sum(b.amnt_1)"StockVal",a.cwar
	from LN_whina112 a
	left join LN_whina113 b on b.compnr=a.compnr
			and replace(b.item, ' ','')=replace(a.item, ' ','') and b.cwar=a.cwar and b.trdt=a.trdt and b.seqn=1
where  a.qskt>0
	group by replace(a.item, ' ',''),a.compnr,Datediff(DAY,dateadd(MINUTE,-29,dateadd(HOUR,-9,a.trdt)),getdate()),a.cwar)
	c on c.item=replace(a.item, ' ','') and c.compnr=a.compnr
where c.stock>0
and a.compnr in (2000) 


union all 

select distinct 

case when left(c.cwar,2) in ('17','CB','CO','SC')  then 'Europe'
else 'Rotair' end "company"
,a.compnr,replace(a.item, ' ','')"Item",b.dsca as "descr",c.stock "OnHand",c.Differ,
case when c.Differ between 0 and 30 then '1. 0-30 Days'
	when c.Differ between 31 and 60 then '2. 31-60 Days'
	when c.Differ between 61 and 90 then '3. 61-90 Days'
	when c.Differ between 91 and 120 then '4. 91-120 Days'
	when c.Differ between 121 and 150 then '5. 121-150 Days'
	when c.Differ between 151 and 180 then '6. 151-180 Days'
	when c.Differ between 181 and 360 then '7. 181-360 Days'
	when c.Differ> 360 then '8. >360 Days' end "Ageing"
	,e1.dsca"dsca",isnull(f.dsca,'NA')"ProductLine",b.seab"Supplier",b.dscd"Model",c.cwar"cwar",(c.StockVal)"StockVal"
,b.seak,b1.cdf_extd"AlterName"
--Master data 
,mas.Demand_Forecasting_Unit_DFU,mas.HP,mas.KW,mas.Pressure_bar,mas.Pressure_psi,mas.Model 'Master_Model',mas.Variant,mas.Region,mas.Item_Category,mas.Product_group
from LN_whwmd215 a
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item, ' ','') and b.compnr=1100
left join LN_tcibd001 b1 on replace(b1.item,' ','')=b.seak and b1.compnr=1100
left join ln_tcmcs015 e1 on e1.ctyp=b.ctyp
left join LN_tcmcs023 f on replace(f.citg,' ','')=replace(b.citg,' ','')

left join (select replace(a.item, ' ','')"Item",a.compnr,
	Datediff(DAY,dateadd(MINUTE,-29,dateadd(HOUR,-9,a.trdt)),getdate())"Differ",sum(a.qskt) "stock",sum(b.amnt_1)"StockVal",a.cwar
	from LN_whina112 a
	left join LN_whina113 b on b.compnr=a.compnr
			and replace(b.item, ' ','')=replace(a.item, ' ','') and b.cwar=a.cwar and b.trdt=a.trdt and b.seqn=1
where  a.qskt>0
	group by replace(a.item, ' ',''),a.compnr,Datediff(DAY,dateadd(MINUTE,-29,dateadd(HOUR,-9,a.trdt)),getdate()),a.cwar)
	c on c.item=replace(a.item, ' ','') and c.compnr=a.compnr
--Joining master
left join elgi_sop.dbo.[TPL_MASTER_REF] mas on ltrim(rtrim(a.item))=ltrim(rtrim(mas.Item))
and mas.Region=(case when left(c.cwar,2) in ('17','CB','CO','SC')  then 'Europe'
else 'Rotair' end )

where c.stock>0
and a.compnr in (1100) 


union all

select case when inv.company=500 then 'ELGI GULF GCC' 
when inv.company=551 then 'ELGi - AUSTRALIA' 
when inv.company=552 then 'ELGi - INDONESIA' 
when inv.company=553 then 'ELGi - Malaysia' 
when inv.COMPANY in ('490','401') then 'ELGi - India'
end 'Company',inv.company 'compnr',ltrim(rtrim(inv.ITEM))'Itemcode',ItemDescr,QSKT,'',
case when Ageing='LessThan30' then '1. 0-30 Days'
	when Ageing='30-60' then '2. 31-60 Days'
	when Ageing='61-90' then '3. 61-90 Days'
	when Ageing='91-120' then '4. 91-120 Days'
	when Ageing='121-150' then '5. 121-150 Days'
	when Ageing='151-180' then '6. 151-180 Days'
	when Ageing='181-365' then '7. 181-360 Days'
	when Ageing in ('GreaterThan_4Years','GreaterThan_1Year','GreaterThan_2Years','GreaterThan_3Years','GreaterThan_5Years','GreaterThan_6Years') then '8. >360 Days' end "Ageing"
	,'','',SuppName,'',CWAR,Amnt,'',''
	--Master data 
,mas.Demand_Forecasting_Unit_DFU,mas.HP,mas.KW,mas.Pressure_bar,mas.Pressure_psi,mas.Model 'Master_Model',mas.Variant,mas.Region,mas.Item_Category,mas.Product_group
from ELGi_LN.dbo.Inventorydetails inv

--Joining master
left join elgi_sop.dbo.[TPL_MASTER_REF] mas on ltrim(rtrim(inv.item))=ltrim(rtrim(mas.Item))
and mas.Region=(case when inv.company=500 then 'ELGI GULF GCC' 
when inv.company=551 then 'AUS' 
when inv.company=552 then 'Indonesia' 
when inv.company=553 then 'Malaysia' 
when inv.company in ('401','490') then 'India'end )

where inv.company in (500,551,552,553,401,490)


) a


end



select * from [GR_SOP_Inventory]

GO

