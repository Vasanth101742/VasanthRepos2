--exec sp_DPMU_Dashboard
CREATE proc sp_DPMU_Dashboard as
begin

--Select * into CCS_DPMU_Details from [bisdb].[elgi_ln].dbo.CCS_DPMU_Details
--Select * into DPMU_Details from [bisdb].[elgi_ln].dbo.DPMU_Details


Truncate table CCS_DPMU_Details
Truncate table DPMU_Details

--Alter table CCS_DPMU_Details add Obligation nvarchar(50)

Insert into CCS_DPMU_Details(Trackno,--Complain,
Product_Group_Code,
--Product_group,Product,
--RCA_Code,RYG,Imp_Date,
Cutoff,System_WI,
--Problem_Description,
--Part_Name,[System],
Part_Category,
--Binned_Month,
--Log_Date,
--CRM,CRM_Year,
Fabno,Pr_Model,
--Build_Date,Build_Year,
Cu_Name,Nature_of_Complaint,Problem_Identified,
--Fix_Description,
LobCode,--LOB,
Closed_Date,
--Coordinator_Accept_Date,Accept_Week_No,
--[TTR_Hrs],
Entity,HMR_Meter,
HMR_Group,
--District_Name,State_Name,
Area_Category,
--mis,
Comm_Date,[COMM.MONTH],
--Escalation_Comments,
--Dispatch_Date,
DealerCode,--Dealer_Assigned,
--SE_Comments,
--Focno,
Reason_Not_Complain,remarks,
FailureMode,SubFailureMode,RCA_Selection_Criteria,Action_Taken,Warranty_Type,
part_req,coordinator,Obligation,
--Call_Type,
--Uptime_Warranty,
--TPLCODE,[TPL DESC],
--ITEMS,[CHANGED ITEMS],
--[CCS-CLOSED BY],ADDRESS,CALLER,TELEPHONE,
DealerEngineerName,DealerEngineerNo,[VC1 SERIAL NO.],
Recd_Date,COURIER,DocketNo,SendBy,DCNo,Item_Code_Desc,TotalQty,BOXES,
GRN_No,[ITEM REFERENCE NO.],TestingType,
Failed_Parts_Collection_Remarks,
Failed_Parts_Observation_Remarks,
Failed_Parts_Testing_Details,
Disposal_Type,
Sent_Via,
QTY,
[RPO / GATE PASS NO.],
RPO_GatePass_Date,
Disposal_Remarks,
Source_of_Defect,
Claim_Status,
Complaint_Status,
EWM_Comments
)
--select * into CCS_DPMU_Details from(
select a.trackno,
--b.complain,
c.actpr_grp,--f.prd_div as Product_group,
--g.product_group as PRODUCT, 
--b.rca_code,b.ryg,b.imp_date,
null as Cutoff,null as System_WI,
--c.symptoms as Problem_Description,
--g.part_name as Part_Name,g.subsytem_name as [System],
null as Part_Category,
--b.statusdate as Binned_Month,
--c.dt_time as Log_Date,
--b.statusdate as CRM,year(b.statusdate) as CRM_Year,
a.fabno,a.pr_model,
--b.build_date,year(b.build_date) as build_year,
a.cu_name,a.symptoms as Nature_of_Complaint,
null as Problem_Identified,
--c.fix as Fix_Description,
c.lob,
--h.lbdesc as [LOB],
a.Actual_closeDate as Closed_Date, --c.clos as Closed_Date,
--b.entry_date as Coordinator_Accept_Date,
--year(b.entry_date) as Accept_Week_No,
--c.ttr as [TTR_Hrs],
a.Branch as Entity,
a.hr_mtr_reading as HMR_Meter,
null as HMR_Group,
--c.cu_city as District_Name,c.ar_code as State_Name,
null as Area_Category,
--b.mis,
a.Comm_Date,month(a.Comm_Date) as [COMM.MONTH],
--c.escl_com as Escalation_Comments,
--d.desp_dt as Dispatch_Date,
c.dealers,
--concat(i.dlr_name,'[',i.dlr_code,']') as Dealer_Assigned,
--c.engr_com as SE_Comments,
--e.focno as Focno,
null as Reason_Not_Complain,
b.remarks,
null as FailureMode,null as SubFailureMode,null as RCA_Selection_Criteria,
b.acttype as Action_Taken,
null as Warranty_Type,
b.part_req,b.coordinator,
oblig as Obligation, 
--null as Call_Type,
--null as Uptime_Warranty,
--d.tpl as [TPLCODE],d.tpl_desc as [TPL DESC],
--j.item_desc as [ITEMS],j.old_itemcode as [CHANGED ITEMS],
--c.closed_by as [CCS-CLOSED BY],
--c.cu_add as [ADDRESS],
--c.caller as [CALLER],
--c.cu_ph as [TELEPHONE],
null as DealerEngineerName,
null as DealerEngineerNo,
null as [VC1 SERIAL NO.],
null as Recd_Date,
null as [COURIER],
null as DocketNo,
null as SendBy,
null as DCNo,
null as Item_Code_Desc,
null as TotalQty,
null as	[BOXES],	
null as GRN_No,
null as [ITEM REFERENCE NO.],
null as TestingType,
null as Failed_Parts_Collection_Remarks,
null as Failed_Parts_Observation_Remarks,
null as	Failed_Parts_Testing_Details,
null as Disposal_Type,	
null as Sent_Via,
null as [QTY],
null as [RPO / GATE PASS NO.],
null as RPO_GatePass_Date,
null as Disposal_Remarks,
null as Source_of_Defect,
null as Claim_Status,
null as Complaint_Status,
null as EWM_Comments


--a.engr_com
--select top 100 * 
from CCS_Calls a
left outer join ccs_autorca_details b
on a.trackno=b.trackno
left outer join CallHistory1 c
on a.trackno=c.trackno
--left outer join despdetails d
--on a.fabno=d.fabno
--left outer join CCS_FOC_Details e
--on a.trackno=e.ccstrackno
--left outer join [ELGi_LN].dbo.prodforcalls f
--on c.actpr_grp=f.prd
--left outer join [ELGi_LN].dbo.call_closing_parts g
--on a.trackno=g.trackno
--left outer join [ELGI-DW].dbo.lob h
--on c.lob=h.lbtype
--left outer join [ELGi_LN].dbo.Maintdlrs i
--on c.dealers=i.dlr_code
--left outer join [ELGi_LN].dbo.crm_closing_details j
--on a.trackno=j.trackno
--where a.FinYear>=2022  --Commented on 10 Jan 2024
--where a.trackno in ('274M02803','264M00095','299N00155')
--)a

