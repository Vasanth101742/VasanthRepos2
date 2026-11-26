--exec sp_Warrenty_tracker_closed
CREATE proc [dbo].[sp_Warrenty_tracker_closed]
as
begin

truncate table Warrenty_tracker_closed
truncate table closed_Approved_fabs 
truncate table closed_pending_fabs


--Alter table Warrenty_tracker_closed add foc_validated_on date
--Verification comment added on 23/6/2025 based on kannan peacock  
--Alter table Warrenty_tracker_closed add foc_verification_comments nvarchar(max)

insert into Warrenty_tracker_closed (Log_Date,ccstrackno,focno,fabno,Model,Custname,partcode,Part_desc,
Itemqty,Item_price,Mileage_Cost,Labour_cost,Misc_cost,Qty,Trips,Other_cost,total_item_price,foc_status,
rno,new_Mileage_Cost,new_Labour_cost,new_Misc_cost,new_Qty,new_Trips,new_Other_cost,total,
Approve_id,Status,--comm_date,firno,
ent_code,rejected,dlr_name,
travel_hours,onsite_hours,charge_hour,total_miles,rate_miles,freight_charge,
Incident_Charge,Repair_Charge,foc_validated,foc_validated_by,Logistics_Charge,foc_type,
foc_validated_on,remarks
)
select Log_Date,ccstrackno,focno,fabno,Model,Custname,partcode,Part_desc,
Itemqty,Item_price,Mileage_Cost,Labour_cost,Misc_cost,Qty,Trips,Other_cost,total_item_price,foc_status,
rno,new_Mileage_Cost,new_Labour_cost,new_Misc_cost,new_Qty,new_Trips,new_Other_cost,total,
Approve_id,Status,ent_code,rejected,dlr_name,
travel_hours,onsite_hours,charge_hour,total_miles,rate_miles,freight_charge,
Incident_Charge,Repair_Charge,foc_validated,foc_validated_by,Logistics_Charge,foc_type,
foc_validated_on,remarks
from (
select *,isnull(total_item_price,0)+isnull(new_Mileage_Cost,0)+isnull(new_Labour_cost,0)+
isnull(new_Misc_cost,0)+isnull(new_Other_cost,0)+
isnull(freight_charge,0)
-- + isnull(Incident_Charge,0) + isnull(Repair_Charge,0) + isnull(Logistics_Charge,0) 
as total,
'' as Approve_id,'' as Status
From (
select rno,Log_Date,ccstrackno,focno,fabno,Model,Custname,
partcode,Part_desc,
--case when rno >1 then 0 else Itemqty end as Itemqty,
--case when rno >1 then 0 else Item_price end as Item_price,
Itemqty,Item_price,
Mileage_Cost,Labour_cost,
Misc_cost,Qty,Trips,Other_cost,total_item_price,foc_status,ent_code,rejected,dlr_name,
case when rno >1 then 0 else Mileage_Cost  end as new_Mileage_Cost,
case when rno >1 then 0 else Labour_cost  end as new_Labour_cost,
case when rno >1 then 0 else Misc_cost  end as new_Misc_cost,
case when rno >1 then 0 else Qty  end as new_Qty,
case when rno >1 then 0 else Trips  end as new_Trips,
case when rno >1 then 0 else other_cost  end as new_Other_cost,

case when rno >1 then 0 else travel_hours end as travel_hours,
case when rno >1 then 0 else onsite_hours end as onsite_hours,
case when rno >1 then 0 else charge_hour end as charge_hour,
case when rno >1 then 0 else total_miles end as total_miles,
case when rno >1 then 0 else rate_miles end as rate_miles,
case when rno >1 then 0 else freight_charge end as freight_charge,
case when rno >1 then 0 else Incident_Charge end as Incident_Charge,
case when rno >1 then 0 else Repair_Charge end as Repair_Charge,
foc_validated,foc_validated_by,
case when rno >1 then 0 else Logistics_Charge end as Logistics_Charge,
foc_type,foc_validated_on,remarks
From (
select distinct *,ROW_NUMBER()over(partition by focno order by focno) rno  From (
select  convert(date,a.date_time) as Log_Date,a.ccstrackno,a.focno,a.fabno,a.pr_model as Model,a.cu_name as Custname,
Item_code as partcode,item_desc as Part_desc,item_req as Itemqty,Item_price,a.mileage_charge as Mileage_Cost,
a.service_charge as Labour_cost,a.miscell_charges as Misc_cost,a.qty_req as Qty,
a.no_trips as Trips,a.other_charges as Other_cost,
item_req*Item_price as total_item_price,foc_status,a.ent_code,rejected,dlr_name,
travel_hours,onsite_hours,charge_hour,total_miles,rate_miles,
frieght_charge as freight_charge,
Incident_Charge,Repair_Charge,foc_validated,foc_validated_by,Logistics_Charge,foc_type,
foc_validated_on,a.remarks
--,apprv_id,,case when a.focno in (select distinct focno  From active_foc_approvels WHERE apprv_id='11120')then 'Approved' else 'Pending'end as Status
From (select a.*,b.Incident_Charge,b.Repair_Charge,b.Logistics_Charge From Closed_Foc a
left outer join
(select focno,--a.charge_type,
sum(case when b.charge_type='INCIDENTAL CHARGES' then amount else null end) as Incident_Charge ,
sum(case when b.charge_type='REPAIR CHARGES' then amount else null end) as Repair_Charge, 
sum(case when b.charge_type='LOGISTICS/FREIGHT' then amount else null end) as Logistics_Charge
from foc_other_charge_details a
left outer join foc_other_charges b
on a.charge_type=b.id
where b.charge_type in ('INCIDENTAL CHARGES','REPAIR CHARGES','LOGISTICS/FREIGHT')
--and focno='26539L007'
group by a.focno--,b.charge_type
)b
on a.focno=b.focno
where a.focno not like '6%'
--where ent_code in ('A0002','A0003')
--dlr_name ='cu1e00847'-- and convert(date,date_time) between'2017-08-01'and '2017-08-31'-- and focno ='26519h059'
) a
--left join active_foc_approvels b
--on a.focno=b.focno
--and a.firno=b.firno
--and a.ccstrackno=b.trackno
inner join (select * From closed_foc_parts where foc_recommend='YES' and confirm='Y') c
on a.ccstrackno=c.ccstrackno
and a.firno=c.focno
)a
)a
)a
)a




