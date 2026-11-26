--exec sp_Warranty_Tracker_Complete
CREATE proc sp_Warranty_Tracker_Complete as 
begin

Truncate Table Warranty_Tracker_Complete

--Alter table Warranty_Tracker_Complete add FinalApprovalDate date
--Alter table Warranty_Tracker_Complete add foc_validated_on date

--Added foc_verification_comments on 23/6/2025
--Alter table Warranty_Tracker_Complete add foc_verification_comments nvarchar(max)


Insert into Warranty_Tracker_Complete(Log_Date,ccstrackno,focno,fabno,Model,
Custname,partcode,Part_desc,Itemqty,Item_price,Mileage_Cost,Labour_cost,
Misc_cost,Qty,Trips,Other_cost,total_item_price,foc_status,rno,
new_Mileage_Cost,new_Labour_cost,new_Misc_cost,new_Qty,new_Trips,
new_Other_cost,total,Approve_id,comm_date,firno,ent_code,rejected,
invnum,t_idat,Trantype,cate_desc,dlr_name,FOC_Status2,
travel_hours,onsite_hours,charge_hour,total_miles,rate_miles,freight_charge,
Incident_Charge,Repair_Charge,foc_validated,foc_validated_by,Logistics_Charge,
foc_type,foc_type_desc,foc_validated_on,remarks
)
select Log_Date,ltrim(rtrim(ccstrackno)) ccstrackno,focno,fabno,Model,Custname,partcode,
Part_desc,Itemqty,Item_price,Mileage_Cost,Labour_cost,Misc_cost,Qty,
Trips,Other_cost,total_item_price,foc_status,rno,new_Mileage_Cost,
new_Labour_cost,new_Misc_cost,new_Qty,new_Trips,new_Other_cost,total,
Approve_id,comm_date,firno,ent_code,rejected,
invnum,t_idat,Trantype,b.cate_desc,a.dlr_name,FOC_Status2,
travel_hours,onsite_hours,charge_hour,total_miles,rate_miles,freight_charge,
Incident_Charge,Repair_Charge,foc_validated,foc_validated_by,Logistics_Charge,
foc_type,foc_type_desc,foc_validated_on,remarks
From (
select a.*,b.invnum,b.t_idat,b.Trantype,
case when foc_status>=60 then 'Approved' else 'Pending' end as FOC_Status2 
From (
select Log_Date,ccstrackno,focno,fabno,Model,Custname,partcode,Part_desc,Itemqty,Item_price,
Mileage_Cost,Labour_cost,Misc_cost,Qty,Trips,Other_cost,total_item_price,foc_status,rno,
new_Mileage_Cost,new_Labour_cost,new_Misc_cost,new_Qty,new_Trips,new_Other_cost,total,
Approve_id,Status,comm_date,firno,ent_code,rejected,dlr_name,travel_hours,onsite_hours,
charge_hour,total_miles,rate_miles,freight_charge,Incident_Charge,Repair_Charge,foc_validated,
foc_validated_by,Logistics_Charge,foc_type,foc_type_desc,foc_validated_on,
null as foc_verification_comments,remarks
From Warrenty_tracker_active where focno <>'2651CH001'
union all
select Log_Date,ccstrackno,focno,fabno,Model,Custname,partcode,Part_desc,Itemqty,Item_price,
Mileage_Cost,Labour_cost,Misc_cost,Qty,Trips,Other_cost,total_item_price,foc_status,rno,
new_Mileage_Cost,new_Labour_cost,new_Misc_cost,new_Qty,new_Trips,new_Other_cost,total,
Approve_id,Status,comm_date,firno,ent_code,rejected,dlr_name,travel_hours,onsite_hours,
charge_hour,total_miles,rate_miles,freight_charge,Incident_Charge,Repair_Charge,foc_validated,
foc_validated_by,Logistics_Charge,foc_type,foc_type_desc,foc_validated_on,
foc_verification_comments,remarks 
From Warrenty_tracker_closed where focno <>'2651CH001' 



)a
left outer join (
select t$cser,max(invnum)invnum,max(t_idat)t_idat,max(Trantype)Trantype from (
select ltrim(rtrim(T$CSER))T$CSER,a.invnum ,t_idat,Trantype  From (
select a.*,b.invnum,b.Trantype From (select distinct T$CSER,T$SHPM  
From [ELGi_LN].dbo.TWHINH433ALL where ltrim(rtrim(T$CSER))<>'' )a
left join 
(select distinct t_shpm,max(invnum)as invnum,max(Trantype)Trantype 
From [ELGi_LN].dbo.CI_Lines where ltrim(rtrim(t_shpm))<>'' and Company =401 group by t_shpm)b
on ltrim(rtrim(a.T$SHPM))=ltrim(rtrim(b.t_shpm))
)a
left join(select distinct invnum,max(t_idat)t_idat 
From [ELGi_LN].dbo.CI_Header where company in (401) group by invnum )b
on ltrim(rtrim(a.invnum)) =ltrim(rtrim(b.invnum)) 
)a group by t$cser

union all

select distinct ltrim(rtrim(T$FABN))T$FABN,InvoiceNum,InvoiceDt,trantype From (
select distinct T$FABN,T$ORNO,T$PONO,T$SRNB  From (select distinct T$LOTI,T$FABN 
From [ELGI-DW].dbo.TTEINV077150 )a
inner join (select distinct T$LOTI,T$ORNO,T$PONO,T$SRNB From 
[ELGI-DW].dbo.TTEINV079150)b
on a.T$LOTI =b.T$LOTI 
)a
inner join (
select distinct OrderNum,max(InvoiceDt)InvoiceDt,max(InvoiceNum)InvoiceNum,max(trantype)trantype 
from [ELGI-DW].dbo.TmpSlsDelivery where Company =150 group by OrderNum
)b
on a.T$ORNO =b.OrderNum 
--and a.T$PONO =b.PositionNum 
--and a.T$SRNB =b.SequenceNum 
)b
on ltrim(rtrim(a.fabno)) =ltrim(rtrim(b.T$CSER)))a
left join (select * From master_foc_category)b
on substring(ltrim(rtrim(a.focno)),5,1)=b.foc_cate


