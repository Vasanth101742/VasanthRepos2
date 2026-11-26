CREATE VIEW  [dbo].[vw_coll_sales] as 
select vertical,monthnum,sum(collections) as collections,sum(advances) as advances,sum(sales) as sales,
sum(sales_ytd) as sales_ytd
from(

select 
isnull(isnull(collections.vertical,advances.vertical),sales.vertical) as vertical,
isnull(isnull(collections.monthnum,advances.monthnum),sales.monthnum)as monthnum,
isnull(collection,0) as collections,isnull(advance,0) as advances,isnull(sales,0) as sales,
isnull(sales_ytd,0) as sales_ytd from


--Collections
(
select sum(collection) as collection,vertical,monthnum 
from 
(
select sum(collection) as collection,vertical,monthnum from
(
SELECT  sum(collection)/1000000 as collection, case when [description] = 'MED' or
[description] = 'Service Charges & Old DPST' or [description] = 'Engines' or description is null
then 'OTHERS' else Upper(description) end as vertical,month(docdt) as monthnum FROM Acc_Collection WITH (nolock)
WHERE (custno NOT IN ('CU1ZA0001','SU1ZA0001', 'CU1A03177','SU1A03177')) 
group by month(docdt), case when [description] = 'MED' or
[description] = 'Service Charges & Old DPST' or [description] = 'Engines' or description is null then 'OTHERS' else Upper(description) end 

union all

select sum(gl_receipt)/1000000 ,'OTHERS' , month(docdt) as gl_receipt from Acc_Collection_GL_receipts
group by month(docdt)
) coll
group by monthnum,vertical

union all

select sum(collection) as collection,vertical,monthnum
from
(
SELECT  sum(collection)/1000000 as collection, case when [description] = 'MED' or
[description] = 'Service Charges & Old DPST' or [description] = 'Engines' or description is null
then 'OTHERS' else Upper(description) end as vertical
,month(docdt) as monthnum 
FROM Acc_Collection_Others WITH (nolock)
WHERE     [description] = 'ELGI SAUER' group by month(docdt), case when [description] = 'MED' or
[description] = 'Service Charges & Old DPST' or [description] = 'Engines' or description is null
then 'OTHERS' else Upper(description) end 
) coll
group by monthnum,vertical

union all

SELECT  sum(collection)/1000000 as advance, 'OTHERS'  as vertical,month(docdt) as monthnum
FROM  Acc_Advance_Others WITH (nolock) WHERE custno in ('CU1A03177','SU1A03177')
group by month(docdt), Upper(description) 

union all

select sum(collection) as collection,vertical,monthnum
from
(
SELECT  sum(collection)/1000000 as collection, 'OTHERS' as vertical,month(docdt) as monthnum
FROM Acc_Collection_Others WITH (nolock)
WHERE [description] <> 'ELGI SAUER'
group by month(docdt)

union all

select sum(collection),vertical,monthnum
from (
SELECT sum(collection)/1000000 as collection, 'ATS'  as vertical,month(docdt) as monthnum
FROM Acc_Collection_ATS
WHERE (global LIKE '%domestic%') AND (collection > 0)
and convert(datetime,docdt) >= dateadd(mm,-2,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate())) 
and docdt <= getdate() -1
group by MONTH(docdt)

union all

seLECT  SUM((c.Amnthome - c.BankCost) * - 1)/1000000 AS Collection, 
'ATS'  as vertical,month(docdt) as monthnum
FROM vw_AREA_MASTER v1 
INNER JOIN vw_Business_Partner v2
ON v1.AreaCode = v2.CustAreaCode 
RIGHT OUTER JOIN (select * from Collection_Stage1 where company in (select company from ELGI_Companies_Master where CompanyGroup='ATS')) c
ON LTRIM(RTRIM(v2.CustCode)) = LTRIM(RTRIM(c.CustNo))
WHERE (c.Trantyp IN ('B29', 'B45', '633', '634', 'B28', 'B31', 'B46','B48','B49','B50','B51')) 
AND (c.DocTyp IN (2, 9)) 
AND (v1.Global <> 'Domestic') 
and convert(datetime,docdt) >= dateadd(mm,-2,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))
and docdt <= getdate() -1
GROUP BY MONTH(docdt)

)a
group by vertical,monthnum

) coll
group by monthnum,vertical

) colls
group by monthnum,vertical

) collections



full join

