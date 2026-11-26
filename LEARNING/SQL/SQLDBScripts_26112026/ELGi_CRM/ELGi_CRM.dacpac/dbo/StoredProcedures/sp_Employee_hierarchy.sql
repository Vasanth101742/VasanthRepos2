--exec sp_Employee_hierarchy
CREATE proc sp_Employee_hierarchy
as

truncate table h1_CRM
truncate table h1_level1_CRM
truncate table h1_level2_CRM
truncate table h1_level3_CRM
truncate table h1_level4_CRM
truncate table h1_level5_CRM
truncate table h1_level6_CRM
truncate table h1_level7_CRM
truncate table employee_hierarchy_CRM;

with crm_hierarchy as
(
select parentsystemuserid,systemuserid,fullname,employeeid,positionidname,isdisabledname,1 as level,territoryidname,businessunitidname,
elgi_businessverticalname,address1_city,internalemailaddress 
from systemuser_CRM 
where parentsystemuserid is null and isdisabledname='Enabled' 

union all

select e.parentsystemuserid,e.systemuserid,e.fullname,e.employeeid,e.positionidname,e.isdisabledname,b.Level+1,
e.territoryidname,e.businessunitidname,e.elgi_businessverticalname,e.address1_city,e.internalemailaddress
from systemuser_CRM e 
inner join (select * From crm_hierarchy)b
on e.parentsystemuserid =b.systemuserid
)
insert into h1_CRM 
select distinct * from crm_hierarchy 
order by level,parentsystemuserid,systemuserid 


insert into h1_level1_CRM
select distinct parentsystemuserid,systemuserid,positionidname,territoryidname,businessunitidname,elgi_businessverticalname,address1_city,
employeeid,fullname,internalemailaddress from h1_CRM where level=1 
and systemuserid='FD28CFE0-BB7A-E811-A95F-000D3AF29E21'
order by parentsystemuserid,systemuserid

insert into h1_level2_CRM 
select distinct parentsystemuserid,systemuserid,positionidname,territoryidname,businessunitidname,elgi_businessverticalname,address1_city,
employeeid,fullname,internalemailaddress from h1_CRM where level=2 
and parentsystemuserid in(select distinct systemuserid from h1_level1_CRM )
order by parentsystemuserid,systemuserid

insert into h1_level3_CRM 
select distinct parentsystemuserid,systemuserid,positionidname,territoryidname,businessunitidname,elgi_businessverticalname,address1_city,
employeeid,fullname,internalemailaddress from h1_CRM where level=3 
and parentsystemuserid in(select distinct systemuserid from h1_level2_CRM )
order by parentsystemuserid,systemuserid

insert into h1_level4_CRM 
select distinct parentsystemuserid,systemuserid,positionidname,territoryidname,businessunitidname,elgi_businessverticalname,address1_city,
employeeid,fullname,internalemailaddress from h1_CRM where level=4 
and parentsystemuserid in(select distinct systemuserid from h1_level3_CRM)
order by parentsystemuserid,systemuserid

insert into h1_level5_CRM 
select distinct parentsystemuserid,systemuserid,positionidname,territoryidname,businessunitidname,elgi_businessverticalname,address1_city,
employeeid,fullname,internalemailaddress from h1_CRM where level=5 
and parentsystemuserid in(select distinct systemuserid from h1_level4_CRM)
order by parentsystemuserid,systemuserid


insert into h1_level6_CRM 
select distinct parentsystemuserid,systemuserid,positionidname,territoryidname,businessunitidname,elgi_businessverticalname,address1_city,
employeeid,fullname,internalemailaddress from h1_CRM where level=6 
and parentsystemuserid in(select distinct systemuserid from h1_level5_CRM)
order by parentsystemuserid,systemuserid


insert into h1_level7_CRM 
select distinct parentsystemuserid,systemuserid,positionidname,territoryidname,businessunitidname,elgi_businessverticalname,address1_city,
employeeid,fullname,internalemailaddress from h1_CRM where level=7 
and parentsystemuserid in(select distinct systemuserid from h1_level6_CRM)
order by parentsystemuserid,systemuserid


