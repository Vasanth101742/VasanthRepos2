--exec sp_Brazil_Sales_Details
CREATE proc sp_Brazil_Sales_Details as
begin

Truncate table Brazil_Sales_Details

Insert into Brazil_Sales_Details(fire,line,accd,dbcr_kw,
amnt,bfcd,leac,item,dqua,Entrydate,bpid,bpna,fdtc,docn,
ttyp,ninv)
--select * into Brazil_Sales_Details from(
select a.fire,a.line,a.accd,a.[dbcr_kw],a.[amnt],a.bfcd,
a.leac,b.item,b.dqua,
DATEADD(MINUTE,-30,DATEADD(HOUR,-8,c.date)) AS Entrydate,
c.bpid,c.bpna,c.fdtc,c.docn,
e.ttyp,e.ninv
from LN_BTSLI208 a
left outer join ln_lpbra247 b 
on a.fire=b.fire
and a.line=b.flin
left outer join LN_BTSLI200 c 
on a.fire=c.fire 
left join ln_lpbra245 e 
on a.fire=e.fire 
and c.bpid=e.bpid
where a.compnr ='2000' and c.stat<>2 
--)a

update Brazil_Sales_Details set dqua=(-1)*dqua where ttyp like '%NCV%'
update Brazil_Sales_Details set dbcr_kw=replace(dbcr_kw,'btgld.dbcr.','')

update Brazil_Sales_Details set amnt=(-1)*amnt where dbcr_kw='credit'


update Brazil_Sales_Details set item_desc=a.dsca,citg=a.citg,cpln=a.cpln
from (select * from LN_TCIBD001 where compnr=2000) a 
where ltrim(rtrim(Brazil_Sales_Details.item))=ltrim(rtrim(a.item))

update Brazil_Sales_Details set desc1=a.dsca
from (select * from ln_tcmcs023 where compnr=2000)a
where Brazil_Sales_Details.citg=a.citg 


update Brazil_Sales_Details set desc2=a.dsca
from (select * from ln_tcmcs061 where compnr=2000)a
where Brazil_Sales_Details.cpln=a.cpln 

update Brazil_Sales_Details set desc2=a.dsca
from (select * from ln_tcmcs061 where compnr=2000)a
where Brazil_Sales_Details.cpln=a.cpln 


update Brazil_Sales_Details set desc3=a.dsca
from (select * from ln_lpbra001 where compnr=2000)a
where Brazil_Sales_Details.fdtc=a.fdtc 


update Brazil_Sales_Details set TransactionType=null where bfcd=''   
update Brazil_Sales_Details set TransactionType='Sales' where bfcd='RECALC'   
update Brazil_Sales_Details set TransactionType='Tax' where [dbcr_kw]='debit'   

--when [bfcd] = 'RECALC' then 'Sales' 
--when [dbcr_kw] like '%debit%' then 'Tax' 
--else '' end 'TransType',

Truncate Table Brazil_Receipt_Details

Insert into Brazil_Receipt_Details(fire,date,bpid,bpna,dbcr_Kw,leac,
amnt,bfcd,combin,RefeD,line)

--select * into Brazil_Receipt_Details from(
Select a.fire,b.date,b.bpid,b.bpna,a.dbcr_Kw,a.leac,a.amnt,a.bfcd,
left(a.fire,1) combin ,c.refr'RefeD', a.line 
from ln_BTREC208 a
left Join ln_BTREC200 b 
	on b.fire=a.fire 
left join ln_BTREC210 c 
	on c.fire=a.fire 
	and c.compnr=2000
where a.compnr='2000'
--)a

update Brazil_Receipt_Details set dbcr_Kw=replace(dbcr_kw,'btgld.dbcr.','')
update Brazil_Receipt_Details set amnt=(-1)*amnt where dbcr_Kw='debit' and amnt<1

--select distinct substring(fire,1,1) as fire from Brazil_Receipt_Details


------------------------------------------------------------------------------------------
Truncate table Brazil_Sales_Details_ver2

Insert into Brazil_Sales_Details_ver2(company,Invoice_Date,trantype,Invoice,
OrderDate,SaleOrderType,OrderNo,PositionNo,CustomerOrderNo,custcode,custname,
FinCustGrp,dpst,dpstname,areacode,areaname,item,Item_desc,Currency,DeliveryQty,
Sales_INR,Sales_USD,Sales_HC,Tax,SalesWithTax,Taxcode,PaymentDesc,EmpCode,EmpName,
Organ,Region,Vertical1,user_names,Zone,sales_category,CRM_Ref,ItemCategory,
ProductGroup,ProductGroup3)