--Advances
(
select sum(advance) as advance ,vertical,monthnum
from (

SELECT  sum(collection)/1000000 as advance, case when [description] = 'MED' or
[description] = 'Service Charges & Old DPST' or [description] = 'Engines' or description is null
then 'OTHERS' else Upper(description) end as vertical
,month(docdt) as monthnum
FROM acc_advance WITH (nolock)
WHERE  (custno NOT IN ('CU1ZA0001','SU1ZA0001','CU1A03177','SU1A03177')) and isnull(description,'OTHERS') <> 'exports'
group by month(docdt), case when [description] = 'MED' or
[description] = 'Service Charges & Old DPST' or [description] = 'Engines' or description is null
then 'OTHERS' else Upper(description) end 

union

SELECT  sum(collection)/1000000 as advance, Upper(description)  as vertical,month(docdt) as monthnum
FROM  Acc_Advance WITH (nolock)
WHERE (custno NOT IN ('CU1ZA0001','SU1ZA0001','CU1A03177','SU1A03177')) 
and isnull(description,'OTHERS') = 'exports' and global = 'International'
group by month(docdt), Upper(description) 

union all
SELECT   -1* SUM(balamnt)/1000000 as advance,'ATS' as vertical,month(docdt) as monthnum FROM Acc_Advance_ATS
group by     MONTH(docdt)

union all

SELECT  sum(collection)/1000000 as advance, Upper(description)  as vertical,month(docdt) as monthnum
FROM  Acc_Advance_Others WITH (nolock)
WHERE description like '%sauer%'
group by month(docdt), Upper(description) 

)advance

group by vertical,monthnum

) advances

on advances.vertical = collections.vertical
and advances.monthnum = collections.monthnum

full join

--Sales
(
select sum(Sales_amount)/1000000 as sales,
case when [description] = 'MED' or [description] = 'Service Charges & Old DPST' or [description] = 'Engines' or description is null then 'OTHERS' 
when [description] = 'AED'  then 'ATS' 
else [description] end as vertical,
--else Upper(case when dpst = '90091' or dpst  = '90002' or dpst = '90012' then 'Railways' else description end) end as vertical,
month (Invoice_Date) as monthnum 
from LN_Sales_Details_ver2  s
left outer join vw_DPST_MASTER d
on s.dpst =  d.dpstcode
where  convert(datetime,Invoice_Date) >= dateadd(mm,-2,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))
and company not in(600,612,616) 
and sales_category in (0,2) 
and dpst not in 
(select distinct dpstcode from vw_DPST_MASTER where description  ='To Elgi China'
union
select distinct dpstcode from vw_DPST_MASTER where description  ='To Elgi Gulf'
union
select distinct dpstcode from DPST_Master_ATS
union
select distinct dpstcode from vw_DPST_MASTER where description  ='Unknown'
union 
select dpstcode from vw_DPST_MASTER where division  in 
('BEYOND TO CUST','BRAZIL TO CUST','ECS TO CUST','EZL TO CUST','BELAIR TO CUST',
'AUSTRALIA TO CUST','To ELGI Australia','To ELGI Belair','To ELGI Brazil')
)
group by case when [description] = 'MED' or [description] = 'Service Charges & Old DPST' or [description] = 'Engines' or description is null
then 'OTHERS' 
when [description] = 'AED'  then 'ATS'
else [description] end,
--else Upper(case when dpst = '90091' or dpst  = '90002' or dpst = '90012' then 'Railways' else description end) end ,
month(Invoice_Date)

union all

select 
sum(Sales_amount)/1000000 as sales,
'ATS',month (Invoice_Date) as monthnum
from ATS_Sales_Details a
inner join DPST_Master_ATS  b on a.dpst =  b.dpstcode
where  convert(datetime,Invoice_Date) >= dateadd(mm,-2,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))
and dpst in ('90049','90041','90042','90044','90040','90050','90045','90051','90048','90241','90111','90240','90054',
'90242','90250','90043','90052')  
and sales_category in (0,2) 
and dpst  in (select distinct dpstcode from DPST_Master_ATS )
and SaleOrderType in (select SaleOrderType from SaleType_Master_ats where Sales_Category in (0,2,5,6))
group by month(Invoice_Date)



union all

select 
sum(Sales_amount)/1000000 as sales,
case when b.division  in ('BEYOND TO CUST','ECS TO CUST','EZL TO CUST') then 'CHINA'
when b.division in ('BELAIR TO CUST') then 'BELAIR'
when b.division in ('BRAZIL TO CUST') then 'BRAZIL'
when b.division in ('AUSTRALIA TO CUST') then 'AUSTRALIA' 
end as vertical,month (Invoice_Date) as monthnum 
from LN_Sales_Details_ver2 a 
left outer join vw_DPST_MASTER b on
a.dpst =  b.dpstcode
where  convert(datetime,Invoice_Date) >= dateadd(mm,-2,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))
and company not in(600,612,616)
and sales_category in (0,2) --and dpst not in (90003,90004)
and dpst  in (select dpstcode from vw_DPST_MASTER where division  in ('BEYOND TO CUST','BRAZIL TO CUST','ECS TO CUST','EZL TO CUST','BELAIR TO CUST','AUSTRALIA TO CUST')
)

group by case when b.division  in ('BEYOND TO CUST','ECS TO CUST','EZL TO CUST') then 'CHINA'
when b.division in ('BELAIR TO CUST') then 'BELAIR'
when b.division in ('BRAZIL TO CUST') then 'BRAZIL'
when b.division in ('AUSTRALIA TO CUST') then 'AUSTRALIA' 
end ,month(Invoice_Date)



) sales
on sales.vertical = collections.vertical
and sales.monthnum = collections.monthnum

full join vw_coll_sales_ytd sales_ytd 
on sales_ytd.vertical = sales.vertical
and sales_ytd.monthnum = sales.monthnum


) coll_sales
group by vertical,monthnum







--select * from ln_sales_details_ver2 where company=581

GO