--Alter table CCS_DPMU_Details add DealerCode	nvarchar(50)
--Alter table CCS_DPMU_Details alter column Dealer_Assigned nvarchar(max) null
--Alter table CCS_DPMU_Details add LobCode	nvarchar(25)
--Alter table CCS_DPMU_Details add actpr_grp nvarchar(25)


--------------------------------------------------------------------------------------------
insert into CCS_DPMU_Details (Trackno,Complain,Product_group,Product,RCA_Code,RYG,Imp_Date,
Cutoff,System_WI,Problem_Description,
Part_Name,
System,Part_Category,
Binned_Month,Log_Date,
CRM,CRM_Year,
Fabno,Pr_Model,
Build_Date,Build_Year,
Cu_Name,Nature_of_Complaint,
Problem_Identified,
Fix_Description,LOB_Desc,Closed_Date,
Coordinator_Accept_Date,Accept_Week_No,TTR_Hrs,
Entity,
HMR_Meter,
HMR_Group,
District_Name,
State_Name,Area_Category,
MIS,Comm_Date,[COMM.MONTH],
Escalation_Comments,
Dispatch_Date,Dealer_Assigned,
SE_Comments,Focno,
Reason_Not_Complain,
Remarks,
FailureMode,SubFailureMode,RCA_Selection_Criteria,
Action_Taken,
Warranty_Type,
Part_Req,Coordinator,
Obligation,
Call_Type,
Uptime_Warranty,
TplCode,Tpl_Desc,
Items,Changed_Items,
CCS_ClosedBy,Address,Caller,Telephone,DealerEngineerName,DealerEngineerNo,
RCA_Required
--[VC1 SERIAL NO.],Recd_Date,Courier,DocketNo,SendBy,DCNo,Item_Code_Desc,
--TotalQty,Boxes,GRN_No,[ITEM REFERENCE NO.],TestingType,Failed_Parts_Collection_Remarks,
--Failed_Parts_Observation_Remarks,Failed_Parts_Testing_Details,Disposal_Type,Sent_Via,
--Qty,[RPO / GATE PASS NO.],RPO_GatePass_Date,Disposal_Remarks,Source_of_Defect,Claim_Status,
--Complaint_Status,EWM_Comments,
--DealerCode,LobCode,Product_Group_Code,Vertical,Country,Region,TO_BE_MAPPED_AS
)

