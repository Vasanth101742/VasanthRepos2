--exec sp_CallsRegister_CRM

CREATE proc [dbo].[sp_CallsRegister_CRM] as
begin


Truncate table Monthly_Calls_Register_CRM
Truncate table Daily_Calls_Register_CRM
Truncate table Yearly_Calls_Register_CRM
Truncate table Monthly_CSI_Register_CRM
Truncate table Open_Complaint_Calls_CRM
--Truncate table [Yearly_Calls_Register_CRM_DATA]


insert into Monthly_Calls_Register_CRM(call_tracking_number,customer,caller_name,commissioning_date,
obligation,call_logged_date,FVRD,ACD,HO_CC_CLOSURE_DT_TIME,TTR,TOTALTTR,service_eng_comment,Assigned_to,
Service_eng_Name,SE_contact_no,Origin,Call_loggedby,Call_createdby,calltype,reasonfor_delay,why_analysis,
actiontake_SE,actiontake_ASM,actiontake_RM,Owner,CallClosed_by,parentcall,msdyn_reportedbycontact,
msdyn_customerasset,Call_status,msdyn_serviceaccount,msdyn_workorderid,ownerid,mobilephone,product_group,
Product_model,Product_subgroup,vertical,Fabrication,elgi_keycustomername,Symptom,Description,
complaintidentified,fix,elgi_focnumber,elgi_foctypename,elgi_foccategoryname,zone,Branch,elgi_repeatreason,
elgi_repeatreasoncategoryname,elgi_repeatrepairname,elgi_callhmr,elgi_discussionpoint,elgi_workdoneonvisit,
msdyn_timeclosed)

select call_tracking_number,customer,caller_name,elgi_commissioningdate,
obligation,call_logged_date,FVRD,ACD,HO_CC_CLOSURE_DT_TIME,TTR,TOTALTTR,service_eng_comment,Assigned_to,
Service_eng_Name,SE_contact_no,Origin,Call_loggedby,Call_createdby,calltype,
elgi_reasonofdelayttrname,why_analysis,
actiontake_SE,asactiontake_ASM,actiontake_RM,Owner,CallClosed_by,parentcall,msdyn_reportedbycontact,
msdyn_customerasset,Call_status,msdyn_serviceaccount,msdyn_workorderid,ownerid,mobilephone,product_group,
Product_model,Product_subgroup,vertical,Fabrication,elgi_keycustomername,Symptom,Description,
complaintidentified,fix,elgi_focnumber,elgi_foctypename,elgi_foccategoryname,zone,Branch,elgi_repeatreason,
elgi_repeatreasoncategoryname,elgi_repeatrepairname,elgi_callhmr,elgi_discussionpoint,elgi_workdoneonvisit, 
msdyn_timeclosed
From (
select a.*
,b.mobilephone,
c.product_group,c.Product_model ,c.Product_subgroup,
c.vertical,
c.Fabrication,
d.elgi_keycustomername,
e.Symptom,e.Description,e.complaintidentified,e.fix
,f.elgi_focnumber,f.elgi_foctypename,
f.elgi_foccategoryname,
g.zone,g.Branch,
h.elgi_workdoneonvisit,h.elgi_discussionpoint 

From (

select msdyn_name as call_tracking_number,msdyn_serviceaccountname as customer,
msdyn_reportedbycontactname as caller_name,elgi_commissioningdate,
elgi_obligationwarrantyname as obligation, createdon as call_logged_date,
elgi_bookingdatetime as FVRD,msdyn_timefrompromised as ACD,
msdyn_timeclosed as HO_CC_CLOSURE_DT_TIME,elgi_actualttrinhrs as TTR,elgi_overduehours as TOTALTTR,
elgi_serviceengineercomments as service_eng_comment,elgi_assigneddealername as Assigned_to,
elgi_dealeremployeename as Service_eng_Name,elgi_serviceengineercontactnumber as SE_contact_no,
elgi_origin1name as Origin, 
createdbyname as Call_loggedby, --TobeCorrected
elgi_callcreatedby as Call_createdby, msdyn_workordertypename as calltype,
elgi_reasonofdelayttrname as elgi_reasonofdelayttrname, --TobeCorrected 
elgi_whyanalysis as  why_analysis, --TobeCorrected
elgi_reasonforttr48hrselgise as actiontake_SE, --TobeCorrected
elgi_reasonforttr48hrsasm asactiontake_ASM, --TobeCorrected
elgi_reasonforttr48hrsrsm as actiontake_RM, --TobeCorrected
owneridname as Owner,elgi_callclosedbyname as CallClosed_by,
elgi_parentcallname as parentcall,msdyn_reportedbycontact,
msdyn_customerasset,statuscodename as Call_status, 
msdyn_serviceaccount,msdyn_workorderid,ownerid,
elgi_repeatreason,elgi_repeatreasoncategoryname,
elgi_repeatrepairname,elgi_callhmr,
msdyn_timeclosed
From MSDYN_WORKORDER_CRM 
where 
msdyn_workordertypename is not null
and year(msdyn_timeclosed)=year(getdate()-1)
and month(msdyn_timeclosed)=month(getdate()-4)
)a

left join (select contactid,mobilephone  from Contact_CRM)b
on a.msdyn_reportedbycontact=b.contactid

left join(select msdyn_productname as Product_model,elgi_productgroupname as product_group,
elgi_productsubgroupname as Product_subgroup,
elgi_verticalname as vertical,
msdyn_customerassetid,msdyn_name as Fabrication
from msdyn_customerasset_CRM)c
on a.msdyn_customerasset=c.msdyn_customerassetid

left join(select distinct elgi_keycustomername,
accountid From Account_CRM)d
on a.msdyn_serviceaccount=d.accountid 

left join(select msdyn_name as Symptom,msdyn_description as Description,
elgi_complaintidentified as complaintidentified,elgi_fix as fix,
msdyn_workorder From msdyn_workorderincident_CRM where elgi_status ='100000001'
and (elgi_complaintidentified is not null) and (elgi_fix is not null))e
on a.msdyn_workorderid=e.msdyn_workorder

left join(select elgi_focnumber,elgi_foctypename,
elgi_foccategoryname,elgi_workorderid 
From elgi_foc_CRM
where statuscodename ='Approved')f
on a.msdyn_workorderid=f.elgi_workorderid

left join (select territoryidname as zone,businessunitidname as Branch,systemuserid  
From systemuser_CRM )g
on a.ownerid  = g.systemuserid

left join (select msdyn_workorder,modifiedon,elgi_workdoneonvisit,elgi_discussionpoint 
from bookableresourcebooking_CRM a 
where createdon=(select max(createdon) from bookableresourcebooking_CRM b
where a.msdyn_workorder=b.msdyn_workorder)
)h
on a.msdyn_workorderid=h.msdyn_workorder

)a

