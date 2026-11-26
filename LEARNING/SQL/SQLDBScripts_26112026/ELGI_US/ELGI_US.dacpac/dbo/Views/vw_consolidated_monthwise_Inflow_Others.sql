




--consolidated monthwise

CREATE view [dbo].[vw_consolidated_monthwise_Inflow_Others] 
as 
select Region,Item_Code,Item_Desc,sum (qoor) 'Ord qty',sum(oamt) 'Ord Amt',CalYear,CalMonth,Dpst,DpstName,Organ,odat from 

(--Brazil
select 'BRAZIL' Region,
replace(a.item,' ','') 'Item_Code',b.dsca 'Item_desc',a.qoor,a.oamt,
YEAR (dateadd(MINUTE ,-29,dateadd(hour,-8,c.odat2)))'CalYear'
,MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,c.odat2)))'CalMonth'
--,a.orno,dateadd(MINUTE ,-29,dateadd(hour,-8,c.odat2)) as odat,a.ddta as DelDate
,'BRAZIL'  Dpst,'BRAZIL' DpstName,null Organ,dateadd(MINUTE ,-29,dateadd(hour,-8,c.odat2)) 'odat'
from LN_tdsls401 a 
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='2000' and b.deleted='N'
left join LN_tdsls400 c on c.compnr=a.compnr and c.orno=a.orno  and c.deleted='N'
 where a.compnr in (2000) and a.deleted='N'

 --6284
 --Europe
 union all 
select case when
b.cpln<>'L02' then'Rotair' when 
b.cpln='L02' then'EUROPE' else 'Rotair' end
Region ,replace(a.item,' ','')"ItemCode",b.dsca,a.qoor,a.oamt
,YEAR (dateadd(MINUTE ,-29,dateadd(hour,-3,c.odat2)))'CalYear',MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,c.odat2)))'CalMonth'
--a.orno,dateadd(MINUTE ,-29,dateadd(hour,-3,c.odat2)) as odat,dateadd(MINUTE ,-29,dateadd(hour,-3,a.ddta2)) as DelDate
,'EUROPE' Dpst,'EUROPE' DpstName,null Organ,dateadd(MINUTE ,-29,dateadd(hour,-3,c.odat2)) 'odat'
from LN_tdsls401 a 
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='1100' 
left join LN_tdsls400 c on c.compnr=a.compnr and c.orno=a.orno
 where a.compnr ='1100' and b.cpln ='L02'
  --154683

union all 

select 'USA' Region,
replace(a.item,' ','')"ItemCode",b.dsca,a.qoor,a.oamt,

YEAR((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time')) 'CalYear',MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time'))'CalMonth'
--,a.orno,(convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') as odat,(convert(datetime,a.ddta2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time' as DelDate,
,'USA' Dpst,'USA' DpstName,null Organ,(convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') 'odat'
from LN_tdsls401 a 
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='3100'  and b.deleted='N'
left join LN_tdsls400 c on c.compnr=a.compnr and c.orno=a.orno  and c.deleted='N'
where a.compnr in  (3100,3110,3120,3130,3140,3150)  and a.deleted='N' and a.orno like 'IND%' and chrq_kw <> 'tcynna.yes'
 ) a
 --where CalYear is not null and CalYear=2025 and CalMonth=10

 GROUP BY Region,Item_Code,Item_Desc,CalYear,CalMonth,Dpst,DpstName,Organ,odat


 union all 

 
select distinct 
 case when dpst in('90016','90020','90000','90010','90072','90074','90014')  then 'INDIA-CHANNEL'

		 when dpst in ('90008','90022','90093','90030','90094') then 'INDIA-DIRECT'

		 when dpst in('90033','90037','90078','90077','90076','90302','90039','90021','90035') then 'INDIA-PORTABLE'

		 WHEN DPST IN  ('90091','90095','90092','90073') THEN 'INDIA-RAILWAYS'

		 when dpst in ('90013','90015','90025','90026','90028','90029','90031',
'90034','90038','90063','90075','90079','90082','90083','90084','90085') then 'INDIA-AFTERMARKET'

end Region,ltrim(rtrim(a.ItemCode))as ItemCode,Item_desc ,
sum(qty)as 'Ord Qty',sum(sales)as 'Ord Amt',year(a.orderdate)as 'Cal_Year',month(a.orderdate)as 'Cal_Month',
--,a.OrderNum,a.OrderDate,sh.t_ddta 'PlannedDelDate'
Dpst,DpstName,Organ,a.OrderDate 'odat'

--DeliveryTerms,DelvDesc,ordertype
--CarrierCode,CarrierDesc,Currency,CurrRate,[Type],Item_Category,Product_Group,subproduct,
--a.Trantype,a.invnum,sum(Foreign_currency_amount) Foreign_currency_amount,
--rate_usd,sum(sales_usd) as sales_usd,
--case when dpst in ('90015','90026','90029', '90034','90038','90079') or concat(a.company,'-',dpst) in ('450-90084') then 'HO'
--	when dpst in ('90013','90028','90031','90063','90075','90082','90083','90084') or concat(a.company,'-',dpst) in ('490-90084') then 'GSC'
--	else 'Others'
--	end 'GSC/HO',
--isnull(case when a.company='490' then d.LeadDays else c.LEADTIME end,90) "leadTime",AreaCode,AreaName,user_names,Zone,a.CustCode,CustName as custname1,
--,a.positionNum

From [elgi_ln].dbo.sales_Inflow a
 ----Planned delivery date 
left  join elgi_ln.dbo.Sales_Lines sh 
on sh.Company=a.company and sh.orderNum=a.OrderNum and ltrim(rtrim(sh.Itemcode))=ltrim(rtrim(a.itemcode)) 
and a.positionNum=sh.positionNum and sh.t_sqnb='0' 

where a.company in (select distinct Company  From elgi_ln.dbo.ELGI_Companies_Master where CompanyGroup ='ELGI')
and concat(a.company,a.ordertype) in (select concat(company,SaleOrderType) from elgi_ln.dbo.SaleType_Master where Sales_Category not in (1))

and Dpst in ('90016','90020','90000','90010','90072','90074','90014','90008','90022','90093','90030','90094'
,'90033','90037','90078','90077','90076','90302','90039','90021','90035','90091','90095','90092','90073',
'90013','90015','90025','90026','90028','90029','90031',
'90034','90038','90063','90075','90079','90082','90083','90084','90085')
and a.Organ='India'
and a.OrderDate >='20250801' and 
len(a.areaname)>0


group by Organ,a.company,Dpst,DpstName,ltrim(rtrim(a.ItemCode)),Item_desc,year(a.orderdate),MONTH(a.OrderDate),a.OrderDate

GO