update Warranty_Tracker_Complete set foc_validated_by=a.emp_name
from (select distinct emp_code,emp_name from employee_detail)a
where Warranty_Tracker_Complete.foc_validated_by=a.emp_code


update Warranty_Tracker_Complete set Foc_Status2='Rejected' where rejected=1--'True'


update Warranty_Tracker_Complete set date_rej=a.date_rej,Rejectedby=a.rej_id
from (select * from closed_foc_rejected)a
where Warranty_Tracker_Complete.ccstrackno=a.trackno
and Warranty_Tracker_Complete.focno=a.focno

update Warranty_Tracker_Complete set RejectedbyName=a.emp_name
from (select distinct emp_code,emp_name from employee_detail)a
where Warranty_Tracker_Complete.Rejectedby=convert(varchar(50),a.emp_code)


update Warranty_Tracker_Complete set FinalApprovalDate=a.date_app
from (select * from closed_foc_approvels where app_levl>=60 
--and trackno='271o00012'
)a
where Warranty_Tracker_Complete.ccstrackno=a.trackno
and Warranty_Tracker_Complete.focno=a.focno

--Alter table Warranty_Tracker_Complete add failure_dt date

update Warranty_Tracker_Complete set failure_dt=a.failure_dt
from (select distinct ccstrackno,failure_dt from closed_foc
-- where ccstrackno='271N00562'
)a
where Warranty_Tracker_Complete.ccstrackno=a.ccstrackno

update Warranty_Tracker_Complete set failure_dt=a.failure_dt
from (select distinct ccstrackno,failure_dt from active_foc
-- where ccstrackno='271N00562'
)a
where Warranty_Tracker_Complete.ccstrackno=a.ccstrackno


--Region Classification

--Method1:
Update Warranty_Tracker_Complete set Region=a.RegionName,Ent_Desc=a.EntityName
from (select * from Region_Entity_Master)a
where Warranty_Tracker_Complete.ent_code=a.EntityCode


