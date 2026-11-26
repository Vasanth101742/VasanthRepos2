--use elgi_intranet
--go
-- exec sp_ats_foc_details
CREATE proc sp_ats_foc_details
as
begin

truncate table ats_foc_details
	
insert into ats_foc_details(company,OrderNo,areacode,areaname,SaleOrderType,indent,custcode,custname,warehouse,trantype,item,item_desc,
invoice,Invoice_Date,Currency,dpst,dpstname,DeliveryQty,cal_year,cal_month,Sales_amount)
SELECT * FROM (
select company,OrderNo,areacode,areaname,SaleOrderType,indent,custcode,custname,warehouse,trantype,item,item_desc,
invoice,	Invoice_Date,Currency,dpst,dpstname,DeliveryQty,cal_year,cal_month,Sales_amount 
From [ELGi_LN].dbo.ATS_Sales_Details
--where indent='6612ak001'
where --company in (@comp) and 
SaleOrderType  in (select SaleOrderType from [ELGi_LN].dbo.saletype_master_ATS where Sales_Category in (1))
AND Invoice_Date>='2019-04-01'
--and cal_year in (@year)
--and cal_Month in (@month)
)a


truncate table foc_details

insert into foc_details
select *  From (
select foc_classification,firno,ccstrackno ,focno,fabno,
oem_name,foc_desc,pr_model,pr_type,item_code,cate_desc,
sum(item_price)item_price,sum(total_value)total_value,
sum(item_req)item_req,max(comm_date)comm_date,max(sale_date)sale_date
From (
select a.*
,b.foc_desc
,c.item_price ,c.total_value ,item_req,c.item_code,
d.comm_date ,d.sale_date ,d.fabno,d.pr_model,pr_type,
f.cate_desc
From (
select firno,ccstrackno,focno,foc_type,oem_name,foc_classification from Active_Foc 
union all
select firno,ccstrackno,focno,foc_type,oem_name,foc_classification from Closed_Foc) a 
left join (select * From master_foc_type) b
on a.foc_type =b.foc_code 
left join(
select item_code,focno,ccstrackno,sum(item_price)item_price,
sum(total_value)total_value,sum(item_req)item_req from Active_Foc_parts
group by item_code,focno,ccstrackno
union all
select item_code,focno,ccstrackno,sum(item_price)tem_price,
sum(total_value)total_value,sum(item_req)item_req from closed_foc_parts
group by item_code,focno,ccstrackno)c
on a.firno=c.focno
and a.ccstrackno =c.ccstrackno
left join(
select ccstrackno,firno,pr_type,pr_model,fabno,sale_date,comm_date From Active_Fir 
union all
select ccstrackno,firno,pr_type,pr_model,fabno,sale_date,comm_date From closed_Fir)d
on a.firno=d.firno
and a.ccstrackno =d.ccstrackno
left join(select * From master_foc_category)f
on substring(a.focno,5,1)=f.foc_cate
)a group by foc_classification,firno,ccstrackno ,focno,fabno,oem_name ,foc_desc,pr_model,pr_type,item_code,cate_desc
)a
	
	

update ats_foc_details set
foc_classification=a.foc_classification,
firno=a.firno,
ccstrackno=a.ccstrackno,
focno=a.focno,
fabno=a.fabno,
oem_name=a.oem_name,
foc_desc=a.foc_desc,
pr_model=a.pr_model,
pr_type=a.pr_type,
cate_desc=a.cate_desc,
comm_date=a.comm_date,
sale_date=a.sale_date from (
select focno,foc_classification,firno,ccstrackno,fabno,oem_name,foc_desc,pr_model,pr_type,cate_desc,
max(comm_date)comm_date,max(sale_date)sale_date from foc_details
group by focno,foc_classification,firno,ccstrackno,fabno,oem_name,foc_desc,pr_model,pr_type,cate_desc
)a
where ats_foc_details.indent=a.focno


update ats_foc_details set
item_price=a.item_price,
total_value=a.total_value,
item_req=a.item_req
from (select focno,item_code,sum(item_price)item_price ,sum(total_value)total_value,sum(item_req)item_req from foc_details
group by focno,item_code)a
where ats_foc_details.indent=a.focno
and ltrim(rtrim(ats_foc_details.item))=a.item_code


truncate table appoval_levels

insert into appoval_levels
select  * from(
select desig,focno as approved_foc,app_comm From (
select
case when (desig is null or ltrim(rtrim(desig))='') and pre_levl=0 then 'AREA SALES MANAGER'
when (desig is null or ltrim(rtrim(desig))='') and pre_levl=5 then 'SALES COORDINATOR'
when (desig is null or ltrim(rtrim(desig))='') and pre_levl=10 then 'HO PRODUCT ENGR'
when (desig is null or ltrim(rtrim(desig))='') and pre_levl=20then 'HEAD AFTER SALES'
when (desig is null or ltrim(rtrim(desig))='') and pre_levl=25 then 'QUALITY HEAD'
when (desig is null or ltrim(rtrim(desig))='') and pre_levl=50 then 'MANAGING DIRECTOR' else desig end as desig,
trackno,firno,focno,app_comm,pre_levl From Active_Foc_approvels
union all
select
case when (desig is null or ltrim(rtrim(desig))='') and pre_levl=0 then 'AREA SALES MANAGER'
when (desig is null or ltrim(rtrim(desig))='') and pre_levl=5 then 'SALES COORDINATOR'
when (desig is null or ltrim(rtrim(desig))='') and pre_levl=10 then 'HO PRODUCT ENGR'
when (desig is null or ltrim(rtrim(desig))='') and pre_levl=20then 'HEAD AFTER SALES'
when (desig is null or ltrim(rtrim(desig))='') and pre_levl=25 then 'QUALITY HEAD'
when (desig is null or ltrim(rtrim(desig))='') and pre_levl=50 then 'MANAGING DIRECTOR' else desig end as desig,
trackno,firno,focno,app_comm,pre_levl From closed_foc_approvels
)a)a
-- where approved_foc='6110AK002'

	--select * From ats_foc_details where cal_year=2020 and cal_month=09
	--order by invoice_date desc

end

GO

