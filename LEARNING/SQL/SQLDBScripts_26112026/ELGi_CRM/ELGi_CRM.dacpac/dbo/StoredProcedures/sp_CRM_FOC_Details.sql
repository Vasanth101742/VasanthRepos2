--exec sp_CRM_FOC_Details

CREATE proc [dbo].[sp_CRM_FOC_Details] as
begin

Truncate table CRM_FOC_Details

Insert into CRM_FOC_Details(elgi_workorderid,elgi_focid,msdyn_customerassetid,
msdyn_incidenttypename,IncidentDate,elgi_aonumber,elgi_ordertypename,
invoiceid)
select * --into CRM_FOC_Details 
from (
select distinct a.elgi_workorderid,a.elgi_focid,d.msdyn_customerassetid,e.msdyn_incidenttypename,
e.createdon as IncidentDate,f.elgi_aonumber,f.elgi_ordertypename,g.invoiceid
from 
(select distinct elgi_workorderid,elgi_focid from elgi_foc_CRM  where statuscodename='Approved'
union all
select  distinct elgi_workorderid,elgi_focid from [CRM_Archival].dbo.elgi_foc where statuscodename='Approved')a
left outer join 
(select distinct msdyn_workorderid from msdyn_workorder_CRM
union all 
select distinct msdyn_workorderid from [CRM_Archival].dbo.msdyn_workorder)b
on a.elgi_workorderid=b.msdyn_workorderid
left outer join 
(select distinct elgi_foc,elgi_customerasset from msdyn_workorderproduct_CRM)c
on a.elgi_focid=c.elgi_foc
left outer join
(select distinct msdyn_customerassetid from msdyn_customerasset_CRM
union all
select distinct msdyn_customerassetid from  [CRM_Archival].dbo.msdyn_customerasset )d
on c.elgi_customerasset=d.msdyn_customerassetid
left outer join 
(select msdyn_workorder,msdyn_incidenttypename,createdon from msdyn_workorderincident_CRM
--where msdyn_workorder= '857F5A20-7202-E911-A976-000D3AF27119'
--order by createdon
)e
on b.msdyn_workorderid=e.msdyn_workorder
left outer join 
(select elgi_ordertypename,elgi_foc,substring(elgi_aonumber,0,10)elgi_aonumber FROM salesorder_CRM)f
on a.elgi_focid=f.elgi_foc
left outer join (select elgi_aonumber,invoiceid FROM invoicedetail_CRM)g
on f.elgi_aonumber=g.elgi_aonumber
--where a.elgi_workorderid='FE487B2B-9ACB-EC11-A7B5-000D3A0A60C1'

)a


--Alter table CRM_FOC_Details alter column elgi_focnumber nvarchar(100)
--Alter table CRM_FOC_Details alter column elgi_foctypename nvarchar(255)
--Alter table CRM_FOC_Details alter column elgi_customer uniqueidentifier
--Alter table CRM_FOC_Details alter column FOC_CreationDate datetime
--Alter table CRM_FOC_Details add WO_CreationDate datetime
--Alter table CRM_FOC_Details add workorderno nvarchar(100)
--Alter table CRM_FOC_Details add Fabno nvarchar(100)
--Alter table CRM_FOC_Details add Model nvarchar(100)
--Alter table CRM_FOC_Details add Product nvarchar(100)
--Alter table CRM_FOC_Details add CommissionDate datetime
--Alter table CRM_FOC_Details add Symptom nvarchar(100)
--Alter table CRM_FOC_Details add ProblemIdentified nvarchar(1000)
--Alter table CRM_FOC_Details add Fix nvarchar(1000)
--Alter table CRM_FOC_Details add SE_Comments nvarchar(max)
--Alter table CRM_FOC_Details add FOC_ModifiedDate datetime

update CRM_FOC_Details set elgi_focnumber=a.elgi_focnumber,
elgi_foctypename=a.elgi_foctypename,
elgi_customer=a.elgi_customer,
FOC_CreationDate=a.createdon,FOC_ModifiedDate=a.modifiedon
from (select distinct elgi_focid,elgi_focnumber,
elgi_foctype,elgi_foctypename,
elgi_customer,createdon,modifiedon
from elgi_foc_CRM 
where statuscodename='Approved' 

union all
select distinct elgi_focid,elgi_focnumber,
elgi_foctype,elgi_foctypename,
elgi_customer,createdon,modifiedon
from [CRM_Archival].dbo.elgi_foc
where statuscodename='Approved' 
)a
where CRM_FOC_Details.elgi_focid=a.elgi_focid

--delete from CRM_FOC_Details where FOC_ModifiedDate<'2022-04-01'

update CRM_FOC_Details set WO_CreationDate=a.createdon,workorderno=a.msdyn_name,
SE_Comments=a.elgi_serviceengineercomments
from (select distinct msdyn_name,createdon,msdyn_workorderid,elgi_serviceengineercomments 
from msdyn_workorder_CRM
union all
select distinct msdyn_name,createdon,msdyn_workorderid,elgi_serviceengineercomments 
from [CRM_Archival].dbo.msdyn_workorder
	)a
