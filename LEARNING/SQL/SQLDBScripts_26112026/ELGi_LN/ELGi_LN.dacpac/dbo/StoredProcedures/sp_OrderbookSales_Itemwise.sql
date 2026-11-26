
CREATE proc [dbo].[sp_OrderbookSales_Itemwise] as

TRUNCATE TABLE OrderbookSales_Itemwise

------------------- STEP 1 ATS------------------------------

Insert into OrderbookSales_Itemwise (Company ,OrderDate ,Invoice_Date ,Sales_Amount ,BookandBill ,MonthYear_S ,Itemcode )

select company_name,convert(date,OrderDate) 'OrderDate',Invoice_Date,sum(Sales_amount) 'Sales_Amount',BookandBill,[MonthYear_S],Trim(item) 'ItemCode' from (
select *,CASE 
        WHEN MONTH(invoice_date) = MONTH(OrderDate) 
         AND YEAR(invoice_date) = YEAR(OrderDate) 
        THEN 'yes' 
        ELSE 'no' 
 END AS BookandBill, format(a.invoice_date,'MMM-yyyy') 'MonthYear_S','ATS' as 'Company_name'
 from ATS_Sales_Details a
where convert(date,invoice_date) between '2021-04-01' and convert(date,getdate())
and dpst <>'90110'
and SaleOrderType not in (select SaleOrderType from saletype_master_ATS where Sales_Category in (1))
) a
group by Company_name,OrderDate,Invoice_Date,BookandBill,[MonthYear_S],Trim(item)


------------------- STEP 2 PULFORD------------------------------

Insert into OrderbookSales_Itemwise (Company ,OrderDate ,Invoice_Date ,Sales_Amount ,BookandBill ,MonthYear_S ,Itemcode )

select  company_name,convert(date,OrderDate1) 'OrderDate',convert(date,PostingDate) 'Invoice_Date',sum(Amount) 'Sales_Amount',BookandBill,[Month-Year_S],tRIM(item) 'ItemCode' from (
select *,case when orderdate is null then isnull(orderdate,'99990101')
when OrderDate='17530101' then '99990101'
else OrderDate
end 'OrderDate1',CASE 

        WHEN MONTH(PostingDate) = MONTH(OrderDate) 

         AND YEAR(PostingDate) = YEAR(OrderDate) 

        THEN 'yes' 

        ELSE 'no' 

    END AS BookandBill, format(PostingDate,'MMM-yyyy') 'Month-Year_S','Pulford' as 'Company_name'
 from ELGi_Pulford.dbo.GLSalesMargin

where convert(date,PostingDate) between '2021-04-01' and convert(date,getdate())

) a
group by Company_name,OrderDate1,PostingDate,BookandBill,[Month-Year_S],tRIM(item)


------------------- STEP 3 BRAZIL ------------------------------

Insert into OrderbookSales_Itemwise (Company ,OrderDate ,Invoice_Date ,Sales_Amount ,BookandBill ,MonthYear_S ,Itemcode )

--Itemwise sales

