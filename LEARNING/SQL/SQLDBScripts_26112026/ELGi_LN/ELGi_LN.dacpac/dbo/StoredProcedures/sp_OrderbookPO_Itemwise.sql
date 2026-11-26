
CREATE proc [dbo].[sp_OrderbookPO_Itemwise] as

Truncate table OrderbookPO_Itemwise 

------------------- STEP 1 ATS------------------------------

Insert into OrderbookPO_Itemwise (Company,MonthYear_P,OrderDate,Sales,Itemcode)

select Company_name,[Month-Year_P],Orderdate,sum(sales) 'Sales',ItemCode from (
SELECT distinct A.*,format(a.orderDate,'MMM-yyyy') 'Month-Year_P' , 'ATS' 'Company_name'
FROM 
(
select a.dpst,a.Company,a.ordertype,a.OrderNum,invnum,
substring(a.LineOfBusiness,1,len(LineOfBusiness)-1)LineOfBusiness,a.LOBCode,
a.Segment,a.SubDivision,a.SalesRep,a.SalesRepCode,     
datename(mm,a.OrderDate)as Month,convert(date,a.OrderDate) as OrderDate,
a.CustCode,a.ItemCode,a.CustName as custname1,a.Item_desc,a.AreaName,a.Zone,Region,
a.Currency,a.CurrRate,price as Unitprice,sum(qty) qty,
sum(discount) discount,sum(sales)as Sales,a.DeliveryTerms,a.DelvDesc,
a.Indent,a.positionNum
From 
(
select * From Sales_Inflow 
where company in (select distinct Company  From ELGI_Companies_Master where CompanyGroup ='ATS')
and convert(date,OrderDate)  between '2021-04-01' and convert(date,getdate()) and invnum=0
--and AreaCode in (@area)
--and zone in (@zone)
and concat(company,OrderType) not IN (select DISTINCT concat(company,saleordertype)  From saletype_master_ATS  WHERE Sales_Category IN (1)) 
)a

group by a.dpst,a.Company,a.ordertype,a.OrderNum,invnum,month(a.OrderDate),a.OrderDate,
a.CustCode,a.ItemCode,a.Currency,a.CurrRate,price,a.LineOfBusiness,a.LOBCode,
a.Segment,a.SubDivision,a.SalesRep,a.SalesRepCode,a.custname,Item_desc,AreaName,Zone,
Region ,a.DeliveryTerms,a.DelvDesc,a.Indent,a.positionNum
)a 

)a
group by Company_name,[Month-Year_P],OrderDate,ItemCode



------------------- STEP 2 PULFORD------------------------------

Insert into OrderbookPO_Itemwise (Company,MonthYear_P,OrderDate,Sales,Itemcode)


select 'Pulford' Company_name,format(a.PostingDate,'MMM-yyyy') 'Month-Year_P',PostingDate 'ORDERDATE',SUM(LineAmount) 'LineAmount',Item from (
select 'SalesOrder' as OrderType,Company,PostingDate,DocumentNo,
Dept1,Dept1Name,null as subDept1,null as subDept1Name,Dept,DeptName,null as subDept,null as subDeptName,
Customer,CustomerName,Item,ItemDescription,RequestedDeliveryDate,
OutstandingQty,UnitPrice,LineDiscountAmount,LineAmount,AmountIncludingVAT,
OutstandingAmount,DocumentType,
Status,Type,Cost,DimensionCode,null as ZoneCode,null as LocationCode from ELGI_PULFORD.DBO.OpenSalesOrderMargin
union
select 'ServiceOrder' as OrderType ,CompanyName,PostingDate,DocumentNo, 
Dept1_Orig,Dept1Name_Orig,Dept1,Dept1Name,Dept_Orig,DeptName_Orig,Dept,DeptName,
Customer,CustomerName,Item,ItemDescription,null as RequestedDeliveryDate,
Quantity,null as UnitPrice,null as LineDiscountAmount,Amount,null as AmountIncludingVAT,
null as OutstandingAmount,DocumentType,
null as Status,null as Type,Cost,DimensionCode,ServiceZoneCode,LocationCode
from ELGI_PULFORD.DBO.OpenServiceOrderMargin
)a
group by PostingDate,Item

