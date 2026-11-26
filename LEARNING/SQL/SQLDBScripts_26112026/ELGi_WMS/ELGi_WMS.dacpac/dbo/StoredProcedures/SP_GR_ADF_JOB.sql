

CREATE proc [dbo].[SP_GR_ADF_JOB]
as
begin
set nocount on 


exec [SP_HOURLY_BILLING]

exec [sp_Hourly_Packing]


end

GO

