--exec sp_Global_Sales_Details
CREATE proc sp_Global_Sales_Details as
begin

Truncate table Global_Sales_Details

--Alter table Global_Sales_Details add S_and_OP_Region varchar(50)
--Alter table Global_Sales_Details add ItemGroupingSource varchar(50)
--Alter table Global_Sales_Details alter column Item nvarchar(60)


Declare @FinYear int=2023

Insert into Global_Sales_Details(company,Invoice_Date,trantype,Invoice,OrderDate,
SaleOrderType,OrderNo,PositionNo,CustomerOrderNo,custcode,custname,FinCustGrp,dpst,
dpstname,areacode,areaname,Item,Item_desc,Currency,DeliveryQty,Sales_INR,Sales_USD,
Sales_HC,Tax,SalesWithTax,Taxcode,PaymentDesc,EmpCode,EmpName,Organ,Region,Vertical1,
user_names,Zone,sales_category,CRM_Ref,ItemCategory,ProductGroup,ProductGroup3,LedgerCode,
S_and_OP_Region,ItemGroupingSource,
INR_ConversionRate_AER,USD_ConversionRate_AER,Sales_INR_AER,Sales_USD_AER,
GeographyKey,Level1
)

--Declare @FinYear int=2026
--select * into Global_Sales_Details from(
select *,concat(Organ,Vertical1,Region,Zone,areaname) as GeographyKey,'India' as Level1
from(
select convert(varchar,company) company,Invoice_Date,trantype,convert(varchar,Invoice) Invoice,
OrderDate,SaleOrderType,OrderNo,PositionNo,indent as CustomerOrderNo,
custcode,custname,FinCustGrp,dpst,dpstname,areacode,areaname,ltrim(rtrim(Item)) Item,Item_desc,
Currency,DeliveryQty,
Sales_amount as Sales_INR,
Sales_USD as Sales_USD, 
Foreign_currency_amount as Sales_HC,
t_txah_1 as Tax,Sales_amount + t_txah_1 as SalesWithTax,
Taxcode,PaymentDesc,salesrepcode as EmpCode,salesrep as EmpName,
Organ,case when Region is null then 'India' else Region end as Region,case
when vertical1 in ('DIRECT') and dpstname not like '%ofsac%' then 'DIRECT'
when vertical1 in ('DIRECT') and dpstname like '%ofsac%' then 'OFSAC'
when vertical1 in ('RAILWAY','Railways AfterMarket') then 'RAILWAYS'
when vertical1 in ('Industrials AfterMarket','Portables AfterMarket','AFTERSALES') then 'AFTER SALES'
else Vertical1 end as Vertical1,
user_names,Zone,convert(varchar,sales_category) sales_category,
null as CRM_Ref, 
CRM_Unit_Acc as ItemCategory,CRM_Productgroup as ProductGroup,
null as ProductGroup3,null as LedgerCode,S_and_OP_Region,ItemGroupingSource,
t_rate_1 as INR_ConversionRate_AER,Rate_USD as USD_ConversionRate_AER,
Sales_amount as Sales_INR_AER,Sales_USD as Sales_USD_AER
from [ELGI_LN].dbo.ELGi_Sales_Details
where sales_category not in (1)
and fin_year>=@FinYear
--and Fin_month=8
and Organ='India'
)a

union

select *,concat(Organ,Vertical1,Region,Zone,areaname) as GeographyKey,'ROW' as Level1 
from(
select convert(varchar,company) company,Invoice_Date,trantype,convert(varchar,Invoice) Invoice,
OrderDate,SaleOrderType,OrderNo,PositionNo,indent as CustomerOrderNo,
custcode,custname,FinCustGrp,dpst,dpstname,areacode,areaname,ltrim(rtrim(Item)) Item,Item_desc,
Currency,DeliveryQty,
Sales_amount as Sales_INR,
Sales_USD as Sales_USD, 
Foreign_currency_amount as Sales_HC,
t_txah_1 as Tax,Sales_amount + t_txah_1 as SalesWithTax,
Taxcode,PaymentDesc,salesrepcode as EmpCode,salesrep as EmpName,
Organ,Region,
case when user_names in ('SA-Spares','SA-Units') then 'SA'
else 'AME' end as Vertical1,
user_names,Zone,convert(varchar,sales_category) sales_category,
null as CRM_Ref, 
CRM_Unit_Acc as ItemCategory,CRM_Productgroup as ProductGroup,
null as ProductGroup3,null as LedgerCode,S_and_OP_Region,ItemGroupingSource,
t_rate_1 as INR_ConversionRate_AER,Rate_USD as USD_ConversionRate_AER,
Sales_amount as Sales_INR_AER,Sales_USD as Sales_USD_AER
from [ELGI_LN].dbo.ELGi_Sales_Details
where sales_category not in (1)
and fin_year>=@FinYear
--and Fin_month=8
and Organ='SAAME'
)a

union

select *,concat(Organ,Vertical1,Region,Zone,areaname) as GeographyKey,'ROW' as Level1
from(
select convert(varchar,company) company,Invoice_Date,trantype,convert(varchar,Invoice) Invoice,
OrderDate,SaleOrderType,OrderNo,PositionNo,indent as CustomerOrderNo,
custcode,custname,FinCustGrp,dpst,dpstname,areacode,areaname,ltrim(rtrim(Item)) Item,Item_desc,
Currency,DeliveryQty,
Sales_amount as Sales_INR,
Sales_USD as Sales_USD, 
Foreign_currency_amount as Sales_HC,
t_txah_1 as Tax,Sales_amount + t_txah_1 as SalesWithTax,
Taxcode,PaymentDesc,salesrepcode as EmpCode,salesrep as EmpName,
Organ,'ID' as Region,'ID' as Vertical1,
user_names,Zone,convert(varchar,sales_category) sales_category,
null as CRM_Ref, 
CRM_Unit_Acc as ItemCategory,CRM_Productgroup as ProductGroup,
null as ProductGroup3,null as LedgerCode,S_and_OP_Region,ItemGroupingSource,
t_rate_1 as INR_ConversionRate_AER,Rate_USD as USD_ConversionRate_AER,
Sales_amount as Sales_INR_AER,Sales_USD as Sales_USD_AER
from [ELGI_LN].dbo.ELGi_Sales_Details
where sales_category not in (1)
and fin_year>=@FinYear
--and Fin_month=8
and Organ='ID'
)a

union

select *,concat(Organ,Vertical1,Region,Zone,areaname) as GeographyKey,'ROW' as Level1
from(
select convert(varchar,company) company,Invoice_Date,trantype,convert(varchar,Invoice) Invoice,
OrderDate,SaleOrderType,OrderNo,PositionNo,indent as CustomerOrderNo,
custcode,custname,FinCustGrp,dpst,dpstname,areacode,areaname,ltrim(rtrim(Item)) Item,Item_desc,
Currency,DeliveryQty,
Sales_amount as Sales_INR,
Sales_USD as Sales_USD, 
Foreign_currency_amount as Sales_HC,
t_txah_1 as Tax,Sales_amount + t_txah_1 as SalesWithTax,
Taxcode,PaymentDesc,salesrepcode as EmpCode,salesrep as EmpName,
'ELGi Australia' as Organ,'ELGi Australia' as Region,'ELGi Australia' as Vertical1,
user_names,Zone,convert(varchar,sales_category) sales_category,
null as CRM_Ref, 
CRM_Unit_Acc as ItemCategory,CRM_Productgroup as ProductGroup,
null as ProductGroup3,null as LedgerCode,S_and_OP_Region,ItemGroupingSource,
t_rate_1 as INR_ConversionRate_AER,Rate_USD as USD_ConversionRate_AER,
Sales_amount as Sales_INR_AER,Sales_USD as Sales_USD_AER
from [ELGI_LN].dbo.ELGi_Sales_Details
where sales_category not in (1)
and fin_year>=@FinYear
--and Fin_month=8
and Organ='COSEA'
and company=551
and Custcode not in ('CU1P00009','CU1A00019')
)a

union


select *,concat(Organ,Vertical1,Region,Zone,areaname) as GeographyKey,'ROW' as Level1 from(
select convert(varchar,company) company,Invoice_Date,trantype,convert(varchar,Invoice) Invoice,
OrderDate,SaleOrderType,OrderNo,PositionNo,indent as CustomerOrderNo,
custcode,custname,FinCustGrp,dpst,dpstname,areacode,areaname,ltrim(rtrim(Item)) Item,Item_desc,
Currency,DeliveryQty,
Sales_amount as Sales_INR,
Sales_USD as Sales_USD, 
Foreign_currency_amount as Sales_HC,
t_txah_1 as Tax,Sales_amount + t_txah_1 as SalesWithTax,
Taxcode,PaymentDesc,salesrepcode as EmpCode,salesrep as EmpName,
'Interco Sales' as Organ,'Interco Sales' as Region,'Interco Sales' as Vertical1,
user_names,Zone,convert(varchar,sales_category) sales_category,
null as CRM_Ref, 
CRM_Unit_Acc as ItemCategory,CRM_Productgroup as ProductGroup,
null as ProductGroup3,null as LedgerCode,S_and_OP_Region,ItemGroupingSource,
t_rate_1 as INR_ConversionRate_AER,Rate_USD as USD_ConversionRate_AER,
Sales_amount as Sales_INR_AER,Sales_USD as Sales_USD_AER
from [ELGI_LN].dbo.ELGi_Sales_Details
where sales_category not in (1)
and fin_year>=@FinYear
--and Fin_month=8
and Organ='COSEA'
and company=551
and Custcode in ('CU1P00009','CU1A00019')
)a

union

select *,concat(Organ,Vertical1,Region,Zone,areaname) as GeographyKey,'ROW' as Level1 from(
select convert(varchar,company) company,Invoice_Date,trantype,convert(varchar,Invoice) Invoice,
OrderDate,SaleOrderType,OrderNo,PositionNo,indent as CustomerOrderNo,
custcode,custname,FinCustGrp,dpst,dpstname,areacode,areaname,ltrim(rtrim(Item)) Item,Item_desc,
Currency,DeliveryQty,
Sales_amount as Sales_INR,
Sales_USD as Sales_USD, 
Foreign_currency_amount as Sales_HC,
t_txah_1 as Tax,Sales_amount + t_txah_1 as SalesWithTax,
Taxcode,PaymentDesc,salesrepcode as EmpCode,salesrep as EmpName,
'SEA' as Organ,'SEA' as Region,areaname as Vertical1,
user_names,Zone,convert(varchar,sales_category) sales_category,
null as CRM_Ref, 
CRM_Unit_Acc as ItemCategory,CRM_Productgroup as ProductGroup,
null as ProductGroup3,null as LedgerCode,S_and_OP_Region,ItemGroupingSource,
t_rate_1 as INR_ConversionRate_AER,Rate_USD as USD_ConversionRate_AER,
Sales_amount as Sales_INR_AER,Sales_USD as Sales_USD_AER
from [ELGI_LN].dbo.ELGi_Sales_Details
where sales_category not in (1)
and fin_year>=@FinYear
--and Fin_month=8
and Organ='COSEA'
and areaname in ('Indonesia','Malaysia')
and company in ('552','553')
)a


union

select *,concat(Organ,Vertical1,Region,Zone,areaname) as GeographyKey,'ROW' as Level1 from(
select convert(varchar,company) company,Invoice_Date,trantype,convert(varchar,Invoice) Invoice,
OrderDate,SaleOrderType,OrderNo,PositionNo,indent as CustomerOrderNo,
custcode,custname,FinCustGrp,dpst,dpstname,areacode,areaname,ltrim(rtrim(Item)) Item,Item_desc,
Currency,DeliveryQty,
Sales_amount as Sales_INR,
Sales_USD as Sales_USD, 
Foreign_currency_amount as Sales_HC,
t_txah_1 as Tax,Sales_amount + t_txah_1 as SalesWithTax,
Taxcode,PaymentDesc,salesrepcode as EmpCode,salesrep as EmpName,
'SEA' as Organ,'SEA' as Region,areaname as Vertical1,
user_names,Zone,convert(varchar,sales_category) sales_category,
null as CRM_Ref, 
CRM_Unit_Acc as ItemCategory,CRM_Productgroup as ProductGroup,
null as ProductGroup3,null as LedgerCode,S_and_OP_Region,ItemGroupingSource,
t_rate_1 as INR_ConversionRate_AER,Rate_USD as USD_ConversionRate_AER,
Sales_amount as Sales_INR_AER,Sales_USD as Sales_USD_AER
from [ELGI_LN].dbo.ELGi_Sales_Details
where sales_category not in (1)
and fin_year>=@FinYear
--and Fin_month=8
and Organ='COSEA'
and areaname in ('Thailand')
)a

union

select *,concat(Organ,Vertical1,Region,Zone,areaname) as GeographyKey,'ROW' as Level1 from(
select convert(varchar,company) company,Invoice_Date,trantype,convert(varchar,Invoice) Invoice,
OrderDate,SaleOrderType,OrderNo,PositionNo,indent as CustomerOrderNo,
custcode,custname,FinCustGrp,dpst,dpstname,areacode,areaname,ltrim(rtrim(Item)) Item,Item_desc,
Currency,DeliveryQty,
Sales_amount as Sales_INR,
Sales_USD as Sales_USD, 
Foreign_currency_amount as Sales_HC,
t_txah_1 as Tax,Sales_amount + t_txah_1 as SalesWithTax,
Taxcode,PaymentDesc,salesrepcode as EmpCode,salesrep as EmpName,
'SEA' as Organ,Region,'SEA - VPS' as Vertical1,
user_names,Zone,convert(varchar,sales_category) sales_category,
null as CRM_Ref, 
CRM_Unit_Acc as ItemCategory,CRM_Productgroup as ProductGroup,
null as ProductGroup3,null as LedgerCode,S_and_OP_Region,ItemGroupingSource,
t_rate_1 as INR_ConversionRate_AER,Rate_USD as USD_ConversionRate_AER,
Sales_amount as Sales_INR_AER,Sales_USD as Sales_USD_AER
from [ELGI_LN].dbo.ELGi_Sales_Details
where sales_category not in (1)
and fin_year>=@FinYear
--and Fin_month=8
and Organ='COSEA'
and areaname in ('SINGAPORE','VIETNAM','Philippines')
and company like '4%'
)a



union

select *,concat(Organ,Vertical1,Region,Zone,areaname) as GeographyKey,'India' as Level1 from(
select convert(varchar,company) company,Invoice_Date,trantype,convert(varchar,Invoice) Invoice,
OrderDate,SaleOrderType,OrderNo,PositionNo,indent as CustomerOrderNo,
custcode,custname,FinCustGrp,dpst,dpstname,areacode,areaname,ltrim(rtrim(Item)) Item,Item_desc,
Currency,DeliveryQty,
Sales_amount as Sales_INR,
Sales_USD as Sales_USD, 
Foreign_currency_amount as Sales_HC,
t_txah_1 as Tax,Sales_amount + t_txah_1 as SalesWithTax,
Taxcode,PaymentDesc,salesrepcode as EmpCode,salesrep as EmpName,
Organ,Region,'VACUUM' as Vertical1,
user_names,Zone,convert(varchar,sales_category) sales_category,
null as CRM_Ref, 
CRM_Unit_Acc as ItemCategory,CRM_Productgroup as ProductGroup,
null as ProductGroup3,null as LedgerCode,S_and_OP_Region,ItemGroupingSource,
t_rate_1 as INR_ConversionRate_AER,Rate_USD as USD_ConversionRate_AER,
Sales_amount as Sales_INR_AER,Sales_USD as Sales_USD_AER
from [ELGI_LN].dbo.ELGi_Sales_Details
where sales_category not in (1)
and fin_year>=@FinYear
--and Fin_month=8
and Organ='VACUUM'
)a

union

select *,concat(Organ,Vertical1,Region,Zone,areaname) as GeographyKey,'India' as Level1 from(
select convert(varchar,company) company,Invoice_Date,trantype,convert(varchar,Invoice) Invoice,
OrderDate,SaleOrderType,OrderNo,PositionNo,indent as CustomerOrderNo,
custcode,custname,FinCustGrp,dpst,dpstname,areacode,areaname,ltrim(rtrim(Item)) Item,Item_desc,
Currency,DeliveryQty,
Sales_amount as Sales_INR,
Sales_USD as Sales_USD, 
Foreign_currency_amount as Sales_HC,
t_txah_1 as Tax,Sales_amount + t_txah_1 as SalesWithTax,
Taxcode,PaymentDesc,salesrepcode as EmpCode,salesrep as EmpName,
'Sales to subsidiary (From HO)' as Organ,
'Sales to subsidiary (From HO)' as Region,
'Sales to subsidiary (From HO)' as Vertical1,
user_names,Zone,convert(varchar,sales_category) sales_category,
null as CRM_Ref, 
CRM_Unit_Acc as ItemCategory,CRM_Productgroup as ProductGroup,
null as ProductGroup3,null as LedgerCode,S_and_OP_Region,ItemGroupingSource,
t_rate_1 as INR_ConversionRate_AER,Rate_USD as USD_ConversionRate_AER,
Sales_amount as Sales_INR_AER,Sales_USD as Sales_USD_AER
from [ELGI_LN].dbo.ELGi_Sales_Details
where sales_category not in (1)
and fin_year>=@FinYear
--and Fin_month=8
and Organ='Subsidiary'
)a


union

select *,concat(Organ,Vertical1,Region,Zone,areaname) as GeographyKey,'India' as Level1 from(
select convert(varchar,company) company,Invoice_Date,trantype,convert(varchar,Invoice) Invoice,
OrderDate,SaleOrderType,OrderNo,PositionNo,indent as CustomerOrderNo,
custcode,custname,FinCustGrp,dpst,dpstname,areacode,areaname,ltrim(rtrim(Item)) Item,Item_desc,
Currency,DeliveryQty,
Sales_amount as Sales_INR,
Sales_USD as Sales_USD, 
Foreign_currency_amount as Sales_HC,
t_txah_1 as Tax,Sales_amount + t_txah_1 as SalesWithTax,
Taxcode,PaymentDesc,salesrepcode as EmpCode,salesrep as EmpName,
Organ,
Region,
Vertical1,
user_names,Zone,convert(varchar,sales_category) sales_category,
null as CRM_Ref, 
CRM_Unit_Acc as ItemCategory,CRM_Productgroup as ProductGroup,
null as ProductGroup3,null as LedgerCode,S_and_OP_Region,ItemGroupingSource,
t_rate_1 as INR_ConversionRate_AER,Rate_USD as USD_ConversionRate_AER,
Sales_amount as Sales_INR_AER,Sales_USD as Sales_USD_AER
from [ELGI_LN].dbo.ELGi_Sales_Details
where sales_category not in (1)
--and fin_year>=@FinYear
--and Fin_month=8
and Organ='VAYU'
)a


union

select *,concat(Organ,Vertical1,Region,Zone,areaname) as GeographyKey,'India' as Level1 from( 
select convert(varchar,company) company,Invoice_Date,trantype,convert(varchar,Invoice) Invoice,
OrderDate,SaleOrderType,OrderNo,PositionNo,indent as CustomerOrderNo,
custcode,custname,FinCustGrp,dpst,dpstname,areacode,areaname,ltrim(rtrim(Item)) Item,Item_desc,
Currency,DeliveryQty,
Sales_amount as Sales_INR,
Sales_USD as Sales_USD, 
Foreign_currency_amount as Sales_HC,
t_txah_1 as Tax,Sales_amount + t_txah_1 as SalesWithTax,
Taxcode,PaymentDesc,salesrepcode as EmpCode,salesrep as EmpName,
'ATS' as Organ,'ATS' as Region,'ATS' as Vertical1,
user_names,Zone,convert(varchar,sales_category) sales_category,
null as CRM_Ref, 
CRM_Unit_Acc as ItemCategory,CRM_Productgroup as ProductGroup,
null as ProductGroup3,null as LedgerCode,'ATS' as S_and_OP_Region,ItemGroupingSource,
t_rate_1 as INR_ConversionRate_AER,Rate_USD as USD_ConversionRate_AER,
Sales_amount as Sales_INR_AER,Sales_USD as Sales_USD_AER
from [ELGi_LN].dbo.ATS_Sales_Details
where --sales_category not in (1) and
SaleOrderType not in (select SaleOrderType from 
[ELGI_LN].dbo.saletype_master_ATS where Sales_Category in (1))
and fin_year>=@FinYear
--and Fin_month=9
and isnull(productgrp,'') not in ('SCRAP')
and ltrim(rtrim(Item))<>'FRT'
and isnull(productgrp,'') not in ('SUPPLIER SALES')
and custcode not in ('CU1E00625','CU1E00001','CU1E00578','CU1E00068','CU1E00263')
)a

union

select *,concat(Organ,Vertical1,Region,Zone,areaname) as GeographyKey,'India' as Level1 from(
select convert(varchar,company) company,Invoice_Date,trantype,convert(varchar,Invoice) Invoice,
OrderDate,SaleOrderType,OrderNo,PositionNo,indent as CustomerOrderNo,
custcode,custname,FinCustGrp,dpst,dpstname,areacode,areaname,ltrim(rtrim(Item)) Item,Item_desc,
Currency,DeliveryQty,
Sales_amount as Sales_INR,
Sales_USD as Sales_USD, 
Foreign_currency_amount as Sales_HC,
t_txah_1 as Tax,Sales_amount + t_txah_1 as SalesWithTax,
Taxcode,PaymentDesc,salesrepcode as EmpCode,salesrep as EmpName,
'ATS to interco' as Organ,'ATS to interco' as Region,'ATS to interco' as Vertical1,
user_names,Zone,convert(varchar,sales_category) sales_category,
null as CRM_Ref, 
CRM_Unit_Acc as ItemCategory,CRM_Productgroup as ProductGroup,
null as ProductGroup3,null as LedgerCode,'ATS' as S_and_OP_Region,ItemGroupingSource,
t_rate_1 as INR_ConversionRate_AER,Rate_USD as USD_ConversionRate_AER,
Sales_amount as Sales_INR_AER,Sales_USD as Sales_USD_AER
from [ELGi_LN].dbo.ATS_Sales_Details
where --sales_category not in (1) and
SaleOrderType not in (select SaleOrderType from 
[ELGI_LN].dbo.saletype_master_ATS where Sales_Category in (1))
and fin_year>=@FinYear
--and Fin_month=9		
and isnull(productgrp,'') not in ('SCRAP')
and ltrim(rtrim(Item))<>'FRT'
and isnull(productgrp,'') not in ('SUPPLIER SALES')
and custcode in ('CU1E00625','CU1E00001','CU1E00578','CU1E00068','CU1E00263')
)a

union

select *,concat(Organ,Vertical1,Region,Zone,areaname) as GeographyKey,'ROW' as Level1 from(
select Company,--GL_AccountNo 
PostingDate as Invoice_Date,No_Series as Trantype,DocumentNo as Invoice,
OrderDate,null as SaleOrderType, --Sales/Service Order Prefix to be fetched from Salesorder table
OrderNo,null as PoNo,ExternalDocumentNo as CustomerOrderNo,
Customer as custcode,CustomerName as custname,null as FinCustGrp,
Dept as dpst,DeptName as dpstname,Dept1 as areacode,Dept1Name as areaname,
ltrim(rtrim(Item)) Item,ItemDescription,CurrencyCode,
Quantity as DeliveryQty,Sales_INR as Sales_INR,Sales_USD as Sales_USD, 
Amount as Sales_HC, null as Tax,null as SalesWithTax,null as Taxcode,PaymentTermsCode as PaymentDesc,
Dept as EmpCode,DeptName as EmpName,'Pulford' as Organ,'Pulford' as Region,--Dept
--'Pulford' as Vertical1,
isnull(vertical,'Pulford') as Vertical1,
null as user_names,
Region as [Zone],vertical as sales_category,
null as CRM_Ref,
ItemCategory,ProductGroup,null as ProductGroup3,null as LedgerCode,'Pulford' as S_and_OP_Region,
'Pulford' as ItemGroupingSource,--Cost,
INR_ConversionRate_AER,USD_ConversionRate_AER,Sales_INR_AER,Sales_USD_AER
from [ELGi_Pulford].dbo.GLSalesMargin
where fin_year>=@FinYear
)a

union

select *,concat(Organ,Vertical1,Region,Zone,areaname) as GeographyKey,'ROW' as Level1 from(
select convert(varchar,company) company,Invoice_Date,trantype,convert(varchar,Invoice) Invoice,
OrderDate,SaleOrderType,OrderNo,PositionNo,null as CustomerOrderNo,
custcode,custname,FinCustGrp,dpst,dpstname,areacode,areaname,ltrim(rtrim(Item)) Item,Item_desc,
Currency,DeliveryQty,
Sales_INR,
Sales_USD, 
Sales_HC,
Tax,
Sales_INR as SalesWithTax,
Taxcode,PaymentDesc,EmpCode,EmpName,
Organ,Region,Vertical1,user_names,Zone,convert(varchar,sales_category) sales_category,
null as CRM_Ref, 
ItemCategory,ProductGroup,
null as ProductGroup3,null as LedgerCode,'Brazil' as S_and_OP_Region,
ItemGroupingSource,
INR_ConversionRate_AER,USD_ConversionRate_AER,
Sales_INR_AER,Sales_USD_AER
from [ELGi_US].dbo.Brazil_Sales_Details_ver2
where fin_year>=@FinYear
)a

union


select company,Invoice_Date,trantype,Invoice,OrderDate,SaleOrderType,OrderNo,PositionNo,CustomerOrderNo,
custcode,custname,FinCustGrp,dpst,dpstname,areacode,areaname,Item,Item_desc,Currency,
sum(DeliveryQty) DeliveryQty,	
sum(Sales_INR) Sales_INR,
sum(Sales_USD) Sales_USD,
sum(Sales_HC) Sales_HC,
sum(Tax) Tax,
sum(SalesWithTax) SalesWithTax,	
Taxcode,PaymentDesc,EmpCode,EmpName,Organ,Region,Vertical1,user_names,Zone,sales_category,CRM_Ref,ItemCategory,
ProductGroup,ProductGroup3,LedgerCode,S_and_OP_Region,ItemGroupingSource,
avg(INR_ConversionRate_AER) INR_ConversionRate_AER,
avg(USD_ConversionRate_AER) USD_ConversionRate_AER,
sum(Sales_INR_AER) Sales_INR_AER,
sum(Sales_USD_AER) Sales_USD_AER,
concat(Organ,Vertical1,Region,Zone,areaname) as GeographyKey,'ROW' as Level1 
from(
select convert(varchar,company) company,convert(date,invdate) as Invoice_Date,trantype,convert(varchar,Invoice) Invoice,
OrderDate,SaleOrderType,OrderNo,PositionNo,null as CustomerOrderNo,
custcode,custname,FinCustGrp,null as dpst,null as dpstname,areacode,areaname,ltrim(rtrim(Item)) Item,Item_desc,
Currency,DeliveryQty,
Sales_INR,
Sales_USD, 
Sales_HC,
txah_1 Tax,
Sales_INR as SalesWithTax,
Taxcode,PayTYP_desc as PaymentDesc,null as EmpCode,null as EmpName,
Organ,Region,Vertical1,null as user_names,
Zone,null as sales_category,
null as CRM_Ref, 
ItemCategory,ProductGroup,
null as ProductGroup3,leac as LedgerCode,
case when company like '3%' then 'USA'
when company like '1%' then 'Europe' end as S_and_OP_Region,
ItemGroupingSource,
INR_ConversionRate_AER,USD_ConversionRate_AER,
Sales_INR_AER,Sales_USD_AER
from [ELGi_US].dbo.ELGi_Subsidiaries_Sales_Details
where fin_year>=@FinYear
and company not in ('2000')
)a
group by
company,Invoice_Date,trantype,Invoice,OrderDate,SaleOrderType,OrderNo,PositionNo,CustomerOrderNo,
custcode,custname,FinCustGrp,dpst,dpstname,areacode,areaname,Item,Item_desc,Currency,
Taxcode,PaymentDesc,EmpCode,EmpName,Organ,Region,Vertical1,user_names,Zone,sales_category,CRM_Ref,ItemCategory,
ProductGroup,ProductGroup3,LedgerCode,S_and_OP_Region,ItemGroupingSource

--)a


