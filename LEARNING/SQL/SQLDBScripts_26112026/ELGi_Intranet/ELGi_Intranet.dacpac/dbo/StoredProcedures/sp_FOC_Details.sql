--Exec sp_FOC_Details
CREATE proc sp_FOC_Details as
Begin

--Truncate table FOC_Details_From_LN
Truncate Table FOC_Details_Complete


--From CRM
Insert into FOC_Details_Complete(elgi_workorderid,
elgi_focnumber,elgi_foctypename,elgi_customer,
FOC_CreationDate,WO_CreationDate,workorderno,Fabno,Model,Product,CommissionDate,
SourceSystem
--,Symptom,ProblemIdentified,Fix,SE_Comments
)
select distinct convert(nvarchar(100),elgi_workorderid) elgi_workorderid,
elgi_focnumber,elgi_foctypename,elgi_customer,
--FOC_CreationDate, --Old Method
FOC_ModifiedDate,
WO_CreationDate,workorderno,Fabno,Model,Product,CommissionDate,
'CRM'
--,Symptom,ProblemIdentified,Fix,SE_Comments
--from [192.168.221.130].[LN_DEMO].dbo.CRM_FOC_Details 
from [ELGI_CRM].dbo.CRM_FOC_Details
--where elgi_focnumber='FOC-00012782'--'FOC-00017685'

---From CCS

Insert into FOC_Details_Complete(elgi_workorderid,
elgi_focnumber,elgi_foctypename,elgi_customer,
FOC_CreationDate,WO_CreationDate,workorderno,Fabno,Model,Product,CommissionDate,
SourceSystem,FinalApprovalDate
--,Symptom,ProblemIdentified,Fix,SE_Comments
)
select distinct null as elgi_workorderid,
focno,FOCType_Descr,null as elgi_customer,
FocDate,TrackCreationDate,ccstrackno,Fabno,pr_model,null,comm_date,'CCS',
FinalApprovalDate
--,Symptom,ProblemIdentified,Fix,SE_Comments
from CCS_FOC_Details
where focno not like '6%' --ATS FOCs
--where elgi_focnumber='FOC-00017685'


--From LN-----


insert into FOC_Details_Complete
(company,warehouse,SaleOrderType,OrderNo,
areacode,areaname,Item,Item_desc,trantype,Invoice,Invoice_Date,
custcode,custname,Currency,DeliveryQty,Sales_amount,Sales_USD,
Foreign_currency_amount,dpst,dpstname,
--Fin_year,Fin_month,cal_year,cal_Month,Monthname,
Organ,elgi_focnumber,SourceSystem)
--select * into FOC_Details_From_LN from(
select company,warehouse,SaleOrderType,OrderNo,areacode,areaname,
Item,Item_desc,trantype,Invoice,Invoice_Date,custcode,custname,Currency,
sum(DeliveryQty) DeliveryQty,
sum(case when Sales_amount=0 then UnitPrice*DeliveryQty else Sales_amount end) Sales_amount,
sum(Sales_USD) Sales_USD,sum(Foreign_currency_amount) Foreign_currency_amount,
dpst,dpstname,--Fin_year,Fin_month,cal_year,cal_Month,Monthname,
Organ,substring(indent,1,12) as indent,'LN'
from [ELGi_LN].dbo.ELGi_Sales_Details
where --sales_category in (1) and 
substring(indent,1,12) in (select distinct elgi_focnumber from FOC_Details_Complete)
group by company,warehouse,SaleOrderType,OrderNo,areacode,areaname,
Item,Item_desc,trantype,Invoice,Invoice_Date,custcode,custname,Currency,
dpst,dpstname,Fin_year,Fin_month,cal_year,cal_Month,Monthname,Organ,indent
--and trantype='452'
--and Invoice='32000413'
--)a



