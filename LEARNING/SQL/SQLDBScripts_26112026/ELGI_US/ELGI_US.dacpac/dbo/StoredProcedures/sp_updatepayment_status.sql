CREATE proc sp_updatepayment_status  
as  
begin  

insert into acr_payment_failed ([compnr]
      ,[ttyp]
      ,[ninv]
      ,[line]
      ,[itbp]
      ,[ccur]
      ,[rate_1]
      ,[docd]
      ,[prod]
      ,[year]
      ,[InAmth]
      ,[PaidAmth]
      ,[OutstandingAmth]
      ,[BPName]
      ,[payment_status]
      ,[refnumber]
      ,[payment_date]
      ,[paypal_id]
      ,[dued]
      ,[initiated_date]) select [compnr]
      ,[ttyp]
      ,[ninv]
      ,[line]
      ,[itbp]
      ,[ccur]
      ,[rate_1]
      ,[docd]
      ,[prod]
      ,[year]
      ,[InAmth]
      ,[PaidAmth]
      ,[OutstandingAmth]
      ,[BPName]
      ,[payment_status]
      ,[refnumber]
      ,[payment_date]
      ,[paypal_id]
      ,[dued]
      ,[initiated_date] from acr_payment WHERE [payment_status] = 0 and [initiated_date] <= getdate() - (5/1440)

delete from [dbo].[acr_payment] WHERE [payment_status] = 0 and [initiated_date] <= getdate() - (5/1440)
  
end

GO