--where call_tracking_number in ('cc-00850368','cc-00817311','cc-00852016','cc-00851895','cc-00838260','cc-00838249')

--where convert(date,HO_CC_CLOSURE_DT_TIME) between
--'09-01-2020' and '09-30-2020'
--order by HO_CC_CLOSURE_DT_TIME desc

select * from Daily_Calls_Register_CRM

Insert into Daily_Calls_Register_CRM(call_tracking_number,customer,caller_name,commissioning_date,
obligation,call_logged_date,FVRD,ACD,HO_CC_CLOSURE_DT_TIME,TTR,TOTALTTR,service_eng_comment,Assigned_to,
Service_eng_Name,SE_contact_no,Origin,Call_loggedby,Call_createdby,calltype,reasonfor_delay,why_analysis,
actiontake_SE,--actiontake_ASM,
actiontake_RM,Owner,CallClosed_by,parentcall,msdyn_reportedbycontact,
msdyn_customerasset,Call_status,msdyn_serviceaccount,msdyn_workorderid,ownerid,mobilephone,product_group,
Product_model,Product_subgroup,vertical,Fabrication,elgi_keycustomername,Symptom,Description,
complaintidentified,fix,elgi_focnumber,elgi_foctypename,elgi_foccategoryname,zone,Branch,elgi_repeatreason,
elgi_repeatreasoncategoryname,elgi_repeatrepairname,elgi_callhmr,elgi_discussionpoint,elgi_workdoneonvisit,
msdyn_timeclosed)
select call_tracking_number,customer,caller_name,commissioning_date,
obligation,call_logged_date,FVRD,ACD,HO_CC_CLOSURE_DT_TIME,TTR,TOTALTTR,service_eng_comment,Assigned_to,
Service_eng_Name,SE_contact_no,Origin,Call_loggedby,Call_createdby,calltype,reasonfor_delay,why_analysis,
actiontake_SE,--actiontake_ASM,
actiontake_RM,Owner,CallClosed_by,parentcall,msdyn_reportedbycontact,
msdyn_customerasset,Call_status,msdyn_serviceaccount,msdyn_workorderid,ownerid,mobilephone,product_group,
Product_model,Product_subgroup,vertical,Fabrication,elgi_keycustomername,Symptom,Description,
complaintidentified,fix,elgi_focnumber,elgi_foctypename,elgi_foccategoryname,zone,Branch,elgi_repeatreason,
elgi_repeatreasoncategoryname,elgi_repeatrepairname,elgi_callhmr,elgi_discussionpoint,elgi_workdoneonvisit,
msdyn_timeclosed from Monthly_Calls_Register_CRM
where convert(date,msdyn_timeclosed) between (convert(date,getdate()-8)) and (convert(date,getdate()-1))


