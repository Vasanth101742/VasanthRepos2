CREATE PROCEDURE [dbo].[sp_updatepayment_authorize]
	-- Add the parameters for the stored procedure here
	@id nvarchar(200),@paypalid nvarchar(200)
AS
BEGIN

	--Need to change
	update acr_payment set payment_status = 1,payment_date=GETDATE(),paypal_id=@paypalid where refnumber = @id
END

GO