------------------- STEP 3 BRAZIL------------------------------

Insert into OrderbookPO_Itemwise (Company,MonthYear_P,OrderDate,Sales,Itemcode)


select Company_name,[Month-Year_P],convert(date,odat) 'Orderdate',Sum(openPrice) 'PendingValue',ItemCode from (
select  a.compnr,
convert(date,dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2)))) as odat,replace(a.item,' ','')"ItemCode",b.dsca,a.orno,pono,sqnb,a.cwar,a.clyn,c.refa,c.sotp,c.refb ,
case when c.refa like '%SO#%' then 'Take StockOrder' else 'LN Order' end "Type"
,a.pric,pror_KW,chrq_kw ,a.oamt,dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,a.ddta2))) as DelDate
,YEAR (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))'CalYear',MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))'CalMonth'
,c.hdst_kw,
case when YEAR (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2)))) <4 
     then YEAR (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))-1 
     else YEAR (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2)))) end 'FinYear',
case when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=1 then 10
	 when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=2 then 11
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=3 then 12
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=4 then 1
	 when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=5 then 2
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=6 then 3
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=7 then 4
	 when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=8 then 5
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=9 then 6
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=10 then 7
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=11 then 8
	 when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,convert(datetime,c.odat2))))=12 then 9
else 0 
end 'FinMonth',format(convert(datetime,c.odat2),'MMM-yyyy') 'Month-Year_P',
qoor,qidl,qbbo,(a.qoor-a.qidl-qbbo)'openQty',(((a.qoor-a.qidl-qbbo)*a.pric)-amld)'OpenPrice',g.nama,b.cpln,amld, 'Brazil' 'Company_name'
from ELGI_US.dbo.LN_tdsls401 a 
left join ELGI_US.dbo.LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='2000' and b.deleted='N'
left join ELGI_US.dbo.LN_tdsls400 c on c.compnr=a.compnr and c.orno=a.orno and c.deleted='N' 
left join ELGI_US.dbo.LN_TCCom100 g on g.bpid=c.ofbp  and g.deleted='N' and g.compnr='2000'
where a.compnr='2000'
and a.deleted='N'   and a.qidl=0
and isnull(sotp,'-')<>'-' 
and a.clyn=2 and c.hdst_kw not in ('tdsls.hdst.cancelled','tdsls.hdst.closed') and isnull(YEAR(c.odat),'')<>''
and c.clyn=2  
and  CONCAT(a.compnr,a.orno,pono,a.sqnb) not in  (select concat(a.compnr,a.orno,pono,a.sqnb) from  ELGI_US.dbo.LN_TDSLS406 a)
) g2
group by Company_name,odat,[Month-Year_P],ItemCode


------------------- STEP 4 EUROPE AND ROTAIR ------------------------------

Insert into OrderbookPO_Itemwise (Company,MonthYear_P,OrderDate,Sales,Itemcode)


select Company,Month_Year_P,convert(date,odat) 'OrdDate',sum(OpenPrice) 'OpenValue',ItemCode from (
select distinct case when
b.cpln<>'L02' then'Rotair' when 
b.cpln='L02' then'ELGi Europe' else 'Rotair' end
"Company",
convert(date,dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2)))) as odat,replace(a.item,' ','')"ItemCode",b.dsca,a.orno,pono,sqnb,a.cwar,a.clyn,c.refa,c.sotp,c.refb ,
case when c.refa like '%SO#%' then 'Take StockOrder' else 'LN Order' end "Type"
,a.pric,pror_KW,chrq_kw 'A.chrw_qw' ,a.oamt,dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,a.ddta2))) as DelDate
,YEAR (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))'CalYear',MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))'CalMonth'
,c.hdst_kw,c.chrq_kw,
case when YEAR (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2)))) <4 
     then YEAR (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))-1 
     else YEAR (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2)))) end 'FinYear',
