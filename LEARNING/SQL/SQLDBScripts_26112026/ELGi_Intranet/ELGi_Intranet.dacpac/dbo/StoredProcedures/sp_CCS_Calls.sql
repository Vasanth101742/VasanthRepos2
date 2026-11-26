--exec sp_CCS_Calls

CREATE proc sp_CCS_Calls as

Begin

Truncate table CCS_Calls


Insert into CCS_Calls(slno,cu_name,ent_code,Branch,Region,loggedby,loggedbyName,
pr_model,trackno,dt_time,FinYear,FinMonth,fabno,hr_mtr_reading,symptoms,sym_desc,Fix,fix_desc,problem,
CallCategory,CallStatus,CloseDate,Ageing1,Actual_StartDate,Actual_CloseDate,
Ageing2,engr_com,escl_com,Problem_desc)
--select * into CCS_Calls from (
select slno,cu_name,
ent_code,null as Branch, null as Region,
loggedby,null as loggedbyName,pr_model,trackno,dt_time,
null as FinYear, Null as FinMonth,
fabno,hr_mtr_reading,
--case when symptoms='0' then unlsym else symptoms end as symptoms,
symptoms,
unlsym as sym_desc,
fix, 
unlfix as fix_desc,
problem,
type_call as CallCategory,'Active' as CallStatus, clos as CloseDate,
datediff(dd,dt_time,clos) as Ageing1,
startdtime as Actual_StartDate,sys_clos as Actual_CloseDate,
datediff(dd,startdtime,sys_clos) as Ageing2
,convert(nvarchar(max),engr_com) engr_com,convert(nvarchar(max),escl_com) escl_com,
unlprob
FROM  custcall


Insert into CCS_Calls(slno,cu_name,ent_code,Branch,Region,loggedby,loggedbyName,
pr_model,trackno,dt_time,FinYear,FinMonth,fabno,hr_mtr_reading,symptoms,sym_desc,Fix,fix_desc,problem,
CallCategory,CallStatus,CloseDate,Ageing1,Actual_StartDate,Actual_CloseDate,
Ageing2,engr_com,escl_com,Problem_desc)

select slno,cu_name,
ent_code,null as Branch, null as Region,
loggedby,null as loggedbyName,pr_model,trackno,dt_time,
null as FinYear, Null as FinMonth,
fabno,hr_mtr_reading,
--case when symptoms='0' then unlsym else symptoms end as symptoms,
symptoms,
unlsym as sym_desc,
fix,unlfix as fix_desc,problem,
type_call as CallCategory,'Closed' as CallStatus, clos as CloseDate,
datediff(dd,dt_time,clos) as Ageing1,
startdtime as Actual_StartDate,sys_clos as Actual_CloseDate,
datediff(dd,startdtime,sys_clos) as Ageing2
,convert(nvarchar(max),engr_com) engr_com,convert(nvarchar(max),escl_com) escl_com,
unlprob
FROM  callhistory1
--)a
--where trackno='299l00090'



update ccs_calls set sym_desc=a.sym_desc
from (select * from symptoms1)a
where ccs_calls.symptoms=a.symptoms
and ccs_calls.symptoms<>'0'


update ccs_calls set problem=a.problem_desc
from (select * from newproblems)a
where ccs_calls.problem=a.problem


update ccs_calls set Region=a.region,Branch=a.city
from (select distinct ent_code,city,region from maintbranches)a
where ccs_calls.ent_code=a.ent_code

update ccs_calls set loggedbyName=a.emp_name
from (select distinct emp_code,new_emp_code,emp_name from employee_detail)a
where ltrim(rtrim(ccs_calls.loggedby))=ltrim(rtrim(a.emp_code))


update ccs_calls set loggedbyName=a.emp_name
from (select distinct emp_code,new_emp_code,emp_name from employee_detail)a
where ltrim(rtrim(ccs_calls.loggedby))=ltrim(rtrim(a.new_emp_code))

update ccs_calls set FinYear=year(dt_time)-1 where month(dt_time)<4 and FinYear is null
update ccs_calls set FinYear=YEAR(dt_time) where month(dt_time)>=4 and FinYear is null


update ccs_calls set FinMonth=month(dt_time)+9 where month(dt_time)<4 and FinMonth is null
update ccs_calls set FinMonth=month(dt_time)-3 where month(dt_time)>=4 and FinMonth is null

--Alter table ccs_calls add comm_date date

update CCS_Calls set comm_date=a.comm_date
from (select distinct fabno,trackno,comm_date from DESPDETAILS)a
where ltrim(rtrim(CCS_Calls.fabno))=ltrim(rtrim(a.fabno))
and ltrim(rtrim(CCS_Calls.trackno))=ltrim(rtrim(a.trackno))


update CCS_Calls set comm_date=a.comm_date
from (select distinct fabno,trackno,comm_date from DESPDETAILS)a
where ltrim(rtrim(CCS_Calls.fabno))=ltrim(rtrim(a.fabno))
and CCS_Calls.comm_date is null

--update CCS_Calls set PartClaim=null
--update CCS_Calls set ServiceClaim=null

update CCS_Calls set PartClaim='Yes'
from (
select * from (
select distinct ccstrackno,item_code From active_foc_parts where foc_recommend='YES' and confirm='Y'
union
select distinct ccstrackno,item_code From closed_foc_parts where foc_recommend='YES' and confirm='Y'
)a
where ltrim(rtrim(item_code)) not in ('SCIN0004')
)a
where ltrim(rtrim(CCS_Calls.trackno))=ltrim(rtrim(a.ccstrackno))

update CCS_Calls set PartClaim='No' where PartClaim is null


update CCS_Calls set ServiceClaim='Yes'
from (
select * from (
select distinct ccstrackno,item_code From active_foc_parts where foc_recommend='YES' and confirm='Y'
union
select distinct ccstrackno,item_code From closed_foc_parts where foc_recommend='YES' and confirm='Y'
)a
where ltrim(rtrim(item_code)) in ('SCIN0004')
)a
where ltrim(rtrim(CCS_Calls.trackno))=ltrim(rtrim(a.ccstrackno))


update CCS_Calls set ServiceClaim='No' where ServiceClaim is null


end

--Alter table CCS_Calls add Fix nvarchar(max)
--Alter table CCS_Calls add PartClaim varchar(50)
--Alter table CCS_Calls add ServiceClaim varchar(50)

--select symptoms,sym_desc,fix,fix_desc,* from CCS_Calls
--where trackno='271O00006'
--select unlsym,unlfix,* from callhistory1 where trackno='271O00006'

GO