--Alter table Global_Sales_Details add HomeCurrency varchar(50)
update Global_Sales_Details set HomeCurrency='DHI' where company='500'
update Global_Sales_Details set HomeCurrency='AUD' where company='551'
update Global_Sales_Details set HomeCurrency='IDR' where company='552'
update Global_Sales_Details set HomeCurrency='MYR' where company='553'


update Global_Sales_Details set Sales_INR=isnull(a.INR_ConversionRate,0)*Sales_HC
from (select * from [ELGi_LN].dbo.CurrencyRateMaster_from_FinanceTeam)a
where (case when month(invoice_date)<4 then year(invoice_date)-1 else year(invoice_date) end)=a.FinYear
and Global_Sales_Details.Currency=a.SourceCurrency
and Global_Sales_Details.company not like '4%'
and Global_Sales_Details.company not like '6%'
and Global_Sales_Details.company not in ('500')

update Global_Sales_Details set Sales_USD=isnull(USD_ConversionRate,0)*Sales_HC
from (select * from [ELGi_LN].dbo.CurrencyRateMaster_from_FinanceTeam)a
where (case when month(invoice_date)<4 then year(invoice_date)-1 else year(invoice_date) end)=a.FinYear
and Global_Sales_Details.Currency=a.SourceCurrency
and Global_Sales_Details.company not like '4%'
and Global_Sales_Details.company not like '6%'
and Global_Sales_Details.company not in ('500')