case when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=1 then 10
	 when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=2 then 11
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=3 then 12
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=4 then 1
	 when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=5 then 2
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=6 then 3
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=7 then 4
	 when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=8 then 5
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=9 then 6
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=10 then 7
	when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=11 then 8
	 when MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2))))=12 then 9
else 0 
end 'FinMonth',format(convert(datetime,dateadd(MINUTE ,-29,dateadd(hour,-3,convert(datetime,c.odat2)))),'MMM-yyyy') 'Month_Year_P',
qoor,qidl,(a.qoor-a.qidl-qbbo)'openQty',(((a.qoor-a.qidl-qbbo)*a.pric)-amld)'OpenPrice',g.nama,b.cpln,amld
from ELGI_US.dbo.LN_tdsls401 a 
left join ELGI_US.dbo.LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='1100' and b.deleted='N'
left join ELGI_US.dbo.LN_tdsls400 c on c.compnr=a.compnr and c.orno=a.orno and c.deleted='N'
left join ELGI_US.dbo.LN_TCCom100 g on g.bpid=c.ofbp  and g.deleted='N'
where a.compnr in('1100','1700') and a.deleted='N' and (a.qoor-a.qidl-qbbo)>0 and isnull(sotp,'-')<>'-' 
and a.clyn=2 and c.hdst_kw<>'tdsls.hdst.cancelled' and isnull(YEAR(c.odat2),'')<>'' and  (
    (b.cpln='L02' AND g.nama NOT LIKE 'ELGi%' AND g.nama NOT LIKE 'ROTAIR%')
    OR B.cpln<>'L02')

	)a 
group by Company,Month_Year_P,convert(date,odat),ItemCode 

------------------- STEP 5 USA ------------------------------

Insert into OrderbookPO_Itemwise (Company,MonthYear_P,OrderDate,Sales,Itemcode)