--select * into CRM_DPMU_Details from (
Select a.trackno,b.complain,a.prod_group,a.prod_subgroup,b.rca_code,b.ryg,b.imp_date,
null as Before_After_Cutoff,null as System_WI,null as ProblemDescription,
a.part_name,
null as SystemType,null as PartCategory,
b.status_date as BinnedMonth,a.call_logtime,
null as C_RM,null as CRM_Year,
a.fabno,a.product_model,
month(b.build_date) as build_month,year(b.build_date) as build_year,
a.customer_name,
a.symptoms,
ltrim(rtrim(a.complaint_identified)) complaint_identified,
a.fix,null as LOB,ho_clos as CLOSED_DT,
b.entry_date ,datepart(wk,b.entry_date) entry_weekNo,a.ttr,
a.city as Entity,
a.call_hmr,
null as HMR_Group,
a.city,
null as StateName,null as Area_Category,
b.mis,a.commissioned_dt,month(a.commissioned_dt) as Comm_Month,
null as EscalationComments,
a.inv_date,a.assigned_to,
a.work_done,a.focno,
null as Reason_NotComplain,
b.remarks as FieldComments,
null as FailureMode,null as SubFailureMode,null as RCA_SelectionCriteria,
b.acttype as ActionTaken,
null as WarrantyType,
b.part_req as Part_REQ,b.coordinator as ClosedBy,
obl_warranty as Obligation,
null as Call_Type,
b.uptime as Uptime_Warranty,
case when len(a.tplcode)<3 then c.item_code end as tplcode,
case when len(a.tpldesc)<3 then c.item_desc end as tpldesc,
null as Items,null as ChangedItems,
a.closed_by,a.[address],a.caller_name,a.phone,a.serv_engineer,a.engr_phone,
'Y' as RCA_Required
--null as VC1_SERIALNO,
--null as RECDDATE,
--null as	COURIER,
--null as DOCKETNO,
--null as SENDBY,
--null as	DCNO,
--null as ITEMCODE_DESC,
--null as TOTALQTY,
--null as BOXES,
--null as	GRNNUMBER,
--null as ITEM_REFERENCE_NO,
--null as	TESTING_TYPE,
--null as FAILED_PARTS_COLLECTION_REMARKS,
--null as FAILED_PARTS_OBSERVATION_REMARKS_OUTER_SURFACE,
--null as	FAILED_PARTS_TESTING_DETAILS,
--null as	DISPOSAL_TYPE,
--null as SENT_VIA,
--null as QTY,
--null as RPO_GATE_PASSNO,
--null as RPO_GATE_PASS_DATE,
--null as DISPOSAL_REMARKS,
--null as	SOURCE_OF_DEFECT,
--null as	CLAIM_STATUS,
--null as COMPLAINT_STATUS,
--null as EWM_Comments
--select top 100 * 
from 
(select * from CRM_Calls) a
left outer join crm_autorca_details b
on isnull(a.trackno,'0')=isnull(b.trackno,'0')
left outer join (select * from crm_closing_details) c
on a.trackno=c.trackno
--where convert(date,call_logtime)>='2019-04-01'
--where a.trackno in ('CC-00748054','CC-00965363')
--)a


--------------------------------------------------------------------------------------------
--insert into CCS_DPMU_Details (Trackno,
--TplCode,Tpl_Desc)

----select * into CRM_DPMU_Details from (
--Select a.trackno,a.item_code,a.item_desc
--from
--(select * from crm_closing_details) a
--left outer join [ELGI-DW].dbo.crm_autorca_details b
--on isnull(a.trackno,'0')=isnull(b.trackno,'0')
----where a.trackno in ('CC-00748054','CC-00965363')
----)a
-------------------------------------------------------------------------------------------------

update CCS_DPMU_Details set Obligation=a.obligdesc
from (select * from maintoblig)a
where convert(varchar,CCS_DPMU_Details.Obligation)=convert(varchar,a.oblig)

update CCS_DPMU_Details set complain= b.complain,
RCA_Code=b.rca_code
from (select distinct trackno,complain,rca_code from ccs_autorca_details) b
where ltrim(rtrim(CCS_DPMU_Details.trackno))=ltrim(rtrim(b.trackno))


update CCS_DPMU_Details set RYG=b.ryg,
Imp_Date=b.imp_date
from (select distinct trackno,ryg,imp_date from ccs_autorca_details) b
where ltrim(rtrim(CCS_DPMU_Details.trackno))=ltrim(rtrim(b.trackno))

update CCS_DPMU_Details set 
Binned_Month=b.status_date,
CRM=b.status_date,
CRM_Year=year(b.status_date)
from (select distinct trackno,status_date from ccs_autorca_details) b
where ltrim(rtrim(CCS_DPMU_Details.trackno))=ltrim(rtrim(b.trackno))