--Method2:
update Warranty_Tracker_Complete set Region='Europe'
where dlr_name in ('CU1R01967','CRE000082') 


--delete from Warranty_Tracker_Complete where Region is null
--Alter table Warranty_Tracker_Complete add PriceBook varchar(50)


--Old Method :Source data to Customer_Pricebook_Master table will be shared by Meenakshi from Costing Team
--Update Warranty_Tracker_Complete set PriceBook=a.PriceBook
--from Customer_Pricebook_Master a
--where ltrim(rtrim(Warranty_Tracker_Complete.dlr_name))=ltrim(rtrim(a.CustCode))

--New Method: 

Update Warranty_Tracker_Complete set PriceBook=a.PriceBook,TP_Currency=a.Currency
from Regionwise_Pricebook_Master a
where ltrim(rtrim(Warranty_Tracker_Complete.Region))=ltrim(rtrim(a.Region))

Update Warranty_Tracker_Complete set PriceBook=a.PriceBook,TP_Currency=a.Currency
from Regionwise_Pricebook_Master a
where ltrim(rtrim(Warranty_Tracker_Complete.Region))=ltrim(rtrim(a.Region))
and ltrim(rtrim(Warranty_Tracker_Complete.Ent_Desc))=ltrim(rtrim(a.Ent_Desc))
and ltrim(rtrim(Warranty_Tracker_Complete.Ent_Desc))='Malaysia'



update Warranty_Tracker_Complete set TP_Currency='AUD'
where Region ='Oceania' and ent_desc ='Australia' 


--Old Method
--update Warranty_Tracker_Complete set company=a.company,OrderNo=a.OrderNum
--from (select Company,OrderNum,substring(ltrim(rtrim(isnull(t_corn,refa))),1,12)  as indent from Sales_Header)a
--where Warranty_Tracker_Complete.focno = a.indent

--update Warranty_Tracker_Complete set SaleOrderType=a.SaleOrderType,trantype2=a.trantype,Invoice=a.Invoice
--from (select distinct substring(ltrim(rtrim(indent)),1,12) indent,company,SaleOrderType,OrderNo,trantype,invoice from ELGi_Sales_Details)a
--where Warranty_Tracker_Complete.company = a.company
--and Warranty_Tracker_Complete.OrderNo=a.OrderNo
--and Warranty_Tracker_Complete.focno = a.indent


--New Method
update Warranty_Tracker_Complete set company=a.company,SaleOrderType=a.ordertype,OrderNo=a.OrderNum
--,trantype2=a.trantype,Invoice=a.Invoice
from [ELGi_LN].dbo.salesorder_with_fabno a
where Warranty_Tracker_Complete.fabno = a.SERL


--Select * from Warranty_Tracker_Complete where pricebook is not null
--Alter table Warranty_Tracker_Complete add TP_Currency varchar(25)



update Warranty_Tracker_Complete set TransferPrice=a.BAPR
--,TP_Currency=a.CURN
from (
select company,ITEM,EFDT,EXDT,BAPR,PRBK,CURN from [ELGi_LN].dbo.TTDPCG031ALL a
where COMPANY=490
and EXDT='9999-01-01 00:00:00.000'
--and prbk in ('sal000024', -- Refers 490 company
--'sal000042'-- Refers 400 company
--)--and company in (400,490)
and EFDT in (select max(efdt) from [ELGi_LN].dbo.TTDPCG031ALL b where a.ITEM=b.ITEM
and a.EFDT=b.EFDT
and a.PRBK=b.PRBK
)
--and item like '         220318780'--'%432180%'
--order by item
)a
where --Warranty_Tracker_Complete.company like '4%' and 
--Warranty_Tracker_Complete.company<>'490' and 
ltrim(rtrim(Warranty_Tracker_Complete.partcode))=ltrim(rtrim(a.item))
and ltrim(rtrim(Warranty_Tracker_Complete.PriceBook))=ltrim(rtrim(a.PRBK))
and ltrim(rtrim(Warranty_Tracker_Complete.TP_Currency))=ltrim(rtrim(a.CURN))