--Special Case:
update Global_Sales_Details set Sales_INR=isnull(a.INR_ConversionRate,0)*Sales_HC
from (select * from [ELGi_LN].dbo.CurrencyRateMaster_from_FinanceTeam)a
where (case when month(invoice_date)<4 then year(invoice_date)-1 else year(invoice_date) end)=a.FinYear
and Global_Sales_Details.HomeCurrency=a.SourceCurrency
and Global_Sales_Details.company in ('551','552','553')


update Global_Sales_Details set Sales_USD=isnull(USD_ConversionRate,0)*Sales_HC
from (select * from [ELGi_LN].dbo.CurrencyRateMaster_from_FinanceTeam)a
where (case when month(invoice_date)<4 then year(invoice_date)-1 else year(invoice_date) end)=a.FinYear
and Global_Sales_Details.HomeCurrency=a.SourceCurrency
and Global_Sales_Details.company in ('551','552','553')



--Alter table Global_Sales_Details add INR_ConversionRate_AER float
--Alter table Global_Sales_Details add USD_ConversionRate_AER float

--Alter table Global_Sales_Details add Sales_INR_AER float
--Alter table Global_Sales_Details add Sales_USD_AER float



--------------------------------------------------------------------------------------------------

Update Global_Sales_Details set organ='India Subsidiaries Sales' where organ='Sales to subsidiary (From HO)'
Update Global_Sales_Details set Vertical1='India Subsidiaries Sales' where Vertical1='Sales to subsidiary (From HO)'

