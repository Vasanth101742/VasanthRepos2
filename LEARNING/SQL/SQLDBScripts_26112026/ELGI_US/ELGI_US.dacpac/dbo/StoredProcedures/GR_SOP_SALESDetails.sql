

CREATE proc [dbo].[GR_SOP_SALESDetails]

as
begin


select distinct a.line,case when a.compnr=3100 then'ELGI NA'
when a.compnr=3110 then'Industrial'
when a.compnr=3120 then'Portables'
when a.compnr=3130 then'Pattons Medical'
when a.compnr=3140 then'Pattons INC'
when a.compnr=3150 then'Michigan' end "compnr",dateadd(MINUTE ,-29,dateadd(hour,-9,c.idat2)) as idat,a.[tran],a.idoc,replace(a.item,' ','')"ItemCode",b.dsca,a.orno,dateadd(MINUTE ,-29,dateadd(hour,-9,a.odat)) as odat
,replace(c.itbp,' ','')"CusCode",isnull(d.nama,'NA')"BPName",f.dsca as "ProductLine"
,a.pono,a.dqua,a.cuqs,a.amti,a.amth_1,a.invt_KW,c.stat_kw,g.Demand_Forecasting_Unit_DFU,g.Model,g.hp,g.India_TPL,g.KW,g.Pressure_bar,g.Pressure_psi,g.Variant,g.Item_Category,g.Product_Group
from 
LN_cisli310 a
left join LN_cisli305 c on c.idoc=a.idoc and c.[tran]=a.[tran] and c.compnr=a.compnr  and c.deleted='N'
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='3100'  and b.deleted='N'
left join LN_tccom100 d on replace(d.bpid,' ','')=replace(c.itbp,' ','') and d.compnr='3100'   and d.deleted='N'
left join LN_tcmcs023 f on replace(f.citg,' ','')=replace(b.citg,' ','') and d.compnr='3100'  and f.deleted='N'
left join SOP_TPL_Master_Final  g on g.Item=replace(a.item,' ','') and g.region='USA'
where  a.compnr in  (3100,3110,3120,3130,3140,3150)  and a.deleted='N' and c.stat='80' and dateadd(MINUTE ,-29,dateadd(hour,-9,c.idat2))>'20230331'
and replace(c.itbp,' ','')not in ('CRE000013','CRE000082','CU1E00625','CU1E00804','CU1E00847','CRE000109','CU1E00880','CU1R01967','CRE000189')

union 

select distinct a.line,case when a.compnr=1100 then'Rotair'
 when a.compnr=1700 then'Elgi Europe' end "compnr",dateadd(MINUTE ,-29,dateadd(hour,-3,c.idat2)) as idat,a.[tran],a.idoc,replace(a.item,' ','')"ItemCode",b.dsca,a.orno,dateadd(MINUTE ,-29,dateadd(hour,-3,a.odat)) as odat
,replace(c.itbp,' ','')"CusCode",isnull(d.nama,'NA')"BPName",f.dsca as "ProductLine"
,a.pono,a.dqua,a.cuqs,a.amti,a.amth_1,a.invt_KW,c.stat_kw,g.Demand_Forecasting_Unit_DFU,g.Model,g.hp,g.India_TPL,g.KW,g.Pressure_bar,g.Pressure_psi,g.Variant,g.Item_Category,g.Product_Group
from 
LN_cisli310 a
left join LN_cisli305 c on c.idoc=a.idoc and c.[tran]=a.[tran] and c.compnr=a.compnr  and c.deleted='N'
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='1100'  and b.deleted='N'
left join LN_tccom100 d on replace(d.bpid,' ','')=replace(c.itbp,' ','') and d.compnr='1100'   and d.deleted='N'
left join LN_tcmcs023 f on replace(f.citg,' ','')=replace(b.citg,' ','') and d.compnr='1100'  and f.deleted='N'
left join SOP_TPL_Master_Final  g on g.Item=replace(a.item,' ','') and  g.region ='europe'
where   a.compnr in  (1100,1700)  and a.deleted='N' and c.stat='80' and c.stat_kw='tcsli.stat.posted' and dateadd(MINUTE ,-29,dateadd(hour,-3,c.idat2))>'20230331'
and replace(c.itbp,' ','')not in ('CRE000013','CRE000082','CU1E00625','CU1E00804','CU1E00847','CRE000109','CU1E00880','CU1R01967','CRE000189') and a.[tran] <> 'ZCR'

union 

select '' as line,
case when a.company=490 then 'GSC'
when a.company=401 then 'HO'
when a.company=500 then 'GULF'
when a.company=553 then 'MALAYSIA'
when a.company=552 then 'INDONESIA'
when a.company=551 then 'AUSTRALIA'
end ,convert(date,a.[Date])idat,a.SaleOrderType,a.Invoice,a.ItemCode,a.Item_desc,a.OrderNum,convert(date,a.order_Date)odat,a.CustCode,a.custname,a.Item_Category
,a.positionno,a.DeliveredQty,'',a.AssesValue,a.AssesValue,'','',g.Demand_Forecasting_Unit_DFU,g.Model,g.hp,g.India_TPL,g.KW,g.Pressure_bar,g.Pressure_psi,g.Variant,g.Item_Category,g.Product_Group
from  elgi_ln.dbo.sales_report_LN a
left join SOP_TPL_Master_Final  g on g.Item=replace(a.ItemCode,' ','') 
and g.Region in (case when a.company=490 then 'India'					when a.company=401 then 'India'					when a.company=500 then 'India'					when a.company=553 then 'Malaysia'
					when a.company=552 then 'Indonesia'					when a.company=551 then 'AUS'					end)

where  convert(date,a.[Date]) >'20230331' and isnull(dpst,'')<>'' and a.company in (401,490,500,553,551,552) 
and a.CustCode not in ('CRE000013','CRE000082','CU1E00625','CU1E00804','CU1E00847','CRE000109','CU1E00880','CU1R01967','CRE000189')


union 


select '','Brazil',convert(date,dateadd(MINUTE ,-29,dateadd(hour,-8,c.idat2))) as idat,a.[tran],a.idoc
,replace(a.item,' ','')"ItemCode",b.dsca,a.orno,convert(date,dateadd(MINUTE ,-29,dateadd(hour,-9,a.odat))) as odat
 ,replace(c.itbp,' ','')"CusCode",isnull(d.nama,'NA')"BPName",f.dsca as "ProductLine"
,a.pono,a.dqua,a.cuqs,a.amti,a.amth_1,a.invt_KW ,'',g.Demand_Forecasting_Unit_DFU,g.Model,g.hp,g.India_TPL,g.KW,g.Pressure_bar,g.Pressure_psi,g.Variant,g.Item_Category,g.Product_Group

from LN_cisli310 a
left join LN_cisli305 c on c.idoc=a.idoc and c.[tran]=a.[tran] and c.compnr=a.compnr  and c.deleted='N'
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='2000'  and b.deleted='N'
left join LN_tccom100 d on replace(d.bpid,' ','')=replace(c.itbp,' ','') and d.compnr='2000'   and d.deleted='N'
left join LN_tcmcs023 f on replace(f.citg,' ','')=replace(b.citg,' ','') and d.compnr='2000'   and f.deleted='N'
left join SOP_TPL_Master_Final  g on g.Item=replace(a.item,' ','') and g.region ='brazil'

where  a.compnr =2000  and a.deleted='N'


end

GO

