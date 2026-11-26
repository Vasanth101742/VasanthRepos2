--exec sp_Brazil_Receipt_Details
CREATE Procedure sp_Brazil_Receipt_Details as
begin

Truncate table Brazil_Receipt_Details_Temp1

Insert into Brazil_Receipt_Details_Temp1(LNFiscalDoc,FiscalDate,Status,ApprovalDate,PNCode,PNName,
NFNumber,NFDate,NFTypeDesc,FiscalID,FiscalDocumentTypeCode,
ReceiptDate,DocumentType,FiscalDocumentDetail,
ElectronicFiscalDocument,LNDocNumber,CostPrice,TransOrgin,AccGroup,NCMCode,NFLine,Item,Description,
TotalQty,TotalPrice,Freight,ProductValue,NFValue,TaxGroupCode,DocumentNumber,DocumentLine,TaxGroupDesc,
TaxBase,TaxRate,TaxAmount,Status2,GeneralExp,Discount)
select LNFiscalDoc,FiscalDate,Status,ApprovalDate,PNCode,PNName,
NFNumber,NFDate,NFTypeDesc,FiscalID,FiscalDocumentTypeCode,ReceiptDate,DocumentType,FiscalDocumentDetail,
ElectronicFiscalDocument,LNDocNumber,CostPrice,TransOrgin,AccGroup,NCMCode,NFLine,Item,Description,
case when a.rfdt=3 and TotalQty>0 then (-1)*TotalQty else TotalQty end as TotalQty,
TotalPrice,Freight,ProductValue,
NFValue,TaxGroupCode,DocumentNumber,DocumentLine,TaxGroupDesc,
TaxBase,TaxRate,TaxAmount,Status2,GeneralExp,Discount
from(select
fire as	LNFiscalDoc,convert(date,Date) as FiscalDate,replace(stat_kw,'btrec.stat.','') as [Status],
convert(date,adat) as ApprovalDate,bpid as PNCode,fids as PNName,docn as NFNumber,
convert(date,idat) as NFDate,
replace(doty_kw,'btdoty.','') as NFTypeDesc,fovn as	FiscalID,
fdtc as FiscalDocumentTypeCode,
convert(date,odat) as	ReceiptDate,
rfdt,
replace(rfdt_kw,'btrec.trfd.','') as DocumentType,fdtc as FiscalDocumentDetail,
replace(nfel_kw,'btyesno.','') as ElectronicFiscalDocument,
case when stat='6' or rfdt='3' then 'Reversal' else replace(stat_kw,'btrec.stat.','') end as Status2
from ln_BTREC200
where deleted='N'
)a
left outer join
(select fire as	LNDocNumber,copr as CostPrice,
replace(orec_kw,'btrec.orec.','') as TransOrgin,
accd as	AccGroup,frat as NCMCode,line as NFLine,
ltrim(rtrim(item)) as Item,dsca as [Description],
qnty as TotalQty,--pric as UnitPrice,
iprt as  TotalPrice,fght as Freight,
gamt as ProductValue,tamt as NFValue,
opty as TaxGroupCode,
isnull(gexp,0)+isnull(insr,0)+isnull(cchr,0) as GeneralExp,
addc as Discount
from ln_BTREC201
where deleted='N'
)b
on a.LNFiscalDoc=b.LNDocNumber
left outer join 
(select fire as	DocumentNumber,
line as DocumentLine,
replace(brty_kw,'btmcs.brty.','') as TaxGroupDesc,
base as TaxBase,
rate as	TaxRate,
amnt as TaxAmount
--amnr as TaxRecoveryAmount
from LN_BTREC203 where deleted='N' )c
on b.LNDocNumber=c.DocumentNumber
and b.NFLine=c.DocumentLine
where a.FiscalDate >= '2023-11-01'
--and a.LNFiscalDoc='R00002665'
order by a.FiscalDate


--Alter table Brazil_Receipt_Details_Temp1 add TaxGroupOrdr int