select 'Brazil' 'Company_name',odat,idat,Amount 'amti',
CASE WHEN MONTH(idat) = MONTH(odat) AND YEAR(idat) = YEAR(odat)  THEN 'yes' ELSE 'no' END 'BookandBill',format(idat,'MMM-yyyy') 'Month-Year_S',TRIM(item) 'ITEMCODE'
from  
 (
select
iw.fire,idat,odat,

case when TransType='Sales' and amnt<0 then amnt*-1 else amnt*-1 end 'Amount',item

from (

select a.fire,a.line,a.accd, case when  a.[dbcr_kw] like '%credit%' then a.[amnt]*-1 else a.[amnt] end amnt

,a.bfcd,a.dbcr_kw,a.leac,b.item,d.dsca 'TCIBD_001_dsca',b.dqua

,convert(date,DATEADD(MINUTE,-30,DATEADD(HOUR,-8,CONVERT(datetime,SWITCHOFFSET(CONVERT(datetimeoffset,e.[date]),DATENAME(TzOffset, SYSDATETIMEOFFSET())))))) AS 'idat' 

,c.bpid,c.bpna,e.ninv,e.ttyp,c.fdtc,e1.dsca,e2.dsca 'tcmcs061_001_dsca',c.docn,

case  when [bfcd] ='' then ''  

when [bfcd] = 'RECALC' then 'Sales' 

when [dbcr_kw] like '%debit%' then 'Tax' 

else '' end 'TransType'

,case when e.ttyp like '%NCV%' then b.dqua*-1 else b.dqua end ReturnQty,e3.dsca "DType",

e4.orno,convert(date,dateadd(MINUTE ,-29,dateadd(hour,-9,e4.odat))) as 'odat'

from ELGI_US.dbo.LN_BTSLI208 a

left join ELGI_US.dbo.ln_lpbra247 b on b.fire=a.fire and b.flin=a.line and b.deleted='N'

left join ELGI_US.dbo.LN_BTSLI200 c on c.fire=a.fire  and c.deleted='N'

left join ELGI_US.dbo.ln_lpbra245 e on e.fire=a.fire and e.bpid=c.bpid and e.deleted='N'

left join ELGI_US.dbo.LN_TCIBD001 d on d.item=b.item and cpcl_ref_compnr='2000' and d.deleted='N'

left join ELGI_US.dbo.ln_tcmcs023 e1 on e1.citg=d.citg and e1.compnr='2000' and e1.deleted='N'

left join ELGI_US.dbo.ln_tcmcs061 e2 on e2.cpln=d.cpln and e2.compnr='2000' and e2.deleted='N'

left join ELGI_US.dbo.ln_lpbra001 e3 on e3.fdtc=c.fdtc and e3.deleted='N'

left join ELGI_US.dbo.LN_cisli310 e4 on e4.idoc=e.ninv and e4.[tran]=e.ttyp and  e4.compnr='2000' and e4.deleted='N' and e4.item=b.item
 
where a.compnr ='2000' and c.stat<>2  and a.deleted='N'

-- for order book

and  (c.fdtc in ('SDV002','SSV003','VMA001') or c.fdtc like 'SVD00%')

--order by DATEADD(MINUTE,-30,DATEADD(HOUR,-8,CONVERT(datetime,SWITCHOFFSET(CONVERT(datetimeoffset,e.[date]),DATENAME(TzOffset, SYSDATETIMEOFFSET())))))  desc 

) iw

where  iw.TransType <> ''

 --23727
 union all
 
 --Return 
--Btrec208
select d1.fire, return_date 'idat'
,odat,case when combin='R' and Final_Amount<0 and [Custom.2]='Tax' then Final_Amount*-1 else Final_Amount end 'Amount',item
--,accd,bpid,item,bfcd 
from (
select c1.*,
case when der='Blank' then ''
when bfcd='' then ''
when der='Negative' then amnt
when der='CreditNe' then [Custom.1]
else [Custom]
end 'Final_Amount',
case when combin='R' and bfcd='RECALC' THEN 'Sales' else 'Tax' end 'Custom.2'
from (
select b1.*,
case when der='CreditNe' and amnt>1 and dbcr_kw like '%credit%' then amnt*-1
when combin='R' and dbcr_kw like '%debit%' then 0 else [custom] end  'Custom.1' 
from (
select a1.*, 
case when dbcr_Kw like '%debit%' and amnt<1 then amnt*-1 else amnt end 'Custom',
 case WHEN fire COLLATE Latin1_General_CS_AS LIKE 'd%' THEN 'Negative'
 when leac like '1%' then 'Blank'
 when fire like 'R%' then 'CreditNe'
 when leac like '2%' then 'Blank'
 when leac like '3%' then 'Blank'
 else null 
 end 'Der'
from (
Select a.fire,DATEADD(MINUTE,-30,DATEADD(HOUR,-8,CONVERT(datetime,SWITCHOFFSET(CONVERT(datetimeoffset,b.[date]),DATENAME(TzOffset, SYSDATETIMEOFFSET()))))) as date
,b.bpid,b.bpna,a.dbcr_Kw,a.leac,a.amnt,a.bfcd,left(a.fire,1) combin ,c.refr'RefeD',
d.accd,
d.odat,d.item,
e.return_date,
 a.line from ELGI_US.dbo.ln_BTREC208 a
left Join ELGI_US.dbo.ln_BTREC200 b on b.fire=a.fire and b.deleted='N' 
left join ELGI_US.dbo.ln_BTREC210 c on c.fire=a.fire and c.compnr=2000 and c.deleted='N'

----btrec201 joining 
join 
(
select distinct a.fire,a.item,a.line,a.accd,
--,a.dsca,a.accd,e1.dsca"ProductGroup",e2.dsca"ProductLine",a.line,a.qnty,e4.orno,
convert(date,dateadd(MINUTE ,-29,dateadd(hour,-9,e4.odat)))odat
from ELGI_US.dbo.ln_btrec201 a
left join ELGI_US.dbo.LN_TCIBD001 d on d.item=a.item and cpcl_ref_compnr='2000' and d.deleted='N'
left join ELGI_US.dbo.ln_tcmcs023 e1 on e1.citg=d.citg and e1.compnr='2000'and e1.deleted='N'
left join ELGI_US.dbo.ln_tcmcs061 e2 on e2.cpln=d.cpln and e2.compnr='2000' and e2.deleted='N'
left join ELGI_US.dbo.ln_btrec212 e4 on e4.deleted='N' and e4.compnr='2000' and e4.fire=a.fire and e4.line=a.line 
where a.compnr=2000 and a.deleted='N'
 )d on concat(a.fire,a.line)=concat(d.fire,d.line) 

-- --btrec200 joining
join (
select 
convert(date,DATEADD(MINUTE,-30,DATEADD(HOUR,-8,CONVERT(datetime,SWITCHOFFSET(CONVERT(datetimeoffset,[date]),DATENAME(TzOffset, SYSDATETIMEOFFSET()))))) ) AS 'return_date',* 
from ELGI_US.dbo.ln_btrec200
where compnr='2000' and deleted='N' and rfdt in ('10','57') 
and convert(date,DATEADD(MINUTE,-30,DATEADD(HOUR,-8,CONVERT(datetime,SWITCHOFFSET(CONVERT(datetimeoffset,[date]),DATENAME(TzOffset, SYSDATETIMEOFFSET()))))) ) >='20240101'

) e on a.fire=e.fire


where a.compnr='2000' and a.deleted='N' 
) a1
)b1
)c1
)d1
where (case when combin='R' and Final_Amount<0 and [Custom.2]='Tax' then Final_Amount*-1 else Final_Amount end )<>0 
and accd='E35' 

)final



