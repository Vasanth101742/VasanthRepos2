-- =============================================
-- Author:		Raviprasath S
-- Create date: 27/06/2025
-- Description:	Acr_payment_procedure
-- =============================================
CREATE PROCEDURE [dbo].[sp_acr_payment]
	
AS
BEGIN

Insert into acr_payment 
Select *,null as transactionstatus from acr_payment_failed 
Where refnumber = 'a63dfead-4684-49a6-90ba-a94d7d229a74'     --Copy the ref number from acr_payment_failed table 


Update acr_payment Set paypal_id = 'AV0A1B961F67', payment_status = 1,payment_date = initiated_date
Where refnumber = 'a63dfead-4684-49a6-90ba-a94d7d229a74'

Select * from acr_payment 
Where paypal_id = 'AV0A1B961F67'

END


--Exec [dbo].[sp_acr_payment]

GO

