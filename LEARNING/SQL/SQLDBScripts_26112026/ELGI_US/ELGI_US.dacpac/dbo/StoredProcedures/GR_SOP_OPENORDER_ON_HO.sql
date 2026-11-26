

CREATE proc [dbo].[GR_SOP_OPENORDER_ON_HO]

as
begin

select case when compnr= '3110' then 'USA'
when compnr='2000' then 'Brazil'
when compnr='1100' and orno like 'EA%' then 'Elgi Europe' 
when compnr='1100' and orno like 'OA%' then 'Rotair' 
end company,orno,pono,a.item,pric,qana,convert(date,ordt)'Odat',bpid,
case when bpid in ('G00000009') then 'GSC' else 'HO' end 'Order Placeed'
,(pric*qana)'Amount',Demand_Forecasting_Unit_DFU
 --Added by me 
,g1.model,g1.hp,g1.kw,g1.[Pressure_bar],g1.[Pressure_psi],g1.variant
from ln_whinp100 a
left join [ELGi_SOP].dbo.[TPL_MASTER_REF]  g1 on g1.Item=replace(a.item,' ','') and g1.region in ( case when compnr= '3110' then 'USA' when compnr='2000' then 'Brazil' when compnr='1100' then 'europe' end)

where koor = 2  and bpid in ('G00000001','G00000009','PN0001000','33-00001')
and compnr<>'2000'

union all

select case when compnr= '3110' then 'USA'
when compnr='2000' then 'Brazil'
when compnr='1100' and orno like 'EA%' then 'Elgi Europe' 
when compnr='1100' and orno like 'OA%' then 'Rotair'  end company,orno,pono,a.item,pric,qana,convert(date,ordt)'Odat',bpid,
case when bpid in ('G00000009') then 'GSC' else 'HO' end 'Order Placeed'
,(pric*qana)'Amount',Demand_Forecasting_Unit_DFU
 --Added by me 
,g1.model,g1.hp,g1.kw,g1.[Pressure_bar],g1.[Pressure_psi],g1.variant
from ln_whinp100 a
left join [ELGi_SOP].dbo.[TPL_MASTER_REF]  g1 on g1.Item=replace(a.item,' ','') and g1.Region= 'brazil'
where koor = 2  and bpid in ('G00000001','G00000009','PN0001000','33-00001')
and compnr='2000'

union all



select case when CustCode='CU1E00625' then 'Gulf'
when custcode='CU1E00804' then 'Australia'
when custcode='CU1E00880' then 'Indonesia'
when custcode='CRE000189' then 'Malaysia'
end company ,OrderNum,PositionNum,ltrim(rtrim(itemcode)),round(Price,2),PendQty,OrderDate,CustCode,case when a.Company='401' then 'HO' else 'GSC' end ,round([value],2),Demand_Forecasting_Unit_DFU
 --Added by me 
,g1.model,g1.hp,g1.kw,g1.[Pressure_bar],g1.[Pressure_psi],g1.variant
from elgi_ln.dbo.pending_orders a
left join [ELGi_SOP].dbo.[TPL_MASTER_REF]  g1 on g1.Item=replace(a.ItemCode,' ','') and g1.Region in (case when CustCode='CU1E00625' then 'India'
when custcode='CU1E00804' then 'Aus' when custcode='CU1E00880' then 'Indonesia' when custcode='CRE000189' then 'Malaysia' end)
where a.Company in (490,401) and CustCode in ('CU1E00625','CU1E00804','CU1E00880','CRE000189')


end 

--4471

GO

