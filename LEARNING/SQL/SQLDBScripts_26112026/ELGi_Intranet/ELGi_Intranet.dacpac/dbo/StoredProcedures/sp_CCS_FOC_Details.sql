--exec sp_CCS_FOC_Details

CREATE proc sp_CCS_FOC_Details as
begin

Truncate table CCS_FOC_Details


Insert into CCS_FOC_Details(focno,FOCType_Descr,FocDate,ccstrackno,fabno,
item_code,item_desc,foc_status,FOC_Category,firno)
--select * into CCS_FOC_Details from (
select a.focno,c.foc_desc as FOCType_Descr,convert(date,a.date_time) as FocDate,
a.ccstrackno,a.fabno,b.item_code,b.item_desc,a.foc_status,'Active',a.firno
from
(select * from Active_Foc --where focno= '6692AJ001'
)a
inner join (select * From active_foc_parts where foc_recommend='YES' and confirm='Y')b
on a.ccstrackno=b.ccstrackno
and a.firno=b.focno
left join (select * from master_foc_type)c
on a.foc_type=c.foc_code
--)a
order by a.focno


Insert into CCS_FOC_Details(focno,FOCType_Descr,FocDate,ccstrackno,fabno,
item_code,item_desc,foc_status,FOC_Category)
--select * into CCS_FOC_Details from (
select a.focno,c.foc_desc as FOCType_Descr,convert(date,a.date_time) as FocDate,
a.ccstrackno,a.fabno,b.item_code,b.item_desc,a.foc_status,'Closed'
from
(select * from Closed_Foc --where focno= '6692AJ001'
)a
inner join (select * From closed_foc_parts where foc_recommend='YES' and confirm='Y')b
on a.ccstrackno=b.ccstrackno
and a.firno=b.focno
left join (select * from master_foc_type)c
on a.foc_type=c.foc_code
--where a.date_time>='2022-04-01'
--)a
order by a.focno


update CCS_FOC_Details set TrackCreationDate=a.dt_time,
pr_model=a.pr_model,symptoms=a.symptoms,problem=a.problem
from (select distinct trackno,dt_time,convert(nvarchar,pr_model) pr_model,
convert(nvarchar,symptoms) symptoms,
convert(nvarchar,problem) problem
from CCS_Calls 
--where trackno='632M01251      '
)a
where ltrim(rtrim(CCS_FOC_Details.ccstrackno))=ltrim(rtrim(a.trackno))


update CCS_FOC_Details set engr_com=a.engr_com,escl_com=a.escl_com
from(
select distinct trackno,convert(nvarchar,engr_com)  engr_com,
convert(nvarchar,escl_com)  escl_com
from CCS_Calls 
)a
where ltrim(rtrim(CCS_FOC_Details.ccstrackno))=ltrim(rtrim(a.trackno))




update CCS_FOC_Details set symptom_descr=a.sym_desc
from (select * from symptoms1)a
where ltrim(rtrim(CCS_FOC_Details.symptoms))=ltrim(rtrim(a.symptoms))


update CCS_FOC_Details set comm_date=d.comm_date from(
select firno,ccstrackno,max(comm_date)comm_date from Active_fir group by firno,ccstrackno)d
where CCS_FOC_Details.firno=d.firno
and CCS_FOC_Details.ccstrackno =d.ccstrackno

update CCS_FOC_Details set comm_date=d.comm_date from(
select firno,ccstrackno,max(comm_date)comm_date from Closed_Fir group by firno,ccstrackno)d
where CCS_FOC_Details.firno=d.firno
and CCS_FOC_Details.ccstrackno =d.ccstrackno



update CCS_FOC_Details set FinalApprovalDate=a.date_app
from (select * from closed_foc_approvels where app_levl>=60 
--and trackno='271o00012'
)a
where CCS_FOC_Details.ccstrackno=a.trackno
and CCS_FOC_Details.focno=a.focno


end


select * from CCS_FOC_Details where focno='26519P720'
--where firno='289L00009A'--'6325LM029'
order by focdate

--select * from closed_foc_approvels where app_levl>=60 and  focno='26519P720'
--select * from foc_details_complete where elgi_focnumber='26419P833'

--select * from Warranty_Tracker_Complete where focno='26519P720'
----'26419P833'

--select * from closed_foc where focno='26519P720'

--select * from Warranty_Tracker_Complete where focno='26519P720'

GO