------------------- STEP 4 EUROPE AND ROTAIR ------------------------------


Insert into OrderbookSales_Itemwise (Company ,OrderDate ,Invoice_Date ,Sales_Amount ,BookandBill ,MonthYear_S ,Itemcode )


select compnr,odat 'Orderdate',idat 'Invdate',sum(amti) 'SalesAmount',BookandBill,Month_Year_S,ItemCode from ( 

select distinct c.stat_kw,c.fyer'FYear',c.fper'Fmonth',a.line,case when a.compnr=1100 then'Rotair'
 when a.compnr=1700 then'ELGi Europe' end "compnr",convert(date,dateadd(MINUTE ,-29,dateadd(hour,-3,c.idat2))) as idat,a.[tran],a.idoc,replace(a.item,' ','')"ItemCode",b.dsca,a.orno,
 convert(date,dateadd(MINUTE ,-29,dateadd(hour,-3,a.odat2))) as odat
 ,replace(c.itbp,' ','')"CusCode",
isnull(d.nama,'NA')  "BPName"
 ,f.dsca as "ProductLine"
,a.pono,a.dqua,a.cuqs,cast(a.amti as decimal(19,2))"amti",a.amth_1,replace(a.invt_KW,'tcinvt.','')invt_KW
,a.slah_1"Home Currency",a.ldah_1"HomeDisc",cast(a.amth_1 as decimal(19,2)) "HomeNet",a.leac,
format(dateadd(MINUTE ,-29,dateadd(hour,-3,c.idat2)),'MMM-yyyy')'Month_Year_S',
case 
when year(dateadd(MINUTE ,-29,dateadd(hour,-3,c.idat2)))=year(dateadd(MINUTE ,-29,dateadd(hour,-3,a.odat2))) 
and month(dateadd(MINUTE ,-29,dateadd(hour,-3,c.idat2)))=month(dateadd(MINUTE ,-29,dateadd(hour,-3,a.odat2))) then 'Yes' else 'No' end 'BookandBill'

from ELGI_US.dbo.LN_cisli310 a
left join ELGI_US.dbo.LN_cisli305 c on c.idoc=a.idoc and c.[tran]=a.[tran] and c.compnr=a.compnr
left join ELGI_US.dbo.LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='1100'
left join ELGI_US.dbo.LN_tccom100 d on replace(d.bpid,' ','')=replace(c.itbp,' ','') and d.compnr='1100' 
left join ELGI_US.dbo.LN_tcmcs023 f on replace(f.citg,' ','')=replace(b.citg,' ','') and d.compnr='1100' 
where  a.compnr in  (1100,1700)  and c.stat_kw='tcsli.stat.posted'  and  (
    (a.compnr = 1700 AND isnull(d.nama,'NA') NOT LIKE 'ELGi%' AND isnull(d.nama,'NA') NOT LIKE 'ROTAIR%')
    OR a.compnr =1100)

) a
group by compnr,convert(date,odat) ,convert(date,idat),bookandbill,Month_year_s,ItemCode