Update Global_Sales_Details set areaname='' where areaname is null

Update Global_Sales_Details set ProductGroup='Filters' where productgroup in ('Filters','Filter')
Update Global_Sales_Details set ProductGroup='Accessories' where productgroup in ('ACCESS','Accessories')
Update Global_Sales_Details set ProductGroup='Accessories' where productgroup in ('Driers','Dryer')
Update Global_Sales_Details set ProductGroup='Service Charges / Contracts' where productgroup like '%Service%'
Update Global_Sales_Details set ProductGroup='NA' where ProductGroup in ('','0') or ProductGroup is null
Update Global_Sales_Details set ProductGroup='Oil Water Separator' where ProductGroup in ('Oil Water Separator','Oil/Water Seperator''s')

--As per manikumar Maid dated: 22 July 2026 
update Global_Sales_Details set ItemCategory='Packaging & Freight'
where company like '3%' and itemcategory in ('PACKAGING','FREIGHT')

update Global_Sales_Details set ItemCategory='Others'
where company like '3%' and itemcategory in ('RENTAL','TBD')


update Global_Sales_Details set ItemCategory='Piping and Pipeline'
where company like '3%' and itemcategory in ('PIPING','Pipeline')




Update Global_Sales_Details set ItemCategory= 'Service' where ItemCategory like '%Service%'

