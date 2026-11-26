

CREATE Proc [dbo].[sp_PurchaseReceipt] as


Truncate table PurchaseReceipt

-------------Step 1 Inserting All Details ------------

insert into PurchaseReceipt(Compnr,PurchaseOrder,otbp,businessPartnerName,item,Itemdesc,Receipt_Number,ReceiptLogDate,ReceiptQty,RecptDate,
pric,[packing Slip number],closingDate,PositionNumber,ReceiptSeqNo,OrderSeqNo,APDocNo,LoginUser,TransactionEnteredDate,PaymentDocNo,
PaidDate,DocumentDate,AgeingDays,Ageing)

select *, DATEDIFF(d,ReceiptLogDate,ClosingDate) 'AgeingDays',
case when DATEDIFF(d,ReceiptLogDate,ClosingDate) between 0 and 30 then '0-30 Days'
     when DATEDIFF(d,ReceiptLogDate,ClosingDate) between 31 and 60 then '31-60 Days'
     when DATEDIFF(d,ReceiptLogDate,ClosingDate) between 61 and 90 then '61-90 Days'
     when DATEDIFF(d,ReceiptLogDate,ClosingDate) between 91 and 120 then '91-120 Days'
     when DATEDIFF(d,ReceiptLogDate,ClosingDate) >120 then 'Above 120 Days'
	end 'Ageing'
from (

select distinct a.compnr,a.orno 'PurchaseOrder',a.otbp,c.nama 'BusinessPartnerName',ltrim(rtrim(a.item)) 'Item', d.dsca 'ItemDesc'
,b.rcno 'Receipt_number',convert(datetime,cast (b.rcld as datetimeoffset) at Time Zone 'Eastern Time Zone')  'ReceiptLogDate',
b.qidl 'ReceiptQty', b.rcld  'RecptDate'
,a.pric,a.dino 'packing slip number', convert(date,getdate()) 'ClosingDate',a.pono 'PositionNumber', a.rseq 'ReceiptSeqNo' , a.sqnb 'OrderSeqNo'
,concat(e.ityp,e.idoc) 'APDocNo'
, f.username 'LoginUser', convert(datetime,cast (g.date as datetimeoffset) at Time Zone 'Eastern Time Zone') 'TransactionEnteredDate'
,concat(f.payt,f.payd) 'PaymentDocNo',convert(datetime,cast (g.dcdt as datetimeoffset) at Time Zone 'Eastern Time Zone') 'PaidDate',
convert(datetime,cast (f.docd as datetimeoffset) at Time Zone 'Eastern Time Zone') 'DocumentDate'

from LN_TDPUR401  a

left join LN_TDPUR406 b on a.compnr=b.compnr and a.orno=b.orno 
and ltrim(rtrim(a.pono))=ltrim(rtrim(b.pono)) and a.rseq=b.rseq
and a.rcno=b.rcno and a.dino=b.dino

left join LN_TCCOM100 c on ltrim(rtrim(a.otbp))=ltrim(rtrim(c.bpid)) and c.compnr='3100'

left join ln_tcibd001 d on ltrim(rtrim(a.item))=ltrim(rtrim(d.item)) and d.compnr='3100'

left join LN_TFACP251 e on a.compnr=e.compnr and a.orno=e.orno 
and ltrim(rtrim(a.pono))=ltrim(rtrim(e.pono)) and a.sqnb=e.sqnb and 
 a.rcno=e.rcno and a.rseq=b.rseq and e.finl='2'

left join LN_TFACP200 f ON e.compnr=f.compnr and e.ityp=convert(nvarchar,f.tpay) and e.idoc=f.docn

left join LN_TFGLD018 g on e.compnr=g.compnr and e.ityp=g.ttyp and e.idoc=g.docn

where a.compnr='3110' and b.rcno is not null 
--and a.rcno='REC000754'
--group by  a.compnr,a.orno ,a.otbp,c.nama,ltrim(rtrim(a.item)) , d.dsca 
--,b.rcno ,b.rcld ,a.pric,a.dino  ,a.pono , a.rseq , a.sqnb
--,concat(e.ityp,e.idoc),f.username,g.date,concat(f.payt,f.payd),g.dcdt
----order by b.rcno


)a

-------------Step 2 Updating Extended Item Descr ------------

--ALter table  PurchaseReceipt add Variance float

update PurchaseReceipt set ItemExtDescr=ltrim(rtrim(a.cdf_extd)),StandardItemDesc=trim(a.dscd) from LN_TCIBD001 a

where  ltrim(rtrim(PurchaseReceipt.Item))=ltrim(rtrim(a.item)) 
and (case when PurchaseReceipt.Compnr like '3%' then '3100' else PurchaseReceipt.Compnr end)
=a.compnr


-------------Step 3 Updating Warehouse ------------
--Warehouse is updated from whinh3512m000 session based on Receipt no

update PurchaseReceipt set  warehouse= a.cwar from (

select distinct Compnr,rcno,rcln,cwar from LN_WHINH312 
) a where PurchaseReceipt.compnr=a.compnr 
and trim(PurchaseReceipt.Receipt_number)=trim(a.rcno)
and PurchaseReceipt.ReceiptSeqNo=a.rcln

-------------Step 4 Total Value, Approved Amount, InvoiceAMount  ------------

--Approved AMnt is ReceiptValue, GRN AMt all are same, InvAmt is modified value both are  taken from tfacp2607m000 session
--(based on Receipt no,position no & doc no)
 --


update PurchaseReceipt set TotalValue =ReceiptQty * Pric

update PurchaseReceipt set InvAmt= a.invAmt, ApprAmnt=a.OrdAmt from (
SELECT compnr,concat(ityp,idoc)'idoc',rcno,rseq, sum(iamt) 'InvAmt',sum(oamt) 'OrdAmt' FROM LN_TFACP256
group by   compnr,concat(ityp,idoc),rcno,rseq
) a where PurchaseReceipt.compnr=a.compnr and PurchaseReceipt.APDocNo=a.idoc
and trim(PurchaseReceipt.Receipt_number)=trim(a.rcno)
and PurchaseReceipt.ReceiptSeqNo=a.rseq

update PurchaseReceipt set Variance=InvAmt-ApprAmnt

GO