------------------- STEP 5 USA ------------------------------


Insert into OrderbookSales_Itemwise (Company ,OrderDate ,Invoice_Date ,Sales_Amount ,BookandBill ,MonthYear_S ,Itemcode )

select compdivision, ODAT,IDAT, SUM(AMTI) 'Sales',
CASE 
    WHEN MONTH(idat) = MONTH(odat) AND YEAR(idat) = YEAR(odat) THEN 'yes' ELSE 'no' END BookandBill,format(idat,'MMM-yyyy') 'Month_Year_S',ItemCode 

from ( 
select distinct a.line, case 
        when a.compnr = 3100 then 'ELGI NA'
        when a.compnr = 3110 then 'Industrial (incl. interco)'
        when a.compnr = 3120 then 'US Portables'
        when a.compnr = 3130 then 'Pattons Medical'
        when a.compnr = 3140 then 'Pattons INC'
        when a.compnr = 3150 then 'Michigan'
    end as CompDivision,c.idat2,
convert(date,(CONVERT(datetime, c.idat) AT TIME ZONE 'UTC') AT TIME ZONE 'Eastern Standard Time') as idat, a.[tran],a.idoc,replace(a.item, ' ', '') as ItemCode,b.dsca,
a.orno,convert(date,(CONVERT(datetime, a.odat) AT TIME ZONE 'UTC') AT TIME ZONE 'Eastern Standard Time') as odat,replace(c.itbp, ' ', '') as CusCode,isnull(d.nama, 'NA') as BPName,
f.dsca as ProductLine,a.pono,a.dqua,a.cuqs,a.amti 'amti_original',a.amth_1,a.invt_KW,c.stat_kw,a.txai,a.amti+a.txai 'amti'
	
from ELGI_US.dbo.LN_cisli310 a
left join ELGI_US.dbo.LN_cisli305 c on c.idoc=a.idoc and c.[tran]=a.[tran] and c.compnr=a.compnr  and c.deleted='N'
left join ELGI_US.dbo.LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='3100'  and b.deleted='N'
left join ELGI_US.dbo.LN_tccom100 d on replace(d.bpid,' ','')=replace(c.itbp,' ','') and d.compnr='3100'   and d.deleted='N'
left join ELGI_US.dbo.LN_tcmcs023 f on replace(f.citg,' ','')=replace(b.citg,' ','') and d.compnr='3100'  and f.deleted='N'
where  a.compnr in  (3100,3110,3120,3130,3140,3150)  and a.deleted='N' and c.stat='80'
) a
group by compdivision, ODAT,IDAT,ItemCode