insert into FOC_Details_Complete
(company,warehouse,SaleOrderType,OrderNo,
areacode,areaname,Item,Item_desc,trantype,Invoice,Invoice_Date,
custcode,custname,Currency,DeliveryQty,Sales_amount,Sales_USD,
Foreign_currency_amount,dpst,dpstname,
--Fin_year,Fin_month,cal_year,cal_Month,Monthname,
Organ,elgi_focnumber,SourceSystem)
--select * into FOC_Details_From_LN from(
select company,warehouse,SaleOrderType,OrderNo,areacode,areaname,
Item,Item_desc,trantype,Invoice,Invoice_Date,custcode,custname,Currency,
sum(DeliveryQty) DeliveryQty,
sum(case when Sales_amount=0 then UnitPrice*DeliveryQty else Sales_amount end) Sales_amount,
sum(Sales_USD) Sales_USD,sum(Foreign_currency_amount) Foreign_currency_amount,
dpst,dpstname,--Fin_year,Fin_month,cal_year,cal_Month,Monthname,
Organ,substring(indent,1,12) as indent,'LN'
from [ELGi_LN].dbo.ATS_Sales_Details
where --sales_category in (1) and 
substring(indent,1,12) in (select distinct elgi_focnumber from FOC_Details_Complete)
group by company,warehouse,SaleOrderType,OrderNo,areacode,areaname,
Item,Item_desc,trantype,Invoice,Invoice_Date,custcode,custname,Currency,
dpst,dpstname,Fin_year,Fin_month,cal_year,cal_Month,Monthname,Organ,indent
--and trantype='452'
--and Invoice='32000413'
--)a


--Alter table FOC_Details_Complete add DiscPerc1 float
update FOC_Details_Complete set DiscPerc1=a.DiscPerc1
from (select distinct Company,OrderNum,PositionNum,ItemCode,DiscPerc1 
from [ELGi_LN].dbo.Sales_Lines
where DiscPerc1<>0)a
where FOC_Details_Complete.company=a.Company
and FOC_Details_Complete.OrderNo=a.OrderNum
and ltrim(rtrim(FOC_Details_Complete.Item))=ltrim(rtrim(a.ItemCode))


update FOC_Details_Complete set elgi_focnumber=a.elgi_focnumber,
elgi_workorderid=a.elgi_workorderid,
elgi_foctypename=a.elgi_foctypename,
elgi_customer=a.elgi_customer,
FOC_CreationDate=a.FOC_CreationDate,
WO_CreationDate=a.WO_CreationDate,
workorderno=a.workorderno,
Fabno=a.Fabno,
Model=a.Model,
Product=a.Product,
CommissionDate=a.CommissionDate
from (select * from FOC_Details_Complete where FOC_CreationDate is not null)a
where FOC_Details_Complete.elgi_focnumber=a.elgi_focnumber
and FOC_Details_Complete.FOC_CreationDate is null


delete from FOC_Details_Complete 
where elgi_focnumber in (
select a.elgi_focnumber from
(select distinct elgi_focnumber from FOC_Details_Complete where invoice is null)a
inner join (select distinct elgi_focnumber from FOC_Details_Complete where invoice is not null)b
on a.elgi_focnumber=b.elgi_focnumber
)
and invoice is null

delete from FOC_Details_Complete where company in 
(select distinct company from [ELGi_LN].dbo.ELGI_Companies_Master
where CompanyGroup='ATS')

--delete from FOC_Details_Complete where Invoice is null



update FOC_Details_Complete set Symptom=a.Symptom
from(
select a.elgi_workorderid,a.Symptom from 
(select elgi_workorderid,Symptom,incidentdate 
from [ELGI_CRM].dbo.CRM_FOC_Details
) a
inner join (select elgi_workorderid,max(incidentdate) incidentdate 
from [ELGI_CRM].dbo.CRM_FOC_Details
where Symptom is not null group by elgi_workorderid) b
on a.elgi_workorderid=b.elgi_workorderid
and a.incidentdate=b.incidentdate
)a
where convert(nvarchar(50),FOC_Details_Complete.elgi_workorderid)=convert(nvarchar(50),a.elgi_workorderid)

update FOC_Details_Complete set Symptom=a.symptom_descr,ProblemIdentified=a.problem
from(select focno,symptom_descr,problem from CCS_FOC_Details)a
where FOC_Details_Complete.elgi_focnumber=a.focno


update FOC_Details_Complete set ProblemIdentified=a.ProblemIdentified
from(select a.elgi_workorderid,a.ProblemIdentified from 
(select elgi_workorderid,ProblemIdentified,incidentdate 
from [ELGI_CRM].dbo.CRM_FOC_Details
) a
inner join (select elgi_workorderid,max(incidentdate) incidentdate 
from [ELGI_CRM].dbo.CRM_FOC_Details
where ProblemIdentified is not null group by elgi_workorderid) b
on a.elgi_workorderid=b.elgi_workorderid
and a.incidentdate=b.incidentdate
)a
where convert(nvarchar(50),FOC_Details_Complete.elgi_workorderid)=convert(nvarchar(50),a.elgi_workorderid)