SELECT company_name,format(odat,'MMM-yyyy') 'Month_year_P' ,odat,sum(OpenPrice) 'OpenPrice',Item FROM (
select distinct case
 when compnr=3110 then'Industrial (incl. interco)'
 when compnr=3120 then'US Portables'
 when compnr=3130 then'Pattons Medical'
 when compnr=3140 then'Pattons INC'
 when compnr=3150 then'Michigan' end Company_name,OpenPrice,odat,dsca,nama,orno,ItemCode 'Item',pono,sqnb,deldate,producttype,qoor,pric,amld

from ELGI_US.dbo.[US_OpenOrder]

union all

--service order
select case when a.compnr=3100 then'ELGI NA'
 when a.compnr=3110 then'Industrial (incl. interco)'
 when a.compnr=3120 then'US Portables'
 when a.compnr=3130 then'Pattons Medical'
 when a.compnr=3140 then'Pattons INC'
 when a.compnr=3150 then'Michigan' end Company_name,
 --format((convert(datetime,CONVERT(datetime,SWITCHOFFSET(CONVERT(datetimeoffset,a.ordt),DATENAME(TzOffset, SYSDATETIMEOFFSET())))) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time','MMM-yyyy') 'Month-Year_P',
 amnt'OpenPrice',
 convert(date,(CONVERT(datetime, a.ordt) AT TIME ZONE 'UTC') AT TIME ZONE 'Eastern Standard Time') as 'odat',
 dsca,nama,orno,item 'Item'
 ,null pono,null sqnb,null deldate,null producttype,null qoor,null pric,null amld
from ELGI_US.dbo.LN_tssoc200 a
left outer join ELGI_US.dbo.ln_tcmcs065 d on d.cwoc=a.CWOC and d.deleted='N'
left join ELGI_US.dbo.Ln_tccom100 f on f.bpid=a.ofbp and f.compnr='3100' and f.deleted='N'
left join ELGI_US.dbo.ln_tsmdm030 e on e.cstp=a.cstp and e.compnr=a.compnr and e.deleted='N'
where a.compnr between '3100' and '3150' and a.deleted='N'
 and replace(osta_kw,'tssoc.osta.','') in ('free','planned','released')
 ) A 
 group by company_name,odat,Item

 
------------------- STEP 6 ID ------------------------------

Insert into OrderbookPO_Itemwise (Company,MonthYear_P,OrderDate,Sales,Itemcode)


select 'ELGi ID' vertical_new,format(orderDate,'MMM-yyyy') '[Month-Year_P]',orderdate,
SUM(t_oamt*CurrencyRate_INR)   'OpenValue',ItemCode

from Pending_Orders
where organ='ID' and ltrim(rtrim(custcode))not in ('CU1K02388','CU1E00893','CU1L00543','CU1E00015',
'CU1E00791','CU1E00008','CU1E00814','CU1E00914','CU1E00477','CU1E00679',
'CU1E00263','CU1E00926','CU1E00396','CU1E00887','CU1E99999','CU1E01015')
and  OrderType IN(select distinct saleordertype  from saletype_master where Sales_Category not in (1))
group by orderdate,itemcode


------------------- STEP 7 Africa, ME, Gulf ------------------------------

--delete from OrderbookPO_Itemwise where company in ('ELGi Africa','ELGi ME Direct','ELGi Gulf')

Insert into OrderbookPO_Itemwise (Company,MonthYear_P,OrderDate,Sales,Itemcode)


select A.CompanyName,format(orderDate,'MMM-yyyy') '[Month-Year_P]',orderdate,sum(openvalue) 'OpenValue',ItemCode from 
(
select CompanyName,areacode,areaname ,dpst,dpstname,ItemCode,Item_desc,
Price,OrderDate,sum(PendQty)as penqty,SUM(t_oamt*CurrencyRate_INR)  'OpenValue'
from (select *,ord_qty-isnull(cancel_qty,0) as ord_qty_new,

case when areacode in ('690','692','698','693','694','691') then 'ELGi Africa' --Nigeria, Kenya, Ghana, Tanzania, Uganda, South Africa
     when areacode in ('675','676') then 'ELGi ME Direct' -- Kuwait, Qatar
	 when areacode in ('672','674','677','671','684') then 'ELGi Gulf' --UAE, Saudi Arabia, Bahrain, Oman,Iraq
	 end 'CompanyName'

From pending_orders where --Company IN (401,500)  and
 dpst in (
--Units
'70221','70222','70224','70226','70227','70242','70250','70251','70231','70232','70234','70236','70237'
--Parts 
,'70028','70029','70030' ,'90213','90231','90257','70228','70229','70230','90252','90253',
'70238','70239','70240','70241','70022'

)


and areacode in (
--Units 
'671','672','674','675','676','677','691','690','692','693','698','694','684'
--Parts 
,'064','601','690','691','692','693','694','698','671','672','674','675','676','677'
)

)a

group by dpst,dpstname,ItemCode,Item_desc,Price,OrderDate,areacode,areaname,company,CompanyName

)a
where penqty >0
--) a
group by CompanyName,OrderDate,ItemCode



------------------- STEP 8 SA ------------------------------

Insert into OrderbookPO_Itemwise (Company,MonthYear_P,OrderDate,Sales,Itemcode)


select A.CompanyName,format(orderDate,'MMM-yyyy') '[Month-Year_P]',orderdate,sum(openvalue) 'OpenValue',ItemCode from 
(
select 'ELGi SA' CompanyName,areacode,areaname ,dpst,dpstname,ItemCode,Item_desc,
Price,OrderDate,sum(PendQty)as penqty,sum(PendQty)*Price 'OpenValue'
from (select *,ord_qty-isnull(cancel_qty,0) as ord_qty_new

From pending_orders where Company not in ('600')  and
dpst between '90200' and '90299'
and areacode in ('610','611','612','613','614')

)a

group by dpst,dpstname,ItemCode,Item_desc,Price,OrderDate,areacode,areaname,company

)a
where penqty >0
--) a
group by CompanyName,OrderDate,ItemCode