-----------------------------------------------------------------------------------------------------------------------------



insert into Yearly_Calls_Register_CRM (call_tracking_number,customer,caller_name,commissioning_date,obligation,
call_logged_date,FVRD,ACD,HO_CC_CLOSURE_DT_TIME,TTR,TOTALTTR,service_eng_comment,Assigned_to,Service_eng_Name,
SE_contact_no,Origin,Call_loggedby,Call_createdby,calltype,reasonfor_delay,why_analysis,actiontake_SE,actiontake_ASM,
actiontake_RM,Owner,CallClosed_by,parentcall,msdyn_reportedbycontact,msdyn_customerasset,Call_status,msdyn_serviceaccount,
msdyn_workorderid,ownerid,mobilephone,product_group,Product_model,Product_subgroup,vertical,Fabrication,elgi_keycustomername,
Symptom,Description,complaintidentified,fix,elgi_focnumber,elgi_foctypename,elgi_foccategoryname,zone,Branch,elgi_repeatreason,
elgi_repeatreasoncategoryname,elgi_repeatrepairname,elgi_callhmr,elgi_discussionpoint,elgi_workdoneonvisit, 
msdyn_timeclosed,asactiontake_ASM,elgi_eligibleforserviceclaim,elgi_complaintdueto
,[elgi_rcarequiredname],[elgi_tpldescription],[elgi_dateofinvoice]
)
select 
call_tracking_number,customer,caller_name,elgi_commissioningdate,obligation,
call_logged_date,FVRD,ACD,HO_CC_CLOSURE_DT_TIME,TTR,TOTALTTR,service_eng_comment,Assigned_to,Service_eng_Name,
SE_contact_no,Origin,Call_loggedby,Call_createdby,calltype,elgi_reasonofdelayttrname,why_analysis,actiontake_SE,actiontake_ASM,
actiontake_RM,Owner,CallClosed_by,parentcall,msdyn_reportedbycontact,msdyn_customerasset,Call_status,msdyn_serviceaccount,
msdyn_workorderid,ownerid,mobilephone,product_group,Product_model,Product_subgroup,vertical,Fabrication,elgi_keycustomername,
Symptom,Description,complaintidentified,fix,elgi_focnumber,elgi_foctypename,elgi_foccategoryname,zone,Branch,elgi_repeatreason,
elgi_repeatreasoncategoryname,elgi_repeatrepairname,elgi_callhmr,elgi_discussionpoint,elgi_workdoneonvisit, 
msdyn_timeclosed,asactiontake_ASM,elgi_eligibleforserviceclaim,elgi_complaintdueto,elgi_rcarequired,elgi_tpldescription,elgi_dateofinvoice