Update Global_Sales_Details set ItemCategory='Aftermarket'
where ItemCategory in ('After Maret Parts - Other','After Market Parts - Other','After Market Parts - Elgi')

--End: As per manikumar Maid dated: 22 July 2026 



delete from Global_Sales_Details where company like '6%' and trantype in 
('6A3','6T1','6T3','6MR','SS1','615','653','6C1','6T4')

-- Removal of MDF Chages Based on Finance Team Mail dated: 26-11-2026
delete from Global_Sales_Details
where concat(company,trantype, invoice) in 
('5532SR35000024','5532SR35000025','5532P136000025','5536S136000008',
'5536S136000002','5536S136000003','5536S136000004','5532P135000328',
'5536S136000007','5536S136000005','5536S136000006','5536S136000001',
'5526S136000002','5526S136000001','5532SR35000025')

update Global_Sales_Details set 
Model=a.Model,
DFUcode=a.Demand_Forecasting_Unit_DFU,
India_TPL=a.India_TPL,
Supplier=a.Supplier,
HP=a.HP,
KW=a.KW,
Pressure_bar=a.Pressure_bar,
Pressure_psi=a.pressure_psi,
Variant=a.Variant,
Frame=a.Frame,
ItemGroupingSource='S&OP'
from (select * from [ELGi_SOP].dbo.TPL_MASTER_REF)a
where ltrim(rtrim(Global_Sales_Details.S_and_op_Region))=ltrim(rtrim(a.Region))
and ltrim(rtrim(Global_Sales_Details.Item))=ltrim(rtrim(a.Item))