------------------- STEP 9 INDIA ------------------------------

Insert into OrderbookPO_Itemwise (Company,MonthYear_P,OrderDate,Sales,Itemcode)

SELECT vertical_new,[Month-Year_P],orderdate,sum(OpenValue) 'OpenValue',ItemCode

from (
select dpst,ItemCode,OrderDate,sum(t_oamt) 'OpenValue',
format(a.orderDate,'MMM-yyyy') 'Month-Year_P',
case when a.dpst like('900%') or a.dpst='90302' then 'India' end 'IND_COSEA_ID',
CASE 

	WHEN a.dpst IN ('90013','90015','90075','90031','90028','90025','90029','90034','90038','90082','90083','90084','90039'
,'90076','90077','90078','90302','90063','90079','90213','90231','90252','90253','90254','90255','90256','90257')
 then 'ELGi INDIA - AfterSales'
	WHEN  a.dpst IN ('90033','90037') then 'ELGi INDIA - C&M'
	when a.dpst in ('90072','90000','90014','90010','90020','90016','90074') then 'ELGi INDIA - Channel'
	when a.dpst in ('90009','90023','90022','90093','90008') then 'ELGi INDIA - Direct'
	when a.dpst in ('90032','90030','90094') then 'ELGi INDIA - OFSAC'
	when  a.dpst in ('90002','90073','90091','90092','90095') then 'ELGi INDIA - Railway'
	when a.dpst in ('90021','90035') then 'ELGi INDIA - WW'
	end 'Vertical_new',sum(PendQty) 'Pendqty'
from (
select *,ord_qty-isnull(cancel_qty,0) as ord_qty_new From pending_orders 

where 
      dpst in (select distinct dpst from elgi_dpst_access where userid like '%elgi_pratik.solapurwala%')
      and areacode in (select distinct area from (select distinct area From ELGI_area_ACCESS
           where userid  like '%elgi_pratik.solapurwala%') a
           left join (select * From vw_AREA_MASTER)b
           on a.area=b.Areacode) 
	  and ltrim(rtrim(custcode))not in ('CU1K02388','CU1E00893','CU1L00543','CU1E00015',
'CU1E00791','CU1E00008','CU1E00814','CU1E00914','CU1E00477','CU1E00679',
'CU1E00263','CU1E00926','CU1E00396','CU1E00887','CU1E99999','CU1E01015')
       and  OrderType IN (select distinct saleordertype  from saletype_master where Sales_Category not in (1))
       and convert(date,OrderDate) >='20210401'
       and (dpst like '900%' or  dpst in ('90302','90213','90231','90252','90253','90254','90255','90256','90257'))

and OrderNum not in ('242053591','235001986','235002010','235002178',
'201004166','235002479','343012156','343012158',
'242031446','235002919','235003190','235003230','343017074') 
and concat(Company,ordertype) not in ('450a16','450285','401246', '490326','490346','490226','490246','401344','450244')


)a
where PendQty>0
group by dpst,ItemCode,orderDate
)a

where  vertical_new is not null

group by Vertical_new,Orderdate,[Month-Year_P],ItemCode


------------------- STEP 10 Australia / SEA ------------------------------

Insert into OrderbookPO_Itemwise (Company,MonthYear_P,OrderDate,Sales,Itemcode)