From (
select a.*
,b.mobilephone
,c.product_group,c.Product_model ,c.Product_subgroup,c.vertical,c.Fabrication
,d.elgi_keycustomername
,e.Symptom,e.Description,e.complaintidentified,e.fix
,f.elgi_focnumber,f.elgi_foctypename,f.elgi_foccategoryname
,g.zone,g.Branch 
,h.elgi_workdoneonvisit,h.elgi_discussionpoint ,elgi_tpldescription,elgi_dateofinvoice
From (

select msdyn_name as call_tracking_number,msdyn_serviceaccountname as customer,msdyn_reportedbycontactname as caller_name,
elgi_commissioningdate,
elgi_obligationwarrantyname as obligation,
createdon as call_logged_date,elgi_bookingdatetime as FVRD,
msdyn_timefrompromised as ACD,msdyn_timeclosed as HO_CC_CLOSURE_DT_TIME,
elgi_actualttrinhrs as TTR,elgi_overduehours as TOTALTTR,elgi_serviceengineercomments as service_eng_comment,
elgi_assigneddealername as Assigned_to,elgi_dealeremployeename as Service_eng_Name,elgi_serviceengineercontactnumber as SE_contact_no,
elgi_origin1name as Origin, createdbyname as Call_loggedby,elgi_callcreatedby as Call_createdby, msdyn_workordertypename as calltype,
elgi_reasonofdelayttrname as elgi_reasonofdelayttrname, -- as reasonfor_delay, TobeCorrected 
elgi_whyanalysis as  why_analysis,elgi_reasonforttr48hrselgise as actiontake_SE,
elgi_reasonforttr48hrsasm as actiontake_ASM,elgi_reasonforttr48hrsrsm as actiontake_RM,owneridname as Owner,
elgi_callclosedbyname as CallClosed_by,elgi_parentcallname as parentcall,msdyn_reportedbycontact,msdyn_customerasset,
statuscodename as Call_status,msdyn_serviceaccount,msdyn_workorderid,ownerid,elgi_repeatreason,
elgi_repeatreasoncategoryname, elgi_repeatrepairname,elgi_callhmr,
msdyn_timeclosed ,
elgi_reasonforttr48hrsasm asactiontake_ASM --TobeCorrected
,elgi_eligibleforserviceclaim,elgi_complaintdueto,elgi_rcarequired--,elgi_tpldescription,elgi_dateofinvoice,elgi_complaintduetoname
From msdyn_workorder_CRM 
--where convert(date,msdyn_timeclosed) between convert(date,dateadd(m,-1,getdate())) and convert(date,getdate()-1)
--'08-01-2021' and '08-31-2021'
)a

left join (select mobilephone,contactid  from Contact_CRM)b
on a.msdyn_reportedbycontact=b.contactid

left join(select msdyn_productname as Product_model,elgi_productgroupname as product_group,
elgi_productsubgroupname as Product_subgroup,
elgi_verticalname as vertical,msdyn_customerassetid,msdyn_name as Fabrication ,elgi_tpldescription,elgi_dateofinvoice
from msdyn_customerasset_CRM)c
on a.msdyn_customerasset=c.msdyn_customerassetid

left join(select distinct elgi_keycustomername,accountid From Account_CRM)d
on a.msdyn_serviceaccount=d.accountid 

left join(select msdyn_name as Symptom,msdyn_description as Description,
elgi_complaintidentified as complaintidentified,elgi_fix as fix,
msdyn_workorder From msdyn_workorderincident_CRM where elgi_status ='100000001'
and (elgi_complaintidentified is not null) and (elgi_fix is not null))e
on a.msdyn_workorderid=e.msdyn_workorder

left join(select elgi_focnumber,elgi_foctypename,elgi_foccategoryname,elgi_workorderid 
From elgi_foc_CRM where statuscodename ='Approved')f
on a.msdyn_workorderid=f.elgi_workorderid

left join (select territoryidname as zone,businessunitidname as Branch,systemuserid  
From systemuser_CRM )g
on a.ownerid  = g.systemuserid

left join (select msdyn_workorder,modifiedon,elgi_workdoneonvisit,elgi_discussionpoint 
from bookableresourcebooking_CRM a 
where createdon=(select max(createdon) from bookableresourcebooking_CRM b
where a.msdyn_workorder=b.msdyn_workorder)
)h
on a.msdyn_workorderid=h.msdyn_workorder

)a
--where convert(date,HO_CC_CLOSURE_DT_TIME) between
--'09-01-2020' and '09-30-2020'
--order by HO_CC_CLOSURE_DT_TIME desc






----------------------------------------------------------------------------------------------------------------------


