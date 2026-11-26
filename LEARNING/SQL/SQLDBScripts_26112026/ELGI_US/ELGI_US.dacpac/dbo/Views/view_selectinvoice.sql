CREATE VIEW view_selectinvoice AS
SELECT        acr_debtors_US.compnr, acr_debtors_US.ttyp, acr_debtors_US.ninv, acr_debtors_US.line, acr_debtors_US.itbp, acr_debtors_US.ccur, acr_debtors_US.rate_1, acr_debtors_US.docd, acr_debtors_US.prod, acr_debtors_US.year, 
                         acr_debtors_US.InvAmth, acr_debtors_US.PaidAmth, acr_debtors_US.OutstandingAmth, acr_debtors_US.BPName, acr_debtors_US.ID, acr_payment.payment_status, acr_payment.refnumber, acr_payment.payment_date, 
                         acr_payment.paypal_id, acr_payment.dued, acr_payment.initiated_date
FROM            acr_debtors_US LEFT OUTER JOIN
                         acr_payment ON acr_debtors_US.compnr = acr_payment.compnr AND acr_debtors_US.ninv = acr_payment.ninv AND acr_debtors_US.line = acr_payment.line AND acr_debtors_US.itbp = acr_payment.itbp

GO

