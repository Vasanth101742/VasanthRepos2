CREATE PROCEDURE [dbo].[sp_updateInvoice]
	@id int,@pid nvarchar(200)
AS
BEGIN
	
	INSERT INTO acr_payment (id,[compnr]
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
      ,[payment_date],initiated_date)
SELECT ID,[compnr]
      ,[ttyp]
      ,[ninv]
      ,[line]
      ,[itbp]
      ,[ccur]
      ,[rate_1]
      ,[docd]
      ,[prod]
      ,[year]
      ,[InvAmth]
      ,[PaidAmth]
      ,[OutstandingAmth]
      ,[BPName],0,@PID,'',GETDATE()
FROM acr_debtors_US
WHERE id = @id

select OutstandingAmth from acr_debtors_US where id = @id
	
END

GO