--Alter table Warranty_Tracker_Complete add LC_Percent float
--Alter table Warranty_Tracker_Complete add LC_Value float

--Alter table Warranty_Tracker_Complete add TotalServiceCost float
--Alter table Warranty_Tracker_Complete add TotalWarrantyCost float
	


Update Warranty_Tracker_Complete set LC_Percent=LC_Percentage
from Regionwise_LC_Master a
where ltrim(rtrim(Warranty_Tracker_Complete.Region))=ltrim(rtrim(a.Region))


Update Warranty_Tracker_Complete set LC_Value =itemqty * TransferPrice * (1+(isnull(LC_Percent,0)/100))

Update Warranty_Tracker_Complete set TotalServiceCost= isnull(new_Mileage_Cost,0) + isnull(new_Labour_cost,0) + 
isnull(new_Misc_cost,0) + isnull(new_Other_cost,0)

Update Warranty_Tracker_Complete set TotalWarrantyCost=isnull(LC_Value,0) + isnull(TotalServiceCost,0)

update Warranty_Tracker_Complete set ProductCategory='Units' where partcode Like 'S%'
update Warranty_Tracker_Complete set ProductCategory='Units' where partcode Like 'Z%'
update Warranty_Tracker_Complete set ProductCategory='Others'where ProductCategory is null

----------------------------
--productgroup,ProductSeries Product segment Update

--Old Method
--update Warranty_Tracker_Complete set productgroup=a.product
--from
--(select distinct focno,product from Active_Foc 
--union
--select distinct focno,product from Closed_Foc)a
--where Warranty_Tracker_Complete.focno=a.focno

--Alter table Warranty_Tracker_Complete add TPL varchar(50)
--Alter table Warranty_Tracker_Complete add prod_series varchar(50)

update Warranty_Tracker_Complete set TPL=a.TPL
from (select distinct fabno,ltrim(rtrim(TPL)) TPL from despdetails
where len(ltrim(rtrim(fabno)))>2)a
where Warranty_Tracker_Complete.fabno=a.fabno

update Warranty_Tracker_Complete set productgroup=prod_group,prod_series=a.prod_series,prod_segment =a.prod_segment
from (select distinct tpl,prod_group,prod_series,prod_segment,tpl_rev from [ELGi_CDOC].dbo.crd_attribs a
where tpl_rev in (select max(tpl_rev) from [ELGi_CDOC].dbo.crd_attribs b where a.tpl=b.tpl)
--and ltrim(rtrim(a.tpl))='S07096'--'S012158' --for testing
)a
where ltrim(rtrim(Warranty_Tracker_Complete.TPL))=ltrim(rtrim(a.tpl))


update Warranty_Tracker_Complete set productgroup=prod_group,prod_series=a.prod_series,prod_segment =a.prod_segment
from (select distinct tpl,prod_group,prod_series,prod_segment,tpl_rev from [ELGi_CDOC].dbo.crd_attribs_obsolete a
where tpl_rev in (select max(tpl_rev) from [ELGi_CDOC].dbo.crd_attribs_obsolete b where a.tpl=b.tpl)
--and ltrim(rtrim(a.tpl))='S07096'--'S012158' --for testing
)a
where ltrim(rtrim(Warranty_Tracker_Complete.TPL))=ltrim(rtrim(a.tpl))


update Warranty_Tracker_Complete set productgroup=prod_group,prod_series=a.prod_series,prod_segment =a.prod_segment
from (select distinct tpl,prod_group,prod_series,prod_segment,tpl_rev from [ELGi_CDOC].dbo.dpsac1 a
where tpl_rev in (select max(tpl_rev) from [ELGi_CDOC].dbo.dpsac1 b where a.tpl=b.tpl)
--and ltrim(rtrim(a.tpl))='S07096'--'S012158' --for testing
)a
where ltrim(rtrim(Warranty_Tracker_Complete.TPL))=ltrim(rtrim(a.tpl))