update Global_Sales_Details set
Product_segment=a.prod_segment,
Product_series=a.prod_series,
Voltage=a.voltage,
Phase=a.phase,
Cooling_type=a.cooling_type,
Lube_type=a.lube_type,
Mount_type=a.mount_type,
Drive_type=a.drive_type,
Feature_variant=a.feature_variant,
HP=a.HP,
KW=a.KW,
Pressure_bar=a.Pressure_bar,
Pressure_psi=a.Pressure_psi,
ItemGroupingSource='CDOC'
from (
select distinct --tpl as CDOC_tpl,tpl_desc as CDOC_tpl_desc,prod_group as CDOC_Productgroup 
tpl,tpl_desc,prod_group,country,voltage,phase,prod_segment,prod_series,cooling_type,
feature_variant,model_variant,power_variant,pressure_variant,lube_type,mount_type,
drive_type,cfm,cfm_uom,power,power_uom,mkt_seg,loco_seg,tpl_rev,pressures,pr_uom,efdate,
case when power_uom='HP' then replace(TRANSLATE([power],'{""}','    '),'    ','') end as HP,
case when power_uom='KW' then replace(TRANSLATE([power],'{""}','    '),'    ','') end as KW,
case when pr_uom='bar.g ' then replace(TRANSLATE(pressures,'{""}','    '),'    ','') end as Pressure_bar,
case when pr_uom='psi.g ' then replace(TRANSLATE(pressures,'{""}','    '),'    ','') end as Pressure_psi
from [ELGi_CDOC].dbo.crd_attribs
union
select distinct 
tpl,tpl_desc,prod_group,country,null as voltage,null as phase,prod_segment,prod_series,
null as cooling_type,null as feature_variant,model_variant,null as power_variant,
null as pressure_variant,null as lube_type,mount_type,
null as drive_type,null as cfm,null as cfm_uom,null as power,null as power_uom,
null as mkt_seg,null as loco_seg,tpl_rev,null as pressures,null as pr_uom,efdate,
null as HP,null as KW,null as Pressure_bar,null as Pressure_psi
from [ELGi_CDOC].dbo.dpsac1
)a
where trim(Global_Sales_Details.Item)=trim(a.tpl)
and trim(Global_Sales_Details.Item) not in (select distinct trim(tpl) from [ELGi_SOP].dbo.TPL_MASTER_REF)



--End : Additional Attributes related to ItemCode

--L1 ,L2, L3 classification as per Finance Logic---------------------

--Prior Step
update Global_Sales_Details set L1_Group=null,L2_Group=null,L3_Group=null,L1L2L3_LogicSource=null

update Global_Sales_Details set L1_Group=ItemCategory,L2_Group=Productgroup,
L1L2L3_LogicSource='Units data from S&OP'
where ItemGroupingSource in ('S&OP')
and ItemCategory in ('Units')

update Global_Sales_Details set --L1_Group=ItemCategory,
L2_Group=Productgroup,
L1L2L3_LogicSource='Data from CDOC'
where ItemGroupingSource in ('CDOC')
and L1_Group is null



--Step 1: USA ;BOM Lookup with S&OP

update Global_Sales_Details set L1_Group=ItemCategory,L2_Group=ProductGroup,
L1L2L3_LogicSource='LN BOM lookup with S&OP Units'
from (
select distinct a.compnr,a.mitm,b.Item,b.India_TPL,Item_Category,Product_group from
(select * from [ELGi_US].dbo.LN_TIBOM310
--where mitm like '%EN005C-150AS-000B-A0J-0000%'
)a
Inner join(select * from [ELGi_SOP].dbo.TPL_MASTER_REF
where Item_Category='Units'
)b
on trim(a.MITM)=trim(b.Item)
)a
where trim(Global_Sales_Details.Item)=trim(a.mitm)
and Global_Sales_Details.Region in ('USA','Brazil')
and Global_Sales_Details.L1_Group is null

update Global_Sales_Details set L1_Group=ItemCategory,L2_Group=ProductGroup,
L1L2L3_LogicSource='LN BOM lookup with S&OP Units'
from (
select distinct a.compnr,a.mitm,b.Item,b.India_TPL,Item_Category,Product_group from
(select * from [ELGi_US].dbo.LN_TIBOM310
--where mitm like '%EN005C-150AS-000B-A0J-0000%'
)a
Inner join(select * from [ELGi_SOP].dbo.TPL_MASTER_REF
where Item_Category='Units'
)b
on trim(a.sitm)=trim(b.Item)
)a
where trim(Global_Sales_Details.Item)=trim(a.mitm)
and Global_Sales_Details.Region in ('USA','Brazil')
and Global_Sales_Details.L1_Group is null

--End of Step 1: USA ;BOM Lookup with S&OP
--Step 2: All Regions

update Global_Sales_Details set L1_Group='Equipments'
--,L1L2L3_LogicSource='Finance Logic'
where ItemCategory like '%Units%' --and company like '4%'

--update Global_Sales_Details set L2_Group=ProductGroup,
--L1L2L3_LogicSource='Finance Logic'
--where L1_Group='Equipments' --and company like '4%'
--and ItemGroupingSource in ('S&OP','CDOC')

--update Global_Sales_Details set L2_Group=ProductGroup,
--L1L2L3_LogicSource='Finance Logic'
--where L1_Group<>'Equipments' --and company like '4%'
--and ItemGroupingSource in ('S&OP','CDOC')

update Global_Sales_Details set L1_Group='Equipments',L2_Group='Vacuum',
L1L2L3_LogicSource='Finance Logic'
where ProductGroup like 'VACUUM PUMP' --and company like '4%'
--and ItemGroupingSource in ('S&OP','CDOC')

--update Global_Sales_Details set L1_Group=ItemCategory,L2_Group=ProductGroup
--where ProductGroup like '%EPSAC%' --and company like '4%'
--and ItemGroupingSource in ('S&OP','CDOC')

--update Global_Sales_Details set L1_Group='Equipments',L2_Group='EPSAC',
--L1L2L3_LogicSource='Finance Logic'
--where ProductGroup like '%EPSAC%'