--select * into Brazil_Sales_Details_ver2 from(
select
convert(varchar,compnr) company,convert(date,a.date) as Invoice_Date,
ttyp as trantype,convert(varchar,ninv) Invoice,
a.odat as OrderDate,null as SaleOrderType,a.orno as OrderNo,null as PositionNo,null as CustomerOrderNo,
bpid as custcode,bpna as custname,null as FinCustGrp,null as dpst,null as dpstname,
null as areacode,'Brazil' as areaname,a.item,a.d_dsca Item_desc,
'BRL' as Currency,
case when bfcd='RECALC' and amnt>0 --then a.dqua 
--Added on 26-10-2026 based on Finance Team Mail 
and DType in ('Estorno Referencia Fiscal #','Venda - Exportação','Venda - Não Contribuinte',
'Venda - peças Consumidor Final','Venda - Peças Distribuidor','Venda - Revenda',
'Venda de Ativo Fixo','Venda de Sucata','Venda por Conta e Ordem','Venda REID')
and ttyp in ('FAT','NCV') then a.dqua 
else 0 end as DeliveryQty,

null as Sales_INR,
null as Sales_USD, 
amnt as Sales_HC,
case when TransType='Tax' then amnt end as Tax,
amnt as SalesWithTax,
bfcd as Taxcode,DType as PaymentDesc,null as EmpCode,null as EmpName,
'Brazil' as Organ,'Brazil' as Region,'Brazil' as Vertical1,
null as user_names,'Brazil' as Zone,DType as sales_category,
null as CRM_Ref, 
null as ItemCategory,--a.el_dsca as ProductGroup,
null as ProductGroup,
null as ProductGroup3
from (
select a.compnr,a.fire,a.line,a.accd, 
case when  a.[dbcr_kw] like '%credit%' then a.[amnt] else a.[amnt]*-1 end amnt,
a.bfcd,a.dbcr_kw,a.leac,b.item,d.dsca d_dsca,b.dqua
,DATEADD(MINUTE,-30,DATEADD(HOUR,-8,CONVERT(datetime,SWITCHOFFSET(CONVERT(datetimeoffset,e.[date]),DATENAME(TzOffset, SYSDATETIMEOFFSET()))))) AS date, 
c.bpid,c.bpna,e.ninv,e.ttyp,c.fdtc,e1.dsca el_dsca,e2.dsca e2_dsca,c.docn,
case when [bfcd] ='' then ''  
when [bfcd] = 'RECALC' then 'Sales' 
when [dbcr_kw] like '%debit%' then 'Tax' 
else '' end TransType,
case when e.ttyp like '%NCV%' then b.dqua*-1 else b.dqua end ReturnQty,e3.dsca DType,
e4.orno,dateadd(MINUTE ,-29,dateadd(hour,-9,e4.odat)) as odat
from [ELGI_US].dbo.LN_BTSLI208 a
left join [ELGI_US].dbo.ln_lpbra247 b on b.fire=a.fire and b.flin=a.line and b.deleted='N'
left join [ELGI_US].dbo.LN_BTSLI200 c on c.fire=a.fire  and c.deleted='N'
left join [ELGI_US].dbo.ln_lpbra245 e on e.fire=a.fire and e.bpid=c.bpid and e.deleted='N'
left join [ELGI_US].dbo.LN_TCIBD001 d on d.item=b.item and cpcl_ref_compnr='2000' and d.deleted='N'
left join [ELGI_US].dbo.ln_tcmcs023 e1 on e1.citg=d.citg and e1.compnr='2000' and e1.deleted='N'
left join [ELGI_US].dbo.ln_tcmcs061 e2 on e2.cpln=d.cpln and e2.compnr='2000' and e2.deleted='N'
left join [ELGI_US].dbo.ln_lpbra001 e3 on e3.fdtc=c.fdtc and e3.deleted='N'
left join (select distinct compnr,[tran],idoc,item,odat,orno,deleted from [ELGI_US].dbo.LN_cisli310) e4 
on e4.idoc=e.ninv and e4.[tran]=e.ttyp 
and e4.compnr='2000' and e4.deleted='N' and e4.item=b.item
where a.compnr ='2000' and c.stat<>2  and a.deleted='N'
--order by DATEADD(MINUTE,-30,DATEADD(HOUR,-8,CONVERT(datetime,SWITCHOFFSET(CONVERT(datetimeoffset,e.[date]),DATENAME(TzOffset, SYSDATETIMEOFFSET())))))  desc 
)a
where dtype not like '%Remessa%'
and TransType in ('Sales','Tax')

--and ltrim(rtrim(item))='015400889'
--and ninv='2392'
--and year(date)>='2024'
--and month(date)='11'
--)a




