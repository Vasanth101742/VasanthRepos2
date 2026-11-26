
CREATE VIEW [dbo].[vw_coll_sales_ytd] as

select 
sum(Sales_amount)/1000000 as sales_ytd,
case when b.Description = 'MED' or b.Description = 'Service Charges & Old DPST' or b.Description = 'Engines' or b.Description is null then 'OTHERS' 
when b.Description = 'AED'  then 'ATS'
else [description] end  as vertical,
--else Upper(case when dpst = '90091' or dpst  = '90002' or dpst = '90012' then 'Railways' else description end) end as vertical,
datepart(mm,dateadd(mm,-2,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))) as monthnum 
from LN_Sales_Details_ver2 a 
left outer join vw_DPST_MASTER b 
on a.dpst =  b.dpstcode
where  convert(datetime,Invoice_Date) between (
select convert(datetime,case when datepart(mm,dateadd(mm,-2,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))) < 4 
then  '04/01/' + convert(varchar,datepart(yy,(getdate())) -1) else   '04/01/' + convert(varchar,datepart(yy,(getdate())) -0) end)) 
and (select  dateadd(dd,-1,dateadd(mm,-1,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate())) ))
and company not in(600,612,616)
and sales_category in (0,2) --and dpst not in (90003,90004)
and dpst not in 
(select distinct dpstcode from vw_DPST_MASTER where description  ='To Elgi China'
union
select distinct dpstcode from vw_DPST_MASTER where description  ='To Elgi Gulf'
union
select distinct dpstcode from vw_DPST_MASTER where description  ='Unknown'
union
select distinct dpstcode from DPST_Master_ATS
union 
select dpstcode from vw_DPST_MASTER where division  in ('BEYOND TO CUST','BRAZIL TO CUST','ECS TO CUST','EZL TO CUST','BELAIR TO CUST','AUSTRALIA TO CUST')
)

group by case when b.Description = 'MED' or b.Description = 'Service Charges & Old DPST' or b.Description = 'Engines' or b.Description is null then 'OTHERS' 
when b.Description = 'AED'  then 'ATS'
else [description] end
--else Upper(case when dpst = '90091' or dpst  = '90002' or dpst = '90012' then 'Railways' else description end) end 

union all

select 
sum(Sales_amount)/1000000 as sales,
'ATS',datepart(mm,dateadd(mm,-2,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))) as monthnum
from
LN_Sales_Details_ver2 a 
left outer join vw_DPST_MASTER b
on a.dpst =  b.dpstcode
where  convert(datetime,Invoice_Date) between (
select convert(datetime,case when datepart(mm,dateadd(mm,-2,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))) < 4
then  '04/01/' + convert(varchar,datepart(yy,(getdate())) -1) else   '04/01/' + convert(varchar,datepart(yy,(getdate())) -0) end)) and 
(select  dateadd(dd,-1,dateadd(mm,-1,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate())) ))
and company  in(600,612,616)
and sales_category in (0,2) 
and dpst not in 
(select distinct dpstcode from vw_DPST_MASTER where description  ='To Elgi China'
union
select distinct dpstcode from vw_DPST_MASTER where description  ='To Elgi Gulf'
union
select distinct dpstcode from vw_DPST_MASTER where description  ='Unknown'
union
select distinct dpstcode from DPST_Master_ATS
union 
select dpstcode from vw_DPST_MASTER where division  in ('BEYOND TO CUST','BRAZIL TO CUST','ECS TO CUST','EZL TO CUST','BELAIR TO CUST','AUSTRALIA TO CUST')
)

union all

select 
sum(Sales_amount)/1000000 as sales_ytd,
case when b.division  in ('BEYOND TO CUST','ECS TO CUST','EZL TO CUST') then 'CHINA'
when b.division in ('BELAIR TO CUST') then 'BELAIR'
when b.division in ('BRAZIL TO CUST') then 'BRAZIL'   
when b.division in ('AUSTRALIA TO CUST') then 'AUSTRALIA' end 
as vertical,datepart(mm,dateadd(mm,-2,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))) as monthnum 
from LN_Sales_Details_ver2 a 
left outer join vw_DPST_MASTER b 
on a.dpst =  b.dpstcode
where  convert(datetime,Invoice_Date) between (
select convert(datetime,case when datepart(mm,dateadd(mm,-2,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))) < 4 
then  '04/01/' + convert(varchar,datepart(yy,(getdate())) -1) else   '04/01/' + convert(varchar,datepart(yy,(getdate())) -0) end)) and 
(select  dateadd(dd,-1,dateadd(mm,-1,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate())) ))
and company not in(600,612,616)
and sales_category in (0,2) --and dpst not in (90003,90004)
and dpst  in (select dpstcode from vw_DPST_MASTER where division  in ('BEYOND TO CUST','BRAZIL TO CUST','ECS TO CUST','EZL TO CUST','BELAIR TO CUST'))
group by case when b.division  in ('BEYOND TO CUST','ECS TO CUST','EZL TO CUST') then 'CHINA'
when b.division in ('BELAIR TO CUST') then 'BELAIR'
when b.division in ('BRAZIL TO CUST') then 'BRAZIL'  
when b.division in ('AUSTRALIA TO CUST') then 'AUSTRALIA' end 