--Mapping Level7 team Members with crm lead
INSERT INTO employee_hierarchy_CRM
select  
h1_level1_CRM.systemuserid as L1_ID,h1_level1_CRM.positionidname AS L1_POSNAME,h1_level1_CRM.territoryidname AS L1_REGION,
h1_level1_CRM.businessunitidname AS L1_BUNIT
,h1_level1_CRM.elgi_businessverticalname AS L1_VERTICAL,h1_level1_CRM.address1_city AS L1_ADDRESS,h1_level1_CRM.employeeid AS L1_EMPID,h1_level1_CRM.fullname AS L1_EMPNAME
,h1_level1_CRM.internalemailaddress AS L1_EMAIL,
h1_level2_CRM.systemuserid as L2_ID,h1_level2_CRM.positionidname AS L2_POSNAME,h1_level2_CRM.territoryidname AS L2_REGION,h1_level2_CRM.businessunitidname AS L2_BUNIT
,h1_level2_CRM.elgi_businessverticalname AS L2_VERTICAL,h1_level2_CRM.address1_city AS L2_ADDRESS,h1_level2_CRM.employeeid AS L2_EMPID,h1_level2_CRM.fullname AS L2_EMPNAME
,h1_level2_CRM.internalemailaddress AS L2_EMAIL,
h1_level3_CRM.systemuserid as L3_ID,h1_level3_CRM.positionidname AS L3_POSNAME,h1_level3_CRM.territoryidname AS L3_REGION,h1_level3_CRM.businessunitidname AS L3_BUNIT
,h1_level3_CRM.elgi_businessverticalname AS L3_VERTICAL,h1_level3_CRM.address1_city AS L3_ADDRESS,h1_level3_CRM.employeeid AS L3_EMPID,h1_level3_CRM.fullname AS L3_EMPNAME
,h1_level3_CRM.internalemailaddress AS L3_EMAIL,
h1_level4_CRM.systemuserid as L4_ID,h1_level4_CRM.positionidname AS L4_POSNAME,h1_level4_CRM.territoryidname AS L4_REGION,h1_level4_CRM.businessunitidname AS L4_BUNIT
,h1_level4_CRM.elgi_businessverticalname AS L4_VERTICAL,h1_level4_CRM.address1_city AS L4_ADDRESS,h1_level4_CRM.employeeid AS L4_EMPID,h1_level4_CRM.fullname AS L4_EMPNAME
,h1_level4_CRM.internalemailaddress AS L4_EMAIL,
h1_level5_CRM.systemuserid as L5_ID,h1_level5_CRM.positionidname AS L5_POSNAME,h1_level5_CRM.territoryidname AS L5_REGION,h1_level5_CRM.businessunitidname AS L5_BUNIT
,h1_level5_CRM.elgi_businessverticalname AS L5_VERTICAL,h1_level5_CRM.address1_city AS L5_ADDRESS,h1_level5_CRM.employeeid AS L5_EMPID,h1_level5_CRM.fullname AS L5_EMPNAME
,h1_level5_CRM.internalemailaddress AS L5_EMAIL,
h1_level6_CRM.systemuserid as L6_ID,h1_level6_CRM.positionidname AS L6_POSNAME,h1_level6_CRM.territoryidname AS L6_REGION,h1_level6_CRM.businessunitidname AS L6_BUNIT
,h1_level6_CRM.elgi_businessverticalname AS L6_VERTICAL,h1_level6_CRM.address1_city AS L6_ADDRESS,h1_level6_CRM.employeeid AS L6_EMPID,h1_level6_CRM.fullname AS L6_EMPNAME
,h1_level6_CRM.internalemailaddress AS L6_EMAIL,
h1_level7_CRM.systemuserid as L7_ID,h1_level7_CRM.positionidname AS L7_POSNAME,h1_level7_CRM.territoryidname AS L7_REGION,h1_level7_CRM.businessunitidname AS L7_BUNIT
,h1_level7_CRM.elgi_businessverticalname AS L7_VERTICAL,h1_level7_CRM.address1_city AS L7_ADDRESS,h1_level7_CRM.employeeid AS L7_EMPID,h1_level7_CRM.fullname AS L7_EMPNAME
,h1_level7_CRM.internalemailaddress AS L7_EMAIL

from h1_level1_CRM 
left outer join h1_level2_CRM
on h1_level1_CRM.systemuserid=h1_level2_CRM.parentsystemuserid
left outer join h1_level3_CRM
on h1_level2_CRM.systemuserid=h1_level3_CRM.parentsystemuserid
left outer join h1_level4_CRM
on h1_level3_CRM.systemuserid=h1_level4_CRM.parentsystemuserid
left outer join h1_level5_CRM
on h1_level4_CRM.systemuserid=h1_level5_CRM.parentsystemuserid
left outer join h1_level6_CRM
on h1_level5_CRM.systemuserid=h1_level6_CRM.parentsystemuserid 
left outer join h1_level7_CRM
on h1_level6_CRM.systemuserid=h1_level7_CRM.parentsystemuserid
order by h1_level1_CRM.systemuserid,h1_level2_CRM.systemuserid,h1_level3_CRM.systemuserid,
h1_level4_CRM.systemuserid,h1_level5_CRM.systemuserid,h1_level6_CRM.systemuserid,h1_level7_CRM.systemuserid


delete from employee_hierarchy_CRM where L1_empid in ('-','--','___','NA','Nil','#')
delete from employee_hierarchy_CRM where L2_empid in ('-','--','___','NA','Nil','#')
delete from employee_hierarchy_CRM where L3_empid in ('-','--','___','NA','Nil','#')
delete from employee_hierarchy_CRM where L4_empid in ('-','--','___','NA','Nil','#')
delete from employee_hierarchy_CRM where L5_empid in ('-','--','___','NA','Nil','#')
delete from employee_hierarchy_CRM where L6_empid in ('-','--','___','NA','Nil','#')
delete from employee_hierarchy_CRM where L7_empid in ('-','--','___','NA','Nil','#')

select * from employee_hierarchy_CRM

GO