update Brazil_Receipt_Details_Temp1 set TaxGroupOrdr=1 where TaxGroupDesc='importation'
update Brazil_Receipt_Details_Temp1 set TaxGroupOrdr=2 where TaxGroupDesc='cofins'
update Brazil_Receipt_Details_Temp1 set TaxGroupOrdr=3 where TaxGroupDesc='pis'
update Brazil_Receipt_Details_Temp1 set TaxGroupOrdr=4 where TaxGroupDesc='ipi'
update Brazil_Receipt_Details_Temp1 set TaxGroupOrdr=5 where TaxGroupDesc='icms'
update Brazil_Receipt_Details_Temp1 set TaxGroupOrdr=6 where TaxGroupDesc='icms.st'
update Brazil_Receipt_Details_Temp1 set TaxGroupOrdr=7 where TaxGroupDesc='irrf.corp'
update Brazil_Receipt_Details_Temp1 set TaxGroupOrdr=8 where TaxGroupDesc='pis.retained'
update Brazil_Receipt_Details_Temp1 set TaxGroupOrdr=9 where TaxGroupDesc='cofins.retained'
update Brazil_Receipt_Details_Temp1 set TaxGroupOrdr=10 where TaxGroupDesc='csll.retained'
update Brazil_Receipt_Details_Temp1 set TaxGroupOrdr=11 where TaxGroupDesc='iss.retained'
update Brazil_Receipt_Details_Temp1 set TaxGroupOrdr=12 where TaxGroupDesc='inss.ret.corp'
update Brazil_Receipt_Details_Temp1 set TaxGroupOrdr=13 where TaxGroupOrdr is null

update Brazil_Receipt_Details_Temp1 set FiscalDocumentDetail=a.dsca
from (select distinct fdtc,dsca from LN_LPBRA001 where compnr=2000)a
where Brazil_Receipt_Details_Temp1.FiscalDocumentDetail=a.fdtc

update Brazil_Receipt_Details_Temp1 set ItemGroup=a.citg,ProductLine=a.cpln
from (select distinct item,citg,cpln from LN_TCIBD001 where compnr=2000)a
where ltrim(rtrim(Brazil_Receipt_Details_Temp1.Item))=ltrim(rtrim(a.item))

update Brazil_Receipt_Details_Temp1 set ItemGroup=a.dsca
from (select distinct citg,dsca from LN_TCMCS023 where compnr=2000)a
where ltrim(rtrim(Brazil_Receipt_Details_Temp1.ItemGroup))=ltrim(rtrim(a.citg))

update Brazil_Receipt_Details_Temp1 set ProductLine=a.dsca
from (select distinct cpln,dsca from LN_TCMCS061 where compnr=2000)a
where ltrim(rtrim(Brazil_Receipt_Details_Temp1.ProductLine))=ltrim(rtrim(a.cpln))

update Brazil_Receipt_Details_Temp1 set TotalQty=(-1)*TotalQty
where ProductValue<0
and TotalQty>0

--Alter table Brazil_Receipt_Details_Temp1 add Discount float
--Alter table Brazil_Receipt_Details_Temp1 add RelatedRef nvarchar(20)
--Alter table Brazil_Receipt_Details_Temp1 add PO_Number nvarchar(25)
--Alter table Brazil_Receipt_Details_Temp1 add WH_ReceiptNo nvarchar(25)

update Brazil_Receipt_Details_Temp1 set RelatedRef=a.refr
from(select * from LN_BTREC210 where deleted='N') a
where Brazil_Receipt_Details_Temp1.LNFiscalDoc=a.fire

--update Brazil_Receipt_Details_Temp1 set PO_Number=a.PO_Number,WH_ReceiptNo=a.WH_ReceiptNo
--from(select distinct fire,line,seri,concat(ordn,'/',ordl) as PO_Number,concat(rcno,'/',rcln) as WH_ReceiptNo
--from LN_BTREC212 
--where fire='D00000004' and line=9
--)a
--where Brazil_Receipt_Details_Temp1.LNFiscalDoc=a.fire
--and Brazil_Receipt_Details_Temp1.NFLine=a.line

--To be discussed
select * from Brazil_Receipt_Details_Temp1 where LNFiscalDoc='D00000004' and NFLine=9
select concat(ordn,'/',ordl) as PO_Number,concat(rcno,'/',rcln) as WH_ReceiptNo,* from LN_BTREC212 where fire='D00000004' and line=9

end

select * from Brazil_Receipt_Details_Temp1
--where LNFiscalDoc='D00000034'
order by LNFiscalDoc
--where ProductValue<0
--where FiscalDocumentDetail='EDF002'
--where LNFiscalDoc in ('R00003362', 'R00003398')


--select distinct FiscalDocumentDetail from Brazil_Receipt_Details_Temp1

--select distinct Date,fire from ln_BTREC200
--where --fire in ('R00002693','R00002694','R00002695')
--deleted='Y'
--order by fire

----'R00002185'

GO

