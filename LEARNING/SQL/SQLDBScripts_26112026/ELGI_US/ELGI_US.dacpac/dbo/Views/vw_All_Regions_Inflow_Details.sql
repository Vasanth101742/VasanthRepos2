

CREATE view [dbo].[vw_All_Regions_Inflow_Details] as
--Brazil
select 'Brazil' "Company",
replace(a.item,' ','')"ItemCode",b.dsca,a.orno,dateadd(MINUTE ,-29,dateadd(hour,-8,c.odat2)) as odat,a.qoor,a.oamt,a.ddta as DelDate
,YEAR (dateadd(MINUTE ,-29,dateadd(hour,-8,c.odat2)))'CalYear'
,MONTH (dateadd(MINUTE ,-29,dateadd(hour,-8,c.odat2)))'CalMonth'
,null Dpst,null DpstName,null Organ
from LN_tdsls401 a 
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='2000' and b.deleted='N'
left join LN_tdsls400 c on c.compnr=a.compnr and c.orno=a.orno  and c.deleted='N'
 where a.compnr in (2000) and a.deleted='N'

 --6284
 --Europe
 union all 
select case when
b.cpln<>'L02' then'Rotair' when 
b.cpln='L02' then'Europe' else 'Rotair' end
"Company",replace(a.item,' ','')"ItemCode",b.dsca,a.orno,
dateadd(MINUTE ,-29,dateadd(hour,-3,c.odat2)) as odat,a.qoor,a.oamt,dateadd(MINUTE ,-29,dateadd(hour,-3,a.ddta2)) as DelDate
,YEAR (dateadd(MINUTE ,-29,dateadd(hour,-3,c.odat2)))'CalYear',MONTH (dateadd(MINUTE ,-29,dateadd(hour,-3,c.odat2)))'CalMonth'
,null Dpst,null DpstName,null Organ
from LN_tdsls401 a 
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='1100' 
left join LN_tdsls400 c on c.compnr=a.compnr and c.orno=a.orno
 where a.compnr ='1100' and b.cpln ='L02'
  --154683

union all 

select 'USA' "compnr",
replace(a.item,' ','')"ItemCode",b.dsca,a.orno,(convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time') as odat,a.qoor,a.oamt,
(convert(datetime,a.ddta2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time' as DelDate,
YEAR((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time')) 'CalYear',MONTH ((convert(datetime,c.odat2) AT TIME ZONE 'India Standard Time'))'CalMonth'
,null Dpst,null DpstName,null Organ
from LN_tdsls401 a 
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='3100'  and b.deleted='N'
left join LN_tdsls400 c on c.compnr=a.compnr and c.orno=a.orno  and c.deleted='N'
where a.compnr in  (3100,3110,3120,3130,3140,3150)  and a.deleted='N' and a.orno like 'IND%' and chrq_kw <> 'tcynna.yes'

--62011

--India

union all

select distinct 
--case when a.company=490 then 'GSC'
--when a.company in (400,401) then 'HO'
--when a.Company=450 then 'ACP'
--when a.company=500 then 'GULF'
--when a.company=553 then 'MALAYSIA'
--when a.company=552 then 'INDONESIA'
--when a.company=551 then 'AUSTRALIA'
--end 'Region',
'INDIA' Region,ltrim(rtrim(a.ItemCode))as ItemCode,Item_desc ,a.OrderNum,a.OrderDate,
sum(qty)as 'Ord Qty',sum(sales)as 'Ord Amt',sh.t_ddta 'PlannedDelDate',year(a.orderdate)as 'Cal_Year',month(a.orderdate)as 'Cal_Month',
Dpst,DpstName,Organ

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
and a.Organ='INDIA'
and a.OrderDate >='20250801'


group by Organ,a.company,Dpst,DpstName,a.OrderDate,a.OrderNum,ltrim(rtrim(a.ItemCode)),Item_desc,sh.t_ddta

GO

