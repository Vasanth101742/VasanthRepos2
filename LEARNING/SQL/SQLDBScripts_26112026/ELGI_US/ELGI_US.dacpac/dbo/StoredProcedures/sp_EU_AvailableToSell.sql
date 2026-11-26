
CREATE proc [dbo].[sp_EU_AvailableToSell] AS 

BEGIN 

truncate table EU_AvailableToSell


INSERT INTO EU_AvailableToSell (ITEMCODE,ITEMDESCR) 

SELECT DISTINCT TRIM(ITEM) ,ItemDescr from InventoryDetails_Subsidiaries where COMPANY='1100'
and cwar in ('170001','170987','sc0987','sc0985','sc0984','170981')

--select distinct trim(item),dsca FROM LN_TCIBD001 where compnr in ('1100','1700') --and cpln='l02'

--- Warehouse wise Stock

UPDATE EU_AvailableToSell set st170001 =isnull(a.St170001,0), st170987=isnull(a.St170987,0), St170981=isnull(a.St170981,0),StSC0987=isnull(a.StSC0987,0), 
StSC0985=isnull(a.Stsc0985,0), stSC0984=isnull(a.Stsc0984,0)


from (
select distinct
itemcode, itemdescr,isnull(sum(St170001),0)'ST170001' ,isnull(sum(St170987),0) 'St170987', isnull(sum(St170981),0) 'St170981',isnull(sum(Stsc0987),0)'Stsc0987', 
isnull(sum(Stsc0985),0) 'Stsc0985',isnull(sum(Stsc0984),0) 'Stsc0984' from 
(
SELECT DISTINCT TRIM(ITEM) 'ItemCode',ItemDescr,
case when cwar ='170001' then isnull(sum(qskt),0) end 'St170001' ,
case when cwar ='170987' then  isnull(sum(qskt),0) end 'St170987',
case when cwar ='170981' then isnull(sum(qskt),0)  end 'St170981',
case when cwar ='sc0987' then isnull(sum(qskt),0) end 'Stsc0987',
case when cwar ='sc0985' then isnull(sum(qskt),0)end 'Stsc0985',
case when cwar ='sc0984' then isnull(sum(qskt),0) end 'Stsc0984'
from InventoryDetails_Subsidiaries 
where COMPANY='1100'
and cwar in ('170001','170987','sc0987','sc0985','sc0984','170981') 
group by ITEM,ItemDescr,CWAR
)a 
group by ItemCode,ItemDescr

) a where EU_AvailableToSell.itemcode=a.ItemCode


--Backlog

update EU_AvailableToSell set backlog=isnull(a.openqty,0) from (

select itemcode,isnull(sum(openqty),0) 'OpenQty' from
(select distinct 
dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,a.ddta2))) as 'PlannedDelDate', a.ofbp 'Sold-to-BP',a.orno,pono,trim(a.item) 'ItemCode',
b.dsca 'ItemDescription',dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))) as 'odat',(a.qoor-a.qidl-qbbo)'openQty',(((a.qoor-a.qidl-qbbo)*a.pric)-amld)'OpenPrice',

case when
b.cpln<>'L02' then'Rotair' when 
b.cpln='L02' then'Elgi Europe' else 'Rotair'
 end 'Company',
sqnb,a.cwar,a.qoor,a.clyn,c.refa,c.sotp,c.refb ,
case when c.refa like '%SO#%' then 'Take StockOrder' else 'LN Order' end 'Type'
,a.pric,pror_KW,chrq_kw ,a.oamt, c.hdst_kw

from LN_TDSLS401 a 

left join LN_TCIBD001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='1100' and b.deleted='N'

left join LN_TDSLS400 c on c.compnr=a.compnr and c.orno=a.orno and c.deleted='N'

where a.compnr in('1100','1700') and a.deleted='N' and (a.qoor-a.qidl-a.qbbo) > 0 and isnull(c.sotp,'-')<>'-' 

and a.clyn=2 and c.hdst_kw<>'tdsls.hdst.cancelled' and isnull(YEAR(c.odat2),'')<>'' AND B.cpln='L02'

)a
where orno not like 'BLOC%'
group by ItemCode


) a where EU_AvailableToSell.itemcode=a.ItemCode


--Reserved TPLs


update EU_AvailableToSell set Reserved=isnull(a.openqty,0) from (

select itemcode,isnull(sum(openqty),0) 'openqty' from
(select distinct 
dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,a.ddta2))) as 'PlannedDelDate', a.ofbp 'Sold-to-BP',a.orno,pono,trim(a.item) 'ItemCode',
b.dsca 'ItemDescription',dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))) as 'odat',(a.qoor-a.qidl-qbbo)'openQty',(((a.qoor-a.qidl-qbbo)*a.pric)-amld)'OpenPrice',