insert into Monthly_CSI_register_CRM(call_tracking_number,customer,caller_name,commissioning_date,obligation,
call_logged_date,FVRD,ACD,HO_CC_CLOSURE_DT_TIME,TTR,TOTALTTR,service_eng_comment,Assigned_to,Service_eng_Name,SE_contact_no,
Origin,Call_loggedby,Call_createdby,calltype,reasonfor_delay,why_analysis,actiontake_SE,actiontake_ASM,actiontake_RM,
Owner,CallClosed_by,parentcall,msdyn_reportedbycontact,msdyn_customerasset,Call_status,msdyn_serviceaccount,msdyn_workorderid,
ownerid,mobilephone,product_group,Product_model,Product_subgroup,vertical,Fabrication,elgi_keycustomername,Symptom,
Description,complaintidentified,fix,elgi_focnumber,elgi_foctypename,elgi_foccategoryname,zone,Branch,elgi_workorderid,
elgi_customersatisfiedname,elgi_feedbacktitle,elgi_score,elgi_areyouawareaboutelgicustomercarenewname,
elgi_yourexperienceonresponsetimenewname,elgi_yourexperienceonpartsavailabilitynewname,elgi_yourexperienceonqualityofresolutionnewname,
elgi_feedbackvoc,elgi_asmremarks,elgi_rsmremarks,elgi_hoccremarks,createdon,elgi_feedbacktakenbyname)

select call_tracking_number,customer,caller_name,commissioning_date,obligation,
call_logged_date,FVRD,ACD,HO_CC_CLOSURE_DT_TIME,TTR,TOTALTTR,service_eng_comment,Assigned_to,Service_eng_Name,SE_contact_no,
Origin,Call_loggedby,Call_createdby,calltype,
elgi_reasonofdelayttrname,
why_analysis,actiontake_SE,asactiontake_ASM,actiontake_RM,
Owner,CallClosed_by,parentcall,msdyn_reportedbycontact,msdyn_customerasset,Call_status,msdyn_serviceaccount,msdyn_workorderid,
ownerid,mobilephone,product_group,Product_model,Product_subgroup,vertical,Fabrication,elgi_keycustomername,Symptom,
Description,complaintidentified,fix,elgi_focnumber,elgi_foctypename,elgi_foccategoryname,zone,Branch,msdyn_workorderid,
elgi_customersatisfiedname,elgi_feedbacktitle,elgi_score,elgi_areyouawareaboutelgicustomercarenewname,
elgi_yourexperienceonresponsetimenewname,elgi_yourexperienceonpartsavailabilitynewname,elgi_yourexperienceonqualityofresolutionnewname,
elgi_feedbackvoc,elgi_asmremarks,elgi_rsmremarks,elgi_hoccremarks,createdon,elgi_feedbacktakenbyname
 From (
select a.*
,b.mobilephone
,c.product_group,c.Product_model ,c.Product_subgroup,c.vertical,c.Fabrication
,d.elgi_keycustomername
,e.Symptom,e.Description,e.complaintidentified,e.fix
,f.elgi_focnumber,f.elgi_foctypename,f.elgi_foccategoryname
,g.zone,g.Branch 
,h.*

From (

select msdyn_name as call_tracking_number,msdyn_serviceaccountname as customer,msdyn_reportedbycontactname as caller_name,
elgi_commissioningdate  as commissioning_date,
elgi_obligationwarrantyname as obligation,
createdon as call_logged_date,
elgi_bookingdatetime as FVRD,
msdyn_timefrompromised as ACD,
msdyn_timeclosed as HO_CC_CLOSURE_DT_TIME,
elgi_actualttrinhrs as TTR,elgi_overduehours as TOTALTTR,elgi_serviceengineercomments as service_eng_comment,
elgi_assigneddealername as Assigned_to,elgi_dealeremployeename as Service_eng_Name,elgi_serviceengineercontactnumber as SE_contact_no,
elgi_origin1name as Origin, createdbyname as Call_loggedby,elgi_callcreatedby as Call_createdby, msdyn_workordertypename as calltype,
elgi_reasonofdelayttrname as elgi_reasonofdelayttrname, -- as reasonfor_delay, TobeCorrected 
elgi_whyanalysis as  why_analysis,elgi_reasonforttr48hrselgise as actiontake_SE,
elgi_reasonforttr48hrsasm asactiontake_ASM,elgi_reasonforttr48hrsrsm as actiontake_RM,owneridname as Owner,
elgi_callclosedbyname as CallClosed_by,elgi_parentcallname as parentcall,msdyn_reportedbycontact,msdyn_customerasset,
statuscodename as Call_status,msdyn_serviceaccount,msdyn_workorderid,ownerid   
From msdyn_workorder_CRM
where 
year(msdyn_timeclosed)=year(getdate()-1)
and month(msdyn_timeclosed)=month(getdate()-1)
--convert(date,msdyn_timeclosed) between
--'06/01/2022' and '06/30/2022'
--convert(date,dateadd(m,-1,getdate())) and convert(date,getdate()-1)
)a


left join (select mobilephone,contactid  from Contact_CRM)b
on a.msdyn_reportedbycontact=b.contactid

left join(select msdyn_productname as Product_model,elgi_productgroupname as product_group,
elgi_productsubgroupname as Product_subgroup,
elgi_verticalname as vertical,msdyn_customerassetid,msdyn_name as Fabrication
from msdyn_customerasset_CRM)c
on a.msdyn_customerasset=c.msdyn_customerassetid

left join(select distinct elgi_keycustomername,accountid From Account_CRM)d
on a.msdyn_serviceaccount=d.accountid 

left join(select msdyn_name as Symptom,msdyn_description as Description,
elgi_complaintidentified as complaintidentified,elgi_fix as fix,
msdyn_workorder From msdyn_workorderincident_CRM where elgi_status ='100000001'
and (elgi_complaintidentified is not null) and (elgi_fix is not null))e
on a.msdyn_workorderid=e.msdyn_workorder

left join(select elgi_focnumber,elgi_foctypename,elgi_foccategoryname,elgi_workorderid 
From elgi_foc_CRM where statuscodename ='Approved')f
on a.msdyn_workorderid=f.elgi_workorderid

left join (select distinct territoryidname as zone,businessunitidname as Branch,systemuserid  
From systemuser_CRM )g
on a.ownerid  = g.systemuserid

left join(select elgi_workorderid,elgi_customersatisfiedname,elgi_feedbacktitle,elgi_score,
elgi_areyouawareaboutelgicustomercarenewname,elgi_yourexperienceonresponsetimenewname,
elgi_yourexperienceonpartsavailabilitynewname,elgi_yourexperienceonqualityofresolutionnewname,
elgi_feedbackvoc,elgi_asmremarks,elgi_rsmremarks,elgi_hoccremarks,createdon,elgi_feedbacktakenbyname 
From  elgi_feedback_CRM where elgi_feedbacktypename='Customer Feedback on Complaint Resolution')h
on a.msdyn_workorderid = h.elgi_workorderid

)a
--where convert(date,HO_CC_CLOSURE_DT_TIME) between
--'09-01-2020' and '09-30-2020'
--order by HO_CC_CLOSURE_DT_TIME desc



