CREATE PROCEDURE [dbo].[sp_updatepaymentcc]  
 -- Add the parameters for the stored procedure here  
 @id nvarchar(200),@paypalid nvarchar(200),@transactionstatus nvarchar(50) 
AS  
BEGIN  
 update acr_payment set payment_status = 1,payment_date=GETDATE(),paypal_id=@paypalid,transactionstatus=@transactionstatus where refnumber = @id  
END

GO

