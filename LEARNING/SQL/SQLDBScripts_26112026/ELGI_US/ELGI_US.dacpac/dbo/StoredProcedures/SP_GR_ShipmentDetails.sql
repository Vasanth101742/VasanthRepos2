
CREATE proc [dbo].[SP_GR_ShipmentDetails]
as
begin
select case when a.compnr='3110' then 'Industrial'
when a.compnr='3120' then 'Portables'
when a.compnr='3130' then 'Medical'
when a.compnr='3140' then 'Pattons'
when a.compnr='3150' then 'MAS'
end 'Compnr'
,convert(date,ShipDate)ShipDate,trnr,so,invnum,convert(date,odat)'OrderDate',PONum,Item,[Desc],qidl'Qty',damt'Amount',b.nama from [dbo].[Shipment_Details] a
left join LN_TCCOM100 b on b.bpid=a.CustNum and b.compnr='3100'

where-- CustNum ='C00002024' and 
 a.compnr='3110'  and CustNum='I00000005'
order by compnr,CustNum,convert(date,ShipDate) desc
end

GO