insert into closed_Approved_fabs 
select distinct a.focno,b.usr_name,app_levl From (
select distinct LTRIM(RTRIM(focno))focno,apprv_id,app_levl From closed_foc_approvels where focno <>'' and focno is not null and apprv_id not like '%[a-z]%'
--and focno ='26519j042'
)a
left join (select distinct usr_id,USR_NAME  From users) b
on b.usr_id=a.apprv_id 

-------------
insert into  closed_pending_fabs
select focno,USR_NAME as pnd_user  from(
select a.*,b.USR_NAME  From (select focno,foc_status,ccstrackno,foc_type  From Active_Foc)a
left join (select foc_status,locations,USR_NAME,foc_type  From users  where login_type is not null and pr_grp not like '%6%' )b
on a.foc_status=b.foc_status
--and a.foc_type =b.foc_type
and b.locations like '%'+substring(a.ccstrackno,2,2)+'%'
)a
------------------ new method
update Warrenty_tracker_closed set status=a.pend_users from (
SELECT  focno
       ,STUFF((SELECT ', ' + CAST(pnd_user AS VARCHAR(10)) [text()]
         FROM closed_pending_fabs 
         WHERE focno = t.focno
         FOR XML PATH(''), TYPE)
        .value('.','NVARCHAR(MAX)'),1,2,' ') pend_users
FROM closed_pending_fabs t
GROUP BY focno)a
where ltrim(rtrim(Warrenty_tracker_closed.focno))=ltrim(rtrim(a.focno))

-----------------

update Warrenty_tracker_closed set Approve_id=a.apprv_users from (
SELECT  focno
       ,STUFF((SELECT ', ' + CAST(usr_name AS VARCHAR(10)) [text()]
         FROM closed_Approved_fabs 
         WHERE focno = t.focno
         FOR XML PATH(''), TYPE)
        .value('.','NVARCHAR(MAX)'),1,2,' ') apprv_users
FROM closed_Approved_fabs t
GROUP BY focno)a
where ltrim(rtrim(Warrenty_tracker_closed.focno))=ltrim(rtrim(a.focno))



update Warrenty_tracker_closed set firno=a.firno from(select ccstrackno,focno,firno from closed_Foc)a
where  Warrenty_tracker_closed.ccstrackno=a.ccstrackno
and Warrenty_tracker_closed.focno=a.focno


update Warrenty_tracker_closed set comm_date=d.comm_date from(
select firno,ccstrackno,max(comm_date)comm_date from closed_fir
--where ISDATE(comm_date)=1
group by firno,ccstrackno
--order by comm_date
)d
where Warrenty_tracker_closed.firno=d.firno
and Warrenty_tracker_closed.ccstrackno =d.ccstrackno



update Warrenty_tracker_closed set foc_type_desc=foc_desc
from(select * from master_foc_type)a
where Warrenty_tracker_closed.foc_type=foc_code

--Updating foc verification_comments on 23/6/2025
update a set a.foc_verification_comments=b.foc_validation_remarks from Warrenty_tracker_closed a 
inner join closed_foc b on ltrim(rtrim(a.focno))=ltrim(rtrim(b.focno)) and ltrim(rtrim(a.ccstrackno))=ltrim(rtrim(b.ccstrackno))



------------- old method

--update Warrenty_tracker_closed set Approve_id=a.apprv_id 
--from (
--select focno,apprv_id,rnk_new,ROW_NUMBER()over(partition by focno order by rnk_new desc) as rowno   From (select focno,apprv_id,case when apprv_id='11120'then 10 else rnk end as rnk_new From (
--select distinct LTRIM(RTRIM(focno))focno,apprv_id ,ROW_NUMBER ()over(partition by focno order by focno,apprv_id )as rnk
--  From closed_foc_approvels
--where focno <>''
--and focno is not null
--and apprv_id not like '%[a-z]%'
--)a
--)a
----where focno ='26519H132'
--group by focno,rnk_new,apprv_id  
--)a
--where ltrim(rtrim(Warrenty_tracker_closed.focno))=ltrim(rtrim(a.focno))
--and rowno=1

--update Warrenty_tracker_closed set status='Rejected' where foc_status>='70'
--update Warrenty_tracker_closed set status='Approved' where Warrenty_tracker_closed.Approve_id between 800000 and 899999

end

GO

