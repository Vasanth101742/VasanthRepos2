CREATE proc [dbo].[sp_viewinvoices_admin]   
as    
begin    
    
  
select * from acr_payment order by payment_date desc
  
--SELECT        acr_payment.payment_status, acr_payment.refnumber AS refnumber, acr_payment.payment_date AS payment_date, acr_payment.paypal_id, acr_debtors_US.compnr, acr_debtors_US.ttyp, acr_debtors_US.ninv, acr_debtors_US.line,     
--                         acr_debtors_US.itbp, acr_debtors_US.ccur, acr_debtors_US.rate_1, acr_debtors_US.docd, acr_debtors_US.prod, acr_debtors_US.year, acr_debtors_US.InvAmth, acr_debtors_US.PaidAmth, acr_debtors_US.OutstandingAmth,     
--                         acr_debtors_US.BPName, acr_debtors_US.ID    
--FROM            acr_debtors_US INNER JOIN    
--                         acr_payment ON acr_debtors_US.compnr = acr_payment.compnr AND acr_debtors_US.ttyp = acr_payment.ttyp AND acr_debtors_US.ninv = acr_payment.ninv AND acr_debtors_US.line = acr_payment.line    
    
end

GO