insert into Open_Complaint_Calls_CRM(obligation,Owner,msdyn_customerasset,msdyn_workorderid,ownerid,
Symptom,Branch,Vertical,tracking_No,Customer,FabNo,Call_Logged_Date,First_visit_Date,Next_visit_Date,Over_Due_Hours,
Over_Due_Group,Dealer,Call_Type,Call_Status,Logged_By,Comm_date,service_engineer_comments,Product_Group,Product_Sub_group,
Product_Model,Zone)
select obligation,Owner,msdyn_customerasset,msdyn_workorderid,ownerid,
Symptom,Branch,Vertical,tracking_No,Customer,FabNo,Call_Logged_Date,First_visit_Date,Next_visit_Date,Over_Due_Hours,
Over_Due_Group,Dealer,Call_Type,Call_Status,Logged_By,Comm_date,service_engineer_comments,Product_Group,Product_Sub_group,
Product_Model,Zone
From (
select a.*,b.elgi_productgroupname as Product_Group,b.elgi_productsubgroupname as Product_Sub_group,b.msdyn_productname as Product_Model,c.territoryidname as Zone,c.businessunitidname as Branch,d.msdyn_name as Symptom   From (
select msdyn_customerasset,ownerid,msdyn_workorderid,
owneridname as Owner,elgi_verticalname as Vertical,msdyn_name as tracking_No,msdyn_serviceaccountname as Customer,msdyn_customerassetname as FabNo,createdon as Call_Logged_Date,
elgi_bookingdatetime as First_visit_Date,elgi_nextvisitdatetime as Next_visit_Date,elgi_ttrinhrsinlcusiveofddc as Over_Due_Hours,
case when elgi_ttrinhrsinlcusiveofddc<0 then 'Negative_Hours' when elgi_ttrinhrsinlcusiveofddc between 0 and 24 then '0-24' when elgi_ttrinhrsinlcusiveofddc between 25 and 48 then '25-48'
when elgi_ttrinhrsinlcusiveofddc between 49 and 72 then '49-72' when elgi_ttrinhrsinlcusiveofddc between 73 and 96 then '73-96'
when elgi_ttrinhrsinlcusiveofddc between 97 and 144 then '97-144' when elgi_ttrinhrsinlcusiveofddc>144 then 'Above144' end as Over_Due_Group,
elgi_assigneddealername as Dealer,msdyn_workordertypename as Call_Type,statuscodename as Call_Status,createdbyname as Logged_By,elgi_obligationamcname as obligation,
elgi_commissioningdate as Comm_date,elgi_serviceengineercomments as service_engineer_comments  
from  msdyn_workorder_CRM
where msdyn_workordertypename in ('Complaint - AMC','Complaint - Breakdown','Complaint - Running With Problem')
and statuscodename in ('Open - Assigned','Open - Clarification Required','Open - DDC','Open - DDE','Open - Issue Resolved By SE','Open - Pending for HO Closure','Open - Unassigned')
and elgi_verticalname not in ('Railways')
and convert(date,elgi_bookingdatetime)<convert(date,getdate())
and convert(date,elgi_nextvisitdatetime)<convert(date,getdate()))a
left join (select msdyn_customerassetid,msdyn_productname,elgi_productgroupname,elgi_productsubgroupname   
From msdyn_customerasset_CRM)b
on a.msdyn_customerasset=b.msdyn_customerassetid
left join (select  systemuserid,territoryidname,
case when businessunitidname like 'ELGi_After Market%' then replace(substring(businessunitidname,18,500),'Service','') 
 when businessunitidname like 'ELGi_C&M%' then substring(businessunitidname,9,500)
 when businessunitidname like 'ELGi_Ind%' then substring(businessunitidname,10,500) 
 when businessunitidname like 'ELGi_Portable AM%' then replace(substring(businessunitidname,18,500),'Service','') end as businessunitidname
 From systemuser_CRM)c
on a.ownerid  = c.systemuserid
left join (select msdyn_workorder,msdyn_name   From msdyn_workorderincident_CRM
where msdyn_name not like 'ACCESSORIES%'
and msdyn_name not like 'CAC%'
AND msdyn_name not like 'Default%'
AND msdyn_name not like 'DPSAC - SKID%'
AND msdyn_name not like 'DPSAC - TROLLEY%'

and msdyn_name not like 'ENCAP%'
AND msdyn_name not like 'EPSAC - SKID%'
AND msdyn_name not like 'EPSAC - TROLLEY%'
AND msdyn_name not like 'IND. RECIP%'

and msdyn_name not like 'LEPSAC%'
AND msdyn_name not like 'LG%'
AND msdyn_name not like 'OE%'
AND msdyn_name not like 'OFSAC%'


and msdyn_name not like 'RAILWAYS%'
AND msdyn_name not like 'SEPSAC%'
AND msdyn_name not like 'VAYU%'
AND msdyn_name not like 'Warranty Checklist%')d
on a.msdyn_workorderid=d.msdyn_workorder)a



update Monthly_Calls_Register_CRM set product_group='Blank' where product_group is null
update Monthly_Calls_Register_CRM set product_subgroup='Blank' where product_subgroup is null
update Monthly_Calls_Register_CRM set zone='Blank' where zone is null
update Monthly_Calls_Register_CRM set branch='Blank' where branch is null
update Monthly_Calls_Register_CRM set calltype='Blank' where calltype is null
update Monthly_Calls_Register_CRM set vertical='Blank' where vertical is null


update Yearly_Calls_Register_CRM set product_group='Blank' where product_group is null
update Yearly_Calls_Register_CRM set product_subgroup='Blank' where product_subgroup is null
update Yearly_Calls_Register_CRM set zone='Blank' where zone is null
update Yearly_Calls_Register_CRM set branch='Blank' where branch is null
update Yearly_Calls_Register_CRM set calltype='Blank' where calltype is null
update Yearly_Calls_Register_CRM set vertical='Blank' where vertical is null

end


--select * from yearly_calls_register_crm

GO