case when
b.cpln<>'L02' then'Rotair' when 
b.cpln='L02' then'Elgi Europe' else 'Rotair'
 end 'Company',
sqnb,a.cwar,a.qoor,a.clyn,c.refa,c.sotp,c.refb ,
case when c.refa like '%SO#%' then 'Take StockOrder' else 'LN Order' end 'Type'
,a.pric,pror_KW,chrq_kw ,a.oamt, c.hdst_kw

from LN_TDSLS401 a 

left join LN_TCIBD001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='1100' and b.deleted='N'

left join LN_TDSLS400 c on c.compnr=a.compnr and c.orno=a.orno and c.deleted='N'

where a.compnr in('1100','1700') and a.deleted='N' and (a.qoor-a.qidl-a.qbbo) > 0 and isnull(c.sotp,'-')<>'-' 

and a.clyn=2 and c.hdst_kw<>'tdsls.hdst.cancelled' and isnull(YEAR(c.odat2),'')<>'' AND B.cpln='L02'

)a
where orno like 'BLOC%'
group by ItemCode

)a where EU_AvailableToSell.itemcode=a.ItemCode


update EU_AvailableToSell set ST170001= 0 where ST170001 is null

update EU_AvailableToSell set ST170987= 0 where ST170987 is null

update EU_AvailableToSell set STsc0987= 0 where STsc0987 is null

update EU_AvailableToSell set stsc0985= 0 where stsc0985 is null

update EU_AvailableToSell set stsc0984= 0 where stsc0984 is null

update EU_AvailableToSell set st170981= 0 where st170981 is null

update EU_AvailableToSell set backlog= 0 where backlog is null

update EU_AvailableToSell set Reserved= 0 where reserved is null

UPDATE EU_AvailableToSell set ONHAND=ST170001 +ST170987+STsc0987+stsc0985+stsc0984-backlog

UPDATE EU_AvailableToSell set ONHAND=0 where onhand is null

update  EU_AvailableToSell set Total= Onhand +st170981

update  EU_AvailableToSell set Total=0 where total is null

update EU_AvailableToSell set AvailableToSell = case when Total<=0 then 0 when onhand<0 then 0 else onhand end

update EU_AvailableToSell set AvailableToSell = 0 where AvailableToSell is null
--alter table EU_AvailableToSell add TransitFinal float

update EU_AvailableToSell set TransitFinal = case when Total<=0 then 0 when onhand<0 then total else St170981 end

update EU_AvailableToSell set TransitFinal = 0 where TransitFinal is null



update EU_AvailableToSell set BaseTPL = a.base_machine from (select * from EU_AvailableToSell_Mapping )a where EU_AvailableToSell.ItemCode=a.tpl

update EU_AvailableToSell set BaseTPL = ItemCode where baseTPl is null

--Alter table EU_AvailableToSell add BaseTPLDesc nvarchar(150)

update EU_AvailableToSell set BaseTPLDesc=a.dsca from ( 
select * from LN_TCIBD001 where compnr='1100' ) a where trim(a.item)=EU_AvailableToSell.basetpl



--alter table  EU_AvailableToSell add BaseTPL nvarchar(150)
update EU_AvailableToSell set ProductLine=a.Product_line,productLine_2=a.Product_Line_II,productline_3=a.Product_line_III,type1=a.Type
,KW=a.kw,pressure=a.Pressure,vfd=a.VFD,ttd=a.T_TD, tanksize=a.Tank_Size,premium=a.Premium, ProductLine_4_ProductType=a.Product_line_IV_Prouct_Type, PriceGroup=a.Price_Groups

from (
select * from EU_ItemDetails )a 
where trim(EU_AvailableToSell.BaseTPL)=trim(a.ItemCode)


update EU_AvailableToSell set ProductLine_4_ProductType = 'Heatless Desicc. Dryer' where ProductLine_4_ProductType in ('Heatless Desicc. Dryer - HDD')

update EU_AvailableToSell set ProductLine_4_ProductType = 'Modular Desicc. Dryer' where ProductLine_4_ProductType in ('Modular Desicc. Dryer w/EDCC - MMD')

update EU_AvailableToSell set ProductLine_4_ProductType = 'VFD Dryer - EED' where ProductLine_4_ProductType in ('Cycling Dryer, VFD - EED')



END



--2985

--select distinct ProductLine_4_ProductType from EU_AvailableToSell order by ProductLine_4_ProductType

GO