----Return Transaction --Old Method
--Insert into Brazil_Sales_Details_ver2(company,Invoice_Date,--trantype,Invoice,
----OrderDate,SaleOrderType,OrderNo,PositionNo,CustomerOrderNo,
--custcode,custname,--FinCustGrp,dpst,dpstname,areacode,areaname,item,Item_desc,
--Currency,DeliveryQty,--Sales_INR,Sales_USD,
--Sales_HC,--Tax,SalesWithTax,
--Taxcode,--PaymentDesc,EmpCode,EmpName,
--Organ,Region,Vertical1,user_names,Zone
----,sales_category,CRM_Ref,ItemCategory,ProductGroup,ProductGroup3
--)
--select compnr,date1,a.bpid,a.bpna, 
--'BRL' as Currency,sum(c.qnty*(-1)) as Qty,
--sum(Final_sum) Final_sum,
--bfcd,'Brazil' as Organ,'Brazil' as Region,'Brazil' as Vertical1,
--null as user_names,'Brazil' as Zone

--from 
--(select DATEADD(MINUTE,-30,DATEADD(HOUR,-8,CONVERT(datetime,SWITCHOFFSET(CONVERT(datetimeoffset,[date]),DATENAME(TzOffset, SYSDATETIMEOFFSET()))))) AS date1,*  
--from ln_btrec200 
--where compnr='2000' and deleted='N'
--and rfdt in ('10','57')
--)a

--left outer join

--(select *,
----case when combin ='R' and Final<0 and Custom2='Tax' then Final*(-1) else Final end as Final_Sum
--case when Final<0 and Custom2='Tax' then Final*(-1) else Final end as Final_Sum
--from(
--select *,
--case when DerivedColumn='Blank' then '' 
--when bfcd ='' then ''
--when DerivedColumn='Negative' then amnt
--when DerivedColumn='CreditNote' then Custom1
--else [Custom] end as Final,
--case when combin ='R' and  [bfcd]='RECALC' then 'Sales' else 'Tax' end as Custom2
--from(select *,
--case when DerivedColumn='CreditNote' and amnt>1 and dbcr_kw='credit' then amnt*-1
--when combin='R' and dbcr_kw='debit' then 0 else [Custom] end as Custom1
--from (
--Select concat(a.fire,a.line) keycolumn,
--DATEADD(MINUTE,-30,DATEADD(HOUR,-8,CONVERT(datetime,SWITCHOFFSET(CONVERT(datetimeoffset,b.[date]),DATENAME(TzOffset, SYSDATETIMEOFFSET()))))) as date,
--a.fire,a.leac,amnt,
--case when replace(a.dbcr_Kw,'btgld.dbcr.','')='debit' and a.amnt<1 then amnt*-1 else amnt end as [Custom],
--b.bpid,b.bpna,replace(a.dbcr_Kw,'btgld.dbcr.','') dbcr_Kw,
--case when a.fire like 'd%' then 'Negative'
--when  a.fire like 'R%' then 'CreditNote'
--when substring(a.leac,1,1) in ('1','2','3') then 'Blank' else null end as DerivedColumn,
--a.bfcd,left(a.fire,1) combin ,c.refr as RefeD,a.line 
--from ln_BTREC208 a
--left Join ln_BTREC200 b on b.fire=a.fire and b.deleted='N' 
--left join ln_BTREC210 c on c.fire=a.fire and c.compnr=2000 and c.deleted='N'
--where a.compnr='2000' and a.deleted='N'
----and a.fire='D00000103' --for testing purpose
--)b1)b2)b3
--)b
--on a.fire=b.fire

--left outer join

