

CREATE proc [dbo].[SP_GR_WMS_JOB]
as
begin
set nocount on 




exec [ELGIPENDINGPUTAWAY]

exec [sp_wmwhse1_ELGILPNDETAIL]

exec [sp_inward]

exec [sp_wms_order_status]

exec [SP_HOURLY_BILLING]

exec [sp_Hourly_Packing]



end

GO