--update Global_Sales_Details set L1_Group='Equipments',L2_Group=ProductGroup,
--L1L2L3_LogicSource='Finance Logic'
--where ProductGroup like '%EPSAC%'
--and ItemGroupingSource in ('S&OP','CDOC')



--update Global_Sales_Details set L1_Group=ItemCategory,L2_Group=ProductGroup,
--L1L2L3_LogicSource='Finance Logic'
--where ProductGroup like '%OFSAC%' --and company like '4%'
--and ItemGroupingSource in ('S&OP','CDOC')

--update Global_Sales_Details set L1_Group=ItemCategory,L2_Group=ProductGroup,
--L1L2L3_LogicSource='Finance Logic'
--where ProductGroup like '%Railway%' --and company like '4%' 
--and ItemGroupingSource in ('S&OP','CDOC')

--update Global_Sales_Details set L1_Group=ItemCategory,L2_Group=ProductGroup,
--L1L2L3_LogicSource='Finance Logic'
--where ProductGroup like 'RAC' --and company like '4%' 
--and ItemGroupingSource in ('S&OP','CDOC')

--update Global_Sales_Details set L1_Group=ItemCategory,L2_Group=ProductGroup,
--L1L2L3_LogicSource='Finance Logic'
--where ProductGroup like 'SPC' --and company like '4%' 
--and ItemGroupingSource in ('S&OP','CDOC')

--End of Step 2: All Regions
--Step 3: Rotair 

--As per the discussion made on Teams Group Discussion Titled: Global Sales Dashboard - UI Cosmetic Changes + Go Live Readiness
--on 05-08-2026 16:53

update Global_Sales_Details set L1_Group='Equipments',
L1L2L3_LogicSource='Finance Logic'
where company='1100'


update Global_Sales_Details set L2_Group=Vertical1,
L1L2L3_LogicSource='Finance Logic'
where company='1100' and Vertical1  not like '%interco%'


update Global_Sales_Details set Organ='Rotair to Interco',
vertical1='Rotair to Interco',Region='Europe',[Zone]='Europe',Areaname='Europe'
where company ='1100'
and custcode in (select custcode from [ELGI_US].dbo.vw_Rotair_Interco_customer_codes)



--Alter table Global_Sales_Details alter column L1L2L3_LogicSource varchar(100)
--End of Step 3: Rotair 
--Step 4: L1 Genralization

--update Global_Sales_Details set L1_Group='Equipments',
--L1L2L3_LogicSource='Finance Logic' where ItemCategory like '%Units%'
--update Global_Sales_Details set L1_Group='Parts',
--L1L2L3_LogicSource='Finance Logic' where ItemCategory in ('Spares','Aftermarket')

--End of Step 4: End of L1 Genralization
--Step 5: Finance Master Lookup --for Parts

update Global_Sales_Details set L1_Group=a.[Level 1],L2_Group=a.[Level 2],L3_Group=a.[Level 3],
L1L2L3_LogicSource='Finance Master File'
from (select distinct [Item code],[Level 1],[Level 2],[Level 3] from Item_Master_Finance 
where Region='India' --and [Level 1] in ('Parts','Accessories')
)a
where trim(Global_Sales_Details.Item)=trim(a.[Item Code])
and (Global_Sales_Details.company like '4%' or Global_Sales_Details.company like '5%')
and Global_Sales_Details.L1_Group is null
--and Global_Sales_Details.L1_Group=a.[Level 1]

update Global_Sales_Details set L1_Group=a.[Level 1],L2_Group=a.[Level 2],L3_Group=a.[Level 3],
L1L2L3_LogicSource='Finance Master File'
from (select distinct [Item code],[Level 1],[Level 2],[Level 3] from Item_Master_Finance 
where Region='USA' --and [Level 1] in ('Parts','Accessories')
)a
where trim(Global_Sales_Details.Item)=trim(a.[Item Code])
and Global_Sales_Details.company like '3%' 
and Global_Sales_Details.L1_Group is null
--and Global_Sales_Details.L1_Group=a.[Level 1]

update Global_Sales_Details set L1_Group=a.[Level 1],L2_Group=a.[Level 2],L3_Group=a.[Level 3],
L1L2L3_LogicSource='Finance Master File'
from (select distinct [Item code],[Level 1],[Level 2],[Level 3] from Item_Master_Finance 
where Region='Europe' --and [Level 1] in ('Parts','Accessories')
)a
where trim(Global_Sales_Details.Item)=trim(a.[Item Code])
and Global_Sales_Details.company like '1%' 
and Global_Sales_Details.L1_Group is null
--and Global_Sales_Details.L1_Group=a.[Level 1]

update Global_Sales_Details set L1_Group=a.[Level 1],L2_Group=a.[Level 2],L3_Group=a.[Level 3],
L1L2L3_LogicSource='Finance Master File'
from (select distinct [Item code],[Level 1],[Level 2],[Level 3] from Item_Master_Finance 
where Region='Brazil' --and [Level 1] in ('Parts','Accessories')
)a
where trim(Global_Sales_Details.Item)=trim(a.[Item Code])
and Global_Sales_Details.company like '2000%' 
and Global_Sales_Details.L1_Group is null
--and Global_Sales_Details.L1_Group=a.[Level 1]


update Global_Sales_Details set L1_Group=a.[Level 1],L2_Group=a.[Level 2],L3_Group=a.[Level 3],
L1L2L3_LogicSource='Finance Master File'
from (select distinct [Item code],[Level 1],[Level 2],[Level 3] from Item_Master_Finance 
where Region='AUS' --and [Level 1] in ('Parts','Accessories')
)a
where trim(Global_Sales_Details.Item)=trim(a.[Item Code])
and Global_Sales_Details.company like '551%' 
and Global_Sales_Details.L1_Group is null
--and Global_Sales_Details.L1_Group=a.[Level 1]


update Global_Sales_Details set L1_Group=a.[Level 1],L2_Group=a.[Level 2],L3_Group=a.[Level 3],
L1L2L3_LogicSource='Finance Master File'
from (select distinct [Item code],[Level 1],[Level 2],[Level 3] from Item_Master_Finance 
where Region='Pulford' --and [Level 1] in ('Parts','Accessories')
)a
where trim(Global_Sales_Details.Item)=trim(a.[Item Code])
and Global_Sales_Details.company in ('Pulford','AdvancedAir')
and Global_Sales_Details.L1_Group is null
--and Global_Sales_Details.L1_Group=a.[Level 1]


update Global_Sales_Details set L1_Group=a.[Level 1],L2_Group=a.[Level 2],L3_Group=a.[Level 3],
L1L2L3_LogicSource='Finance Master File'
from (select distinct [Item code],[Level 1],[Level 2],[Level 3] from Item_Master_Finance 
where Region='Gulf' --and [Level 1] in ('Parts','Accessories')
)a
where trim(Global_Sales_Details.Item)=trim(a.[Item Code])
and Global_Sales_Details.company in ('500')
and Global_Sales_Details.L1_Group is null
--and Global_Sales_Details.L1_Group=a.[Level 1]


