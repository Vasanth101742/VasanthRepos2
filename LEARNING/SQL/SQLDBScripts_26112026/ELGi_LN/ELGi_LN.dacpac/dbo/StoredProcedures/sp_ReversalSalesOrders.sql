--exec sp_ReversalSalesOrders
CREATE Proc sp_ReversalSalesOrders as
begin

--Drop table ReversalSalesOrders_Temp

Truncate table ReversalSalesOrders

--sp_rename 'ReversalSalesOrders.Invoice','OriginalInvoice'
--sp_rename 'ReversalSalesOrders.t_txah_1','TaxAmnt'
--select * into ReversalSalesOrders_Temp from
--(select Company,OriginalInvDate,OriginalInvoice,ReversalAODate,ReversalOrderNo,
--PONO,SQNB,CreditNote,ReversalInvoiceDate,ReversalInvoice,custcode,custname,Item,Item_desc,DeliveryQty,UnitPrice,Sales_amount,
--DiscPercent,DiscAmnt,Sales_After_Discount,Taxcode,TaxAmnt,null as TotalValue
--from ReversalSalesOrders)a
--select * into ReversalSalesOrders from ReversalSalesOrders_Temp




Insert into ReversalSalesOrders(Company,OriginalInvoice,--invoice_date,
ReversalOrderNo,ReversalAODate,PONO,SQNB,CreditNote)
select a.Company,case when len(Invoice)<=3 then '' else Invoice end as Invoice,
ReversalOrderNo,ReversalAODate,PONO,SQNB,CreditNote 
from (select t_odat as ReversalAODate,company,t_orno as ReversalOrderNo,
concat(Company,t_rtyp,t_odno) as Invoice from TTDSLS400ALL
where t_odty=4
--and concat(company,t_orno)='401240001111'
--and concat(company,t_orno)='401201001850'
--and concat(company,t_rtyp,t_odno)='40121133017608'
--and concat(company,t_rtyp,t_odno)='40121131010477'
)a
left outer join (select distinct Company,ORNO,PONO,SQNB,concat(SCMP,TTYP,INVN) as CreditNote from TTDslS406ALL
--where concat(Company,ORNO,PONO,SQNB)='401240001111100'
)b
on a.company=b.COMPANY
and a.ReversalOrderNo=b.ORNO


update ReversalSalesOrders set OriginalInvDate=a.invoice_date
from(select distinct concat(company,trantype,invoice) as Invoice,invoice_date
from ELGi_Sales_Details
--where concat(company,trantype,invoice)='40121131010477'
)a
where ReversalSalesOrders.OriginalInvoice=a.Invoice

update ReversalSalesOrders set OriginalInvDate=a.invoice_date
from(
select distinct concat(company,trantype,invoice) as Invoice,invoice_date from LN_SALES_BDI
union
select distinct concat(company,trantype,invoice) as Invoice,invoice_date from FRT_Sales
union
select distinct concat(company,trantype,invoice) as Invoice,invoice_date from Auction_sales
)a
where ReversalSalesOrders.OriginalInvoice=a.Invoice



update ReversalSalesOrders set ReversalInvoiceDate=a.invoice_date,ReversalInvoice=a.Invoice
from(select distinct company,orderno,concat(company,trantype,invoice) as Invoice,invoice_date
from Elgi_sales_details
--where concat(company,trantype,invoice)='40125230000121'
--where concat(company,trantype,invoice)='40121133017608'
--where concat(company,Orderno)='401240001111'
)a
where ReversalSalesOrders.Company=a.Company
and ReversalSalesOrders.ReversalOrderNo=a.orderno

update ReversalSalesOrders set ReversalInvoiceDate=a.invoice_date,ReversalInvoice=a.Invoice
from(select distinct company,orderno,concat(company,trantype,invoice) as Invoice,invoice_date
from LN_SALES_BDI
union
select distinct company,orderno,concat(company,trantype,invoice) as Invoice,invoice_date
from FRT_Sales
union
select distinct company,orderno,concat(company,trantype,invoice) as Invoice,invoice_date
from Auction_sales
--where concat(company,trantype,invoice)='40125230000121'
--where concat(company,trantype,invoice)='40121133017608'
--where concat(company,Orderno)='401240001111'
)a
where ReversalSalesOrders.Company=a.Company
and ReversalSalesOrders.ReversalOrderNo=a.orderno


update ReversalSalesOrders set custcode=a.custcode,custname=a.custname,Item=a.Item,Item_desc=a.Item_desc,
DeliveryQty=a.DeliveryQty,UnitPrice=a.UnitPrice,Sales_amount=a.Sales_amount,
Taxcode=a.Taxcode,TaxAmnt=a.t_txah_1
from(select distinct company,orderno,concat(company,trantype,invoice) as Invoice,invoice_date,DeliveryQty,
UnitPrice,Sales_amount,custcode,custname,Item,Item_desc,Taxcode,t_txah_1
from Elgi_sales_details
--where concat(company,trantype,invoice)='40125230000121'
--where concat(company,trantype,invoice)='40121133017608'
--where concat(company,Orderno)='401240001111'
)a
where ReversalSalesOrders.ReversalInvoice=a.Invoice


update ReversalSalesOrders set custcode=a.custcode,custname=a.custname,Item=a.Item,Item_desc=a.Item_desc,
DeliveryQty=a.DeliveryQty,UnitPrice=a.UnitPrice,Sales_amount=a.Sales_amount,
Taxcode=a.Taxcode--,TaxAmnt=a.t_txah_1
from(select distinct company,orderno,concat(company,trantype,invoice) as Invoice,invoice_date,DeliveryQty,
UnitPrice,Sales_amount,custcode,custname,Item,Item_desc,Taxcode--,t_txah_1
from LN_SALES_BDI
union
select distinct company,orderno,concat(company,trantype,invoice) as Invoice,invoice_date,DeliveryQty,
UnitPrice,Sales_amount,custcode,custname,Item,Item_desc,Taxcode--,t_txah_1
from FRT_Sales
union
select distinct company,orderno,concat(company,trantype,invoice) as Invoice,invoice_date,DeliveryQty,
UnitPrice,Sales_amount,custcode,custname,Item,Item_desc,Taxcode--,t_txah_1
from Auction_sales
--where concat(company,trantype,invoice)='40125230000121'
--where concat(company,trantype,invoice)='40121133017608'
--where concat(company,Orderno)='401240001111'
)a
where ReversalSalesOrders.ReversalInvoice=a.Invoice




update ReversalSalesOrders set DiscPercent=a.DiscPercent,DiscAmnt=a.DiscAmnt
from (select distinct company,t_orno,t_disc_1 as DiscPercent,t_ldam_1 DiscAmnt
from TTDSLS401ALL
--where concat(company,t_orno)='401240001111'
)a
where ReversalSalesOrders.company=a.COMPANY
and ReversalSalesOrders.ReversalOrderNo=a.t_orno


update ReversalSalesOrders  set Sales_After_Discount=sales_amount-DiscAmnt
update ReversalSalesOrders  set TotalValue=isnull(Sales_After_Discount,0)+isnull(TaxAmnt,0)



end

select * from ReversalSalesOrders
--where OriginalInvDate is null
--and company like '4%'
--where OriginalInvoice='40121131010477'

GO

