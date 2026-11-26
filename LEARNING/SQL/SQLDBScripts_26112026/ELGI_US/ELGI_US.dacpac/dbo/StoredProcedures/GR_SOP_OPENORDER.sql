
CREATE proc [dbo].[GR_SOP_OPENORDER]
as
begin


select distinct case when
b.cpln<>'L02' then'Rotair' when 
b.cpln='L02' then'Elgi Europe' else 'Rotair' end
"Company",
dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))) as odat,replace(a.item,' ','')"ItemCode",b.dsca,a.orno,pono,sqnb,a.qoor
,a.pric,a.oamt,dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,a.ddta2))) as DelDate
,format(convert(datetime,dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2)))),'MMM-yyyy') 'Month-Year',
qoor'Qty',qidl,(a.qoor-a.qidl-qbbo)'openQty',(((a.qoor-a.qidl-qbbo)*a.pric)-amld)'OpenPrice',g.nama,g1.Demand_Forecasting_Unit_DFU
--Added by me 
,g1.model,g1.hp,g1.kw,g1.[Pressure_bar],g1.[Pressure_psi],g1.variant
from LN_tdsls401 a 
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='1100' and b.deleted='N'
left join LN_tdsls400 c on c.compnr=a.compnr and c.orno=a.orno and c.deleted='N'
left join LN_TCCom100 g on g.bpid=c.ofbp  and g.deleted='N'
left join [ELGi_SOP].dbo.[TPL_MASTER_REF]  g1 on g1.Item=replace(a.item,' ','') and g1.region='europe'
where a.compnr in('1100','1700') and a.deleted='N' and (a.qoor-a.qidl-qbbo)>0 and isnull(sotp,'-')<>'-' 
and a.clyn=2 and c.hdst_kw<>'tdsls.hdst.cancelled' and isnull(YEAR(c.odat2),'')<>'' and  qoor>0


union 

 select 'Industrial',odat,itemcode,dsca,orno,pono,sqnb,qoor,pric,oamt,deldate,[month-year],qoor'Qty',qidl,openqty,openprice,nama,g1.Demand_Forecasting_Unit_DFU
 --Added by me 
,g1.model,g1.hp,g1.kw,g1.[Pressure_bar],g1.[Pressure_psi],g1.variant
 from [US_OpenOrder] a
left join [ELGi_SOP].dbo.[TPL_MASTER_REF]  g1 on g1.Item=replace(a.itemcode,' ','') and g1.region='usa'
 where compnr='3110' and qoor>0

 union 
  

 select * from (
select  'Brazil'
"Company",
dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))) as odat,replace(a.item,' ','')"ItemCode",b.dsca,a.orno,pono,sqnb,qoor
,a.pric,a.oamt,dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,a.ddta2))) as DelDate
,format(convert(datetime,dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2)))),'MMM-yyyy') 'Month-Year',
qoor'Qty',qidl,(a.qoor-a.qidl-qbbo)'openQty',(((a.qoor-a.qidl-qbbo)*a.pric)-amld)'OpenPrice',g.nama,g1.Demand_Forecasting_Unit_DFU
--Added by me 
,g1.model,g1.hp,g1.kw,g1.[Pressure_bar],g1.[Pressure_psi],g1.variant

from LN_tdsls401 a 
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='2000' and b.deleted='N'
left join LN_tdsls400 c on c.compnr=a.compnr and c.orno=a.orno and c.deleted='N' 
left join LN_TCCom100 g on g.bpid=c.ofbp  and g.deleted='N' and g.compnr='2000'
left join [ELGi_SOP].dbo.[TPL_MASTER_REF]  g1 on g1.Item=replace(a.item,' ','') and g1.region='brazil'
where a.compnr='2000'
and a.deleted='N'   and a.qidl=0
and isnull(sotp,'-')<>'-' 
and a.clyn=2 and c.hdst_kw not in ('tdsls.hdst.cancelled','tdsls.hdst.closed') and isnull(YEAR(c.odat),'')<>''
and c.clyn=2  
and  CONCAT(a.compnr,a.orno,pono,a.sqnb) not in  (select concat(a.compnr,a.orno,pono,a.sqnb) from  LN_TDSLS406 a)) g2


union 

select case when a.Company=500 then 'ELGI GULF GCC' 
when a.Company=551 then 'ELGi - AUSTRALIA' 
when a.Company=552 then 'ELGi - INDONESIA' 
when a.Company=553 then 'ELGi - Malaysia'  end 'Company',OrderDate,ltrim(rtrim(ItemCode))ItemCode,Item_desc,OrderNum,PositionNum,seq,ord_qty,price,[value],
DeliveryDate,concat(left(OrderMonth,3),'-',OrderMonthYear),ord_qty,0,PendQty,[value],Custname,g1.Demand_Forecasting_Unit_DFU
--Added by me 
,g1.model,g1.hp,g1.kw,g1.[Pressure_bar],g1.[Pressure_psi],g1.variant
from elgi_ln.dbo.pending_orders a
left join [ELGi_SOP].dbo.[TPL_MASTER_REF]  g1 
on g1.Item=replace(a.ItemCode,' ','') 
and g1.region in (case when a.company=490 then 'India' 
when a.company=401 then 'India' 
when a.company=500 then 'India' 
when a.company=553 then 'Malaysia'
when a.company=552 then 'Indonesia' 
when a.company=551 then 'AUS' end)
where a.Company in (500,551,552,553)
end

GO