update Global_Sales_Details set L1_Group=a.[Level 1],L2_Group=a.[Level 2],L3_Group=a.[Level 3],
L1L2L3_LogicSource='Finance Master File'
from (select distinct [Item code],[Level 1],[Level 2],[Level 3] from Item_Master_Finance 
where Region='ATS' --and [Level 1] in ('Parts','Accessories')
)a
where trim(Global_Sales_Details.Item)=trim(a.[Item Code])
and Global_Sales_Details.company like '6%'
and Global_Sales_Details.L1_Group is null
--and Global_Sales_Details.L1_Group=a.[Level 1]


--'BI Reconciliation'

--update Global_Sales_Details set L1_Group=a.[Level 1],L2_Group=a.[Level 2],L3_Group=a.[Level 3],
--L1L2L3_LogicSource='BI Reconciliation'
--from (select distinct [Item code],[Level 1],[Level 2],[Level 3] from Item_Master_Finance 
--where [Level 1] in ('Parts','Accessories'))a
--where trim(Global_Sales_Details.Item)=trim(a.[Item Code])
--and Global_Sales_Details.L1_Group is null

--update Global_Sales_Details set L1_Group=a.L1_Group,L2_Group=a.L2_Group,L3_Group=a.L3_Group,
--L1L2L3_LogicSource='BI Reconciliation'
--from (select distinct company,Item,L1_Group,L2_Group,L3_Group from Global_Sales_Details 
--where L1_Group='Equipments'
--)a
--where trim(Global_Sales_Details.Item)=trim(a.Item)
--and Global_Sales_Details.L1_Group is null



--End of Step 5: Finance Master Lookup for Parts
--Step 6: For the Missing Cases

update Global_Sales_Details set L1_Group='Parts',L1L2L3_LogicSource='Finance Logic'
where L1_Group='Spares'
update Global_Sales_Details set L2_Group='Parts',L1L2L3_LogicSource='Finance Logic'
where L2_Group='Spares'
update Global_Sales_Details set L3_Group='Parts',L1L2L3_LogicSource='Finance Logic'
where L3_Group='Spares'


update Global_Sales_Details set L1_Group='Service',L2_Group='Service Charges / Contracts',
L1L2L3_LogicSource='BI Logic'
where ItemCategory='Service'


update Global_Sales_Details set L1_Group='Service',L2_Group='Service Charges / Contracts',
L1L2L3_LogicSource='Finance Logic'
where company like '3%'
and trantype in ('s11','s20')
and item =''

update Global_Sales_Details set L1_Group=ItemCategory,L2_Group=ProductGroup,
L1L2L3_LogicSource='BI Logic'
where L1_Group is null and ItemGroupingSource='BI Logic'


--New Method Since 05-10-2026
update Global_Sales_Details set L1_Group=L1,L2_Group=L2,L3_Group=L3,
L1L2L3_LogicSource='Revised S&OP Master'
from (select * from [ELGi_SOP].dbo.TPL_MASTER_REF
where L1 not in ('SPARES','PARTS','ACCESSORIES')
--and Region in ('USA','Europe','Brazil')
)a
where trim(Global_Sales_Details.Item)=trim(a.Item)
and Global_Sales_Details.S_and_OP_Region=trim(a.Region)
--and Global_Sales_Details.Region in ('USA','Europe','Brazil','ID')

update Global_Sales_Details set L1_Group='ATS Equipments' where L1_Group='ATS'



--End of Step 6: For the Missing Cases
--Step 7: For the Missing Cases lookup from LN Master

--update Global_Sales_Details set L1_Group=ItemCategory,L2_Group=ProductGroup,
--L1L2L3_LogicSource='LN Master'
--where L1_Group is null and ItemGroupingSource='LN Master'
--and itemcategory in ('Equipments','PARTS','Accessories','Aftermarket','Spares',
--'Packaging & Freight','Piping and Pipeline','Others')


--update Global_Sales_Details set L2_Group=L1_Group
--where L1_Group in ('Packaging & Freight','Piping and Pipeline','Others')

--End of Step 7: For the Missing Cases lookup from LN Master
--Step 8: For the Remaining Missing Cases

update Global_Sales_Details set L1_Group='Service' where L1_Group like '%Service%'
update Global_Sales_Details set L2_Group='Service Charges / Contracts' where L2_Group like '%Service%'


update Global_Sales_Details set L1_Group='Grouping to be Defined',
L1L2L3_LogicSource='Finance Logic' where L1_Group is null
update Global_Sales_Details set L2_Group='Grouping to be Defined',
L1L2L3_LogicSource='Finance Logic' where L2_Group is null
update Global_Sales_Details set L3_Group='Grouping to be Defined',
L1L2L3_LogicSource='Finance Logic' where L3_Group is null

--update Global_Sales_Details set L1_Group=upper(L1_Group)
--update Global_Sales_Details set L2_Group=upper(L2_Group)
--update Global_Sales_Details set L3_Group=upper(L3_Group)


--End of Step 8: For the Remaining Missing Cases
--End of Step 2: L1 ,L2, L3 classification as per Finance Logic---------------------



end

select count(*) from Global_Sales_Details --15246
where l1_group='Grouping to be Defined'

select count(*) from Global_Sales_Details --15622
where L2_Group='Grouping to be Defined'

--select distinct company,L1_Group,L2_Group from Global_Sales_Details
--where l1_group like '%service%'
----where Organ='Rotair'

--select L1_Group,count(distinct Item) from Global_Sales_Details
--where company like '6%'
--group by L1_Group



--select distinct itemcategory from Global_Sales_Details
--where company like '3%'


--select distinct company,areacode,Areaname from Global_Sales_Details
--where company like '1%'
--order by company
--select distinct concat(ItemCategory,Productgroup) as ProductKey ,ItemCategory,Productgroup from Global_Sales_Details
--where concat(ItemCategory,Productgroup) not in ('')
--and ltrim(rtrim(Item))='S019379'

--select distinct CRM_Unit_Acc,CRM_Productgroup from ELGi_Sales_Details
--where ltrim(rtrim(Item))='S019379'

--select * from ELGi_Sales_Details
--where ltrim(rtrim(Item))='X990825'


--select * from [ELGi_SOP].dbo.TPL_MASTER_REF
--where ltrim(rtrim(Item))='S019310'

--select * from Global_Sales_Details
--where ltrim(rtrim(Item))='Z03205'

--select sum(sales_HC) from Global_sales_details
--where company='2000'
--and invoice_date between '2026-03-01' and '2026-03-31'

GO