update FOC_Details_Complete set Fix=a.Fix
from(
select a.elgi_workorderid,a.Fix from 
(select elgi_workorderid,Fix,incidentdate 
from [ELGI_CRM].dbo.CRM_FOC_Details
) a
inner join (select elgi_workorderid,max(incidentdate) incidentdate 
from [ELGI_CRM].dbo.CRM_FOC_Details
where Fix is not null group by elgi_workorderid) b
on a.elgi_workorderid=b.elgi_workorderid
and a.incidentdate=b.incidentdate
)a
where convert(nvarchar(50),FOC_Details_Complete.elgi_workorderid)=convert(nvarchar(50),a.elgi_workorderid)

update FOC_Details_Complete set SE_Comments=a.SE_Comments
from(
select a.elgi_workorderid,a.SE_Comments from 
(select elgi_workorderid,SE_Comments,incidentdate 
from [ELGI_CRM].dbo.CRM_FOC_Details
) a
inner join (select elgi_workorderid,max(incidentdate) incidentdate 
from [ELGI_CRM].dbo.CRM_FOC_Details
where SE_Comments is not null group by elgi_workorderid) b
on a.elgi_workorderid=b.elgi_workorderid
and a.incidentdate=b.incidentdate
)a
where convert(nvarchar(50),FOC_Details_Complete.elgi_workorderid)=convert(nvarchar(50),a.elgi_workorderid)



------- Updates from CCS------

update FOC_Details_Complete set Organ=a.Region
from (select distinct trackno,Region from CCS_Calls)a
where FOC_Details_Complete.workorderno=a.trackno
and FOC_Details_Complete.Organ is null

update FOC_Details_Complete set ActualCloseDate=a.Actual_CloseDate
from (select distinct trackno,fabno,Actual_CloseDate,loggedby,loggedbyname from CCS_Calls)a
where ltrim(rtrim(FOC_Details_Complete.workorderno))=ltrim(rtrim(a.trackno))


update FOC_Details_Complete set Assigned_to=case when a.loggedbyname is null then a.loggedby else a.loggedbyname end,
ServiceEngineer=case when a.loggedbyname is null then a.loggedby else a.loggedbyname end
from (select distinct trackno,fabno,Actual_CloseDate,loggedby,loggedbyname from CCS_Calls)a
where ltrim(rtrim(FOC_Details_Complete.workorderno))=ltrim(rtrim(a.trackno))

update FOC_Details_Complete set Assigned_to=a.dlr_name,ServiceEngineer=a.dlr_name
from (select * from maintdlrs)a
where FOC_Details_Complete.Assigned_to=a.dlr_code


update FOC_Details_Complete set Assigned_to=a.dlr_name,ServiceEngineer=a.dlr_name
from (select * from maintdlrs)a
where FOC_Details_Complete.Assigned_to=a.new_dlr_code



update FOC_Details_Complete set ActualCloseDate=a.ho_clos,RCA_Required='Y',Obligation=a.obl_warranty,
Assigned_to=a.assigned_to,[Address]=a.[Address],cu_city=city,ServiceEngineer=a.serv_engineer,
engr_phone=a.engr_phone,complaint_identified=a.complaint_identified,call_hmr=a.call_hmr,
closedby=a.closed_by
from(select distinct trackno,ho_clos,obl_warranty,assigned_to,[Address],city,
serv_engineer,engr_phone,complaint_identified,call_hmr,closed_by
from CRM_Calls)a
where FOC_Details_Complete.workorderno=a.trackno

--Alter table FOC_Details_Complete add cu_city nvarchar(200)
--Alter table FOC_Details_Complete add ServiceEngineer nvarchar(200)
--Alter table FOC_Details_Complete add engr_phone nvarchar(200)
--Alter table FOC_Details_Complete add complaint_identified nvarchar(max)
--Alter table FOC_Details_Complete add rca_code nvarchar(50)
--Alter table FOC_Details_Complete add rca_description nvarchar(200)
--Alter table FOC_Details_Complete add call_hmr nvarchar(50)
--Alter table FOC_Details_Complete add closedby nvarchar(100)


update FOC_Details_Complete set RCA_Required=ow_complaint,Obligation=a.oblig,cu_city=a.cu_city,[Address]=a.cu_add,
complaint_identified=a.unlsym,call_hmr=a.hr_mtr_reading,closedby=a.closed_by
from (select distinct trackno,dt_time,clos,ttr,ow_complaint,oblig,cu_city,cu_add,unlsym,hr_mtr_reading,
closed_by
from CallHistory1)a
where ltrim(rtrim(FOC_Details_Complete.workorderno))=ltrim(rtrim(a.trackno))