where CRM_FOC_Details.elgi_workorderid=msdyn_workorderid




update CRM_FOC_Details set Fabno=a.msdyn_name,Model=a.msdyn_productname,
Product=a.elgi_productsubgroupname,CommissionDate=a.elgi_dateofcommissioning
from (select distinct msdyn_name,msdyn_productname,
elgi_productgroupname,elgi_productsubgroupname,msdyn_customerassetid,elgi_dateofcommissioning
from msdyn_customerasset_CRM
union all
select distinct msdyn_name,msdyn_productname,
elgi_productgroupname,elgi_productsubgroupname,msdyn_customerassetid,elgi_dateofcommissioning
from [CRM_Archival].dbo.msdyn_customerasset
)a
where CRM_FOC_Details.msdyn_customerassetid=a.msdyn_customerassetid



update CRM_FOC_Details set Symptom=a.msdyn_name,ProblemIdentified=a.elgi_complaintidentified,
Fix=a.elgi_fix
from(select distinct msdyn_workorder,msdyn_name,createdon,elgi_complaintidentified,elgi_fix
from msdyn_workorderincident_CRM
union all
select distinct msdyn_workorder,msdyn_name,createdon,elgi_complaintidentified,elgi_fix
from [CRM_Archival].dbo.msdyn_workorderincident

) a
where convert(nvarchar(50),CRM_FOC_Details.elgi_workorderid)=convert(nvarchar(50),a.msdyn_workorder)
and CRM_FOC_Details.IncidentDate=a.createdon



--Method1
--update CRM_FOC_Details set Symptom=a.msdyn_name
--from(select msdyn_name,elgi_complaintidentified,elgi_fix,
--msdyn_incidenttypename,msdyn_workorder from MSDYN_WORKORDERINCIDENT a
--where MSDYN_WORKORDER in (select distinct elgi_workorderid from CRM_FOC_Details)
--and createdon = (select max(createdon) from MSDYN_WORKORDERINCIDENT b
--where  convert(nvarchar(50),b.MSDYN_WORKORDER)= convert(nvarchar(50),a.MSDYN_WORKORDER)
--and msdyn_name is not null)
--)a
--where convert(nvarchar(50),CRM_FOC_Details.elgi_workorderid)=convert(nvarchar(50),a.msdyn_workorder)


--Method2
--update CRM_FOC_Details set Symptom=a.msdyn_name
--from(select a.msdyn_workorder,a.msdyn_name,b.createdon from
--(select distinct msdyn_name,msdyn_workorder,createdon from MSDYN_WORKORDERINCIDENT) a
--inner join(select msdyn_workorder,max(createdon) createdon from MSDYN_WORKORDERINCIDENT
--where msdyn_name is not null group by msdyn_workorder)b
--on a.msdyn_workorder=b.msdyn_workorder
--and a.createdon=b.createdon
--)a
--where convert(nvarchar(50),CRM_FOC_Details.elgi_workorderid)=convert(nvarchar(50),a.msdyn_workorder)


--update CRM_FOC_Details set ProblemIdentified=a.elgi_complaintidentified
--from(select a.msdyn_workorder,a.elgi_complaintidentified,b.createdon from
--(select distinct msdyn_workorder,createdon,elgi_complaintidentified from MSDYN_WORKORDERINCIDENT) a
--inner join(select msdyn_workorder,max(createdon) createdon from MSDYN_WORKORDERINCIDENT
--where elgi_complaintidentified is not null group by msdyn_workorder)b
--on a.msdyn_workorder=b.msdyn_workorder
--and a.createdon=b.createdon
--)a
--where convert(nvarchar(50),CRM_FOC_Details.elgi_workorderid)=convert(nvarchar(50),a.msdyn_workorder)


--update CRM_FOC_Details set Fix=a.elgi_fix
--from(select a.msdyn_workorder,a.elgi_fix,b.createdon from
--(select distinct msdyn_workorder,createdon,elgi_fix from MSDYN_WORKORDERINCIDENT) a
--inner join(select msdyn_workorder,max(createdon) createdon from MSDYN_WORKORDERINCIDENT
--where elgi_fix is not null group by msdyn_workorder)b
--on a.msdyn_workorder=b.msdyn_workorder
--and a.createdon=b.createdon
--)a
--where convert(nvarchar(50),CRM_FOC_Details.elgi_workorderid)=convert(nvarchar(50),a.msdyn_workorder)


end


--select elgi_foctypename,statuscodename from elgi_foc_CRM
--select elgi_ordertypename,elgi_foc,substring(elgi_aonumber,0,10)elgi_aonumber FROM salesorder_CRM

--select * from CRM_FOC_Details
--where elgi_focnumber='FOC-00017685'

GO