update CCS_DPMU_Details set 
build_date= b.build_date,
build_year= year(b.build_date)
from (select distinct trackno,build_date from ccs_autorca_details) b
where ltrim(rtrim(CCS_DPMU_Details.trackno))=ltrim(rtrim(b.trackno))

update CCS_DPMU_Details set 
Coordinator_Accept_Date=b.entry_date,
Accept_Week_No=year(b.entry_date),
mis=b.mis
from (select distinct trackno,entry_date,mis from ccs_autorca_details) b
where ltrim(rtrim(CCS_DPMU_Details.trackno))=ltrim(rtrim(b.trackno))

---------------------------------------
--Alter Table CCS_DPMU_Details add RCA_Required varchar(50)
update CCS_DPMU_Details set Log_Date=c.dt_time,Closed_Date=c.clos,[TTR_Hrs]=c.ttr,
RCA_Required=ow_complaint
from(select distinct trackno,dt_time,clos,ttr,ow_complaint from CallHistory1) c
where ltrim(rtrim(CCS_DPMU_Details.trackno))=ltrim(rtrim(c.trackno))


update CCS_DPMU_Details set State_Name=c.ar_code
from(select distinct trackno,ar_code from CallHistory1) c
where ltrim(rtrim(CCS_DPMU_Details.trackno))=ltrim(rtrim(c.trackno))


--update CCS_DPMU_Details set District_Name=c.cu_city
--from(select distinct trackno,cu_city from CallHistory1) c
--where ltrim(rtrim(CCS_DPMU_Details.trackno))=ltrim(rtrim(c.trackno))


--update CCS_DPMU_Details set Problem_Description=c.symptoms
--from(select distinct trackno,symptoms from CallHistory1) c
--where ltrim(rtrim(CCS_DPMU_Details.trackno))=ltrim(rtrim(c.trackno))

--update CCS_DPMU_Details set Fix_Description=c.fix
--from(select distinct trackno,fix from CallHistory1) c
--where ltrim(rtrim(CCS_DPMU_Details.trackno))=ltrim(rtrim(c.trackno))

--update CCS_DPMU_Details set Escalation_Comments=c.escl_com
--from(select distinct trackno,escl_com from CallHistory1) c
--where ltrim(rtrim(CCS_DPMU_Details.trackno))=ltrim(rtrim(c.trackno))

--update CCS_DPMU_Details set SE_Comments=c.engr_com
--from(select distinct trackno,engr_com from CallHistory1) c
--where ltrim(rtrim(CCS_DPMU_Details.trackno))=ltrim(rtrim(c.trackno))


--update CCS_DPMU_Details set CCS_ClosedBy=c.closed_by,
--[ADDRESS]=c.cu_add,[CALLER]=c.caller,[TELEPHONE]=c.cu_ph
--from(select distinct trackno,closed_by,cu_add,caller,cu_ph  from CallHistory1) c
--where ltrim(rtrim(CCS_DPMU_Details.trackno))=ltrim(rtrim(c.trackno))



update CCS_DPMU_Details set Dispatch_Date=d.desp_dt,[TPLCODE]=d.tpl,Tpl_Desc=d.tpl_desc 
from (select distinct fabno,desp_dt,tpl,tpl_desc from despdetails
where len(fabno)>2
) d
where ltrim(rtrim(CCS_DPMU_Details.fabno))=ltrim(rtrim(d.fabno))

update CCS_DPMU_Details set Focno=e.focno
from (
--Method1
select distinct ccstrackno,focno from CCS_FOC_Details
--where  ltrim(rtrim(ccstrackno))='299N00155' --Test data
--Method2
--select * from active_foc
--where  ltrim(rtrim(ccstrackno))='299N00155' --Test data
--select * from Closed_Foc
--where  ltrim(rtrim(ccstrackno))='299N00155' --Test data
) e
where ltrim(rtrim(CCS_DPMU_Details.trackno))=ltrim(rtrim(e.ccstrackno))


--update CCS_DPMU_Details set Product_group=f.prd_div
--from (select distinct prd,prd_div from [ELGi_LN].dbo.prodforcalls) f
--where ltrim(rtrim(CCS_DPMU_Details.Product_Group_Code))=ltrim(rtrim(f.prd))

----Method1
----update CCS_DPMU_Details set Product=g.product_group,Part_Name=g.part_name,[System]=g.subsytem_name
----from (select distinct trackno,product_group,part_name,subsytem_name from [ELGi_LN].dbo.call_closing_parts) g
----where ltrim(rtrim(CCS_DPMU_Details.trackno))=ltrim(rtrim(g.trackno))