update FOC_Details_Complete set Obligation=a.obligdesc
from (select * from maintoblig)a
where convert(varchar,FOC_Details_Complete.Obligation)=convert(varchar,a.oblig)

update FOC_Details_Complete set closedby=a.emp_name
from (select distinct emp_code,new_emp_code,emp_name from employee_detail)a
where convert(varchar,FOC_Details_Complete.closedby)=convert(varchar,a.emp_code)


update FOC_Details_Complete set closedby=a.emp_name
from (select distinct emp_code,new_emp_code,emp_name from employee_detail)a
where convert(varchar,FOC_Details_Complete.closedby)=convert(varchar,a.new_emp_code)


update FOC_Details_Complete set rca_code=a.rca_code
from (select distinct trackno,rca_code from ccs_autorca_details)a
where ltrim(rtrim(FOC_Details_Complete.workorderno))=ltrim(rtrim(a.trackno))

update FOC_Details_Complete set rca_code=a.rca_code
from (select distinct trackno,rca_code from crm_autorca_details)a
where ltrim(rtrim(FOC_Details_Complete.workorderno))=ltrim(rtrim(a.trackno))

update FOC_Details_Complete set rca_description=a.prob_desc
from (select distinct rca_code,prob_desc from rca_master)a
where ltrim(rtrim(FOC_Details_Complete.rca_code))=ltrim(rtrim(a.rca_code))




------- End: Updates from CCS------

update FOC_Details_Complete set SuppCode=a.OTBP
from (select distinct company,item,otbp from [ELGI_LN].dbo.ttdipu001all
where company=490 
--and ltrim(rtrim(item))='B011707920003'
)a
where FOC_Details_Complete.company=a.company
and ltrim(rtrim(FOC_Details_Complete.item))=ltrim(rtrim(a.item))

update FOC_Details_Complete set SuppName=a.custname1
from (select * from [ELGI_LN].dbo.vw_business_partner)a
where ltrim(rtrim(FOC_Details_Complete.suppcode))=ltrim(rtrim(a.custcode))

update FOC_Details_Complete set cal_year=year(coalesce(Invoice_Date,FinalApprovalDate,FOC_CreationDate))
update FOC_Details_Complete set cal_Month=month(coalesce(Invoice_Date,FinalApprovalDate,FOC_CreationDate))
update FOC_Details_Complete set Monthname=datename(mm,dateadd(mm,cal_Month,-1))

update FOC_Details_Complete set Fin_year=cal_year-1 where cal_Month<4
update FOC_Details_Complete set Fin_year=cal_year where cal_Month>=4

update FOC_Details_Complete set Fin_month=cal_Month+9  where cal_Month<4
update FOC_Details_Complete set Fin_month=cal_Month-3  where cal_Month>=4


--------Material Cost Update
--Method1:
--update FOC_Details_Complete set LTPR=a.T$LTPR,AVPR=a.T$AVPR
--from (select distinct COMPANY,item,T$LTPR,T$AVPR from TTDIPU100ALL)a
--where FOC_Details_Complete.company=a.COMPANY
--and ltrim(rtrim(FOC_Details_Complete.ITEM))=ltrim(rtrim(a.Item))

--update FOC_Details_Complete set PRIP=a.PRIP
--from(select distinct COMPANY,ITEM,PRIP from TTDIPU001ALL)a
--where FOC_Details_Complete.company=a.COMPANY
--and ltrim(rtrim(FOC_Details_Complete.ITEM))=ltrim(rtrim(a.Item))


--update FOC_Details_Complete set SIPP=a.SIPP
--from(select distinct COMPANY,ITEM,SIPP from TTICPR170ALL)a
--where FOC_Details_Complete.company=a.COMPANY
--and ltrim(rtrim(FOC_Details_Complete.ITEM))=ltrim(rtrim(a.Item))


--update FOC_Details_Complete set MC_UnitPrice=LTPR
--where LTPR is not null

--update FOC_Details_Complete set MC_UnitPrice=AVPR
--where MC_UnitPrice is null and LTPR is null and AVPR is not null

--update FOC_Details_Complete set MC_UnitPrice=PRIP
--where MC_UnitPrice is null and LTPR is null and AVPR is null and PRIP is not null

--update FOC_Details_Complete set MC_UnitPrice=SIPP
--where MC_UnitPrice is null and LTPR is null and AVPR is null and PRIP is null and SIPP is not null

