
CREATE proc [dbo].[Sp_Wms_locationln]
as
begin
set nocount on

select substring(EXT_UDF_STR2,5,LEN(EXT_UDF_STR2)-4) 'ShipmentNo',CODE as BoxNo,EXT_UDF_STR5 as "Location" ,ext_UDF_STR3 as LpnNo
,getdate() as UpdatedDate,FORMAT(getdate(),'ddMMyy')+'-'+FORMAT(getdate(),'HH:mm') as Login
from [dbo].[WMWHSE1_CODELKUP] as WMSLocation
where DESCRIPTION like '%pack order%' 
and isnull(EXT_UDF_STR5,'')<>''
and EXT_UDF_STR2 like '%SHO%' --and EXT_UDF_LKUP1=2
and convert(date,ADDDATE)>=dateadd(d,-1,convert(date,getdate()))
order by substring(EXT_UDF_STR2,5,LEN(EXT_UDF_STR2)-4),code
for XML AUTO,Elements,root('DataArea')

end

GO