--(select concat(a.fire,a.line) keycolumn,a.fire,a.item,a.dsca,a.accd,e1.dsca as ProductGroup,
--e2.dsca as ProductLine,a.line,a.qnty,e4.orno,
--dateadd(MINUTE ,-29,dateadd(hour,-9,e4.odat))odat from ln_btrec201 a
--left join LN_TCIBD001 d on d.item=a.item and cpcl_ref_compnr='2000' and d.deleted='N'
--left join ln_tcmcs023 e1 on e1.citg=d.citg and e1.compnr='2000'and e1.deleted='N'
--left join ln_tcmcs061 e2 on e2.cpln=d.cpln and e2.compnr='2000' and e2.deleted='N'
--left join ln_btrec212 e4 on e4.deleted='N' and e4.compnr='2000' and e4.fire=a.fire and e4.line=a.line 
--where a.compnr=2000 and a.deleted='N'
--)c
--on b.keycolumn=c.keycolumn
----where a.date1 between '2025-11-01' and '2025-11-30' --for testing

--group by compnr,date1,a.bpid,a.bpna,bfcd


--Return Transaction --New Method


Insert into Brazil_Sales_Details_ver2(company,Invoice_Date,trantype,Invoice,
OrderDate,SaleOrderType,OrderNo,PositionNo,CustomerOrderNo,custcode,custname,
FinCustGrp,dpst,dpstname,areacode,areaname,item,Item_desc,Currency,DeliveryQty,
Sales_INR,Sales_USD,Sales_HC,Tax,SalesWithTax,Taxcode,PaymentDesc,EmpCode,EmpName,
Organ,Region,Vertical1,Zone--,user_names
--sales_category,CRM_Ref,ItemCategory,ProductGroup,ProductGroup3
)

select '2000' as Company,FiscalDate,--fiscalDocumentTypeCode,
null as Trantype, LNFiscalDoc,
NFDate,NFTypeDesc,NFNumber,NFline,FiscalID,PNCode,PNName,null as FinCustGrp,
null as dpst,null as dpstname,null as areacode,'Brazil' as areaname,item,[Description],
'BRL' as Currency,
0 as TotalQty, -- Updated on 26-10-2026
null as Sales_INR,null as Sales_USD,SalesReturnValue as Sales_HC,
TaxAmount,null as SalesWithTax,TaxGroupDesc as Taxcode,null as PaymentDesc,null as EmpCode,null as EmpName,
'Brazil' as Organ,'Brazil' as Region,'Brazil' as Vertical1,
'Brazil' as Zone--,null as user_names
from(
select *,NFValue2 + TaxAmount as SalesReturnValue  from (
select *,case when NFRnk=1 then NFValue*(-1) else 0 end as NFValue2 
from (
select *,
row_number() over(partition by LNFiscalDoc,NFLine order by FiscalDate) as NFRnk
from Brazil_Receipt_Details_Temp1
where FiscalDocumentDetail='Devolução vendas clientes'
--and LNFiscalDoc='D00000103'
)a)b)c


--Alter table Brazil_Sales_Details_ver2 add ctyp varchar(25)
--Alter table Brazil_Sales_Details_ver2 add ctypdesc varchar(50)


--Alter table Brazil_Sales_Details_ver2 add ItemGroupCode varchar(25)
--Alter table Brazil_Sales_Details_ver2 add ItemGroup varchar(100)


--Commented based on Finance Team Mail dated: 26-10-2026
--update Brazil_Sales_Details_ver2 set DeliveryQty=0
--from (select * from [ELGi_SOP].dbo.TPL_MASTER_REF
--where Region='Brazil'
--and L1='Equipments'
--)a
--where trim(Brazil_Sales_Details_ver2.item)=trim(a.Item)
--and Invoice like 'D%'


update Brazil_Sales_Details_ver2 set ctyp=a.ctyp
from (select * from LN_tcibd001 where compnr='2000')a
where ltrim(rtrim(Brazil_Sales_Details_ver2.item))=ltrim(rtrim(a.item))


update Brazil_Sales_Details_ver2 set ctypdesc=c.dsca
from(select distinct compnr,ctyp,dsca from ln_tcmcs015 where compnr='2000')c
where Brazil_Sales_Details_ver2.ctyp=c.ctyp
and (Brazil_Sales_Details_ver2.company =c.compnr) 