--Method2:
update FOC_Details_Complete set MC_UnitPrice=a.sales_Mc
from(select t$year,t$mnth,ltrim(rtrim(t$sele))t$sele,sum(convert(float,t$impo)) sales_Mc  
From [ELGi_LN].dbo.TZZCPR104ALL group by t$sele,t$year,t$mnth)a
where ltrim(rtrim(FOC_Details_Complete.Item))=ltrim(rtrim(t$sele))
and FOC_Details_Complete.cal_year=a.T$YEAR 
and FOC_Details_Complete.cal_Month=a.T$MNTH 


update FOC_Details_Complete set MC_UnitPrice=a.sales_Mc
from(
select t$year,t$mnth,t$sele,sum(convert(float,t$impo)) sales_Mc  
From [ELGi_LN].dbo.TZZCPR104ALL a
where concat(t$year,t$mnth) in (select max(concat( t$year,t$mnth)) 
from [ELGi_LN].dbo.TZZCPR104ALL b 
where a.t$sele= b.t$sele)
--and ltrim(rtrim(t$sele))='B004706740001'
group by t$year,t$mnth,t$sele
)a
where ltrim(rtrim(FOC_Details_Complete.Item))=ltrim(rtrim(t$sele))
and FOC_Details_Complete.MC_UnitPrice is null


--Method3: Manual File input from CostingTeam
update FOC_Details_Complete set MC_UnitPrice=a.MC_Unitprice
from(select CalYear,CalMonth,ltrim(rtrim(ItemCode)) ItemCode,(convert(float,MC_Unitprice)) MC_Unitprice  
From [ELGi_LN].dbo.MC_Data_from_CostingTeam 
)a
where ltrim(rtrim(FOC_Details_Complete.Item))=ltrim(rtrim(ItemCode))
and FOC_Details_Complete.cal_year=a.CalYear 
and FOC_Details_Complete.cal_Month=a.CalMonth 





update FOC_Details_Complete set LandedCost=MC_UnitPrice*(0.15) where company like '4%'
update FOC_Details_Complete set LandedCost=MC_UnitPrice*(0.20)  where company like '6%'

--Alter table FOC_Details_Complete add MC_UnitPrice2 float
--Alter table FOC_Details_Complete add MC_Value2 float
--sp_rename 'FOC_Details_Complete.MC_UnitPrice2','LandedCost'

update FOC_Details_Complete set MC_Value=DeliveryQty*MC_UnitPrice
update FOC_Details_Complete set MC_Value2= DeliveryQty*(isnull(MC_UnitPrice,0) +isnull(LandedCost,0))

--End: Material Cost Update-----------------------------------------------------

--Alter table FOC_Details_Complete add Vertical varchar(50)
--Alter table FOC_Details_Complete add CostCentre varchar(50)
--sp_rename 'FOC_Details_Complete.CostCentre','CostCenter'


update FOC_Details_Complete set Vertical=ltrim(rtrim(a.Vertical))
from (select * from FOC_DPST_Master)a
where FOC_Details_Complete.dpst=a.DPST
and FOC_Details_Complete.Vertical is null

update FOC_Details_Complete set Vertical=ltrim(rtrim(a.Region))
from (select * from FOC_Area_Master)a
where FOC_Details_Complete.areacode=a.AreaCode
and FOC_Details_Complete.dpst like '902%'


update FOC_Details_Complete set Vertical='Quality'
where elgi_foctypename in ('Uptime','Spares Warranty','Warranty','WARRANTY FAILURE FOC')

update FOC_Details_Complete set Vertical='AFTERSALES OVC'
where elgi_foctypename in ('Goodwill - CAMC')


update FOC_Details_Complete set CostCenter=ltrim(rtrim(a.CostCenter))
from (select * from FOC_DPST_Master)a
where ltrim(rtrim(FOC_Details_Complete.Vertical))=ltrim(rtrim(a.Vertical))


update FOC_Details_Complete set CostCenter=ltrim(rtrim(a.CostCenter))
from (select * from FOC_Costcenter_Master)a
where ltrim(rtrim(FOC_Details_Complete.Vertical))=ltrim(rtrim(a.Vertical))


end

select * from FOC_Details_Complete
where elgi_focnumber in ('FOC-00039871'
--'26419P833','26519P720'
)

--select * from Warranty_Tracker_Complete
--where focno in  ('26419P833','26519P720')

GO