----Method2
--update CCS_DPMU_Details set Product=g.product_group
--from (select distinct trackno,product_group from [ELGi_LN].dbo.call_closing_parts) g
--where ltrim(rtrim(CCS_DPMU_Details.trackno))=ltrim(rtrim(g.trackno))

update CCS_DPMU_Details set Part_Name=g.part_name
from (select distinct trackno,part_name from call_closing_parts) g
where ltrim(rtrim(CCS_DPMU_Details.trackno))=ltrim(rtrim(g.trackno))


--update CCS_DPMU_Details set [System]=g.subsytem_name
--from (select distinct trackno,subsytem_name from [ELGi_LN].dbo.call_closing_parts) g
--where ltrim(rtrim(CCS_DPMU_Details.trackno))=ltrim(rtrim(g.trackno))

update CCS_DPMU_Details set LOB_Desc=h.lb_desc
from(select distinct lb_type,lb_desc from lob) h
where ltrim(rtrim(CCS_DPMU_Details.LobCode))=ltrim(rtrim(h.lb_type))

update CCS_DPMU_Details set Dealer_Assigned=concat(i.dlr_name,'[',i.dlr_code,']')
from (select distinct dlr_code,dlr_name from Maintdlrs) i
where ltrim(rtrim(CCS_DPMU_Details.DealerCode))=ltrim(rtrim(i.dlr_code))

update CCS_DPMU_Details set [ITEMS]=j.item_desc,Changed_Items=j.old_itemcode 
from (select distinct trackno,item_desc,old_itemcode from crm_closing_details) j
where ltrim(rtrim(CCS_DPMU_Details.trackno))=ltrim(rtrim(j.trackno))

--Alter table CCS_DPMU_Details add Vertical nvarchar(50)

update CCS_DPMU_Details set Vertical=a.Vertical
from (select * from DPMU_Vertical_Master)a
where CCS_DPMU_Details.PRODUCT_GROUP=a.ProductSubGroup


--update CCS_DPMU_Details set Country=a.Country,Region=a.Region,TO_BE_MAPPED_AS=a.TO_BE_MAPPED_AS
--from (select * from DPMU_Country_Master)a
--where CCS_DPMU_Details.ENTITY=a.name

--select * from DPMU_Part_Master

--Alter table CCS_DPMU_Details add Country nvarchar(25)
--Alter table CCS_DPMU_Details add Region nvarchar(25)
--Alter table CCS_DPMU_Details add TO_BE_MAPPED_AS nvarchar(25)