------------------- STEP 6 INDIA/COSEA/SAAME ------------------------------


Insert into OrderbookSales_Itemwise (Company ,OrderDate ,Invoice_Date ,Sales_Amount ,BookandBill ,MonthYear_S ,Itemcode )

select vertical_final,order_Date,Inv_Date,sum(Sales_value) 'Sales_Amnt',BookandBill,[Month-Year_S],ItemCode from (

select 
--a.*,b.ReleaseDate,DATEDIFF(day,a.order_Date,convert(date,a.Date)) 'Actual_days',

--India/Cosea/ID
case when a.organ ='India' then 'India'
	when a.organ='COSEA' then 'COSEA'
	when a.organ='SAAME' and a.Vertical1 in ('Africa-Spares','Africa-Units','GULF TO CUST - SPARES','GULF TO CUST - UNITS','ME-Spares','ME-Units','SA-Spares','SA-Units') then 'SAAME/ID'
	when a.organ='ID' then 'SAAME/ID'
end 'IND_COSEA_ID',
--Vertical

case
--COSEA
   when a.organ='COSEA' and a.areaname='AUSTRALIA' then 'ElGI Australia (incl. interco)'
   when a.organ='COSEA' and a.areaname <> 'AUSTRALIA' then 'ELGi SEA'
 --SAAME/ID
	WHEN a.Organ in ('SAAME') and a.Vertical1 LIKE '%GULF TO CUST%' THEN 'ELGi Gulf'
    WHEN a.Organ in ('SAAME') and a.Vertical1 LIKE '%Africa-%' THEN 'ELGi Africa'
    WHEN a.Organ in ('SAAME') and a.Vertical1 LIKE '%ME-%' THEN 'ELGi ME Direct'
    WHEN a.Organ in ('SAAME') and a.Vertical1 LIKE '%SA-%' THEN 'ELGi SA'
	when a.Organ in ('ID') then 'ELGi ID'
--India New Method
	WHEN a.organ='India' and a.dpst IN('90036','90084','90083','90063','90079','90038','90028','90031','90085','90025','90082','90026','90075','90013',
'90029','90256','90015','90034','90078','90077','90076','90302','90039','90231','90001') then 'ELGi INDIA - AfterSales'
	WHEN a.organ='India' and a.dpst IN ('90033','90037') then 'ELGi INDIA - C&M'
	when a.Organ='India' and a.dpst in ('90072','90000','90014','90010','90020','90016','90074') then 'ELGi INDIA - Channel'
	when a.Organ='India' and a.dpst in ('90009','90023','90022','90093','90008') then 'ELGi INDIA - Direct'
	when a.Organ='India' and a.dpst in ('90032','90030','90094') then 'ELGi INDIA - OFSAC'
	when a.Organ='India' and a.dpst in ('90002','90073','90091','90092','90095') then 'ELGi INDIA - Railway'
	when a.Organ='India' and a.dpst in ('90021','90035') then 'ELGi INDIA - WW'
	end vertical_final,
--Sales Value
--COSEA
case when a.organ='COSEA' and a.areaname='AUSTRALIA' then AssesValue/t_rate_1
	  when a.organ='COSEA' and a.areaname <> 'AUSTRALIA' then AssesValue/83
	 -- when a.organ in ('ID') then sales_usd
	  When a.Organ IN ('ID','SAAME','India') Then AssesValue 

end 'Sales_value',
--Book and bill
CASE 
        WHEN MONTH(a.Date) = MONTH(Order_Date) AND YEAR(a.Date) = YEAR(Order_Date) 
        THEN 'yes' 
        ELSE 'no' 
END AS BookandBill, format(a.Date,'MMM-yyyy') 'Month-Year_S', 
a.ItemCode, a.dpst,a.areacode,a.Organ,a.OrderNum,a.Vertical1,a.areaname,convert(date,a.Date) 'Inv_Date',convert(date,a.order_Date) 'order_Date' 

From sales_report_LN a

where  convert(date,a.[Date]) >='20210401' and 
(case when a.organ ='India' then 'India'
	when a.organ='COSEA' then 'COSEA'
	when a.organ='SAAME' and a.Vertical1 in ('Africa-Spares','Africa-Units','GULF TO CUST - SPARES','GULF TO CUST - UNITS','ME-Spares','ME-Units','SA-Spares','SA-Units') then 'SAAME/ID'
	when a.organ='ID' then 'SAAME/ID'
end) is not null
 --and a.dpst in  (select dpst from ELGI_DPST_ACCESS where userid like '%elgi\pratik.solapurwala%')
 --and a.areacode in (select areacode from ELGI_AREA_ACCESS where userid like '%elgi\pratik.solapurwala%' )

 ) a
 where vertical_final is not null
 group by vertical_final,order_Date,Inv_Date,BookandBill,[Month-Year_S],ItemCode

 