union all

select 
sum(Sales_amount)/1000000 as sales_ytd,
case when [description] = 'MED' or
[description] = 'Service Charges & Old DPST' or [description] = 'Engines' or description is null
then 'OTHERS' 
when [description] = 'AED'  then 'ATS'
else [description] end  as vertical,
--else Upper(case when dpst = '90091' or dpst  = '90002' or dpst = '90012' then 'Railways' else description end) end as vertical,
datepart(mm,dateadd(mm,-1,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))) as monthnum 
from LN_Sales_Details_ver2 a 
left outer join vw_DPST_MASTER b 
on a.dpst =  b.dpstcode
where  convert(datetime,Invoice_Date) between (
select convert(datetime,case when datepart(mm,dateadd(mm,-1,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))) < 4 
then  '04/01/' + convert(varchar,datepart(yy,(getdate())) -1) else   '04/01/' + convert(varchar,datepart(yy,(getdate())) -0) end)) and 
(select  dateadd(dd,-1,dateadd(mm,-0,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate())) ))
and company not in(600,612,616)
and sales_category in (0,2) --and dpst not in (90003,90004)
and dpst not in (select distinct dpstcode from vw_DPST_MASTER where description  ='To Elgi China'
union
select distinct dpstcode from vw_DPST_MASTER where description  ='To Elgi Gulf'
union
select distinct dpstcode from DPST_Master_ATS
union
select distinct dpstcode from vw_DPST_MASTER where description  ='Unknown'
union 
select dpstcode from vw_DPST_MASTER where division  in ('BEYOND TO CUST','BRAZIL TO CUST','ECS TO CUST','EZL TO CUST','BELAIR TO CUST','AUSTRALIA TO CUST')
)
group by case when [description] = 'MED' or
[description] = 'Service Charges & Old DPST' or [description] = 'Engines' or description is null
then 'OTHERS' 
when [description] = 'AED'  then 'ATS'
else [description] end
--else Upper(case when dpst = '90091' or dpst  = '90002' or dpst = '90012' then 'Railways' else description end) end 


union all

select 
sum(Sales_amount)/1000000 as sales,
'ATS',datepart(mm,dateadd(mm,-1,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))) as monthnum
from
LN_Sales_Details_ver2 a 
left outer join vw_DPST_MASTER b 
on a.dpst =  b.dpstcode
where  convert(datetime,Invoice_Date) between (
select convert(datetime,case when datepart(mm,dateadd(mm,-1,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))) < 4 
then  '04/01/' + convert(varchar,datepart(yy,(getdate())) -1) else   '04/01/' + convert(varchar,datepart(yy,(getdate())) -0) end)) and 
(select  dateadd(dd,-1,dateadd(mm,-0,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate())) ))
and company in(600,612,616)
and sales_category in (0,2) --and dpst not in (90003,90004)
and dpst not in (select distinct dpstcode from vw_DPST_MASTER where description  ='To Elgi China'
union
select distinct dpstcode from vw_DPST_MASTER where description  ='To Elgi Gulf'
union
select distinct dpstcode from DPST_Master_ATS
union
select distinct dpstcode from vw_DPST_MASTER where description  ='Unknown'
union 
select dpstcode from vw_DPST_MASTER where division  in ('BEYOND TO CUST','BRAZIL TO CUST','ECS TO CUST','EZL TO CUST','BELAIR TO CUST','AUSTRALIA TO CUST')
)

union all

select 
sum(Sales_amount)/1000000 as sales_ytd,
case when b.division  in ('BEYOND TO CUST','ECS TO CUST','EZL TO CUST') then 'CHINA'
when b.division in ('BELAIR TO CUST') then 'BELAIR'
when b.division in ('BRAZIL TO CUST') then 'BRAZIL' 
when b.division in ('AUSTRALIA TO CUST') then 'AUSTRALIA' end 
as vertical,datepart(mm,dateadd(mm,-1,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))) as monthnum 
from LN_Sales_Details_ver2 a
left outer join vw_DPST_MASTER b
on a.dpst =  b.dpstcode
where  convert(datetime,Invoice_Date) between (
select convert(datetime,case when datepart(mm,dateadd(mm,-1,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))) < 4 
then  '04/01/' + convert(varchar,datepart(yy,(getdate())) -1) else   '04/01/' + convert(varchar,datepart(yy,(getdate())) -0) end)) and 
(select  dateadd(dd,-1,dateadd(mm,-0,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate())) ))
and company not in(600,612,616)
and sales_category in (0,2) --and dpst not in (90003,90004)
and dpst  in (select dpstcode from vw_DPST_MASTER where division  in ('BEYOND TO CUST','BRAZIL TO CUST','ECS TO CUST','EZL TO CUST','BELAIR TO CUST','AUSTRALIA TO CUST'))
group by case when b.division  in ('BEYOND TO CUST','ECS TO CUST','EZL TO CUST') then 'CHINA'
when b.division in ('BELAIR TO CUST') then 'BELAIR'
when b.division in ('BRAZIL TO CUST') then 'BRAZIL' 
when b.division in ('AUSTRALIA TO CUST') then 'AUSTRALIA' end 