select Vertical_Final,[Month-Year_I],orderdate, sum(openvalue) 'OpenValue',ItemCode from (
select distinct a.Organ,a.OrderDate,ltrim(rtrim(a.ItemCode))as ItemCode,Item_desc ,
--COSEA 
case when a.organ='COSEA' then 'COSEA'
     when a.organ in ('SAAME') then 'SAAME/ID'
end IND_COSEA_ID,
--Vertical
case when a.organ='COSEA' and a.areaname='AUSTRALIA' then 'ElGI Australia (incl. interco)'
     when a.organ='COSEA' and a.areaname <>'AUSTRALIA' then 'ELGi SEA'
	 end 'Vertical_final',

--Open Value
case	when a.organ='COSEA' and Currency ='USD' then sum(Foreign_currency_amount)
		when a.organ='COSEA' and Currency ='AUD' then sum(Foreign_currency_amount)
		when a.organ='COSEA' and Currency='IDR' then sum(Foreign_currency_amount)/15500
		when a.organ='COSEA' and Currency='MYR' then sum(Foreign_currency_amount)/4.66
		end 'OpenValue',format(a.orderdate,'MMM-yyyy')'Month-Year_I'

From sales_Inflow a

where a.company in (select distinct Company  From ELGI_Companies_Master where CompanyGroup ='ELGI')
and concat(a.company,a.ordertype) in (select concat(company,SaleOrderType) from SaleType_Master where Sales_Category not in (1))

and a.OrderDate >='20210401' and (case when a.organ='COSEA' then 'COSEA'
	--when a.organ in ('SAAME') then 'SAAME/ID'
	end ) is not null
 and a.dpst in  (select dpst from ELGI_DPST_ACCESS where userid like '%elgi\pratik.solapurwala%')
 and a.areacode in (SELECT  area FROM  ELGI_AREA_ACCESS a inner join
 vw_AREA_MASTER  b on ltrim(rtrim(a.area)) =ltrim(rtrim(b.areacode))
	 WHERE  userid like '%elgi\pratik.solapurwala%'
		and len(areaname)>2
		) and a.invnum=0

group by a.Organ,a.OrderDate,itemcode,Item_desc ,areaname,Currency
)a 
where vertical_FInal is not null
group by Vertical_Final,[Month-Year_I],orderdate,ItemCode


------------------- STEP 11 PRODUCT GROUP AND ITEMCATEGORY FROM TPL MASTER ------------------------------

--ALTER TABLE OrderbookSales_Itemwise add Product_group nvarchar(250)
--ALTER TABLE OrderbookSales_Itemwise add Item_Category nvarchar(250)

update OrderbookPO_Itemwise set Product_group=b.product_group , Item_category=b.item_category  
from ELGi_SOP.dbo.TPL_MASTER_REF b  

where ltrim(rtrim(OrderbookPO_Itemwise.Itemcode))=ltrim(rtrim(b.item)) and 
(case 
--when a.Company_name in ('ATS') then 'India'  
when OrderbookPO_Itemwise.Company='Brazil' then 'Brazil'
when OrderbookPO_Itemwise.Company ='ELGi Africa' then 'Africa'
when OrderbookPO_Itemwise.Company ='ElGI Australia (incl. interco)' then 'Australia'
when OrderbookPO_Itemwise.Company in ('ELGi Europe','Rotair') then 'Europe'
when OrderbookPO_Itemwise.Company ='ELGi ID' then 'ID'
WHEN OrderbookPO_Itemwise.Company IN ('ELGi INDIA - AfterSales','ELGi INDIA - C&M','ELGi INDIA - Channel','ELGi INDIA - Direct','ELGi INDIA - OFSAC','ELGi INDIA - Railway',
'ELGi INDIA - WW') THEN 'India'
when OrderbookPO_Itemwise.Company='ELGi SA' then 'SA'
when OrderbookPO_Itemwise.Company  in ('Industrial (incl. interco)','Michigan','Pattons INC','Pattons Medical','US Portables') then 'USA'

--need for PUlford,elgi gulf and elgi sea
end )=b.Region


------------------- STEP 12 UPDATED DATE ------------------------------

--ALTER TABLE OrderbookPO_Itemwise add UpdatedDate datetime\

update OrderbookPO_Itemwise set updateddate=getdate()

GO