update Brazil_Sales_Details_ver2 set ItemGroupCode=a.citg
from (select distinct item,citg,cpln from LN_TCIBD001 where compnr='2000')a
where ltrim(rtrim(Brazil_Sales_Details_ver2.Item))=ltrim(rtrim(a.item))
and Brazil_Sales_Details_ver2.Company in ('2000')

update Brazil_Sales_Details_ver2 set ItemGroup=a.dsca
from (select distinct citg,dsca from LN_TCMCS023 where compnr='2000')a
where ltrim(rtrim(Brazil_Sales_Details_ver2.ItemGroupCode))=ltrim(rtrim(a.citg))
and Brazil_Sales_Details_ver2.Company in ('2000')





--Alter table Brazil_Sales_Details_ver2 add Fin_year int
--Alter table Brazil_Sales_Details_ver2 add Fin_month int


update Brazil_Sales_Details_ver2 set Fin_year=year(Invoice_Date)-1 where month(Invoice_Date)<4
update Brazil_Sales_Details_ver2 set Fin_year=year(Invoice_Date) where month(Invoice_Date)>=4

update Brazil_Sales_Details_ver2 set Fin_month=month(Invoice_Date)+9 where month(Invoice_Date)<4
update Brazil_Sales_Details_ver2 set Fin_month=month(Invoice_Date)-3 where month(Invoice_Date)>=4


--Alter table Brazil_Sales_Details_ver2 alter column Empname nvarchar(70)

--Alter table Brazil_Sales_Details_ver2 alter column Sales_USD float

--Alter table Brazil_Sales_Details_ver2 add INR_ConversionRate float
--Alter table Brazil_Sales_Details_ver2 add USD_ConversionRate float

update Brazil_Sales_Details_ver2 set INR_ConversionRate=a.INR_ConversionRate
from (select * from [ELGi_LN].dbo.CurrencyRateMaster_from_FinanceTeam)a
where Brazil_Sales_Details_ver2.Fin_year=a.FinYear
and Brazil_Sales_Details_ver2.Currency=a.SourceCurrency

update Brazil_Sales_Details_ver2 set USD_ConversionRate=a.USD_ConversionRate
from (select * from [ELGi_LN].dbo.CurrencyRateMaster_from_FinanceTeam)a
where Brazil_Sales_Details_ver2.Fin_year=a.FinYear
and Brazil_Sales_Details_ver2.Currency=a.SourceCurrency

update Brazil_Sales_Details_ver2 set Sales_INR=isnull(INR_ConversionRate,0)*sales_HC
update Brazil_Sales_Details_ver2 set Sales_USD=isnull(USD_ConversionRate,0)*sales_HC

update Brazil_Sales_Details_ver2 set SalesWithTax=isnull(INR_ConversionRate,0)*sales_HC



--------------
--Alter table Brazil_Sales_Details_ver2 add INR_ConversionRate_AER float
--Alter table Brazil_Sales_Details_ver2 add USD_ConversionRate_AER float

--Alter table Brazil_Sales_Details_ver2 add Sales_INR_AER float
--Alter table Brazil_Sales_Details_ver2 add Sales_USD_AER float



update Brazil_Sales_Details_ver2 set USD_ConversionRate_AER=a.RATE
from (select distinct Invoice_Date,Currency,BCUR,CCUR,STDT,RATE,Rnk--,DaysDiff
from (
select *,datediff(dd,STDT,Invoice_Date) as DaysDiff,
row_number() over (partition by Invoice_Date,Currency order by datediff(dd,STDT,Invoice_Date)) as Rnk 
from (select distinct Invoice_Date,Currency from Brazil_Sales_Details_ver2
--where currency='MYR'
)a
left outer join 
(select CCUR,BCUR,RTYP,convert(date,STDT) STDT,1/max(RATE) RATE
from [ELGi_LN].dbo.TTCMCS008ALL 
where BCUR in ('USD','EUR','BRL','GBP')
and CCUR in ('USD')
and RATE<>1
--and convert(date,stdt)='2024-01-08'
group by CCUR,BCUR,RTYP,convert(date,STDT)
--order by convert(date,STDT)
)b
on a.Currency=b.BCUR
and a.Invoice_Date>=b.STDT
)a
where Rnk=1
--order by PostingDate
)a
where Brazil_Sales_Details_ver2.Invoice_Date=a.Invoice_Date
and Brazil_Sales_Details_ver2.Currency=a.Currency