------------------- STEP 7 PRODUCT GROUP AND ITEMCATEGORY FROM TPL MASTER ------------------------------

--ALTER TABLE OrderbookSales_Itemwise add Product_group nvarchar(250)
--ALTER TABLE OrderbookSales_Itemwise add Item_Category nvarchar(250)

update OrderbookSales_Itemwise set Product_group=b.product_group , Item_category=b.item_category  
from ELGi_SOP.dbo.TPL_MASTER_REF b  

where ltrim(rtrim(OrderbookSales_Itemwise.Itemcode))=ltrim(rtrim(b.item)) and 
(case 
--when a.Company_name in ('ATS') then 'India'  
when OrderbookSales_Itemwise.Company='Brazil' then 'Brazil'
when OrderbookSales_Itemwise.Company ='ELGi Africa' then 'Africa'
when OrderbookSales_Itemwise.Company ='ElGI Australia (incl. interco)' then 'Australia'
when OrderbookSales_Itemwise.Company in ('ELGi Europe','Rotair') then 'Europe'
when OrderbookSales_Itemwise.Company ='ELGi ID' then 'ID'
WHEN OrderbookSales_Itemwise.Company IN ('ELGi INDIA - AfterSales','ELGi INDIA - C&M','ELGi INDIA - Channel','ELGi INDIA - Direct','ELGi INDIA - OFSAC','ELGi INDIA - Railway',
'ELGi INDIA - WW') THEN 'India'
when OrderbookSales_Itemwise.Company='ELGi SA' then 'SA'
when OrderbookSales_Itemwise.Company  in ('Industrial (incl. interco)','Michigan','Pattons INC','Pattons Medical','US Portables') then 'USA'

--need for PUlford,elgi gulf and elgi sea
end )=b.Region

 
------------------- STEP 8 Updated Date ------------------------------

--ALTER TABLE OrderbookSales_Itemwise add UpdatedDate datetime
update OrderbookSales_Itemwise set UpdatedDate=getdate()

GO

