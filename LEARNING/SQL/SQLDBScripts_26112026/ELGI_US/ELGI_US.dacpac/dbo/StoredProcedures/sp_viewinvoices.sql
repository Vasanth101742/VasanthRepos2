CREATE proc [dbo].[sp_viewinvoices]   
(@compnr nvarchar(50),@itbp nvarchar(50))  
as    
begin    
    
  
  SELECT *  
FROM   acr_debtors_US C  
WHERE C.compnr=@compnr and C.itbp = @itbp and OutstandingAmth > 0 and NOT EXISTS (SELECT 1  
                   FROM   acr_payment e  
                   WHERE  c.compnr = e.compnr and c.ninv = e.ninv and c.line = e.line)  

--SELECT [compnr]
--      ,[ttyp]
--      ,[ninv]
--      ,[line]
--      ,[itbp]
--      ,[ccur]
--      ,[rate_1]
--      ,[docd]
--      ,[prod]
--      ,[year]
--      ,[InvAmth]
--      ,[PaidAmth]
--      ,[OutstandingAmth]
--      ,[BPName]
--	  ,ID
      
--  FROM [dbo].[acr_debtors_US] where compnr=@compnr and itbp = @itbp and OutstandingAmth > 0

--EXCEPT

--SELECT [compnr]
--      ,[ttyp]
--      ,[ninv]
--      ,[line]
--      ,[itbp]
--      ,[ccur]
--      ,[rate_1]
--      ,[docd]
--      ,[prod]
--      ,[year]
--      ,[InAmth]
--      ,[PaidAmth]
--      ,[OutstandingAmth]
--      ,[BPName]
--	  ,id
      
--  FROM [dbo].[acr_payment]
  
  --select * from acr_debtors_US MINUS select * from acr_payment  
  
--SELECT        acr_payment.payment_status, acr_payment.refnumber AS refnumber, acr_payment.payment_date AS payment_date, acr_payment.paypal_id, acr_debtors_US.compnr, acr_debtors_US.ttyp, acr_debtors_US.ninv, acr_debtors_US.line,     
--                         acr_debtors_US.itbp, acr_debtors_US.ccur, acr_debtors_US.rate_1, acr_debtors_US.docd, acr_debtors_US.prod, acr_debtors_US.year, acr_debtors_US.InvAmth, acr_debtors_US.PaidAmth, acr_debtors_US.OutstandingAmth,     
--                         acr_debtors_US.BPName, acr_debtors_US.ID    
--FROM            acr_debtors_US INNER JOIN    
--                         acr_payment ON acr_debtors_US.compnr = acr_payment.compnr AND acr_debtors_US.ttyp = acr_payment.ttyp AND acr_debtors_US.ninv = acr_payment.ninv AND acr_debtors_US.line = acr_payment.line    
    
end

GO