update Warranty_Tracker_Complete set productgroup=prod_group,prod_series=a.prod_series,prod_segment =a.prod_segment
from (select distinct tpl,prod_group,prod_series,prod_segment,tpl_rev from [ELGi_CDOC].dbo.dpsac1_obsolete a
where tpl_rev in (select max(tpl_rev) from [ELGi_CDOC].dbo.dpsac1_obsolete b where a.tpl=b.tpl)
--and ltrim(rtrim(a.tpl))='S07096'--'S012158' --for testing
)a
where ltrim(rtrim(Warranty_Tracker_Complete.TPL))=ltrim(rtrim(a.tpl))

--Alter Table Warranty_Tracker_Complete add rca_code nvarchar(50)
--Alter Table Warranty_Tracker_Complete add rca_description nvarchar(200)
--Alter Table Warranty_Tracker_Complete add call_hmr nvarchar(50)

update Warranty_Tracker_Complete set rca_code=a.rca_code
from (select distinct trackno,rca_code from ccs_autorca_details)a
where ltrim(rtrim(Warranty_Tracker_Complete.ccstrackno))=ltrim(rtrim(a.trackno))

update Warranty_Tracker_Complete set rca_code=a.rca_code
from (select distinct trackno,rca_code from crm_autorca_details)a
where ltrim(rtrim(Warranty_Tracker_Complete.ccstrackno))=ltrim(rtrim(a.trackno))

update Warranty_Tracker_Complete set rca_description=a.prob_desc
from (select distinct rca_code,prob_desc from rca_master)a
where ltrim(rtrim(Warranty_Tracker_Complete.rca_code))=ltrim(rtrim(a.rca_code))

update Warranty_Tracker_Complete set call_hmr=a.hr_mtr_reading
from (select distinct trackno,hr_mtr_reading from callhistory1)a
where ltrim(rtrim(Warranty_Tracker_Complete.ccstrackno))=ltrim(rtrim(a.trackno))


--Alter table Warranty_Tracker_Complete add Finyear varchar(10)
--Alter table Warranty_Tracker_Complete add FinMonth varchar(10)
--Alter table Warranty_Tracker_Complete add FinMonthName varchar(20)

update Warranty_Tracker_Complete set Finyear=year(log_date)-1 where month(Log_Date)<4
update Warranty_Tracker_Complete set Finyear=year(log_date) where month(Log_Date)>=4

update Warranty_Tracker_Complete set FinMonth=month(Log_Date)+9 where month(Log_Date)<4
update Warranty_Tracker_Complete set FinMonth=month(Log_Date)-3 where month(Log_Date)>=4

update Warranty_Tracker_Complete set FinMonthName=substring(datename(mm,dateadd(mm,month(Log_Date),-1)),1,3)


--Foc verification_comments added on 23/6/2025

update Warranty_Tracker_Complete set foc_verification_comments= b.foc_verification_comments from 
(select * from [Warrenty_tracker_closed]) b 
where ltrim(rtrim(b.ccstrackno))=ltrim(rtrim(Warranty_Tracker_Complete.ccstrackno)) and ltrim(rtrim(Warranty_Tracker_Complete.focno))=ltrim(rtrim(b.focno))

--update Warranty_Tracker_Complete set TransferPrice=a.BAPR
--from (select company,ITEM,EFDT,EXDT,BAPR,prbk from TTDPCG031ALL a
--where EXDT='9999-01-01 00:00:00.000'
--and prbk in ('sal000024', -- Refers 490 company
--'sal000042'-- Refers 400 company
--)
----and company in (400,490)
--and EFDT in (select max(efdt) from TTDPCG031ALL b where a.ITEM=b.ITEM
----and a.EFDT=b.EFDT
--)
----and item like '%432180%'
----order by item
--)a
--where --Warranty_Tracker_Complete.company='490' and 
--ltrim(rtrim(Warranty_Tracker_Complete.partcode))=ltrim(rtrim(a.item))
--and Warranty_Tracker_Complete.TransferPrice is null

end

select  * from Warranty_Tracker_Complete
--where Region is not null
--where partcode='A991276'
--where prod_segment is null

GO