--Select distinct Productgroup1 from Productgroup_Master_from_QualityTeam
--Truncate table DPMU_Details
--Insert into DPMU_Details(FABNO,COMPANY,TTYP,INVN,AREA,AreaName,DPST,
--item,Item_desc,Invoice_date,Invqty,Inv_amount,Total_inv,Months_after_Dispatch,
--Warrantyperiod,WarrantyType,
--Productgroup1,Productgroup2,Trackno,Log_Date,Rnk1,Rnk2,Calyear,Calmonth,Finyear,Finmonth)
----Select * into DPMU_Details from(
--select * from (
--select 
--a.FABNO,COMPANY,a.TTYP,a.INVN,a.AREA,a.AreaName,a.DPST,
--a.item,a.Item_desc,a.Invoice_date,a.Invqty,a.Inv_amount,a.Total_inv,
--a.Months_after_Dispatch,a.Warrantyperiod,
----Method1
--a.WarrantyType,
----Method2
----case when a.Warrantyperiod-datediff(mm,a.Invoice_date,b.Log_Date)>0  then 'Within_Warranty'
----else 'Outof_Warranty' end as WarrantyType,
--a.Productgroup1,a.Productgroup2,
--b.Trackno,b.Log_Date,
--row_number() over(partition by a.fabno order by a.fabno,b.trackno) as Rnk1,
--row_number() over(partition by a.fabno,b.trackno order by a.fabno,b.trackno) as Rnk2,
--a.Calyear,a.Calmonth,a.Finyear,a.Finmonth
--from(
--select * from (
--select a.FABNO,COMPANY,ttyp,invn,area,AreaName,DPST,
--a.item,a.Item_desc,a.Invoice_date,a.Invqty,a.Inv_amount,a.Total_inv,
--datediff(mm,a.Invoice_date,getdate()-1) as Months_after_Dispatch ,b.Warrantyperiod,
--case when b.Warrantyperiod-datediff(mm,a.Invoice_date,getdate()-1)>0  then 'Within_Warranty'
--else 'Outof_Warranty' end as WarrantyType,
--b.Productgroup1,b.Productgroup2,a.Calyear,a.Calmonth,a.Finyear,a.Finmonth
--from Dispatch_Details a
--left outer join Productgroup_Master_from_QualityTeam b
--on ltrim(rtrim(a.item))=ltrim(rtrim(b.TPL))
--where --a.FABNO='AQHS040771' and
--b.remarks='To be considered'
--)ab
--where WarrantyType='Within_Warranty'
--)a
--left outer join
--(Select a.Fabno,a.Trackno,a.Log_Date
----,a.TplCode,a.Tpl_Desc,
----b.Productgroup1,b.Productgroup2,b.Warrantyperiod 
--from CCS_DPMU_Details a
----left outer join Productgroup_Master_from_QualityTeam b
----on ltrim(rtrim(a.TplCode))=ltrim(rtrim(b.TPL))
--where a.Log_Date is not null
----and fabno='BQFS031160'
--)b
--on a.FABNO=b.Fabno
--)a
----where WarrantyType='Within_Warranty'


--Method2
--Truncate table DPMU_Details
Insert into DPMU_Details(FABNO,COMPANY,TTYP,INVN,AREA,AreaName,DPST,
item,Item_desc,Invoice_date,Invqty,Inv_amount,Total_inv,Months_after_Dispatch,
Warrantyperiod,--WarrantyType,
Productgroup1,Productgroup2,
--,Trackno,Log_Date,Rnk1,Rnk2,
Calyear,Calmonth,Finyear,Finmonth
)
select * from (
select a.FABNO,COMPANY,ttyp,invn,area,AreaName,DPST,
a.item,a.Item_desc,a.Invoice_date,a.Invqty,a.Inv_amount,a.Total_inv,
datediff(mm,a.Invoice_date,getdate()-1) as Months_after_Dispatch ,b.Warrantyperiod,
--case when b.Warrantyperiod-datediff(mm,a.Invoice_date,getdate()-1)>0  then 'Within_Warranty'
--else 'Outof_Warranty' end as WarrantyType,
b.Productgroup1,b.Productgroup2,
a.Calyear,a.Calmonth,a.Finyear,a.Finmonth
from [ELGI_LN].dbo.Dispatch_Details a
left outer join Productgroup_Master_from_QualityTeam b
on ltrim(rtrim(a.item))=ltrim(rtrim(b.TPL))
where --a.FABNO='221E1247' and--'AQHS040771' 
b.remarks='Consider both Nr & Dr'
)ab
--where WarrantyType='Within_Warranty'

--Alter table DPMU_Details alter column FABNO nvarchar(400) null
Insert into DPMU_Details(
FABNO,--COMPANY,TTYP,INVN,AREA,AreaName,DPST,
item,Item_desc,--Invoice_date,Invqty,Inv_amount,Total_inv,Months_after_Dispatch,
--WarrantyType,
Trackno,Log_Date,
Productgroup1,Productgroup2,Warrantyperiod
--,Rnk1,Rnk2,Calyear,Calmonth,Finyear,Finmonth
)
Select a.Fabno,a.TplCode,a.Tpl_Desc,
Trackno,a.Log_Date,
b.Productgroup1,b.Productgroup2,b.Warrantyperiod 
from CCS_DPMU_Details a
left outer join Productgroup_Master_from_QualityTeam b
on ltrim(rtrim(a.TplCode))=ltrim(rtrim(b.TPL))
where a.Log_Date is not null
and b.remarks in ('Consider both Nr & Dr','Consider for Nr alone')
and a.fabno is not null
--and fabno='BQFS031160'

Update DPMU_Details set Trackno=ltrim(rtrim(Trackno))


Update DPMU_Details set area=null where ltrim(rtrim(area))=''
Update DPMU_Details set areaname=null where ltrim(rtrim(areaname))= ''


--select * from Productgroup_Master_from_QualityTeam where ltrim(rtrim(tpl))= 'S12102'

--update DPMU_Details set item
--select distinct fabno,item,item_desc from DPMU_Details
--order by fabno


update DPMU_Details set area=a.area
from (select distinct area,areaname from DPMU_Details where area is not null
and areaname is not null
)a
where DPMU_Details.areaname=a.areaname


update DPMU_Details set area=a.areacode
from (select * from [ELGi_LN].dbo.vw_area_master)a
where DPMU_Details.areaname=a.areaname
and DPMU_Details.area is null

update DPMU_Details set area=a.area,areaname=a.areaname
from (select * from DPMU_details where Fabno is not null and area is not null and areaname is not null)a
where DPMU_Details.fabno=a.fabno
and DPMU_Details.area is null


update DPMU_Details set invoice_date=a.invoice_date
from (select distinct Fabno,Invoice_date from DPMU_Details where Invoice_date is not null)a
where DPMU_Details.Fabno=a.Fabno
and DPMU_Details.invoice_date is null

update DPMU_Country_Master set Area=concat(0,area) where len(area)=2

update DPMU_Details set Country=a.Country,Region=a.Region,TO_BE_MAPPED_AS=a.TO_BE_MAPPED_AS
from (select * from DPMU_Country_Master)a
where DPMU_Details.AREA=a.Area

update DPMU_Details set Invqty=null,Inv_amount=null,Total_inv=null where Rnk1>1

--Update DPMU_Details set Calyear=year(coalesce(Invoice_date,log_date))
--Update DPMU_Details set CalMonth=Month(coalesce(Invoice_date,log_date))

Update DPMU_Details set Calyear=year(Invoice_date) where trackno is null
Update DPMU_Details set CalMonth=month(Invoice_date) where trackno is null

Update DPMU_Details set Calyear=year(log_date) where trackno is not null
Update DPMU_Details set CalMonth=month(log_date) where trackno is not null

update DPMU_Details set Finyear=CalYear-1 where CalMonth<4
update DPMU_Details set Finyear=CalYear where CalMonth>=4

update DPMU_Details set FinMonth=CalMonth+9 where CalMonth<4
update DPMU_Details set FinMonth=CalMonth-3 where CalMonth>=4

update DPMU_Details set Finperiod=concat(finyear,RIGHT('00'+CAST(FinMonth AS VARCHAR(2)),2))
update DPMU_Details set FinperiodName=concat(substring(datename(mm,dateadd(mm,Calmonth,-1)),1,3),'-',substring(convert(varchar,Calyear),3,2))


Update DPMU_Details set warrantyType='Within_Warranty' where 
Warrantyperiod-datediff(mm,Invoice_date,getdate()-1)>=0 --and trackno is null 
Update DPMU_Details set warrantyType='Outof_Warranty' where
Warrantyperiod-datediff(mm,Invoice_date,getdate()-1)<0 --and trackno is null 


--Old Method
--Update DPMU_Details set warrantyType='Within_Warranty' where
--Warrantyperiod-datediff(mm,Invoice_date,log_date)>=0 and trackno is not null 
--Update DPMU_Details set warrantyType='Outof_Warranty' where
--Warrantyperiod-datediff(mm,Invoice_date,log_date)<0 and trackno is not null 

delete from DPMU_Details where warrantyType='Outof_Warranty'



Truncate table DPMU_Details_Temp
Insert into DPMU_Details_Temp(FABNO,COMPANY,TTYP,INVN,AREA,AreaName,DPST,item,Item_desc,
Invoice_date,Invqty,Inv_amount,Total_inv,Months_after_Dispatch,Warrantyperiod,WarrantyType,
Productgroup1,Productgroup2,Trackno,Log_Date,Rnk1,Rnk2,Country,Region,TO_BE_MAPPED_AS,
Calyear,CalMonth,Finyear,FinMonth,Finperiod,FinperiodName,Fabno2,FabnoRnk)
select FABNO,COMPANY,TTYP,INVN,AREA,AreaName,DPST,item,Item_desc,
Invoice_date,Invqty,Inv_amount,Total_inv,Months_after_Dispatch,Warrantyperiod,WarrantyType,
Productgroup1,Productgroup2,Trackno,Log_Date,Rnk1,Rnk2,Country,Region,TO_BE_MAPPED_AS,
Calyear,CalMonth,Finyear,FinMonth,Finperiod,FinperiodName,Fabno2,FabnoRnk from DPMU_Details


Truncate table DPMU_Details
Insert into DPMU_Details(FABNO,COMPANY,TTYP,INVN,AREA,AreaName,DPST,item,Item_desc,
Invoice_date,Invqty,Inv_amount,Total_inv,Months_after_Dispatch,Warrantyperiod,WarrantyType,
Productgroup1,Productgroup2,Trackno,Log_Date,Rnk1,Rnk2,Country,Region,TO_BE_MAPPED_AS,
Calyear,CalMonth,Finyear,FinMonth,Finperiod,FinperiodName,Fabno2,FabnoRnk)
select FABNO,COMPANY,TTYP,INVN,AREA,AreaName,DPST,item,Item_desc,
Invoice_date,Invqty,Inv_amount,Total_inv,Months_after_Dispatch,Warrantyperiod,WarrantyType,
Productgroup1,Productgroup2,Trackno,Log_Date,Rnk1,Rnk2,Country,Region,TO_BE_MAPPED_AS,
Calyear,CalMonth,Finyear,FinMonth,Finperiod,FinperiodName,
FABNO,ROW_NUMBER() over(Partition by TO_BE_MAPPED_AS,FABNO order by FABNO) from DPMU_Details_Temp

--OWHS041747 --> Fabno Reflecting in two different verticals


Truncate Table DPMU_Details_Temp


update DPMU_Details set Fabno2=null where FabnoRnk>1

--Alter table DPMU_Details add Finperiod varchar(20)
--Alter table DPMU_Details add FinperiodName varchar(20)
--Alter table DPMU_Details add Fabno2 Varchar(50)

--select TO_BE_MAPPED_AS,Region,Country,Productgroup1,Productgroup2,
--Finyear,Finmonth,
--count(distinct FABNO) Fabno_Counts
--from DPMU_Details
--group by TO_BE_MAPPED_AS,Region,Country,Productgroup1,Productgroup2,
--Finyear,Finmonth


Truncate table DPMU_Cumulative

Insert into DPMU_Cumulative(TO_BE_MAPPED_AS,Productgroup1,Productgroup2,Finyear,Finmonth,
Calyear,CalMonth,Finperiod,FinperiodName,Fabno_counts,Trackno_counts,Fabno_Counts_Cum,
Trackno_counts_Cum,Fabno_Counts_Cum2,Trackno_counts_Cum2,Fabno_Counts_Cum3,Trackno_counts_Cum3)
--select * into DPMU_Cumulative from (
select *,
sum( Fabno_counts) over (partition by TO_BE_MAPPED_AS
--Region,Country,Productgroup1,Productgroup2 
order by Finperiod
rows between UNBOUNDED PRECEDING and CURRENT ROW) as Fabno_Counts_Cum,
sum( Trackno_counts) over (partition by TO_BE_MAPPED_AS
--,Region,Country,Productgroup1,Productgroup2 
order by Finperiod
rows between UNBOUNDED PRECEDING and CURRENT ROW) as Trackno_counts_Cum,

sum( Fabno_counts) over (partition by TO_BE_MAPPED_AS,
--Region,Country,
Productgroup1--,Productgroup2 
order by Finperiod
rows between UNBOUNDED PRECEDING and CURRENT ROW) as Fabno_Counts_Cum2,
sum( Trackno_counts) over (partition by TO_BE_MAPPED_AS,
--,Region,Country,
Productgroup1--,Productgroup2 
order by Finperiod
rows between UNBOUNDED PRECEDING and CURRENT ROW) as Trackno_counts_Cum2,


sum( Fabno_counts) over (partition by TO_BE_MAPPED_AS,
--Region,Country,
Productgroup1,Productgroup2 
order by Finperiod
rows between UNBOUNDED PRECEDING and CURRENT ROW) as Fabno_Counts_Cum3,
sum( Trackno_counts) over (partition by TO_BE_MAPPED_AS,
--,Region,Country,
Productgroup1,Productgroup2 
order by Finperiod
rows between UNBOUNDED PRECEDING and CURRENT ROW) as Trackno_counts_Cum3

from
(select TO_BE_MAPPED_AS,--Region,Country,
Productgroup1,Productgroup2,
Finyear,Finmonth,Calyear,CalMonth,Finperiod,FinperiodName,
count(distinct Fabno2) as Fabno_counts,
count(distinct trackno) as Trackno_counts
from (select *
--,case when trackno is not null then null else fabno end as fabno2
from DPMU_Details)a
--where TO_BE_MAPPED_AS in --('Brazil')
--(@Vertical)
--where productgroup2='DPSAC-C&M'
--and to_be_mapped_as='Brazil'
--and finyear=2021
group by TO_BE_MAPPED_AS,--Region,Country,
Productgroup1,Productgroup2,
Finyear,Finmonth,Calyear,CalMonth,Finperiod,FinperiodName)a
order by finperiod,Productgroup1,Productgroup2
--)a


end





Select distinct Trackno,item,Item_desc,a.Productgroup1,a.Productgroup2,WarrantyType,b.Remarks from DPMU_Details a
left outer join Productgroup_Master_from_QualityTeam b
on ltrim(rtrim(a.item))=ltrim(rtrim(b.TPL))
where a.Trackno is not null
--where trackno='CC-00511482'
--where FABNO in ('OSCS037327','UUIS036413','UVJC374109')
--where trackno in ('274M02803','264M00095','299N00155')
--where Focno is not null

select * from CCS_DPMU_Details
where trackno='CC-00511482'

--select * from DPMU_Details
--where --to_be_mapped_as is null
--fabno='BPHS030490'
--productgroup2='DPSAC-C&M'
--and to_be_mapped_as='Brazil'
--and finyear=2021

GO