union all

select 
sum(Sales_amount)/1000000 as sales_ytd,
case when [description] = 'MED' or
[description] = 'Service Charges & Old DPST' or [description] = 'Engines' or description is null
then 'OTHERS' 
when [description] = 'AED'  then 'ATS'
else [description] end as vertical,
--else Upper(case when dpst = 90091 or dpst  = 90002 or dpst = 90012 then 'Railways' else description end) end as vertical,
datepart(mm,dateadd(mm,-0,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))) as monthnum 
from LN_Sales_Details_ver2 a 
left outer join vw_DPST_MASTER b 
on a.dpst =  b.dpstcode
where  convert(datetime,Invoice_Date) between (
select convert(datetime,case when datepart(mm,dateadd(mm,-0,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))) < 4 then  
'04/01/' + convert(varchar,datepart(yy,(getdate())) -1) else   '04/01/' + convert(varchar,datepart(yy,(getdate())) -0) end)) and 
(select  dateadd(dd,-1,dateadd(mm,1,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate())) ))
and company not in(600,612,616)
and sales_category in (0,2) --and dpst not in (90003,90004)
and dpst not in (select distinct dpstcode from vw_DPST_MASTER where description  ='To Elgi China'
union
select distinct dpstcode from vw_DPST_MASTER where description  ='To Elgi Gulf'
union
select distinct dpstcode from DPST_Master_ATS
union
select distinct dpstcode from vw_DPST_MASTER where description  ='Unknown'
union 
select dpstcode from vw_DPST_MASTER where division  in ('BEYOND TO CUST','BRAZIL TO CUST','ECS TO CUST','EZL TO CUST','BELAIR TO CUST','AUSTRALIA TO CUST')
)
group by case when [description] = 'MED' or
[description] = 'Service Charges & Old DPST' or [description] = 'Engines' or description is null
then 'OTHERS' 
when [description] = 'AED'  then 'ATS'
else [description] end
--else Upper(case when dpst = 90091 or dpst  = 90002 or dpst = 90012 then 'Railways' else description end) end 

union all

select 
sum(Sales_amount)/1000000 as sales_ytd,
case when b.division  in ('BEYOND TO CUST','ECS TO CUST','EZL TO CUST') then 'CHINA'
when b.division in ('BELAIR TO CUST') then 'BELAIR'
when b.division in ('BRAZIL TO CUST') then 'BRAZIL'
when b.division in ('AUSTRALIA TO CUST') then 'AUSTRALIA'  
end   as vertical,datepart(mm,dateadd(mm,-0,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))) as monthnum 
from LN_Sales_Details_ver2 a 
left outer join vw_DPST_MASTER b
on a.dpst =  b.dpstcode
where  convert(datetime,Invoice_Date) between (
select convert(datetime,case when datepart(mm,dateadd(mm,-0,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))) < 4
then  '04/01/' + convert(varchar,datepart(yy,(getdate())) -1) else   '04/01/' + convert(varchar,datepart(yy,(getdate())) -0) end)) and 
(select  dateadd(dd,-1,dateadd(mm,1,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate())) ))
and company not in(600,612,616)
and sales_category in (0,2) --and dpst not in (90003,90004)
and dpst  in (select dpstcode from vw_DPST_MASTER where division  in ('BEYOND TO CUST','BRAZIL TO CUST','ECS TO CUST','EZL TO CUST','BELAIR TO CUST','AUSTRALIA TO CUST')
)
group by case when b.division  in ('BEYOND TO CUST','ECS TO CUST','EZL TO CUST') then 'CHINA'
when b.division in ('BELAIR TO CUST') then 'BELAIR'
when b.division in ('BRAZIL TO CUST') then 'BRAZIL' 
when b.division in ('AUSTRALIA TO CUST') then 'AUSTRALIA' end 
 


union all

select 
sum(Sales_amount)/1000000 as sales,
'ATS',datepart(mm,dateadd(mm,-0,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))) as monthnum
from LN_Sales_Details_ver2 a 
left outer join vw_DPST_MASTER b 
on a.dpst =  b.dpstcode
where  convert(datetime,Invoice_Date) between (
select convert(datetime,case when datepart(mm,dateadd(mm,-0,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))) < 4 
then  '04/01/' + convert(varchar,datepart(yy,(getdate())) -1) else   '04/01/' + convert(varchar,datepart(yy,(getdate())) -0) end)) and 
(select  dateadd(dd,-1,dateadd(mm,1,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate())) ))
and sales_category in (0,2) --and dpst not in (90003,90004)
and dpst  in (select distinct dpstcode from DPST_Master_ATS)

GO