update Brazil_Sales_Details_ver2 set INR_ConversionRate_AER=a.RATE
from (select distinct Invoice_Date,Currency,BCUR,CCUR,STDT,RATE,Rnk--,DaysDiff
from (
select *,datediff(dd,STDT,Invoice_Date) as DaysDiff,
row_number() over (partition by Invoice_Date,Currency order by datediff(dd,STDT,Invoice_Date)) as Rnk 
from (select distinct Invoice_Date,Currency from Brazil_Sales_Details_ver2
--where currency='MYR'
)a
left outer join 
(select CCUR,BCUR,RTYP,convert(date,STDT) STDT,max(RATE) RATE
from [ELGi_LN].dbo.TTCMCS008ALL 
where ccur in ('USD','EUR','BRL','GBP')
and bcur in ('IND','INR')
and RATE<>1
--and convert(date,stdt)='2024-01-08'
group by CCUR,BCUR,RTYP,convert(date,STDT)
--order by convert(date,STDT)
)b
on a.Currency=b.CCUR
and a.Invoice_Date>=b.STDT
)a
where Rnk=1
--order by PostingDate
)a
where Brazil_Sales_Details_ver2.Invoice_Date=a.Invoice_Date
and Brazil_Sales_Details_ver2.Currency=a.Currency





----Special Case: 
--update GLSalesMargin set INR_ConversionRate_AER=a.CurrencyRate
--from (select * from [ELGi_LN].dbo.CurrencyRateMaster a where company=551
--and UpdatedDate=(select max(UpdatedDate) from [ELGi_LN].dbo.CurrencyRateMaster where company=551 and FromCurrency=a.FromCurrency) 
--and ToCurrency='INR' )a
--where GLSalesMargin.CurrencyCode=a.FromCurrency
--and GLSalesMargin.PostingDate between a.validFromDate and a.ValidToDate
--and GLSalesMargin.INR_ConversionRate_AER is null

update Brazil_Sales_Details_ver2 set USD_ConversionRate_AER=1 where currency='USD'

update Brazil_Sales_Details_ver2 set Sales_INR_AER=INR_ConversionRate_AER*Sales_HC
update Brazil_Sales_Details_ver2 set Sales_USD_AER=USD_ConversionRate_AER*Sales_HC



--Alter table Brazil_Sales_Details_ver2 alter column ItemCategory varchar(50)
--Alter table Brazil_Sales_Details_ver2 alter column ProductGroup varchar(50)
--Alter table Brazil_Sales_Details_ver2 add ItemGroupingSource varchar(50)

update Brazil_Sales_Details_ver2 set ItemCategory=a.Item_Category,
ProductGroup=a.Product_group,ItemGroupingSource='S&OP'
from (select * from [ELGi_SOP].dbo.TPL_MASTER_REF where region='Brazil')a
where ltrim(rtrim(Brazil_Sales_Details_ver2.Item))=ltrim(rtrim(a.Item))


update Brazil_Sales_Details_ver2 set ItemCategory=ctypdesc,ItemGroupingSource='LN Master'
where ItemCategory is null

update Brazil_Sales_Details_ver2 set ProductGroup=ItemGroup,ItemGroupingSource='LN Master'
where ProductGroup is null

update Brazil_Sales_Details_ver2 set ProductGroup='' where ProductGroup is null


end

--select PaymentDesc,trantype,sum(DeliveryQty) from Brazil_Sales_Details_ver2 
--where Invoice_Date between '2026-09-01' and '2026-09-30'
--group by PaymentDesc,trantype


--select L2_Group,PaymentDesc,trantype,sum(DeliveryQty) from [ELGi_LN].dbo.Global_Sales_Details
--where Invoice_Date between '2026-09-01' and '2026-09-30'
--and organ='Brazil'
--and L2_Group='ENCAP'
--group by L2_Group,PaymentDesc,trantype


--select PaymentDesc,Sales_HC,trantype,invoice,DeliveryQty from [ELGi_LN].dbo.Global_Sales_Details
--where Invoice_Date between '2026-09-01' and '2026-09-30'
--and organ='Brazil'
--and L2_Group='ENCAP'




--select * from Brazil_Sales_Details_ver2 where ltrim(rtrim(item))='X031964'
--where trantype='FAT' and invoice='2924' --Test Data

--select * from [ELGi_SOP].dbo.TPL_MASTER_REF where region='Brazil'
--and ltrim(rtrim(item))='X031964'

GO

