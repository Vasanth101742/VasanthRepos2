-- exec sp_crm_parent_child
CREATE proc sp_crm_parent_child as 
begin

truncate table crm_final_fact
truncate table crm_final_Actual
truncate table tb1;
truncate table level1;
truncate table level2;
truncate table level3;
truncate table level4;
truncate table level5;
truncate table level6;
truncate table level7;
TRUNCATE TABLE TB3;
TRUNCATE TABLE TB3a;

--Commenting the below script as part of Optimization during SSIS - Azure Migration

--truncate table plan_act 
--truncate table crm_plan_Actual  --- some times plan_act and crm_plan_actuals table data count mismatch because team head is disable

--truncate table avg_visits
--truncate table crm_avg_visits

--truncate table customerclassificationname	   
--truncate table elgi_customerclassificationname

--truncate table Active
--truncate table offer_Active

--truncate table Active_next2months
--truncate table offer_Active_next2months

--truncate table Active_eqnuiries --------- enquiries
--truncate table All_Active_eqnuiries

--truncate table orders_elgi  -- inflow
--truncate table orders_to_elgi

--truncate table reasonname
--truncate table elgi_reasonname

--truncate table ordersdealer
--truncate table orders_to_dealer


--truncate table Funnel
--truncate table crm_funnel;


--truncate table USERS

--INSERT INTO USERS
--SELECT * FROM SYSTEMUSER 


--delete  From USERS
--where businessunitidname  like '%After Market%' 
--or businessunitidname  like '%WW%' 
--or businessunitidname  like '%Waterwell%' 
--or businessunitidname  like '%portable%' 
--or businessunitidname  like '%recip%' 
--or businessunitidname  like '%railway%' 
--or businessunitidname  like '%C&M%' ;

----for waterwell


----delete  From USERS
----where elgi_businessverticalname<>'Portables - Waterwell Sales'

--delete  From USERS where elgi_businessverticalname is null

--delete from USERS where isdisabledname<>'Enabled';


with crm_hierarchy as
(
select parentsystemuserid,systemuserid,fullname,employeeid,positionidname,isdisabledname,1 as level,
territoryidname,businessunitidname,elgi_businessverticalname,address1_city,internalemailaddress 
from systemuser_CRM where parentsystemuserid is null 
--and isdisabledname='Enabled' 

union all

select e.parentsystemuserid,e.systemuserid,e.fullname,e.employeeid,e.positionidname,e.isdisabledname,b.Level+1,
e.territoryidname,e.businessunitidname,e.elgi_businessverticalname,e.address1_city,e.internalemailaddress
 from systemuser_CRM e 
inner join (select * From crm_hierarchy)b
on e.parentsystemuserid =b.systemuserid
)
insert into tb1 
select distinct * from crm_hierarchy 
order by level,parentsystemuserid,systemuserid 
-- for water wells
--insert into tb1 
--  select parentsystemuserid,systemuserid,fullname,employeeid,positionidname,isdisabledname,1 as level,territoryidname,businessunitidname,
--  elgi_businessverticalname,address1_city,internalemailaddress 
--   from USERS

insert into level1 
select distinct parentsystemuserid,systemuserid,positionidname,territoryidname,businessunitidname,elgi_businessverticalname,address1_city,
employeeid,fullname,internalemailaddress from tb1 where level=1 
--and systemuserid='FD28CFE0-BB7A-E811-A95F-000D3AF29E21'
order by parentsystemuserid,systemuserid

insert into level2 
select distinct parentsystemuserid,systemuserid,positionidname,territoryidname,businessunitidname,elgi_businessverticalname,address1_city,
employeeid,fullname,internalemailaddress from tb1 where level=2 
and parentsystemuserid in(select distinct systemuserid from level1 )
order by parentsystemuserid,systemuserid

insert into level3 
select distinct parentsystemuserid,systemuserid,positionidname,territoryidname,businessunitidname,elgi_businessverticalname,address1_city,
employeeid,fullname,internalemailaddress from tb1 where level=3 
and parentsystemuserid in(select distinct systemuserid from level2 )
order by parentsystemuserid,systemuserid

insert into level4 
select distinct parentsystemuserid,systemuserid,positionidname,territoryidname,businessunitidname,elgi_businessverticalname,address1_city,
employeeid,fullname,internalemailaddress from tb1 where level=4 
and parentsystemuserid in(select distinct systemuserid from level3)
order by parentsystemuserid,systemuserid

insert into level5 
select distinct parentsystemuserid,systemuserid,positionidname,territoryidname,businessunitidname,elgi_businessverticalname,address1_city,
employeeid,fullname,internalemailaddress from tb1 where level=5 
and parentsystemuserid in(select distinct systemuserid from level4)
order by parentsystemuserid,systemuserid


insert into level6 
select distinct parentsystemuserid,systemuserid,positionidname,territoryidname,businessunitidname,elgi_businessverticalname,address1_city,
employeeid,fullname,internalemailaddress from tb1 where level=6 
and parentsystemuserid in(select distinct systemuserid from level5)
order by parentsystemuserid,systemuserid


insert into level7 
select distinct parentsystemuserid,systemuserid,positionidname,territoryidname,businessunitidname,elgi_businessverticalname,address1_city,
employeeid,fullname,internalemailaddress from tb1 where level=7 
and parentsystemuserid in(select distinct systemuserid from level6)
order by parentsystemuserid,systemuserid


--Mapping Level7 team Members with crm lead
INSERT INTO TB3
select  
level1.systemuserid as L1_ID,level1.positionidname AS L1_POSNAME,level1.territoryidname AS L1_REGION,level1.businessunitidname AS L1_BUNIT
,level1.elgi_businessverticalname AS L1_VERTICAL,level1.address1_city AS L1_ADDRESS,level1.employeeid AS L1_EMPID,level1.fullname AS L1_EMPNAME
,level1.internalemailaddress AS L1_EMAIL,
level2.systemuserid as L2_ID,level2.positionidname AS L2_POSNAME,level2.territoryidname AS L2_REGION,level2.businessunitidname AS L2_BUNIT
,level2.elgi_businessverticalname AS L2_VERTICAL,level2.address1_city AS L2_ADDRESS,level2.employeeid AS L2_EMPID,level2.fullname AS L2_EMPNAME
,level2.internalemailaddress AS L2_EMAIL,
level3.systemuserid as L3_ID,level3.positionidname AS L3_POSNAME,level3.territoryidname AS L3_REGION,level3.businessunitidname AS L3_BUNIT
,level3.elgi_businessverticalname AS L3_VERTICAL,level3.address1_city AS L3_ADDRESS,level3.employeeid AS L3_EMPID,level3.fullname AS L3_EMPNAME
,level3.internalemailaddress AS L3_EMAIL,
level4.systemuserid as L4_ID,level4.positionidname AS L4_POSNAME,level4.territoryidname AS L4_REGION,level4.businessunitidname AS L4_BUNIT
,level4.elgi_businessverticalname AS L4_VERTICAL,level4.address1_city AS L4_ADDRESS,level4.employeeid AS L4_EMPID,level4.fullname AS L4_EMPNAME
,level4.internalemailaddress AS L4_EMAIL,
level5.systemuserid as L5_ID,level5.positionidname AS L5_POSNAME,level5.territoryidname AS L5_REGION,level5.businessunitidname AS L5_BUNIT
,level5.elgi_businessverticalname AS L5_VERTICAL,level5.address1_city AS L5_ADDRESS,level5.employeeid AS L5_EMPID,level5.fullname AS L5_EMPNAME
,level5.internalemailaddress AS L5_EMAIL,
level6.systemuserid as L6_ID,level6.positionidname AS L6_POSNAME,level6.territoryidname AS L6_REGION,level6.businessunitidname AS L6_BUNIT
,level6.elgi_businessverticalname AS L6_VERTICAL,level6.address1_city AS L6_ADDRESS,level6.employeeid AS L6_EMPID,level6.fullname AS L6_EMPNAME
,level6.internalemailaddress AS L6_EMAIL,
level7.systemuserid as L7_ID,level7.positionidname AS L7_POSNAME,level7.territoryidname AS L7_REGION,level7.businessunitidname AS L7_BUNIT
,level7.elgi_businessverticalname AS L7_VERTICAL,level7.address1_city AS L7_ADDRESS,level7.employeeid AS L7_EMPID,level7.fullname AS L7_EMPNAME
,level7.internalemailaddress AS L7_EMAIL

from level1 
left outer join level2 
on level1.systemuserid=level2.parentsystemuserid
left outer join level3
on level2.systemuserid=level3.parentsystemuserid
left outer join level4
on level3.systemuserid=level4.parentsystemuserid
left outer join level5
on level4.systemuserid=level5.parentsystemuserid
left outer join level6
on level5.systemuserid=level6.parentsystemuserid 
left outer join level7
on level6.systemuserid=level7.parentsystemuserid
order by level1.systemuserid,level2.systemuserid,level3.systemuserid,level4.systemuserid,level5.systemuserid,level6.systemuserid,level7.systemuserid


--Commenting the below script as part of Optimization during SSIS - Azure Migration

--insert into plan_act 
--select elgi_dealer,elgi_dealername,elgi_dealerengineername,elgi_monthstartingdate,
--elgi_weeklyplannumbername,convert(date,elgi_latestvisitdate)elgi_latestvisitdate,
--owneridname,ownerid,elgi_customertypesalesname,sum(plan_cnt)[plan],sum(Actual_cnt)[Actual] 
--From (
--select * From (
--select * From (
--select  elgi_dealer,elgi_dealername,elgi_dealerengineername,convert(date,elgi_monthstartingdate)elgi_monthstartingdate,elgi_weeklyplannumbername,convert(date,elgi_latestvisitdate)elgi_latestvisitdate,
--owneridname,ownerid,elgi_customertypesalesname ,count(distinct substring(requiredattendees,14,36)) as plan_cnt,0 as Actual_cnt from (
--select *,row_number()over(partition by ownerid,substring(requiredattendees,14,36) order by elgi_latestvisitdate desc) as rno from APPOINTMENT 
--where elgi_customertypesalesname ='Cold Calls' and requiredattendees<>'[]' and statecodename<>'Canceled' and 
--convert(date,elgi_monthstartingdate)>='2021-04-01'
-- --and elgi_lineofbusinessname in ('040a','040b','952','953','954','955') --ww
--)a
--where rno<2
--group by convert(date,elgi_latestvisitdate),elgi_customertypesalesname,owneridname,ownerid,elgi_weeklyplannumbername,convert(date,elgi_monthstartingdate)
--,elgi_dealername,elgi_dealerengineername,elgi_dealer)a

--union all
---------------------- distinct customers will change to Courtesy Visits
--select * From (
--select  elgi_dealer,elgi_dealername,elgi_dealerengineername,convert(date,elgi_monthstartingdate)elgi_monthstartingdate,elgi_weeklyplannumbername,convert(date,elgi_latestvisitdate)elgi_latestvisitdate,
--owneridname,ownerid,'Cold Calls-Already Met' as elgi_customertypesalesname ,count(substring(requiredattendees,14,36)) as plan_cnt,0 as Actual_cnt from (
--select *,row_number()over(partition by ownerid,substring(requiredattendees,14,36) order by elgi_latestvisitdate desc) as rno from APPOINTMENT 
--where elgi_customertypesalesname ='Cold Calls' and requiredattendees<>'[]' and statecodename<>'Canceled' and 
--convert(date,elgi_monthstartingdate)>='2021-04-01'
-- --and elgi_lineofbusinessname in ('040a','040b','952','953','954','955') --ww
--)a
--where rno>1
--group by convert(date,elgi_latestvisitdate),elgi_customertypesalesname,owneridname,ownerid,elgi_weeklyplannumbername,convert(date,elgi_monthstartingdate)
--,elgi_dealername,elgi_dealerengineername,elgi_dealer)a
---------------------------------------------------------------------------
--union all

--select  elgi_dealer,elgi_dealername,elgi_dealerengineername,convert(date,elgi_monthstartingdate)elgi_monthstartingdate,elgi_weeklyplannumbername,convert(date,elgi_latestvisitdate)elgi_latestvisitdate,
--owneridname,ownerid,elgi_customertypesalesname,count(substring(requiredattendees,14,36)) as cnt,0  from APPOINTMENT
--where elgi_customertypesalesname <>'Cold Calls' and requiredattendees<>'[]' and statecodename<>'Canceled' 
--and convert(date,elgi_monthstartingdate)>='2021-04-01'
----and elgi_lineofbusinessname in ('040a','040b','952','953','954','955') --ww
--group by convert(date,elgi_latestvisitdate),elgi_customertypesalesname,owneridname,ownerid,elgi_weeklyplannumbername,convert(date,elgi_monthstartingdate)
--,elgi_dealername,elgi_dealerengineername,elgi_dealer)a


--union all

------------------------------------- b
--select * From (
--select  * from (
--select  elgi_dealer,elgi_dealername,elgi_dealerengineername,convert(date,elgi_monthstartingdate)elgi_monthstartingdate,elgi_weeklyplannumbername,convert(date,elgi_latestvisitdate)elgi_latestvisitdate,
--owneridname,ownerid,elgi_customertypesalesname ,0 as Plan_cnt,count(distinct substring(requiredattendees,14,36)) as Actual_cnt from ( 
--select *,row_number()over(partition by ownerid,substring(requiredattendees,14,36) order by elgi_latestvisitdate desc) as rno from APPOINTMENT 
--where elgi_customertypesalesname ='Cold Calls' and requiredattendees<>'[]'and statecodename<>'Canceled'and 
----convert(date,elgi_monthstartingdate)>='2021-04-01' 
--convert(date,elgi_latestvisitdate) is not null and convert(date,elgi_latestvisitdate)>='2021-04-01'
----and elgi_lineofbusinessname in ('040a','040b','952','953','954','955') --ww
--)a
--where rno<2
--group by convert(date,elgi_latestvisitdate),elgi_customertypesalesname,owneridname,ownerid,elgi_weeklyplannumbername,convert(date,elgi_monthstartingdate)
--,elgi_dealername,elgi_dealerengineername,elgi_dealer)a

--union all
---------------------- distinct customers will change to Courtesy Visits

--select  * from (
--select  elgi_dealer,elgi_dealername,elgi_dealerengineername,convert(date,elgi_monthstartingdate)elgi_monthstartingdate,elgi_weeklyplannumbername,convert(date,elgi_latestvisitdate)elgi_latestvisitdate,
--owneridname,ownerid,'Cold Calls-Already Met' as elgi_customertypesalesname ,0 as Plan_cnt,count(substring(requiredattendees,14,36)) as Actual_cnt from ( 
--select *,row_number()over(partition by ownerid,substring(requiredattendees,14,36) order by elgi_latestvisitdate desc) as rno from APPOINTMENT 
--where elgi_customertypesalesname ='Cold Calls' and requiredattendees<>'[]'and statecodename<>'Canceled'and 
----convert(date,elgi_monthstartingdate)>='2021-04-01'  
--convert(date,elgi_latestvisitdate)>='2021-04-01' and
--convert(date,elgi_latestvisitdate) is not null 
----and elgi_lineofbusinessname in ('040a','040b','952','953','954','955') --ww
--)a
--where rno>1
--group by convert(date,elgi_latestvisitdate),elgi_customertypesalesname,owneridname,ownerid,elgi_weeklyplannumbername,convert(date,elgi_monthstartingdate)
--,elgi_dealername,elgi_dealerengineername,elgi_dealer)a

-----------------------------
--union all

--select  elgi_dealer,elgi_dealername,elgi_dealerengineername,convert(date,elgi_monthstartingdate)elgi_monthstartingdate,elgi_weeklyplannumbername,convert(date,elgi_latestvisitdate)elgi_latestvisitdate,
--owneridname,ownerid,elgi_customertypesalesname,0,count(substring(requiredattendees,14,36)) as cnt from APPOINTMENT 
--where elgi_customertypesalesname <>'Cold Calls'and requiredattendees<>'[]'and statecodename<>'Canceled'  
----and convert(date,elgi_monthstartingdate)>='2021-04-01' 
--and convert(date,elgi_latestvisitdate)>='2021-04-01'
--and convert(date,elgi_latestvisitdate) is not null 
----and elgi_lineofbusinessname in ('040a','040b','952','953','954','955') --ww
-- group by convert(date,elgi_latestvisitdate),elgi_customertypesalesname,owneridname,ownerid,elgi_weeklyplannumbername,convert(date,elgi_monthstartingdate)
--,elgi_dealername,elgi_dealerengineername,elgi_dealer)a
--)a
--group by elgi_dealer,elgi_dealername,elgi_dealerengineername,elgi_monthstartingdate,elgi_weeklyplannumbername,convert(date,elgi_latestvisitdate),
--owneridname,ownerid,elgi_customertypesalesname


--insert into crm_plan_Actual 
--select distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* 
--From tb3
--inner join (select * From plan_act)a
--on tb3.l1_id=a.ownerid 


--insert into crm_plan_Actual 
--select  distinct L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.*
-- From tb3
--inner join (select * From plan_act)a
--on tb3.l2_id=a.ownerid 


--insert into crm_plan_Actual 
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.*
-- From tb3
--inner join (select * From plan_act)a
--on tb3.l3_id=a.ownerid 


--insert into crm_plan_Actual 
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.*
--From tb3
--inner join (select * From plan_act)a
--on tb3.l4_id=a.ownerid 


--insert into crm_plan_Actual 
--select  distinct L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--L5_ID,L5_POSNAME,L5_REGION,L5_BUNIT,L5_VERTICAL,L5_ADDRESS,L5_EMPID,L5_EMPNAME,L5_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.*
-- From tb3
--inner join (select * From plan_act)a
--on tb3.l5_id=a.ownerid 


--insert into crm_plan_Actual 
--select  distinct L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--L5_ID,L5_POSNAME,L5_REGION,L5_BUNIT,L5_VERTICAL,L5_ADDRESS,L5_EMPID,L5_EMPNAME,L5_EMAIL,
--L6_ID,L6_POSNAME,L6_REGION,L6_BUNIT,L6_VERTICAL,L6_ADDRESS,L6_EMPID,L6_EMPNAME,L6_EMAIL,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From plan_act)a
--on tb3.l6_id=a.ownerid 


--insert into crm_plan_Actual 
--select * From tb3
--inner join (select * From plan_act)a
--on tb3.l7_id=a.ownerid 

--------------------------  avg visit count
--insert into avg_visits

--select *  from(
--select elgi_dealer,elgi_dealername,elgi_dealerengineername,elgi_monthstartingdate,elgi_weeklyplannumbername,ownerid,owneridname
--,sum(NoofVisits)as totalNoofVisits,sum(indvdl) as indvdl,sum(NoofVisits)/sum(indvdl) avgvisits  from (
--select elgi_dealer,elgi_dealername,elgi_dealerengineername,convert(date,elgi_monthstartingdate)elgi_monthstartingdate,elgi_weeklyplannumbername,ownerid,owneridname,count(elgi_customervisitid) as NoofVisits,
--count(distinct convert(date,elgi_latestvisitdate)) as indvdl  from APPOINTMENT 
--where requiredattendees<>'[]'
--and statecodename<>'Canceled'
--and elgi_latestvisitdate is not null
--and convert(date,elgi_monthstartingdate )>='2021-04-01'
----and elgi_lineofbusinessname in ('040a','040b','952','953','954','955') --ww
--group by elgi_dealer,elgi_dealername,elgi_dealerengineername,convert(date,elgi_latestvisitdate),ownerid,owneridname,convert(date,elgi_monthstartingdate),elgi_weeklyplannumbername)a
--group by elgi_dealer,elgi_dealername,elgi_dealerengineername,ownerid,elgi_monthstartingdate,elgi_weeklyplannumbername,owneridname )a



--insert into crm_avg_visits
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From avg_visits)a
--on tb3.l1_id=a.ownerid 


--insert into crm_avg_visits
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From avg_visits)a
--on tb3.l2_id=a.ownerid 


--insert into crm_avg_visits
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From avg_visits)a
--on tb3.l3_id=a.ownerid 


--insert into crm_avg_visits
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From avg_visits)a
--on tb3.l4_id=a.ownerid 


--insert into crm_avg_visits
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--L5_ID,L5_POSNAME,L5_REGION,L5_BUNIT,L5_VERTICAL,L5_ADDRESS,L5_EMPID,L5_EMPNAME,L5_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From avg_visits)a
--on tb3.l5_id=a.ownerid 


--insert into crm_avg_visits 
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--L5_ID,L5_POSNAME,L5_REGION,L5_BUNIT,L5_VERTICAL,L5_ADDRESS,L5_EMPID,L5_EMPNAME,L5_EMAIL,
--L6_ID,L6_POSNAME,L6_REGION,L6_BUNIT,L6_VERTICAL,L6_ADDRESS,L6_EMPID,L6_EMPNAME,L6_EMAIL,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From avg_visits)a
--on tb3.l6_id=a.ownerid 


--insert into crm_avg_visits
--select * From tb3
--inner join (select * From avg_visits)a
--on tb3.l7_id=a.ownerid 

---------------------------- end avg visit count


--------------------------- elgi_customerclasificationname

--insert into customerclassificationname

--select * From (
--select elgi_dealer,owneridname,
--elgi_dealername,elgi_dealerengineername,elgi_monthstartingdate,elgi_weeklyplannumbername,ownerid,elgi_customerclassificationname,elgi_description,
--sum(coldcalls_cnt)coldcalls_cnt,sum(Non_coldcalls)Non_coldcalls from(

--select elgi_dealer,owneridname,
--elgi_dealername,elgi_dealerengineername,ownerid,elgi_customerclassificationname,elgi_description,
--convert(date,elgi_monthstartingdate)elgi_monthstartingdate,elgi_weeklyplannumbername,sum(coldcalls_cnt)coldcalls_cnt,sum(Non_coldcalls)Non_coldcalls from(
--select a.*,b.name,b.elgi_customerclassificationname,b.elgi_lineofbusinessname,b.elgi_description From (
--select  substring(requiredattendees,14,36)as custcode,elgi_dealer,elgi_dealername,elgi_dealerengineername,
--convert(date,elgi_monthstartingdate)elgi_monthstartingdate,elgi_weeklyplannumbername,convert(date,elgi_latestvisitdate)elgi_latestvisitdate,
--ownerid,owneridname,elgi_customertypesalesname ,count(distinct substring(requiredattendees,14,36)) as coldcalls_cnt,0 as Non_coldcalls from ( --distinct removed
--select *,row_number()over(partition by ownerid,substring(requiredattendees,14,36) order by elgi_latestvisitdate desc) as rno from APPOINTMENT 
--where --elgi_customervisitid in ('cv-155030','cv-154986') and 
--elgi_customertypesalesname ='Cold Calls'
--and requiredattendees<>'[]'
--and statecodename<>'Canceled'--and elgi_customervisitid='CV-220001'
--and convert(date,elgi_monthstartingdate)>='2021-04-01'
--and convert(date,elgi_latestvisitdate) is not null 
----and elgi_lineofbusinessname in ('040a','040b','952','953','954','955') --ww
--)a
--where rno<2
--group by owneridname,convert(date,elgi_latestvisitdate),elgi_customertypesalesname,owneridname,ownerid,elgi_weeklyplannumbername,convert(date,elgi_monthstartingdate)
--,elgi_dealer,elgi_dealername,elgi_dealerengineername,substring(requiredattendees,14,36))a

--left join (
--select a.*,c.elgi_description From (select accountid,name,elgi_lineofbusinessname,elgi_customerclassificationname From ACCOUNT)a
--left join (select elgi_name,elgi_description From ELGI_LINEOFBUSINESS)c
--on a.elgi_lineofbusinessname =c.elgi_name)b
--on a.CustCode=b.accountid)A
----where elgi_dealerengineername like '%vijaya%'
--group by owneridname,elgi_dealer,elgi_description,elgi_dealername,elgi_dealerengineername,ownerid,elgi_customerclassificationname,convert(date,elgi_monthstartingdate),elgi_weeklyplannumbername


--union all

--select elgi_dealer,owneridname,
--elgi_dealername,elgi_dealerengineername,ownerid,elgi_customerclassificationname,elgi_description,
--convert(date,elgi_monthstartingdate)elgi_monthstartingdate,elgi_weeklyplannumbername,sum(coldcalls_cnt)coldcalls_cnt,sum(Non_coldcalls)Non_coldcalls from(
--select a.*,b.name,b.elgi_customerclassificationname,b.elgi_lineofbusinessname,b.elgi_description From (
--select  substring(requiredattendees,14,36)as custcode,elgi_dealer,elgi_dealername,elgi_dealerengineername,convert(date,elgi_monthstartingdate)elgi_monthstartingdate,elgi_weeklyplannumbername,convert(date,elgi_latestvisitdate)elgi_latestvisitdate,
--owneridname,ownerid,elgi_customertypesalesname ,0 as coldcalls_cnt,count(distinct substring(requiredattendees,14,36)) as Non_coldcalls from (
--select *,row_number()over(partition by ownerid,substring(requiredattendees,14,36) order by elgi_latestvisitdate desc) as rno from APPOINTMENT 
--where --elgi_customervisitid in ('cv-155030','cv-154986') and 
--elgi_customertypesalesname <>'Cold Calls' and elgi_customertypesalesname is not null
--and requiredattendees<>'[]'
--and statecodename<>'Canceled'--and elgi_customervisitid='CV-220001'
--and convert(date,elgi_monthstartingdate)>='2021-04-01'
--and convert(date,elgi_latestvisitdate) is not null
----and elgi_lineofbusinessname in ('040a','040b','952','953','954','955') --ww
--)a
----where rno<2
--group by convert(date,elgi_latestvisitdate),elgi_customertypesalesname,owneridname,ownerid,elgi_weeklyplannumbername,convert(date,elgi_monthstartingdate)
--,elgi_dealer,elgi_dealername,elgi_dealerengineername,substring(requiredattendees,14,36))a

--left join (
--select a.*,c.elgi_description From (select accountid,name,elgi_lineofbusinessname,elgi_customerclassificationname From ACCOUNT)a
--left join (select elgi_name,elgi_description From ELGI_LINEOFBUSINESS)c
--on a.elgi_lineofbusinessname =c.elgi_name)b
--on a.CustCode=b.accountid)A
----where elgi_dealerengineername like '%vijaya%'
--group by owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername,ownerid,elgi_customerclassificationname,convert(date,elgi_monthstartingdate),elgi_weeklyplannumbername,elgi_description)a
--group by owneridname,elgi_dealer,elgi_description,elgi_dealername,elgi_dealerengineername,ownerid,elgi_customerclassificationname,convert(date,elgi_monthstartingdate),elgi_weeklyplannumbername
--)a



--insert into elgi_customerclassificationname
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From customerclassificationname)a
--on tb3.l1_id=a.ownerid 


--insert into elgi_customerclassificationname
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From customerclassificationname)a
--on tb3.l2_id=a.ownerid 




--insert into elgi_customerclassificationname
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From customerclassificationname)a
--on tb3.l3_id=a.ownerid 




--insert into elgi_customerclassificationname
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
-- inner join (select * From customerclassificationname)a
--on tb3.l4_id=a.ownerid 




--insert into elgi_customerclassificationname
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--L5_ID,L5_POSNAME,L5_REGION,L5_BUNIT,L5_VERTICAL,L5_ADDRESS,L5_EMPID,L5_EMPNAME,L5_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From customerclassificationname)a
--on tb3.l5_id=a.ownerid 




--insert into elgi_customerclassificationname 
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--L5_ID,L5_POSNAME,L5_REGION,L5_BUNIT,L5_VERTICAL,L5_ADDRESS,L5_EMPID,L5_EMPNAME,L5_EMAIL,
--L6_ID,L6_POSNAME,L6_REGION,L6_BUNIT,L6_VERTICAL,L6_ADDRESS,L6_EMPID,L6_EMPNAME,L6_EMAIL,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From customerclassificationname)a
--on tb3.l6_id=a.ownerid 


--insert into elgi_customerclassificationname
--select * From tb3
--inner join (select * From customerclassificationname)a
--on tb3.l7_id=a.ownerid 

----------------------------offer_Active
--insert into Active

--select owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername,ownerid,year(createdon) as Year,month(createdon)as Month,datename(month,createdon)as monthname ,sum(qty) Count From (
-------- dealer
--select * From (
--select * From (
--select elgi_dealer,customeridname,elgi_existingproductname,createdon,opportunityid,elgi_enquiryid,ownerid,elgi_productcategoryname,owneridname,elgi_dealername,elgi_dealerengineername
--,sum(elgi_quantity*elgi_priceperunit) as Value,sum(elgi_quantity) as Qty    From (
--select * From (
--select * From (
--select elgi_dealer,elgi_enquiryid,opportunityid,ownerid,elgi_opportunitystatusname,owneridname,elgi_dealername,elgi_dealerengineername,customeridname,createdon  From (
--select  opportunityid,elgi_enquiryid,name,elgi_enquirystatus,elgi_enquirystatusname,elgi_opportunitystatus,elgi_opportunitystatusname,
--statuscode,statuscodename,convert(date,createdon)createdon,estimatedclosedate,actualclosedate,ownerid,owneridname,elgi_dealer,elgi_dealername,
--elgi_dealerengineername,elgi_businessverticalname,customeridname      
--from OPPORTUNITY  where convert(date,createdon) >='2021-04-01' and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3'
--AND  elgi_customervisit in (select distinct activityid From APPOINTMENT 
----where elgi_lineofbusinessname in ('040a','040b','952','953','954','955')) --WW
--))a
--group by elgi_dealer,elgi_enquiryid,elgi_opportunitystatusname,ownerid,opportunityid,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,customeridname,createdon)a

--inner join (
--select a.elgi_businessverticalname,a.elgi_revisedflagname,a.elgi_enquiry,b.*   From (
--select elgi_businessverticalname,elgi_revisedflagname,elgi_dealerofferid,elgi_enquiry  From ELGI_DEALEROFFER
--where elgi_businessverticalname='Industrial'  and elgi_revisedflagname<>'Yes' 
--)a
--inner join (
--select elgi_existingproduct, elgi_producttplitemcode,elgi_priceperunit,elgi_quantity,elgi_existingproductname,elgi_dealeroffer,elgi_dealeroffername  From ELGI_DEALEROFFERPRODUCT)b 
--on a.elgi_dealerofferid=b.elgi_dealeroffer)b
--on a.opportunityid =b.elgi_enquiry)a
--left join (
--select DISTINCT elgi_product,elgi_productcategoryname From ELGI_DEALERPRICELISTMASTER where elgi_productgroupname is not null AND elgi_product IS NOT NULL)b
--on a.elgi_existingproduct =b.elgi_product)a
--where elgi_productcategoryname is not null
--group by elgi_dealer,customeridname,elgi_existingproductname,createdon,elgi_enquiryid,ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername)a

--------------------------------------------------------------------------------------------------------------------------------------
----Quote
--union all

--select elgi_dealer,customeridname,productidname,createdon,opportunityid,elgi_enquiryid,ownerid,elgi_productcategoryname,owneridname,elgi_dealername,elgi_dealerengineername,
--sum(quantity*priceperunit) as Value,sum(quantity) as CNT  From (
--select * From (
--select a.*,b.productid,priceperunit,quantity,productidname From (
--select elgi_dealer,elgi_enquiryid,opportunityid,ownerid,elgi_opportunitystatusname,owneridname,elgi_dealername,elgi_dealerengineername,customeridname,createdon  From (
--select  opportunityid,elgi_enquiryid,name,elgi_enquirystatus,elgi_enquirystatusname,elgi_opportunitystatus,elgi_opportunitystatusname,
--statuscode,statuscodename,convert(date,createdon)createdon,estimatedclosedate,actualclosedate,ownerid,owneridname,elgi_dealer,elgi_dealername,
--elgi_dealerengineername,elgi_businessverticalname,customeridname      
--from OPPORTUNITY  where convert(date,createdon) >='2021-04-01' and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3'
--AND  elgi_customervisit in (select distinct activityid From APPOINTMENT 
----where elgi_lineofbusinessname in ('040a','040b','952','953','954','955'))--WW
--))a
--group by elgi_dealer,elgi_enquiryid,elgi_opportunitystatusname,ownerid,opportunityid,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,customeridname,createdon)a

--inner join(
--select a.opportunityid ,b.* From (
--select ownerid,owneridname,quoteid,elgi_businessverticalname,statuscodename, opportunityid
-- from QUOTE where elgi_businessverticalname ='Industrial' AND statuscodename<>'revised'
-- )a
--inner join (select productid,msdyn_linedescription,priceperunit,quantity,productidname,quoteid,quoteidname From quotedetails)b
--on a.quoteid =b.quoteid )b
--on a.opportunityid =b.opportunityid)a
--left join (
--select DISTINCT elgi_product,elgi_productcategoryname From ELGI_DEALERPRICELISTMASTER where elgi_productgroupname is not null AND elgi_product IS NOT NULL)b
--on a.productid =b.elgi_product)a
--where elgi_productcategoryname is not null
--group by elgi_dealer,customeridname,createdon,productidname,opportunityid,elgi_enquiryid,ownerid,elgi_productcategoryname,owneridname,elgi_dealername,elgi_dealerengineername)a
--where elgi_productcategoryname in ('s0','s1','s2','ENCAP','L0','L1','L2','o0','ot','o1','NSD SEP','CAC') 
--)a
--group by owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername,ownerid,year(createdon),month(createdon),datename(month,createdon)


--insert into offer_Active
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From Active)a
--on tb3.l1_id=a.ownerid 


--insert into offer_Active
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From Active)a
--on tb3.l2_id=a.ownerid 




--insert into offer_Active
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From Active)a
--on tb3.l3_id=a.ownerid 


--insert into offer_Active
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From Active)a
--on tb3.l4_id=a.ownerid 


--insert into offer_Active
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--L5_ID,L5_POSNAME,L5_REGION,L5_BUNIT,L5_VERTICAL,L5_ADDRESS,L5_EMPID,L5_EMPNAME,L5_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From Active)a
--on tb3.l5_id=a.ownerid 


--insert into offer_Active 
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--L5_ID,L5_POSNAME,L5_REGION,L5_BUNIT,L5_VERTICAL,L5_ADDRESS,L5_EMPID,L5_EMPNAME,L5_EMAIL,
--L6_ID,L6_POSNAME,L6_REGION,L6_BUNIT,L6_VERTICAL,L6_ADDRESS,L6_EMPID,L6_EMPNAME,L6_EMAIL,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From Active)a
--on tb3.l6_id=a.ownerid 


--insert into offer_Active
--select * From tb3
--inner join (select * From Active)a
--on tb3.l7_id=a.ownerid 

---------------- end offer_Active

---------------------------- offer_Active_next2months details
--insert into Active_next2months

--select a.*,b.elgi_description,elgi_cityname,elgi_statename,elgi_locationofcustomer  From (
--select estimatedclosedate,createdon,customerid,customeridname,elgi_existingproductname,owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername,ownerid,elgi_productcategoryname,sum(qty) as Count,sum(Value)as Value From (

-------- dealer
--select * From (
--select * From (
--select estimatedclosedate,
--elgi_opportunitystatusname,elgi_dealer,customerid,customeridname,elgi_existingproductname,createdon,opportunityid,elgi_enquiryid,ownerid,elgi_productcategoryname,owneridname,elgi_dealername,elgi_dealerengineername,
--sum(elgi_quantity*elgi_priceperunit) as Value,sum(elgi_quantity) as Qty    From (
--select * From (
--select * From (
--select elgi_dealer,elgi_enquiryid,opportunityid,ownerid,elgi_opportunitystatusname,owneridname,elgi_dealername,elgi_dealerengineername,customerid,customeridname,createdon,estimatedclosedate From (
--select  opportunityid,elgi_enquiryid,name,elgi_enquirystatus,elgi_enquirystatusname,elgi_opportunitystatus,elgi_opportunitystatusname,
--statuscode,statuscodename,convert(date,createdon)createdon,convert(date,estimatedclosedate)estimatedclosedate,actualclosedate,ownerid,owneridname,elgi_dealer,elgi_dealername,
--elgi_dealerengineername,elgi_businessverticalname,customerid,customeridname      
--from OPPORTUNITY where elgi_enquirystatusname='In Progress' and 
--(convert(date,estimatedclosedate) between 
--convert(date,dateadd(d,case when day(getdate())=1 then 0 else -day(getdate()-1) end,getdate())) and dateadd(m,6,convert(date,dateadd(d,-day(getdate()),getdate()))))
--and statuscodename <>'Order Lost' and actualclosedate is null
--and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3'
--AND elgi_customervisit in (select distinct activityid From APPOINTMENT 
----where elgi_lineofbusinessname in ('040a','040b','952','953','954','955')) --WW
--))a
--group by estimatedclosedate,elgi_opportunitystatusname,elgi_dealer,elgi_enquiryid,elgi_opportunitystatusname,ownerid,opportunityid,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,
--customerid,customeridname,createdon)a

--inner join (
--select a.elgi_businessverticalname,a.elgi_revisedflagname,a.elgi_enquiry,b.*   From (
--select elgi_businessverticalname,elgi_revisedflagname,elgi_dealerofferid,elgi_enquiry  From ELGI_DEALEROFFER
--where elgi_businessverticalname='Industrial'  and elgi_revisedflagname<>'Yes' 
--)a
--inner join (
--select elgi_existingproduct, elgi_producttplitemcode,elgi_priceperunit,elgi_quantity,elgi_existingproductname,elgi_dealeroffer,elgi_dealeroffername  From ELGI_DEALEROFFERPRODUCT)b 
--on a.elgi_dealerofferid=b.elgi_dealeroffer)b
--on a.opportunityid =b.elgi_enquiry)a
--left join (
--select DISTINCT elgi_product,elgi_productcategoryname From ELGI_DEALERPRICELISTMASTER where elgi_productgroupname is not null AND elgi_product IS NOT NULL)b
--on a.elgi_existingproduct =b.elgi_product)a
--where elgi_productcategoryname is not null
--group by elgi_opportunitystatusname,elgi_dealer,customerid,customeridname,elgi_existingproductname,createdon,elgi_enquiryid,ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,
--estimatedclosedate)a

--------------------------------------------------------------------------------------------------------------------------------------
----Quote
--union all

--select estimatedclosedate,elgi_opportunitystatusname,elgi_dealer,customerid,customeridname,productidname,createdon,opportunityid,elgi_enquiryid,ownerid,elgi_productcategoryname,owneridname,elgi_dealername,elgi_dealerengineername,
--sum(quantity*priceperunit) as Value,sum(quantity) as CNT  From (
--select * From (
--select a.*,b.productid,priceperunit,quantity,productidname From (
--select estimatedclosedate,elgi_dealer,elgi_enquiryid,opportunityid,ownerid,elgi_opportunitystatusname,owneridname,elgi_dealername,elgi_dealerengineername,customerid,customeridname,createdon  From (
--select  opportunityid,elgi_enquiryid,name,elgi_enquirystatus,elgi_enquirystatusname,elgi_opportunitystatus,elgi_opportunitystatusname,
--statuscode,statuscodename,convert(date,createdon)createdon,convert(date,estimatedclosedate)estimatedclosedate,actualclosedate,ownerid,owneridname,elgi_dealer,elgi_dealername,
--elgi_dealerengineername,elgi_businessverticalname,customerid,customeridname      
--from OPPORTUNITY  where elgi_enquirystatusname='In Progress' and 
--(convert(date,estimatedclosedate) between 
--convert(date,dateadd(d,case when day(getdate())=1 then 0 else -day(getdate()-1) end,getdate())) and dateadd(m,6,convert(date,dateadd(d,-day(getdate()),getdate()))))
--and statuscodename <>'Order Lost' and actualclosedate is null
--and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3'
--AND elgi_customervisit in (select distinct activityid From APPOINTMENT 
----where elgi_lineofbusinessname in ('040a','040b','952','953','954','955')) --WW
--))a
--group by elgi_opportunitystatusname,elgi_dealer,elgi_enquiryid,elgi_opportunitystatusname,ownerid,opportunityid,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,customerid,customeridname,createdon,
--convert(date,estimatedclosedate))a

--inner join(
--select a.opportunityid ,b.* From (
--select ownerid,owneridname,quoteid,elgi_businessverticalname,statuscodename, opportunityid
-- from QUOTE where elgi_businessverticalname ='Industrial' AND statuscodename<>'revised'
-- )a
--inner join (select productid,msdyn_linedescription,priceperunit,quantity,productidname,quoteid,quoteidname From quotedetails)b
--on a.quoteid =b.quoteid )b
--on a.opportunityid =b.opportunityid)a
--left join (
--select DISTINCT elgi_product,elgi_productcategoryname From ELGI_DEALERPRICELISTMASTER where elgi_productgroupname is not null AND elgi_product IS NOT NULL)b
--on a.productid =b.elgi_product)a
--where elgi_productcategoryname is not null
--group by elgi_opportunitystatusname,elgi_dealer,customerid,customeridname,createdon,productidname,opportunityid,elgi_enquiryid,ownerid,elgi_productcategoryname,owneridname,elgi_dealername,elgi_dealerengineername,estimatedclosedate)a
--where elgi_productcategoryname in ('s0','s1','s2','ENCAP','L0','L1','L2','o0','ot','o1','NSD SEP','CAC')
--)a

--group by estimatedclosedate,customerid,customeridname,elgi_existingproductname,owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername,elgi_productcategoryname,ownerid,createdon)a

--left join (
--select distinct b.accountid ,c.elgi_description,elgi_cityname,elgi_statename,elgi_locationofcustomer  
--From (select elgi_lineofbusiness,accountid,elgi_cityname,elgi_statename,elgi_locationofcustomer from ACCOUNT)b
--left join(select distinct elgi_lineofbusinessid,elgi_description  from ELGI_LINEOFBUSINESS)c 
--on b.elgi_lineofbusiness =c.elgi_lineofbusinessid 
--)b
--on a.customerid=b.accountid 



--insert into offer_Active_next2months
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From Active_next2months)a
--on tb3.l1_id=a.ownerid 


--insert into offer_Active_next2months
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From Active_next2months)a
--on tb3.l2_id=a.ownerid 


--insert into offer_Active_next2months
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From Active_next2months)a
--on tb3.l3_id=a.ownerid 


--insert into offer_Active_next2months
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From Active_next2months)a
--on tb3.l4_id=a.ownerid 




--insert into offer_Active_next2months
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--L5_ID,L5_POSNAME,L5_REGION,L5_BUNIT,L5_VERTICAL,L5_ADDRESS,L5_EMPID,L5_EMPNAME,L5_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From Active_next2months)a
--on tb3.l5_id=a.ownerid 


--insert into offer_Active_next2months 
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--L5_ID,L5_POSNAME,L5_REGION,L5_BUNIT,L5_VERTICAL,L5_ADDRESS,L5_EMPID,L5_EMPNAME,L5_EMAIL,
--L6_ID,L6_POSNAME,L6_REGION,L6_BUNIT,L6_VERTICAL,L6_ADDRESS,L6_EMPID,L6_EMPNAME,L6_EMAIL,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From Active_next2months)a
--on tb3.l6_id=a.ownerid 


--insert into  offer_Active_next2months
--select * From tb3
--inner join (select * From Active_next2months)a
--on tb3.l7_id=a.ownerid 

---------------- end offer_Active_next2months
--insert into Active_eqnuiries


--select createdon,elgi_salesoffice,owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername,ownerid,elgi_productcategoryname,
--elgi_salesofficename,sum(Value) as Value,sum(Qty) as Count,'' from (

--select * From (
--select * From (
--select elgi_salesoffice,elgi_salesofficename,elgi_dealer,customeridname,elgi_existingproductname,createdon,opportunityid,elgi_enquiryid,ownerid,elgi_productcategoryname,owneridname,elgi_dealername,
--elgi_dealerengineername,sum(elgi_quantity*elgi_priceperunit) as Value,sum(elgi_quantity) as Qty    From (
--select * From (
--select * From (
--select elgi_dealer,elgi_enquiryid,opportunityid,ownerid,elgi_opportunitystatusname,owneridname,elgi_dealername,elgi_dealerengineername,customeridname,createdon  From (
--select  opportunityid,elgi_enquiryid,name,elgi_enquirystatus,elgi_enquirystatusname,elgi_opportunitystatus,elgi_opportunitystatusname,
--statuscode,statuscodename,convert(date,createdon)createdon,estimatedclosedate,actualclosedate,ownerid,owneridname,elgi_dealer,elgi_dealername,
--elgi_dealerengineername,elgi_businessverticalname,customeridname      
--from OPPORTUNITY  where convert(date,createdon) >='2021-04-01' and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3')a
--group by elgi_dealer,elgi_enquiryid,elgi_opportunitystatusname,ownerid,opportunityid,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,customeridname,createdon)a

--inner join (
--select a.elgi_businessverticalname,a.elgi_revisedflagname,a.elgi_enquiry,b.*   From (
--select elgi_businessverticalname,elgi_revisedflagname,elgi_dealerofferid,elgi_enquiry  From ELGI_DEALEROFFER
--where elgi_businessverticalname='Industrial'  and elgi_revisedflagname<>'Yes' )a
--inner join (
--select elgi_existingproduct, elgi_producttplitemcode,elgi_priceperunit,elgi_quantity,elgi_existingproductname,elgi_dealeroffer,elgi_dealeroffername,elgi_salesoffice,elgi_salesofficename  From ELGI_DEALEROFFERPRODUCT)b 
--on a.elgi_dealerofferid=b.elgi_dealeroffer)b
--on a.opportunityid =b.elgi_enquiry)a
--left join (
--select DISTINCT elgi_product,elgi_productcategoryname From ELGI_DEALERPRICELISTMASTER where elgi_productgroupname is not null AND elgi_product IS NOT NULL)b
--on a.elgi_existingproduct =b.elgi_product)a
--where elgi_productcategoryname is not null
--group by elgi_salesoffice,elgi_salesofficename,elgi_dealer,customeridname,elgi_existingproductname,createdon,elgi_enquiryid,ownerid,elgi_productcategoryname,opportunityid,owneridname,
--elgi_dealername,elgi_dealerengineername)a

--------------------------------------------------------------------------------------------------------------------------------------
----Quote
--union all

--select elgi_salesoffice,elgi_salesofficename,elgi_dealer,customeridname,productidname,createdon,opportunityid,elgi_enquiryid,ownerid,elgi_productcategoryname,owneridname,elgi_dealername,elgi_dealerengineername,
--sum(quantity*priceperunit) as Value,sum(quantity) as CNT  From (
--select * From (
--select a.*,b.productid,priceperunit,quantity,productidname,elgi_salesoffice,elgi_salesofficename From (
--select elgi_dealer,elgi_enquiryid,opportunityid,ownerid,elgi_opportunitystatusname,owneridname,elgi_dealername,elgi_dealerengineername,customeridname,createdon  From (
--select  opportunityid,elgi_enquiryid,name,elgi_enquirystatus,elgi_enquirystatusname,elgi_opportunitystatus,elgi_opportunitystatusname,
--statuscode,statuscodename,convert(date,createdon)createdon,estimatedclosedate,actualclosedate,ownerid,owneridname,elgi_dealer,elgi_dealername,
--elgi_dealerengineername,elgi_businessverticalname,customeridname      
--from OPPORTUNITY  where convert(date,createdon) >='2021-04-01' and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3')a
--group by elgi_dealer,elgi_enquiryid,elgi_opportunitystatusname,ownerid,opportunityid,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,customeridname,createdon)a

--inner join(
--select a.opportunityid ,b.* From (
--select ownerid,owneridname,quoteid,elgi_businessverticalname,statuscodename, opportunityid
-- from QUOTE where elgi_businessverticalname ='Industrial' AND statuscodename<>'revised')a
--inner join (select productid,msdyn_linedescription,priceperunit,quantity,productidname,quoteid,quoteidname,elgi_salesoffice,elgi_salesofficename From quotedetails)b
--on a.quoteid =b.quoteid )b
--on a.opportunityid =b.opportunityid)a
--left join (
--select DISTINCT elgi_product,elgi_productcategoryname From ELGI_DEALERPRICELISTMASTER where elgi_productgroupname is not null AND elgi_product IS NOT NULL)b
--on a.productid =b.elgi_product)a
--where elgi_productcategoryname is not null
--group by elgi_salesoffice,elgi_salesofficename,elgi_dealer,customeridname,createdon,productidname,opportunityid,elgi_enquiryid,ownerid,elgi_productcategoryname,owneridname,elgi_dealername,elgi_dealerengineername)a
----where elgi_productcategoryname in ('s0','s1','s2','ENCAP','L0','L1','L2','o0','ot','o1','NSD SEP','CAC')
--)a
--group by createdon,owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername,ownerid,elgi_productcategoryname,elgi_salesofficename,elgi_salesoffice

--	update Active_eqnuiries set count=0 where count is null

--insert into All_Active_eqnuiries
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From Active_eqnuiries)a
--on tb3.l1_id=a.ownerid 


--insert into All_Active_eqnuiries
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From Active_eqnuiries)a
--on tb3.l2_id=a.ownerid 


--insert into All_Active_eqnuiries
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From Active_eqnuiries)a
--on tb3.l3_id=a.ownerid 


--insert into All_Active_eqnuiries
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From Active_eqnuiries)a
--on tb3.l4_id=a.ownerid 




--insert into All_Active_eqnuiries
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--L5_ID,L5_POSNAME,L5_REGION,L5_BUNIT,L5_VERTICAL,L5_ADDRESS,L5_EMPID,L5_EMPNAME,L5_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From Active_eqnuiries)a
--on tb3.l5_id=a.ownerid 


--insert into All_Active_eqnuiries 
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--L5_ID,L5_POSNAME,L5_REGION,L5_BUNIT,L5_VERTICAL,L5_ADDRESS,L5_EMPID,L5_EMPNAME,L5_EMAIL,
--L6_ID,L6_POSNAME,L6_REGION,L6_BUNIT,L6_VERTICAL,L6_ADDRESS,L6_EMPID,L6_EMPNAME,L6_EMAIL,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From Active_eqnuiries)a
--on tb3.l6_id=a.ownerid 


--insert into  All_Active_eqnuiries
--select * From tb3
--inner join (select * From Active_eqnuiries)a
--on tb3.l7_id=a.ownerid 

------------------------------

--insert into orders_elgi --- total inflow

--select a.*,b.elgi_description as Segment,elgi_cityname,elgi_statename,elgi_locationofcustomer  From (
--select customeridname,customerid,elgi_existingproductname,--owneridname,elgi_dealer,elgi_salesoffice,elgi_salesofficename,convert(date,createdon)createdon,elgi_dealername,--elgi_dealerengineername,ownerid,elgi_productcategoryname,sum(count)as count,sum(value)as value 
--from (

--select  customeridname,customerid,productidname as elgi_existingproductname,--owneridname,elgi_dealer,elgi_salesoffice,elgi_salesofficename,createdon,elgi_dealername,elgi_dealerengineername,ownerid,elgi_productcategoryname,sum(quantity)as count,
--sum(quantity*priceperunit)as value from (
--select * from(
--select a.*,b.priceperunit,b.productid,b.quantity,b.productidname from(
--Select elgi_dealer,
--case when elgi_dealerindent is not null then customeridname else elgi_dealername end as elgi_dealername,elgi_dealerengineername,ownerid,owneridname,salesorderid,
--convert(date,createdon)createdon,elgi_salesoffice,elgi_salesofficename, customerid, customeridname, elgi_dealerindent, 
--elgi_dealerindentname, quoteid,quoteidname,elgi_businessverticalname from SALESORDER 
--where --quoteidname like '%industrial%' and
--convert(date,createdon) >= '2021-04-01'  
--and elgi_salesofficename in ('SEPSAC - DIRECT','OFSAC - UNITS','ENCAP','VOLTAS','SEPSAC','LEPSAC','MEDICAL','SEPSAC- NSD','OFSAC-TURNKEY','CAC')
--AND (elgi_dealerindent IS NOT NULL OR quoteid IS NOT NULL) 
--AND statecodename <>'canceled' 
--)a
--inner join (Select salesorderid,priceperunit,productid,quantity,productidname from SALESORDERDETAIL where convert(date,createdon) >= '2021-04-01' )b 
--on a.salesorderid = b.salesorderid)a
--left join (select distinct elgi_product,elgi_productcategoryname from ELGI_DEALERPRICELISTMASTER where --elgi_productcategoryname is not null) b
--on a.productid=b.elgi_product
--)a--where elgi_productcategoryname is null
--group by customeridname,customerid,productidname,owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername,ownerid,elgi_productcategoryname,convert(date,createdon),elgi_salesofficename,elgi_salesoffice

--union all
-----------------------

--select customeridname,customerid,elgi_existingproductname,
--owneridname,elgi_dealer,elgi_salesoffice,elgi_salesofficename,createdon,elgi_dealername,elgi_dealerengineername,ownerid,elgi_productcategoryname,
--sum(elgi_quantity) as Count,sum(elgi_quantity*elgi_priceperunit) as Value From (

--select * From (
--select * From (
--select owneridname,createdon,elgi_dealername,elgi_dealerengineername,opportunityid,ownerid,elgi_opportunitystatusname,elgi_dealer,estimatedclosedate,customeridname,customerid  From (
--select opportunityid,elgi_enquiryid,name,elgi_enquirystatus,elgi_enquirystatusname,elgi_opportunitystatus,elgi_opportunitystatusname,
--statuscode,statuscodename,convert(date,createdon)createdon,convert(date,estimatedclosedate)estimatedclosedate,actualclosedate,ownerid,owneridname,elgi_dealer,elgi_dealername,
--elgi_dealerengineername,elgi_businessverticalname,customeridname,customerid
--from OPPORTUNITY 
--where statecodename = 'Won'
--and (convert(date,actualclosedate))>='2021-04-01'
--and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3' --- DUE TO SYSTEM INTEGRATION
--)a
--group by owneridname,createdon,convert(date,estimatedclosedate),elgi_dealername,elgi_dealerengineername,elgi_opportunitystatusname,ownerid,opportunityid,elgi_dealer,customeridname,customerid)a
--inner join (
--select a.elgi_businessverticalname,a.elgi_revisedflagname,a.elgi_enquiry,b.* From (
--select elgi_businessverticalname,elgi_revisedflagname,elgi_dealerofferid,elgi_enquiry  From ELGI_DEALEROFFER
--where elgi_revisedflagname<>'Yes'
--)a
--inner join (
--select elgi_existingproduct, elgi_producttplitemcode,elgi_priceperunit,elgi_quantity,elgi_existingproductname,
--elgi_dealeroffer,elgi_dealeroffername,elgi_salesofficename,elgi_salesoffice From ELGI_DEALEROFFERPRODUCT where elgi_salesofficename in ('ENCAP','SEPSAC','LEPSAC'))b 
--on a.elgi_dealerofferid=b.elgi_dealeroffer  )b
--on a.opportunityid =b.elgi_enquiry)a
--left join (
--select DISTINCT elgi_product,--,elgi_itemcode, --elgi_productgroupname,elgi_productsubgroupname,
--elgi_productcategoryname 
--From ELGI_DEALERPRICELISTMASTER where elgi_productgroupname is not null AND elgi_product IS NOT NULL)b
--on a.elgi_existingproduct =b.elgi_product
--)a
--where elgi_productcategoryname is not null
--group by customeridname,customerid,elgi_existingproductname,
--owneridname,elgi_salesofficename,elgi_salesoffice,createdon,elgi_dealername,elgi_dealerengineername,ownerid,elgi_dealer,elgi_productcategoryname
--)a
--group by customeridname,customerid,elgi_existingproductname,
--owneridname,elgi_dealer,elgi_salesoffice,elgi_salesofficename,convert(date,createdon),elgi_dealername,elgi_dealerengineername,ownerid,elgi_productcategoryname)a
----where elgi_productcategoryname in ('s0','s1','s2','ENCAP','L0','L1','L2','o0','ot','o1','NSD SEP','CAC')
--left join(
--select b.accountid ,c.elgi_description,elgi_cityname,elgi_statename,elgi_locationofcustomer  From 
--(select elgi_lineofbusiness,accountid,elgi_cityname,elgi_statename,elgi_locationofcustomer from ACCOUNT)b -- for segment
--left join(select distinct elgi_lineofbusinessid,elgi_description  from ELGI_LINEOFBUSINESS)c 
--on b.elgi_lineofbusiness =c.elgi_lineofbusinessid )b
--on a.customerid=b.accountid 


--insert into  orders_to_elgi
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From orders_elgi)a
--on tb3.l1_id=a.ownerid 


--insert into orders_to_elgi
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From orders_elgi)a
--on tb3.l2_id=a.ownerid 


--insert into orders_to_elgi
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From orders_elgi)a
--on tb3.l3_id=a.ownerid 


--insert into orders_to_elgi
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From orders_elgi)a
--on tb3.l4_id=a.ownerid 




--insert into orders_to_elgi
--select distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--L5_ID,L5_POSNAME,L5_REGION,L5_BUNIT,L5_VERTICAL,L5_ADDRESS,L5_EMPID,L5_EMPNAME,L5_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From orders_elgi)a
--on tb3.l5_id=a.ownerid 


--insert into orders_to_elgi 
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--L5_ID,L5_POSNAME,L5_REGION,L5_BUNIT,L5_VERTICAL,L5_ADDRESS,L5_EMPID,L5_EMPNAME,L5_EMAIL,
--L6_ID,L6_POSNAME,L6_REGION,L6_BUNIT,L6_VERTICAL,L6_ADDRESS,L6_EMPID,L6_EMPNAME,L6_EMAIL,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From orders_elgi)a
--on tb3.l6_id=a.ownerid 


--insert into orders_to_elgi
--select *  From tb3
--inner join (select * From orders_elgi)a
--on tb3.l7_id=a.ownerid 
---------------------------------------


--insert into  reasonname 

--select a.*,b.Segment,elgi_cityname,elgi_statename,elgi_locationofcustomer   from (
--select opportunityid, owneridname,actualclosedate,elgi_dealer,elgi_dealername,elgi_dealerengineername,ownerid,elgi_reasonname,elgi_losttoname,customeridname,customerid,elgi_model,createdon,
--sum(isnull(elgi_numbers,1)) as count from
--(select opportunityid,convert(date,createdon)createdon, actualclosedate, elgi_losttoname, elgi_model,elgi_numbers, elgi_opportunitystatusname,
--statuscodename, elgi_reasonname,elgi_remarks,ownerid,owneridname,elgi_dealerengineername,elgi_dealername,elgi_dealer,customerid,customeridname from OPPORTUNITY
--where statuscodename = 'Order Lost' and convert(date,actualclosedate)>= '2021-04-01'
--)a
--group by opportunityid,owneridname,actualclosedate,elgi_dealername,elgi_dealerengineername,elgi_reasonname,elgi_losttoname,ownerid,elgi_dealer,customeridname,customerid,elgi_model,createdon)a

----- to find the product details
----left join (select a.opportunityid,b.productidname,b.quantity From QUOTE a,QUOTEDETAILS b where a.quoteid =b.quoteid)b  
----on a.opportunityid =b.opportunityid 

--left join(
--select b.accountid ,c.elgi_description as Segment,elgi_cityname,elgi_statename,elgi_locationofcustomer  From
--(select elgi_lineofbusiness,accountid,elgi_cityname,elgi_statename,elgi_locationofcustomer from ACCOUNT)b -- for segment
--left join(select distinct elgi_lineofbusinessid,elgi_description  from ELGI_LINEOFBUSINESS)c 
--on b.elgi_lineofbusiness =c.elgi_lineofbusinessid )b
--on a.customerid=b.accountid 


------------ if we want product details for order lost below querry
---------------------------
----select * From (
----select * From (
------select a.*,b.Segment,d.productidname,d.quantity,d.extendedamount,d.priceperunit,d.tax  from (
----select a.*,productid,priceperunit,quantity,productidname From (
----select opportunityid, owneridname,actualclosedate,elgi_dealer,elgi_dealername,elgi_dealerengineername,ownerid,elgi_reasonname,elgi_losttoname,customeridname,customerid,elgi_model,
----sum(isnull(elgi_numbers,1)) as count from
----(select opportunityid, actualclosedate, elgi_losttoname, elgi_model,elgi_numbers, elgi_opportunitystatusname,
----statuscodename, elgi_reasonname,elgi_remarks,ownerid,owneridname,elgi_dealerengineername,elgi_dealername,elgi_dealer,customerid,customeridname from OPPORTUNITY
----where statuscodename = 'Order Lost' and convert(date,actualclosedate)>= '2021-04-01')a
------where opportunityid='828AF05D-7433-E911-A980-000D3AF262E1'
----group by opportunityid,owneridname,actualclosedate,elgi_dealername,elgi_dealerengineername,elgi_reasonname,elgi_losttoname,ownerid,elgi_dealer,customeridname,customerid,elgi_model
----)a

----left join (
----select a.opportunityid ,b.* From (
----select quoteid,elgi_businessverticalname,opportunityid from QUOTE where elgi_businessverticalname ='Industrial' AND statuscodename='Lost')a
----inner join (select productid,msdyn_linedescription,productidname,quoteid,quoteidname,sum(priceperunit)priceperunit,sum(quantity)quantity From quotedetails
----group by productid,msdyn_linedescription,productidname,quoteid,quoteidname)b
----on a.quoteid =b.quoteid
----)b
----on a.opportunityid =b.opportunityid)a

----left join (
----select DISTINCT elgi_product,elgi_productcategoryname From ELGI_DEALERPRICELISTMASTER where elgi_productgroupname is not null AND elgi_product IS NOT NULL)b
----on a.productid =b.elgi_product)a
------where elgi_productcategoryname is not null --in ('s0','s1','s2','ENCAP','L0','L1','L2','o0','ot','o1','NSD SEP','CAC')
------where opportunityid='828AF05D-7433-E911-A980-000D3AF262E1'

------------------------------------


--insert into elgi_reasonname
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From reasonname)a
--on tb3.l1_id=a.ownerid 


--insert into elgi_reasonname

--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From reasonname)a
--on tb3.l2_id=a.ownerid 


--insert into elgi_reasonname
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From reasonname)a
--on tb3.l3_id=a.ownerid 


--insert into elgi_reasonname
--select  distinct L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From reasonname)a
--on tb3.l4_id=a.ownerid 




--insert into elgi_reasonname
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--L5_ID,L5_POSNAME,L5_REGION,L5_BUNIT,L5_VERTICAL,L5_ADDRESS,L5_EMPID,L5_EMPNAME,L5_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From reasonname)a
--on tb3.l5_id=a.ownerid 


--insert into elgi_reasonname 
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--L5_ID,L5_POSNAME,L5_REGION,L5_BUNIT,L5_VERTICAL,L5_ADDRESS,L5_EMPID,L5_EMPNAME,L5_EMAIL,
--L6_ID,L6_POSNAME,L6_REGION,L6_BUNIT,L6_VERTICAL,L6_ADDRESS,L6_EMPID,L6_EMPNAME,L6_EMAIL,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From reasonname)a
--on tb3.l6_id=a.ownerid 


--insert into  elgi_reasonname 
--select * From tb3
--inner join (select * From reasonname)a
--on tb3.l7_id=a.ownerid 

---------------------------------------------------------------
--insert into ordersdealer
---- orders to dealer
--select *  From (
--select owneridname,elgi_salesofficename,elgi_salesoffice,createdon,elgi_dealername,elgi_dealerengineername,ownerid,elgi_dealer,elgi_productcategoryname,sum(elgi_quantity*elgi_priceperunit) as Value,sum(elgi_quantity) as Count  From (
--select * From (
--select * From (
--select owneridname,createdon,elgi_dealername,elgi_dealerengineername,opportunityid,ownerid,elgi_opportunitystatusname,elgi_dealer  From (
--select opportunityid,elgi_enquiryid,name,elgi_enquirystatus,elgi_enquirystatusname,elgi_opportunitystatus,elgi_opportunitystatusname,
--statuscode,statuscodename,convert(date,createdon)createdon,estimatedclosedate,actualclosedate,ownerid,owneridname,elgi_dealer,elgi_dealername,
--elgi_dealerengineername,elgi_businessverticalname,customeridname       
--from OPPORTUNITY 
--where statecodename = 'Won'
--and (convert(date,actualclosedate))>='2021-04-01'
--and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3' --- DUE TO SYSTEM INTEGRATION
--)a
--group by owneridname,createdon,elgi_dealername,elgi_dealerengineername,elgi_opportunitystatusname,ownerid,opportunityid,elgi_dealer)a
--inner join (
--select a.elgi_businessverticalname,a.elgi_revisedflagname,a.elgi_enquiry,b.* From (
--select elgi_businessverticalname,elgi_revisedflagname,elgi_dealerofferid,elgi_enquiry  From ELGI_DEALEROFFER
--where elgi_businessverticalname='Industrial'  and 
-- elgi_revisedflagname<>'Yes'
--)a
--inner join (
--select elgi_existingproduct, elgi_producttplitemcode,elgi_priceperunit,elgi_quantity,elgi_existingproductname,
--elgi_dealeroffer,elgi_dealeroffername,elgi_salesofficename,elgi_salesoffice From ELGI_DEALEROFFERPRODUCT where elgi_salesofficename in ('ENCAP','SEPSAC','LEPSAC'))b 
--on a.elgi_dealerofferid=b.elgi_dealeroffer  )b
--on a.opportunityid =b.elgi_enquiry)a
--left join (
--select DISTINCT elgi_product,--,elgi_itemcode, --elgi_productgroupname,elgi_productsubgroupname,
--elgi_productcategoryname 
--From ELGI_DEALERPRICELISTMASTER where elgi_productgroupname is not null AND elgi_product IS NOT NULL)b
--on a.elgi_existingproduct =b.elgi_product
--)a
--where elgi_productcategoryname is not null
--group by owneridname,createdon,elgi_dealername,elgi_dealerengineername,ownerid,elgi_productcategoryname,elgi_dealer,elgi_salesofficename,elgi_salesoffice)a



--insert into orders_to_dealer 
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From ordersdealer)a
--on tb3.l1_id=a.ownerid 


--insert into orders_to_dealer 
--select distinct L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From ordersdealer)a
--on tb3.l2_id=a.ownerid 


--insert into orders_to_dealer 
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From ordersdealer)a
--on tb3.l3_id=a.ownerid 


--insert into orders_to_dealer 
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From ordersdealer)a
--on tb3.l4_id=a.ownerid 


--insert into orders_to_dealer 
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--L5_ID,L5_POSNAME,L5_REGION,L5_BUNIT,L5_VERTICAL,L5_ADDRESS,L5_EMPID,L5_EMPNAME,L5_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From ordersdealer)a
--on tb3.l5_id=a.ownerid 


--insert into orders_to_dealer  
--select  distinct  L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--L5_ID,L5_POSNAME,L5_REGION,L5_BUNIT,L5_VERTICAL,L5_ADDRESS,L5_EMPID,L5_EMPNAME,L5_EMAIL,
--L6_ID,L6_POSNAME,L6_REGION,L6_BUNIT,L6_VERTICAL,L6_ADDRESS,L6_EMPID,L6_EMPNAME,L6_EMAIL,
--null,null,null,null,null,null,null,null,null,
--a.* From tb3
--inner join (select * From ordersdealer)a
--on tb3.l6_id=a.ownerid 


--insert into orders_to_dealer 
--select * From tb3
--inner join (select * From ordersdealer)a
--on tb3.l7_id=a.ownerid 


--insert into Funnel 
--	  --------------- funnel data
--select * From (
--select NAME,ownerid,owneridname,elgi_dealername,elgi_dealerengineername,sum(coldDistcustomer)coldDistcustomer,sum(noncoldDistcustomer)noncoldDistcustomer,
--sum(lastyearcold) lastyearcold,sum(lastyearnoncold) lastyearnoncold,sum(coldcalls_cnt)coldcalls_cnt,sum(Non_coldcalls_cnt)Non_coldcalls_cnt  from (

---------------- visits
--select 'VISITS' as NAME, ownerid,owneridname,elgi_dealername,elgi_dealerengineername,sum(coldvisits)coldDistcustomer,sum(noncoldvisits)noncoldDistcustomer,0 as lastyearcold,0 as lastyearnoncold,
--sum(coldcalls_cnt)coldcalls_cnt,sum(Non_coldcalls)Non_coldcalls_cnt
-- from(
--select elgi_dealer,owneridname,
--elgi_dealername,elgi_dealerengineername,elgi_monthstartingdate,elgi_weeklyplannumbername,ownerid,elgi_customerclassificationname,elgi_description,
--sum(coldcalls_cnt)coldcalls_cnt,sum(Non_coldcalls)Non_coldcalls,sum(coldvisits)coldvisits,sum(noncoldvisits)noncoldvisits from(

--select elgi_dealer,owneridname,
--elgi_dealername,elgi_dealerengineername,ownerid,elgi_customerclassificationname,elgi_description,
--convert(date,elgi_monthstartingdate)elgi_monthstartingdate,elgi_weeklyplannumbername,sum(coldcalls_cnt)coldcalls_cnt,sum(Non_coldcalls)Non_coldcalls,sum(Visits)coldvisits,0 as noncoldvisits from(
--select a.*,b.name,b.elgi_customerclassificationname,b.elgi_lineofbusinessname,b.elgi_description From (
--select  substring(requiredattendees,14,36)as custcode,elgi_dealer,elgi_dealername,elgi_dealerengineername,
--convert(date,elgi_monthstartingdate)elgi_monthstartingdate,elgi_weeklyplannumbername,convert(date,elgi_latestvisitdate)elgi_latestvisitdate,
--ownerid,owneridname,elgi_customertypesalesname ,count(distinct substring(requiredattendees,14,36)) as coldcalls_cnt,count(substring(requiredattendees,14,36)) as Visits,0 as Non_coldcalls from ( --distinct removed
--select *,row_number()over(partition by ownerid,substring(requiredattendees,14,36) order by elgi_latestvisitdate desc) as rno from APPOINTMENT 
--where --elgi_customervisitid in ('cv-155030','cv-154986') and 
--elgi_customertypesalesname ='Cold Calls'
--and requiredattendees<>'[]'
--and statecodename<>'Canceled'--and elgi_customervisitid='CV-220001'
--and convert(date,elgi_monthstartingdate)>='2021-04-01'
--and convert(date,elgi_latestvisitdate) is not null )a
--where rno<2
--group by owneridname,convert(date,elgi_latestvisitdate),elgi_customertypesalesname,owneridname,ownerid,elgi_weeklyplannumbername,convert(date,elgi_monthstartingdate)
--,elgi_dealer,elgi_dealername,elgi_dealerengineername,substring(requiredattendees,14,36))a

--left join (
--select a.*,c.elgi_description From (select accountid,name,elgi_lineofbusinessname,elgi_customerclassificationname From ACCOUNT)a
--left join (select elgi_name,elgi_description From ELGI_LINEOFBUSINESS)c
--on a.elgi_lineofbusinessname =c.elgi_name)b
--on a.CustCode=b.accountid)A
----where elgi_dealerengineername like '%vijaya%'
--group by owneridname,elgi_dealer,elgi_description,elgi_dealername,elgi_dealerengineername,ownerid,elgi_customerclassificationname,convert(date,elgi_monthstartingdate),elgi_weeklyplannumbername

--union all

--select elgi_dealer,owneridname,
--elgi_dealername,elgi_dealerengineername,ownerid,elgi_customerclassificationname,elgi_description,
--convert(date,elgi_monthstartingdate)elgi_monthstartingdate,elgi_weeklyplannumbername,sum(coldcalls_cnt)coldcalls_cnt,sum(Non_coldcalls)Non_coldcalls,0 as coldvisits,sum(noncoldvisits)noncoldvisits from(
--select a.*,b.name,b.elgi_customerclassificationname,b.elgi_lineofbusinessname,b.elgi_description From (
--select  substring(requiredattendees,14,36)as custcode,elgi_dealer,elgi_dealername,elgi_dealerengineername,convert(date,elgi_monthstartingdate)elgi_monthstartingdate,elgi_weeklyplannumbername,convert(date,elgi_latestvisitdate)elgi_latestvisitdate,
--owneridname,ownerid,elgi_customertypesalesname ,0 as coldcalls_cnt,count(distinct substring(requiredattendees,14,36)) as Non_coldcalls,count(substring(requiredattendees,14,36)) as noncoldvisits from (
--select *,row_number()over(partition by ownerid,substring(requiredattendees,14,36) order by elgi_latestvisitdate desc) as rno from APPOINTMENT 
--where --elgi_customervisitid in ('cv-155030','cv-154986') and 
--elgi_customertypesalesname <>'Cold Calls' and elgi_customertypesalesname is not null
--and requiredattendees<>'[]'
--and statecodename<>'Canceled'--and elgi_customervisitid='CV-220001'
--and convert(date,elgi_monthstartingdate)>='2021-04-01'
--and convert(date,elgi_latestvisitdate) is not null)a
----where rno<2
--group by convert(date,elgi_latestvisitdate),elgi_customertypesalesname,owneridname,ownerid,elgi_weeklyplannumbername,convert(date,elgi_monthstartingdate)
--,elgi_dealer,elgi_dealername,elgi_dealerengineername,substring(requiredattendees,14,36))a

--left join (
--select a.*,c.elgi_description From (select accountid,name,elgi_lineofbusinessname,elgi_customerclassificationname From ACCOUNT)a
--left join (select elgi_name,elgi_description From ELGI_LINEOFBUSINESS)c
--on a.elgi_lineofbusinessname =c.elgi_name)b
--on a.CustCode=b.accountid)A
----where elgi_dealerengineername like '%vijaya%'
--group by owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername,ownerid,elgi_customerclassificationname,convert(date,elgi_monthstartingdate),elgi_weeklyplannumbername,elgi_description

--)a
--group by owneridname,elgi_dealer,elgi_description,elgi_dealername,elgi_dealerengineername,ownerid,elgi_customerclassificationname,convert(date,elgi_monthstartingdate),elgi_weeklyplannumbername
--)a
--group by ownerid,owneridname,elgi_dealername,elgi_dealerengineername

-------------- end visit


----------------- start Enquiry
--union all


--select 'Enquiry' as NAME,ownerid,owneridname,elgi_dealername,elgi_dealerengineername,
--sum(coldDistcustomer)coldDistcustomer,sum(noncoldDistcustomer)noncoldDistcustomer,0 as lastyearcold, 0 as lastyearnoncold,sum(Coldcalls)coldcalls_cnt,sum(NonColdcalls)Non_coldcalls_cnt from (
--select ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername,
--sum(case when type='Cold Calls' then cnt else 0 end)as Coldcalls,
--sum(case when type='Non ColdCalls' then cnt else 0 end) as NonColdcalls,

--case when type='Cold Calls' then count(distinct customerid) else 0 end as coldDistcustomer,
--case when type='Non ColdCalls' then count(distinct customerid) else 0 end  as noncoldDistcustomer,
--count(distinct customerid)customerid

--from(
--select ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername ,b.elgi_customertypesalesname,a.customerid,case when b.elgi_customertypesalesname='Cold Calls' then 'Cold Calls' else 'Non ColdCalls' end as type,cnt From (
--select ownerid,elgi_customervisitid,customerid,owneridname,elgi_dealername,elgi_dealerengineername,count(*) as cnt from(
--select ownerid,elgi_customervisitid,customerid,owneridname,elgi_dealername,elgi_dealerengineername from OPPORTUNITY 
--where --elgi_businessverticalname='Industrial' and 
-- elgi_opportunitystatusname in ('Enquiry','Lead')--('Quotation','Negotiation')
--and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3'
--and statuscodename <>'Order Lost'
--and actualclosedate is null
--and convert(date,createdon)>='2021-04-01')a
--group by ownerid,elgi_customervisitid,customerid,owneridname,elgi_dealername,elgi_dealerengineername)a
--left join (select distinct elgi_customervisitid,elgi_customertypesalesname,substring(requiredattendees,14,36) AS CUSTOMERID From APPOINTMENT)b
--on a.elgi_customervisitid =b.elgi_customervisitid 
--AND convert(varchar(100),A.customerid) =B.CUSTOMERID)a
--group by ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername,type)a
--group by ownerid,owneridname,elgi_dealername,elgi_dealerengineername

----------- end Enquiry

--union all

------------------------- enquiryNEW

--select 'Enquiry' as NAME,ownerid,owneridname,elgi_dealername,elgi_dealerengineername,
--0 as coldDistcustomer,0 as noncoldDistcustomer,sum(Coldcalls) as lastyearcold,sum(NonColdcalls) as lastyearnoncold,0 as coldcalls_cnt,0 as Non_coldcalls_cnt from (
--select ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername,
--sum(case when type='Cold Calls' then cnt else 0 end)as Coldcalls,
--sum(case when type='Non ColdCalls' then cnt else 0 end) as NonColdcalls
--from(
--select ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername ,b.elgi_customertypesalesname,a.customerid,case when b.elgi_customertypesalesname='Cold Calls' then 'Cold Calls' else 'Non ColdCalls' end as type,cnt From (
--select ownerid,elgi_customervisitid,customerid,owneridname,elgi_dealername,elgi_dealerengineername,count(*) as cnt from(
--select ownerid,elgi_customervisitid,customerid,owneridname,elgi_dealername,elgi_dealerengineername from OPPORTUNITY 
--where --elgi_businessverticalname='Industrial' and
-- elgi_opportunitystatusname in ('Enquiry','Lead')--('Quotation','Negotiation')
--and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3'
--and statuscodename <>'Order Lost'
--and actualclosedate is null
--and convert(date,createdon)<'2021-04-01')a
--group by ownerid,elgi_customervisitid,customerid,owneridname,elgi_dealername,elgi_dealerengineername)a
--left join (select distinct elgi_customervisitid,elgi_customertypesalesname,substring(requiredattendees,14,36) AS CUSTOMERID From APPOINTMENT)b
--on a.elgi_customervisitid =b.elgi_customervisitid 
--AND convert(varchar(100),A.customerid) =B.CUSTOMERID)a
--group by ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername)a
--group by ownerid,owneridname,elgi_dealername,elgi_dealerengineername

--------------- end enquiryNEW

--union all
---------------------------- total Quote
--select 'Quote'as Name,ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername,
--sum(case when type='Cold Calls' then Distcustomer else 0 end)as coldDistcustomer,
--sum(case when type='Non ColdCalls' then Distcustomer  else 0 end) as noncoldDistcustomer,
--0 as lastyearcold,0 as lastyearnoncold,
--sum(case when type='Cold Calls' then qty else 0 end)as coldcalls_cnt,
--sum(case when type='Non ColdCalls' then qty  else 0 end) as Non_coldcalls_cnt
-- from (
--select a.*,b.elgi_customertypesalesname,case when b.elgi_customertypesalesname='Cold Calls' then 'Cold Calls' else 'Non ColdCalls' end as type  From (
--select ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,SUM(VALUE)Value,SUM(Qty) AS Qty,sum(Distcustomer)Distcustomer From (

--------------------- dealer offer
--select ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,SUM(VALUE)Value,SUM(CNT) AS Qty,sum(Distcustomer)Distcustomer From (
--select opportunityid,ownerid,elgi_productcategoryname,owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername
--,sum(elgi_quantity*elgi_priceperunit) as Value,sum(elgi_quantity) as CNT,count(distinct customerid)Distcustomer    From (
--select * From (
--select * From (
--select opportunityid,ownerid,elgi_opportunitystatusname,owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername,customerid  From (
--select  opportunityid,elgi_enquiryid,name,elgi_enquirystatus,elgi_enquirystatusname,elgi_opportunitystatus,elgi_opportunitystatusname,
--statuscode,statuscodename,convert(date,createdon)createdon,estimatedclosedate,actualclosedate,ownerid,owneridname,elgi_dealer,elgi_dealername,
--elgi_dealerengineername,elgi_businessverticalname,customerid        
--from OPPORTUNITY 
--where elgi_enquirystatusname='In Progress'
--and elgi_opportunitystatusname in ('Quotation','Negotiation','Enquiry','Lead')
--and (convert(date,createdon))>='2021-04-01'
--and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3' --- DUE TO SYSTEM INTEGRATION
--and statuscodename <>'Order Lost'
--and actualclosedate is null)a)a
----group by opportunityid,ownerid,elgi_opportunitystatusname,owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername)a
--inner join (

--select a.elgi_businessverticalname,a.elgi_revisedflagname,a.elgi_enquiry,b.*   From (
--select elgi_businessverticalname,elgi_revisedflagname,elgi_dealerofferid,elgi_enquiry  From ELGI_DEALEROFFER
--where elgi_revisedflagname<>'Yes' )a --elgi_businessverticalname='Industrial'  and
--inner join (
--select elgi_existingproduct, elgi_producttplitemcode,elgi_priceperunit,elgi_quantity,elgi_existingproductname,
--elgi_dealeroffer,elgi_dealeroffername, createdon    From ELGI_DEALEROFFERPRODUCT)b 
--on a.elgi_dealerofferid=b.elgi_dealeroffer  )b
--on a.opportunityid =b.elgi_enquiry)a
--left join (
--select DISTINCT elgi_product,--,elgi_itemcode, --elgi_productgroupname,elgi_productsubgroupname,
--elgi_productcategoryname 
--From ELGI_DEALERPRICELISTMASTER where elgi_productgroupname is not null AND elgi_product IS NOT NULL)b
--on a.elgi_existingproduct =b.elgi_product
--)a
--where elgi_productcategoryname is not null
--group by ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername)a
--group by ownerid,owneridname,elgi_dealername,elgi_dealerengineername,elgi_productcategoryname,opportunityid


------------------- --------------------- end dealer offer

--union all

--------------- quote

--select ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,SUM(VALUE)Value,SUM(CNT) AS Qty,sum(Distcustomer)Distcustomer From (
--select owneridname,elgi_dealername,elgi_dealerengineername,opportunityid,ownerid,elgi_productcategoryname,sum(quantity*priceperunit) as Value,sum(quantity) as CNT,count(distinct customerid)Distcustomer From (
--select * From (
--select a.elgi_opportunitystatusname,A.elgi_dealername,A.elgi_dealerengineername,customerid,b.* From (
--select opportunityid,ownerid,elgi_opportunitystatusname,owneridname,elgi_dealername,elgi_dealerengineername,customerid From (
--select  opportunityid,elgi_enquiryid,name,elgi_enquirystatus,elgi_enquirystatusname,elgi_opportunitystatus,elgi_opportunitystatusname,
--statuscode,statuscodename,convert(date,createdon)createdon,estimatedclosedate,actualclosedate,ownerid,owneridname,elgi_dealer,elgi_dealername,
--elgi_dealerengineername,elgi_businessverticalname,customerid    
--from OPPORTUNITY 
--where elgi_enquirystatusname='In Progress'
--and elgi_opportunitystatusname in ('Quotation','Negotiation','Enquiry','Lead')
--and (convert(date,createdon))>='2021-04-01'
--and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3' --- DUE TO SYSTEM INTEGRATION
--and statuscodename <>'Order Lost'
--and actualclosedate is null)a)a
----group by elgi_opportunitystatusname,ownerid,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername)a
--inner join(
--select a.ownerid,a.owneridname,a.elgi_businessverticalname,a.statuscodename,a.opportunityid ,b.* From (
--select ownerid,owneridname,quoteid,elgi_businessverticalname,statuscodename, opportunityid
-- from QUOTE where statuscodename<>'revised')a -- elgi_businessverticalname ='Industrial' AND
--inner join (select productid, msdyn_linedescription,priceperunit,quantity,productidname,quoteid,quoteidname, createdon   From quotedetails)b
--on a.quoteid =b.quoteid )b
--on a.opportunityid =b.opportunityid)a
--left join (
--select DISTINCT elgi_product,--,elgi_itemcode, --elgi_productgroupname,elgi_productsubgroupname,
--elgi_productcategoryname 
--From ELGI_DEALERPRICELISTMASTER where elgi_productgroupname is not null AND elgi_product IS NOT NULL)b
--on a.productid =b.elgi_product)a
--where elgi_productcategoryname is not null
--group by ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername)a
--group by ownerid,owneridname,elgi_dealername,elgi_dealerengineername,elgi_productcategoryname,opportunityid

-------------- end quote
--)a
----where elgi_productcategoryname in ('s0','s1','s2','ENCAP','L0','L1','L2','o0','ot','o1','NSD SEP','CAC')--WW
--group by ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername)a
--left join (
--select * From (
--select a.*,b.opportunityid  From (
--select elgi_customervisitid,elgi_customertypesalesname,substring(requiredattendees,14,36)as customerid From APPOINTMENT 
--where elgi_customertypesalesname is not null)a
--left join (select elgi_customervisitid,opportunityid,convert(varchar(100),customerid)customerid    From OPPORTUNITY)b 
--on a.customerid =b.customerid 
--and a.elgi_customervisitid =b.elgi_customervisitid )a
--where opportunityid is not null)b
--on a.opportunityid =b.opportunityid )a
--group by ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername

------ -------------------------- end total Quote

--union all

---------------------------- total Quotenew
--select 'Quote'as Name,ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername,
--0 as coldDistcustomer,0 as noncoldDistcustomer,
--sum(case when type='Cold Calls' then qty else 0 end)as lastyearcold,
--sum(case when type='Non ColdCalls' then qty  else 0 end) as lastyearnoncold,
--0 as coldcalls_cnt,0 as Non_coldcalls_cnt
-- from (
--select a.*,b.elgi_customertypesalesname,case when b.elgi_customertypesalesname='Cold Calls' then 'Cold Calls' else 'Non ColdCalls' end as type  From (
--select ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,SUM(VALUE)Value,SUM(Qty) AS Qty,sum(Distcustomer)Distcustomer From (

--------------------- dealer offer
--select ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,SUM(VALUE)Value,SUM(CNT) AS Qty,sum(Distcustomer)Distcustomer From (
--select opportunityid,ownerid,elgi_productcategoryname,owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername
--,sum(elgi_quantity*elgi_priceperunit) as Value,sum(elgi_quantity) as CNT,count(distinct customerid)Distcustomer    From (
--select * From (
--select * From (
--select opportunityid,ownerid,elgi_opportunitystatusname,owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername,customerid  From (
--select  opportunityid,elgi_enquiryid,name,elgi_enquirystatus,elgi_enquirystatusname,elgi_opportunitystatus,elgi_opportunitystatusname,
--statuscode,statuscodename,convert(date,createdon)createdon,estimatedclosedate,actualclosedate,ownerid,owneridname,elgi_dealer,elgi_dealername,
--elgi_dealerengineername,elgi_businessverticalname,customerid        
--from OPPORTUNITY 
--where elgi_enquirystatusname='In Progress'
--and elgi_opportunitystatusname in ('Quotation','Negotiation','Enquiry','Lead')
--and (convert(date,createdon))<'2021-04-01'
--and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3' --- DUE TO SYSTEM INTEGRATION
--and statuscodename <>'Order Lost'
--and actualclosedate is null)a)a
----group by opportunityid,ownerid,elgi_opportunitystatusname,owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername)a
--inner join (

--select a.elgi_businessverticalname,a.elgi_revisedflagname,a.elgi_enquiry,b.*   From (
--select elgi_businessverticalname,elgi_revisedflagname,elgi_dealerofferid,elgi_enquiry  From ELGI_DEALEROFFER
--where elgi_revisedflagname<>'Yes' )a --elgi_businessverticalname='Industrial'  and
--inner join (
--select elgi_existingproduct, elgi_producttplitemcode,elgi_priceperunit,elgi_quantity,elgi_existingproductname,
--elgi_dealeroffer,elgi_dealeroffername, createdon    From ELGI_DEALEROFFERPRODUCT)b 
--on a.elgi_dealerofferid=b.elgi_dealeroffer  )b
--on a.opportunityid =b.elgi_enquiry)a
--left join (
--select DISTINCT elgi_product,--,elgi_itemcode, --elgi_productgroupname,elgi_productsubgroupname,
--elgi_productcategoryname 
--From ELGI_DEALERPRICELISTMASTER where elgi_productgroupname is not null AND elgi_product IS NOT NULL)b
--on a.elgi_existingproduct =b.elgi_product
--)a
--where elgi_productcategoryname is not null
--group by ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername)a
--group by ownerid,owneridname,elgi_dealername,elgi_dealerengineername,elgi_productcategoryname,opportunityid


------------------- --------------------- end dealer offer

--union all

--------------- quote

--select ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,SUM(VALUE)Value,SUM(CNT) AS Qty,sum(Distcustomer)Distcustomer From (
--select owneridname,elgi_dealername,elgi_dealerengineername,opportunityid,ownerid,elgi_productcategoryname,sum(quantity*priceperunit) as Value,sum(quantity) as CNT,count(distinct customerid)Distcustomer From (
--select * From (
--select a.elgi_opportunitystatusname,A.elgi_dealername,A.elgi_dealerengineername,customerid,b.* From (
--select opportunityid,ownerid,elgi_opportunitystatusname,owneridname,elgi_dealername,elgi_dealerengineername,customerid From (
--select  opportunityid,elgi_enquiryid,name,elgi_enquirystatus,elgi_enquirystatusname,elgi_opportunitystatus,elgi_opportunitystatusname,
--statuscode,statuscodename,convert(date,createdon)createdon,estimatedclosedate,actualclosedate,ownerid,owneridname,elgi_dealer,elgi_dealername,
--elgi_dealerengineername,elgi_businessverticalname,customerid    
--from OPPORTUNITY 
--where elgi_enquirystatusname='In Progress'
--and elgi_opportunitystatusname in ('Quotation','Negotiation','Enquiry','Lead')
--and (convert(date,createdon))<'2021-04-01'
--and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3' --- DUE TO SYSTEM INTEGRATION
--and statuscodename <>'Order Lost'
--and actualclosedate is null)a)a
----group by elgi_opportunitystatusname,ownerid,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername)a
--inner join(
--select a.ownerid,a.owneridname,a.elgi_businessverticalname,a.statuscodename,a.opportunityid ,b.* From (
--select ownerid,owneridname,quoteid,elgi_businessverticalname,statuscodename, opportunityid
-- from QUOTE where statuscodename<>'revised')a -- elgi_businessverticalname ='Industrial' AND
--inner join (select productid, msdyn_linedescription,priceperunit,quantity,productidname,quoteid,quoteidname, createdon   From quotedetails)b
--on a.quoteid =b.quoteid )b
--on a.opportunityid =b.opportunityid)a
--left join (
--select DISTINCT elgi_product,--,elgi_itemcode, --elgi_productgroupname,elgi_productsubgroupname,
--elgi_productcategoryname 
--From ELGI_DEALERPRICELISTMASTER where elgi_productgroupname is not null AND elgi_product IS NOT NULL)b
--on a.productid =b.elgi_product)a
--where elgi_productcategoryname is not null
--group by ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername)a
--group by ownerid,owneridname,elgi_dealername,elgi_dealerengineername,elgi_productcategoryname,opportunityid

-------------- end quote
--)a
----where elgi_productcategoryname in ('s0','s1','s2','ENCAP','L0','L1','L2','o0','ot','o1','NSD SEP','CAC') --WW
--group by ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername)a
--left join (
--select * From (
--select a.*,b.opportunityid  From (
--select elgi_customervisitid,elgi_customertypesalesname,substring(requiredattendees,14,36)as customerid From APPOINTMENT 
--where elgi_customertypesalesname is not null)a
--left join (select elgi_customervisitid,opportunityid,convert(varchar(100),customerid)customerid    From OPPORTUNITY)b 
--on a.customerid =b.customerid 
--and a.elgi_customervisitid =b.elgi_customervisitid )a
--where opportunityid is not null)b
--on a.opportunityid =b.opportunityid )a
--group by ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername

------ -------------------------- end total Quote


--union all
----------- total code for orderwon


--select 'Order Won'as Name,ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername,
--sum(case when type='Cold Calls' then Distcustomer else 0 end)as coldDistcustomer,
--sum(case when type='Non ColdCalls' then Distcustomer  else 0 end) as noncoldDistcustomer,
--0 as lastyearcold,0 as lastyearnoncold,
--sum(case when type='Cold Calls' then qty else 0 end)as coldcalls_cnt,
--sum(case when type='Non ColdCalls' then qty  else 0 end) as Non_coldcalls_cnt  from (
--select a.*,b.elgi_customertypesalesname,case when b.elgi_customertypesalesname='Cold Calls' then 'Cold Calls' else 'Non ColdCalls' end as type  From (
--select ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,SUM(VALUE)Value,SUM(Qty) AS Qty,sum(Distcustomer)Distcustomer From (

--------------------- dealer offer
--select ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,SUM(VALUE)Value,SUM(Qty) AS Qty,sum(Distcustomer)Distcustomer From (
--select owneridname,elgi_dealername,elgi_dealerengineername,opportunityid,ownerid,elgi_productcategoryname,sum(elgi_quantity*elgi_priceperunit) as Value,sum(elgi_quantity) as qty,count(distinct customerid)Distcustomer From (
--select * From (
--select * From (
--select owneridname,elgi_dealername,elgi_dealerengineername,opportunityid,ownerid,elgi_opportunitystatusname,customerid  From (
--select  opportunityid,elgi_enquiryid,name,elgi_enquirystatus,elgi_enquirystatusname,elgi_opportunitystatus,elgi_opportunitystatusname,
--statuscode,statuscodename,convert(date,createdon)createdon,estimatedclosedate,actualclosedate,ownerid,owneridname,elgi_dealer,elgi_dealername,
--elgi_dealerengineername,elgi_businessverticalname,customerid     
--from OPPORTUNITY 
--where statecodename = 'Won'
--and (convert(date,actualclosedate))>='2021-04-01'
--and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3' --- DUE TO SYSTEM INTEGRATION 
--)a)a
----group by elgi_opportunitystatusname,ownerid,opportunityid,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername)a
--inner join (
--select a.elgi_businessverticalname,a.elgi_revisedflagname,a.elgi_enquiry,b.*   From (
--select elgi_businessverticalname,elgi_revisedflagname,elgi_dealerofferid,elgi_enquiry  From ELGI_DEALEROFFER
--where elgi_revisedflagname<>'Yes' )a
--inner join (
--select elgi_existingproduct, elgi_producttplitemcode,elgi_priceperunit,elgi_quantity,elgi_existingproductname,
--elgi_dealeroffer,elgi_dealeroffername, createdon    From ELGI_DEALEROFFERPRODUCT)b 
--on a.elgi_dealerofferid=b.elgi_dealeroffer  )b
--on a.opportunityid =b.elgi_enquiry)a
--left join (
--select DISTINCT elgi_product,--,elgi_itemcode, --elgi_productgroupname,elgi_productsubgroupname,
--elgi_productcategoryname 
--From ELGI_DEALERPRICELISTMASTER where elgi_productgroupname is not null AND elgi_product IS NOT NULL)b
--on a.elgi_existingproduct =b.elgi_product
--)a
--where elgi_productcategoryname is not null
--group by ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername)a
--group by ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername

------------------- --------------------- end dealer offer

--union all

--------------- quote

--select ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,SUM(VALUE)Value,SUM(Qty) AS Qty,sum(Distcustomer)Distcustomer From (
--select owneridname,elgi_dealername,elgi_dealerengineername,opportunityid,ownerid,elgi_productcategoryname,sum(quantity*priceperunit) as Value,sum(quantity) as qty,count(distinct customerid)Distcustomer From (
--select * From (
--select a.customerid,a.elgi_dealername,a.elgi_dealerengineername,a.elgi_opportunitystatusname,b.* From (
--select owneridname,elgi_dealername,elgi_dealerengineername,opportunityid,ownerid,elgi_opportunitystatusname,customerid From (
--select  opportunityid,elgi_enquiryid,name,elgi_enquirystatus,elgi_enquirystatusname,elgi_opportunitystatus,elgi_opportunitystatusname,
--statuscode,statuscodename,convert(date,createdon)createdon,estimatedclosedate,actualclosedate,ownerid,owneridname,elgi_dealer,elgi_dealername,
--elgi_dealerengineername,elgi_businessverticalname,customerid     
--from OPPORTUNITY 
--where convert(date,actualclosedate)>='2021-04-01'
--and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3' --- DUE TO SYSTEM INTEGRATION
--)a)a
----group by elgi_opportunitystatusname,ownerid,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername)a
--inner join(
--select a.ownerid,a.owneridname,a.elgi_businessverticalname,a.statuscodename,a.opportunityid ,b.* From (
--select ownerid,owneridname,quoteid,elgi_businessverticalname,statuscodename, opportunityid
-- from QUOTE where statuscodename = 'Won' --and name like '%industrial%'
-- )a
--inner join (select productid, msdyn_linedescription,priceperunit,quantity,productidname,quoteid,quoteidname, createdon From quotedetails
----where elgi_salesofficename in ('SEPSAC - DIRECT','OFSAC - UNITS','ENCAP','VOLTAS','SEPSAC','LEPSAC','MEDICAL','SEPSAC- NSD','OFSAC-TURNKEY','CAC')
--)b
--on a.quoteid =b.quoteid )b
--on a.opportunityid =b.opportunityid)a
--left join (
--select DISTINCT elgi_product,--,elgi_itemcode, --elgi_productgroupname,elgi_productsubgroupname,
--elgi_productcategoryname 
--From ELGI_DEALERPRICELISTMASTER where elgi_productgroupname is not null AND elgi_product IS NOT NULL)b
--on a.productid =b.elgi_product)a
--where elgi_productcategoryname is not null
--group by ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername)a
--group by ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername

-------------- end quote
--)a
----where elgi_productcategoryname in ('s0','s1','s2','ENCAP','L0','L1','L2','o0','ot','o1','NSD SEP','CAC') --WW
--group by ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername)a
--left join (
--select * From (
--select a.*,b.opportunityid  From (
--select elgi_customervisitid,elgi_customertypesalesname,substring(requiredattendees,14,36)as customerid From APPOINTMENT 
--where elgi_customertypesalesname is not null)a
--left join (select elgi_customervisitid,opportunityid,convert(varchar(100),customerid)customerid    From OPPORTUNITY)b 
--on a.customerid =b.customerid 
--and a.elgi_customervisitid =b.elgi_customervisitid )a
--where opportunityid is not null)b
--on a.opportunityid =b.opportunityid )a
--group by ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername

-----------------
--union all

----------- order lost

--select 'Order Lost' as NAME,ownerid,owneridname,elgi_dealername,elgi_dealerengineername,
--case when type='Cold Calls' then count(distinct a.customerid) else 0 end as coldDistcustomer,
--case when type='Non ColdCalls' then count(distinct a.customerid)  else 0 end  as noncoldDistcustomer
--,0 as lastyearcold,0 as lastyearnoncold,
--sum(case when type='Cold Calls' then count else 0 end)as Coldcalls,
--sum(case when type='Non ColdCalls' then count else 0 end) as NonColdcalls from(
--select ownerid,owneridname,elgi_dealername,elgi_dealerengineername,
--case when b.elgi_customertypesalesname='Cold Calls' then 'Cold Calls' else 'Non ColdCalls' end as type,count,a.customerid
--From (
--select ownerid,owneridname,elgi_dealername,elgi_dealerengineername,customerid,elgi_customervisitid,sum(isnull(elgi_numbers,1)) as count from
--(select actualclosedate, elgi_losttoname, elgi_model,elgi_numbers, elgi_opportunitystatusname,convert(varchar(100),customerid)customerid,
--statuscodename, elgi_reasonname,elgi_remarks,ownerid,owneridname,elgi_dealerengineername,elgi_dealername,elgi_dealer,elgi_customervisitid from OPPORTUNITY
--where statuscodename = 'Order Lost' and convert(date,actualclosedate)>= '2021-04-01')a
--group by ownerid,owneridname,elgi_dealername,elgi_dealerengineername,customerid,elgi_customervisitid)a
--left join(select elgi_customervisitid,elgi_customertypesalesname,substring(requiredattendees,14,36)as customerid From APPOINTMENT where elgi_customertypesalesname is not null)b
--on a.customerid =b.customerid 
--and a.elgi_customervisitid =b.elgi_customervisitid)a
--group by ownerid,owneridname,elgi_dealername,elgi_dealerengineername,type

------------- end order lost

--)a
-------------------total code for orderwon
--group by NAME,ownerid,owneridname,elgi_dealername,elgi_dealerengineername
--)a 
----where 1=2

---------------- end funnel



--insert into Funnel 
--	  --------------- funnel data
--select * From (
--select NAME,ownerid,owneridname,elgi_dealername,elgi_dealerengineername,sum(coldDistcustomer)coldDistcustomer,sum(noncoldDistcustomer)noncoldDistcustomer,
--sum(lastyearcold) lastyearcold,sum(lastyearnoncold) lastyearnoncold,sum(coldcalls_cnt)coldcalls_cnt,sum(Non_coldcalls_cnt)Non_coldcalls_cnt  from (

---------------- visits
--select 'VISITS' as NAME, ownerid,owneridname,elgi_dealername,elgi_dealerengineername,sum(coldvisits)coldDistcustomer,sum(noncoldvisits)noncoldDistcustomer,0 as lastyearcold,0 as lastyearnoncold,
--sum(coldcalls_cnt)coldcalls_cnt,sum(Non_coldcalls)Non_coldcalls_cnt
-- from(
--select elgi_dealer,owneridname,
--elgi_dealername,elgi_dealerengineername,elgi_monthstartingdate,elgi_weeklyplannumbername,ownerid,elgi_customerclassificationname,elgi_description,
--sum(coldcalls_cnt)coldcalls_cnt,sum(Non_coldcalls)Non_coldcalls,sum(coldvisits)coldvisits,sum(noncoldvisits)noncoldvisits from(

--select elgi_dealer,owneridname,
--elgi_dealername,elgi_dealerengineername,ownerid,elgi_customerclassificationname,elgi_description,
--convert(date,elgi_monthstartingdate)elgi_monthstartingdate,elgi_weeklyplannumbername,sum(coldcalls_cnt)coldcalls_cnt,sum(Non_coldcalls)Non_coldcalls,sum(Visits)coldvisits,0 as noncoldvisits from(
--select a.*,b.name,b.elgi_customerclassificationname,b.elgi_lineofbusinessname,b.elgi_description From (
--select  substring(requiredattendees,14,36)as custcode,elgi_dealer,elgi_dealername,elgi_dealerengineername,
--convert(date,elgi_monthstartingdate)elgi_monthstartingdate,elgi_weeklyplannumbername,convert(date,elgi_latestvisitdate)elgi_latestvisitdate,
--ownerid,owneridname,elgi_customertypesalesname ,count(distinct substring(requiredattendees,14,36)) as coldcalls_cnt,count(substring(requiredattendees,14,36)) as Visits,0 as Non_coldcalls from ( --distinct removed
--select *,row_number()over(partition by ownerid,substring(requiredattendees,14,36) order by elgi_latestvisitdate desc) as rno from APPOINTMENT 
--where --elgi_customervisitid in ('cv-155030','cv-154986') and 
--elgi_customertypesalesname ='Cold Calls'
--and requiredattendees<>'[]'
--and statecodename<>'Canceled'--and elgi_customervisitid='CV-220001'
--and convert(date,elgi_monthstartingdate)>='2021-04-01'
----and convert(date,elgi_latestvisitdate) is not null 
--and elgi_lineofbusinessname in ('040a','040b','952','953','954','955')

--)a
--where rno<2
--group by owneridname,convert(date,elgi_latestvisitdate),elgi_customertypesalesname,owneridname,ownerid,elgi_weeklyplannumbername,convert(date,elgi_monthstartingdate)
--,elgi_dealer,elgi_dealername,elgi_dealerengineername,substring(requiredattendees,14,36))a

--left join (
--select a.*,c.elgi_description From (select accountid,name,elgi_lineofbusinessname,elgi_customerclassificationname From ACCOUNT)a
--left join (select elgi_name,elgi_description From ELGI_LINEOFBUSINESS)c
--on a.elgi_lineofbusinessname =c.elgi_name)b
--on a.CustCode=b.accountid)A
----where elgi_dealerengineername like '%vijaya%'
--group by owneridname,elgi_dealer,elgi_description,elgi_dealername,elgi_dealerengineername,ownerid,elgi_customerclassificationname,convert(date,elgi_monthstartingdate),elgi_weeklyplannumbername

--union all

--select elgi_dealer,owneridname,
--elgi_dealername,elgi_dealerengineername,ownerid,elgi_customerclassificationname,elgi_description,
--convert(date,elgi_monthstartingdate)elgi_monthstartingdate,elgi_weeklyplannumbername,sum(coldcalls_cnt)coldcalls_cnt,sum(Non_coldcalls)Non_coldcalls,0 as coldvisits,sum(noncoldvisits)noncoldvisits from(
--select a.*,b.name,b.elgi_customerclassificationname,b.elgi_lineofbusinessname,b.elgi_description From (
--select  substring(requiredattendees,14,36)as custcode,elgi_dealer,elgi_dealername,elgi_dealerengineername,convert(date,elgi_monthstartingdate)elgi_monthstartingdate,elgi_weeklyplannumbername,convert(date,elgi_latestvisitdate)elgi_latestvisitdate,
--owneridname,ownerid,elgi_customertypesalesname ,0 as coldcalls_cnt,count(distinct substring(requiredattendees,14,36)) as Non_coldcalls,count(substring(requiredattendees,14,36)) as noncoldvisits from (
--select *,row_number()over(partition by ownerid,substring(requiredattendees,14,36) order by elgi_latestvisitdate desc) as rno from APPOINTMENT 
--where --elgi_customervisitid in ('cv-155030','cv-154986') and 
--elgi_customertypesalesname <>'Cold Calls' and elgi_customertypesalesname is not null
--and requiredattendees<>'[]'
--and statecodename<>'Canceled'--and elgi_customervisitid='CV-220001'
--and convert(date,elgi_latestvisitdate)>='2021-04-01'
----and convert(date,elgi_latestvisitdate) is not null
--and elgi_lineofbusinessname in ('040a','040b','952','953','954','955') --ww

--)a
----where rno<2
--group by convert(date,elgi_latestvisitdate),elgi_customertypesalesname,owneridname,ownerid,elgi_weeklyplannumbername,convert(date,elgi_monthstartingdate)
--,elgi_dealer,elgi_dealername,elgi_dealerengineername,substring(requiredattendees,14,36))a

--left join (
--select a.*,c.elgi_description From (select accountid,name,elgi_lineofbusinessname,elgi_customerclassificationname From ACCOUNT)a
--left join (select elgi_name,elgi_description From ELGI_LINEOFBUSINESS)c
--on a.elgi_lineofbusinessname =c.elgi_name)b
--on a.CustCode=b.accountid)A
----where elgi_dealerengineername like '%vijaya%'
--group by owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername,ownerid,elgi_customerclassificationname,convert(date,elgi_monthstartingdate),elgi_weeklyplannumbername,elgi_description

--)a
--group by owneridname,elgi_dealer,elgi_description,elgi_dealername,elgi_dealerengineername,ownerid,elgi_customerclassificationname,convert(date,elgi_monthstartingdate),elgi_weeklyplannumbername
--)a
--group by ownerid,owneridname,elgi_dealername,elgi_dealerengineername

-------------- end visit


----------------- start Enquiry
--union all


--select 'Enquiry' as NAME,ownerid,owneridname,elgi_dealername,elgi_dealerengineername,
--sum(coldDistcustomer)coldDistcustomer,sum(noncoldDistcustomer)noncoldDistcustomer,0 as lastyearcold, 0 as lastyearnoncold,sum(Coldcalls)coldcalls_cnt,sum(NonColdcalls)Non_coldcalls_cnt from (
--select ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername,
--sum(case when type='Cold Calls' then cnt else 0 end)as Coldcalls,
--sum(case when type='Non ColdCalls' then cnt else 0 end) as NonColdcalls,

--case when type='Cold Calls' then count(distinct customerid) else 0 end as coldDistcustomer,
--case when type='Non ColdCalls' then count(distinct customerid) else 0 end  as noncoldDistcustomer,
--count(distinct customerid)customerid

--from(
--select ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername ,b.elgi_customertypesalesname,a.customerid,case when b.elgi_customertypesalesname='Cold Calls' then 'Cold Calls' else 'Non ColdCalls' end as type,cnt From (
--select ownerid,elgi_customervisitid,customerid,owneridname,elgi_dealername,elgi_dealerengineername,count(*) as cnt from(
--select ownerid,elgi_customervisitid,customerid,owneridname,elgi_dealername,elgi_dealerengineername from OPPORTUNITY 
--where --elgi_businessverticalname='Industrial' and 
-- elgi_opportunitystatusname in ('Enquiry','Lead')--('Quotation','Negotiation')
--and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3'
--and statuscodename <>'Order Lost'
--and actualclosedate is null
--and convert(date,createdon)>='2021-04-01')a
--group by ownerid,elgi_customervisitid,customerid,owneridname,elgi_dealername,elgi_dealerengineername)a
--left join (select distinct elgi_customervisitid,elgi_customertypesalesname,substring(requiredattendees,14,36) AS CUSTOMERID From APPOINTMENT
--where elgi_lineofbusinessname in ('040a','040b','952','953','954','955') --ww
--)b
--on a.elgi_customervisitid =b.elgi_customervisitid 
--AND convert(varchar(100),A.customerid) =B.CUSTOMERID)a
--group by ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername,type)a
--group by ownerid,owneridname,elgi_dealername,elgi_dealerengineername

----------- end Enquiry

--union all

------------------------- enquiryNEW

--select 'Enquiry' as NAME,ownerid,owneridname,elgi_dealername,elgi_dealerengineername,
--0 as coldDistcustomer,0 as noncoldDistcustomer,sum(Coldcalls) as lastyearcold,sum(NonColdcalls) as lastyearnoncold,0 as coldcalls_cnt,0 as Non_coldcalls_cnt from (
--select ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername,
--sum(case when type='Cold Calls' then cnt else 0 end)as Coldcalls,
--sum(case when type='Non ColdCalls' then cnt else 0 end) as NonColdcalls
--from(
--select ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername ,b.elgi_customertypesalesname,a.customerid,case when b.elgi_customertypesalesname='Cold Calls' then 'Cold Calls' else 'Non ColdCalls' end as type,cnt From (
--select ownerid,elgi_customervisitid,customerid,owneridname,elgi_dealername,elgi_dealerengineername,count(*) as cnt from(
--select ownerid,elgi_customervisitid,customerid,owneridname,elgi_dealername,elgi_dealerengineername from OPPORTUNITY 
--where --elgi_businessverticalname='Industrial' and
-- elgi_opportunitystatusname in ('Enquiry','Lead')--('Quotation','Negotiation')
--and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3'
--and statuscodename <>'Order Lost'
--and actualclosedate is null
--and convert(date,createdon)<'2021-04-01')a
--group by ownerid,elgi_customervisitid,customerid,owneridname,elgi_dealername,elgi_dealerengineername)a
--left join (select distinct elgi_customervisitid,elgi_customertypesalesname,substring(requiredattendees,14,36) AS CUSTOMERID From APPOINTMENT
--where elgi_lineofbusinessname in ('040a','040b','952','953','954','955') --ww
--)b
--on a.elgi_customervisitid =b.elgi_customervisitid 
--AND convert(varchar(100),A.customerid) =B.CUSTOMERID)a
--group by ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername)a
--group by ownerid,owneridname,elgi_dealername,elgi_dealerengineername

--------------- end enquiryNEW

--union all
---------------------------- total Quote
--select 'Quote'as Name,ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername,
--sum(case when type='Cold Calls' then Distcustomer else 0 end)as coldDistcustomer,
--sum(case when type='Non ColdCalls' then Distcustomer  else 0 end) as noncoldDistcustomer,
--0 as lastyearcold,0 as lastyearnoncold,
--sum(case when type='Cold Calls' then qty else 0 end)as coldcalls_cnt,
--sum(case when type='Non ColdCalls' then qty  else 0 end) as Non_coldcalls_cnt
-- from (
--select a.*,b.elgi_customertypesalesname,case when b.elgi_customertypesalesname='Cold Calls' then 'Cold Calls' else 'Non ColdCalls' end as type  From (
--select ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,SUM(VALUE)Value,SUM(Qty) AS Qty,sum(Distcustomer)Distcustomer From (

--------------------- dealer offer
--select ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,SUM(VALUE)Value,SUM(CNT) AS Qty,sum(Distcustomer)Distcustomer From (
--select opportunityid,ownerid,elgi_productcategoryname,owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername
--,sum(elgi_quantity*elgi_priceperunit) as Value,sum(elgi_quantity) as CNT,count(distinct customerid)Distcustomer    From (
--select * From (
--select * From (
--select opportunityid,ownerid,elgi_opportunitystatusname,owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername,customerid  From (
--select  opportunityid,elgi_enquiryid,name,elgi_enquirystatus,elgi_enquirystatusname,elgi_opportunitystatus,elgi_opportunitystatusname,
--statuscode,statuscodename,convert(date,createdon)createdon,estimatedclosedate,actualclosedate,ownerid,owneridname,elgi_dealer,elgi_dealername,
--elgi_dealerengineername,elgi_businessverticalname,customerid        
--from OPPORTUNITY 
--where elgi_enquirystatusname='In Progress'
--and elgi_opportunitystatusname in ('Quotation','Negotiation','Enquiry','Lead')
--and (convert(date,createdon))>='2021-04-01'
--and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3' --- DUE TO SYSTEM INTEGRATION
--and statuscodename <>'Order Lost'
--and actualclosedate is null)a)a
----group by opportunityid,ownerid,elgi_opportunitystatusname,owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername)a
--inner join (

--select a.elgi_businessverticalname,a.elgi_revisedflagname,a.elgi_enquiry,b.*   From (
--select elgi_businessverticalname,elgi_revisedflagname,elgi_dealerofferid,elgi_enquiry  From ELGI_DEALEROFFER
--where elgi_revisedflagname<>'Yes' )a --elgi_businessverticalname='Industrial'  and
--inner join (
--select elgi_existingproduct, elgi_producttplitemcode,elgi_priceperunit,elgi_quantity,elgi_existingproductname,
--elgi_dealeroffer,elgi_dealeroffername, createdon    From ELGI_DEALEROFFERPRODUCT)b 
--on a.elgi_dealerofferid=b.elgi_dealeroffer  )b
--on a.opportunityid =b.elgi_enquiry)a
--left join (
--select DISTINCT elgi_product,--,elgi_itemcode, --elgi_productgroupname,elgi_productsubgroupname,
--elgi_productcategoryname 
--From ELGI_DEALERPRICELISTMASTER where elgi_productgroupname is not null AND elgi_product IS NOT NULL)b
--on a.elgi_existingproduct =b.elgi_product
--)a
--where elgi_productcategoryname is not null
--group by ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername)a
--group by ownerid,owneridname,elgi_dealername,elgi_dealerengineername,elgi_productcategoryname,opportunityid


------------------- --------------------- end dealer offer

--union all

--------------- quote

--select ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,SUM(VALUE)Value,SUM(CNT) AS Qty,sum(Distcustomer)Distcustomer From (
--select owneridname,elgi_dealername,elgi_dealerengineername,opportunityid,ownerid,elgi_productcategoryname,sum(quantity*priceperunit) as Value,sum(quantity) as CNT,count(distinct customerid)Distcustomer From (
--select * From (
--select a.elgi_opportunitystatusname,A.elgi_dealername,A.elgi_dealerengineername,customerid,b.* From (
--select opportunityid,ownerid,elgi_opportunitystatusname,owneridname,elgi_dealername,elgi_dealerengineername,customerid From (
--select  opportunityid,elgi_enquiryid,name,elgi_enquirystatus,elgi_enquirystatusname,elgi_opportunitystatus,elgi_opportunitystatusname,
--statuscode,statuscodename,convert(date,createdon)createdon,estimatedclosedate,actualclosedate,ownerid,owneridname,elgi_dealer,elgi_dealername,
--elgi_dealerengineername,elgi_businessverticalname,customerid    
--from OPPORTUNITY 
--where elgi_enquirystatusname='In Progress'
--and elgi_opportunitystatusname in ('Quotation','Negotiation','Enquiry','Lead')
--and (convert(date,createdon))>='2021-04-01'
--and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3' --- DUE TO SYSTEM INTEGRATION
--and statuscodename <>'Order Lost'
--and actualclosedate is null)a)a
----group by elgi_opportunitystatusname,ownerid,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername)a
--inner join(
--select a.ownerid,a.owneridname,a.elgi_businessverticalname,a.statuscodename,a.opportunityid ,b.* From (
--select ownerid,owneridname,quoteid,elgi_businessverticalname,statuscodename, opportunityid
-- from QUOTE where statuscodename<>'revised')a -- elgi_businessverticalname ='Industrial' AND
--inner join (select productid, msdyn_linedescription,priceperunit,quantity,productidname,quoteid,quoteidname, createdon   From quotedetails)b
--on a.quoteid =b.quoteid )b
--on a.opportunityid =b.opportunityid)a
--left join (
--select DISTINCT elgi_product,--,elgi_itemcode, --elgi_productgroupname,elgi_productsubgroupname,
--elgi_productcategoryname 
--From ELGI_DEALERPRICELISTMASTER where elgi_productgroupname is not null AND elgi_product IS NOT NULL)b
--on a.productid =b.elgi_product)a
--where elgi_productcategoryname is not null
--group by ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername)a
--group by ownerid,owneridname,elgi_dealername,elgi_dealerengineername,elgi_productcategoryname,opportunityid

-------------- end quote
--)a
----where elgi_productcategoryname in ('s0','s1','s2','ENCAP','L0','L1','L2','o0','ot','o1','NSD SEP','CAC')--WW
--group by ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername)a
--left join (
--select * From (
--select a.*,b.opportunityid  From (
--select elgi_customervisitid,elgi_customertypesalesname,substring(requiredattendees,14,36)as customerid From APPOINTMENT 
--where elgi_customertypesalesname is not null
--and elgi_lineofbusinessname in ('040a','040b','952','953','954','955') --ww
--)a
--left join (select elgi_customervisitid,opportunityid,convert(varchar(100),customerid)customerid    From OPPORTUNITY)b 
--on a.customerid =b.customerid 
--and a.elgi_customervisitid =b.elgi_customervisitid )a
--where opportunityid is not null)b
--on a.opportunityid =b.opportunityid )a
--group by ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername

------ -------------------------- end total Quote

--union all

---------------------------- total Quotenew
--select 'Quote'as Name,ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername,
--0 as coldDistcustomer,0 as noncoldDistcustomer,
--sum(case when type='Cold Calls' then qty else 0 end)as lastyearcold,
--sum(case when type='Non ColdCalls' then qty  else 0 end) as lastyearnoncold,
--0 as coldcalls_cnt,0 as Non_coldcalls_cnt
-- from (
--select a.*,b.elgi_customertypesalesname,case when b.elgi_customertypesalesname='Cold Calls' then 'Cold Calls' else 'Non ColdCalls' end as type  From (
--select ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,SUM(VALUE)Value,SUM(Qty) AS Qty,sum(Distcustomer)Distcustomer From (

--------------------- dealer offer
--select ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,SUM(VALUE)Value,SUM(CNT) AS Qty,sum(Distcustomer)Distcustomer From (
--select opportunityid,ownerid,elgi_productcategoryname,owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername
--,sum(elgi_quantity*elgi_priceperunit) as Value,sum(elgi_quantity) as CNT,count(distinct customerid)Distcustomer    From (
--select * From (
--select * From (
--select opportunityid,ownerid,elgi_opportunitystatusname,owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername,customerid  From (
--select  opportunityid,elgi_enquiryid,name,elgi_enquirystatus,elgi_enquirystatusname,elgi_opportunitystatus,elgi_opportunitystatusname,
--statuscode,statuscodename,convert(date,createdon)createdon,estimatedclosedate,actualclosedate,ownerid,owneridname,elgi_dealer,elgi_dealername,
--elgi_dealerengineername,elgi_businessverticalname,customerid        
--from OPPORTUNITY 
--where elgi_enquirystatusname='In Progress'
--and elgi_opportunitystatusname in ('Quotation','Negotiation','Enquiry','Lead')
--and (convert(date,createdon))<'2021-04-01'
--and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3' --- DUE TO SYSTEM INTEGRATION
--and statuscodename <>'Order Lost'
--and actualclosedate is null)a)a
----group by opportunityid,ownerid,elgi_opportunitystatusname,owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername)a
--inner join (

--select a.elgi_businessverticalname,a.elgi_revisedflagname,a.elgi_enquiry,b.*   From (
--select elgi_businessverticalname,elgi_revisedflagname,elgi_dealerofferid,elgi_enquiry  From ELGI_DEALEROFFER
--where elgi_revisedflagname<>'Yes' )a --elgi_businessverticalname='Industrial'  and
--inner join (
--select elgi_existingproduct, elgi_producttplitemcode,elgi_priceperunit,elgi_quantity,elgi_existingproductname,
--elgi_dealeroffer,elgi_dealeroffername, createdon    From ELGI_DEALEROFFERPRODUCT)b 
--on a.elgi_dealerofferid=b.elgi_dealeroffer  )b
--on a.opportunityid =b.elgi_enquiry)a
--left join (
--select DISTINCT elgi_product,--,elgi_itemcode, --elgi_productgroupname,elgi_productsubgroupname,
--elgi_productcategoryname 
--From ELGI_DEALERPRICELISTMASTER where elgi_productgroupname is not null AND elgi_product IS NOT NULL)b
--on a.elgi_existingproduct =b.elgi_product
--)a
--where elgi_productcategoryname is not null
--group by ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealer,elgi_dealername,elgi_dealerengineername)a
--group by ownerid,owneridname,elgi_dealername,elgi_dealerengineername,elgi_productcategoryname,opportunityid


------------------- --------------------- end dealer offer

--union all

--------------- quote

--select ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,SUM(VALUE)Value,SUM(CNT) AS Qty,sum(Distcustomer)Distcustomer From (
--select owneridname,elgi_dealername,elgi_dealerengineername,opportunityid,ownerid,elgi_productcategoryname,sum(quantity*priceperunit) as Value,sum(quantity) as CNT,count(distinct customerid)Distcustomer From (
--select * From (
--select a.elgi_opportunitystatusname,A.elgi_dealername,A.elgi_dealerengineername,customerid,b.* From (
--select opportunityid,ownerid,elgi_opportunitystatusname,owneridname,elgi_dealername,elgi_dealerengineername,customerid From (
--select  opportunityid,elgi_enquiryid,name,elgi_enquirystatus,elgi_enquirystatusname,elgi_opportunitystatus,elgi_opportunitystatusname,
--statuscode,statuscodename,convert(date,createdon)createdon,estimatedclosedate,actualclosedate,ownerid,owneridname,elgi_dealer,elgi_dealername,
--elgi_dealerengineername,elgi_businessverticalname,customerid    
--from OPPORTUNITY 
--where elgi_enquirystatusname='In Progress'
--and elgi_opportunitystatusname in ('Quotation','Negotiation','Enquiry','Lead')
--and (convert(date,createdon))<'2021-04-01'
--and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3' --- DUE TO SYSTEM INTEGRATION
--and statuscodename <>'Order Lost'
--and actualclosedate is null)a)a
----group by elgi_opportunitystatusname,ownerid,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername)a
--inner join(
--select a.ownerid,a.owneridname,a.elgi_businessverticalname,a.statuscodename,a.opportunityid ,b.* From (
--select ownerid,owneridname,quoteid,elgi_businessverticalname,statuscodename, opportunityid
-- from QUOTE where statuscodename<>'revised')a -- elgi_businessverticalname ='Industrial' AND
--inner join (select productid, msdyn_linedescription,priceperunit,quantity,productidname,quoteid,quoteidname, createdon   From quotedetails)b
--on a.quoteid =b.quoteid )b
--on a.opportunityid =b.opportunityid)a
--left join (
--select DISTINCT elgi_product,--,elgi_itemcode, --elgi_productgroupname,elgi_productsubgroupname,
--elgi_productcategoryname 
--From ELGI_DEALERPRICELISTMASTER where elgi_productgroupname is not null AND elgi_product IS NOT NULL)b
--on a.productid =b.elgi_product)a
--where elgi_productcategoryname is not null
--group by ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername)a
--group by ownerid,owneridname,elgi_dealername,elgi_dealerengineername,elgi_productcategoryname,opportunityid

-------------- end quote
--)a
----where elgi_productcategoryname in ('s0','s1','s2','ENCAP','L0','L1','L2','o0','ot','o1','NSD SEP','CAC') --WW
--group by ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername)a
--left join (
--select * From (
--select a.*,b.opportunityid  From (
--select elgi_customervisitid,elgi_customertypesalesname,substring(requiredattendees,14,36)as customerid From APPOINTMENT 
--where elgi_customertypesalesname is not null and elgi_lineofbusinessname in ('040a','040b','952','953','954','955') --ww
--)a
--left join (select elgi_customervisitid,opportunityid,convert(varchar(100),customerid)customerid    From OPPORTUNITY)b 
--on a.customerid =b.customerid 
--and a.elgi_customervisitid =b.elgi_customervisitid )a
--where opportunityid is not null)b
--on a.opportunityid =b.opportunityid )a
--group by ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername

------ -------------------------- end total Quote


--union all
----------- total code for orderwon


--select 'Order Won'as Name,ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername,
--sum(case when type='Cold Calls' then Distcustomer else 0 end)as coldDistcustomer,
--sum(case when type='Non ColdCalls' then Distcustomer  else 0 end) as noncoldDistcustomer,
--0 as lastyearcold,0 as lastyearnoncold,
--sum(case when type='Cold Calls' then qty else 0 end)as coldcalls_cnt,
--sum(case when type='Non ColdCalls' then qty  else 0 end) as Non_coldcalls_cnt  from (
--select a.*,b.elgi_customertypesalesname,case when b.elgi_customertypesalesname='Cold Calls' then 'Cold Calls' else 'Non ColdCalls' end as type  From (
--select ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,SUM(VALUE)Value,SUM(Qty) AS Qty,sum(Distcustomer)Distcustomer From (

--------------------- dealer offer
--select ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,SUM(VALUE)Value,SUM(Qty) AS Qty,sum(Distcustomer)Distcustomer From (
--select owneridname,elgi_dealername,elgi_dealerengineername,opportunityid,ownerid,elgi_productcategoryname,sum(elgi_quantity*elgi_priceperunit) as Value,sum(elgi_quantity) as qty,count(distinct customerid)Distcustomer From (
--select * From (
--select * From (
--select owneridname,elgi_dealername,elgi_dealerengineername,opportunityid,ownerid,elgi_opportunitystatusname,customerid  From (
--select  opportunityid,elgi_enquiryid,name,elgi_enquirystatus,elgi_enquirystatusname,elgi_opportunitystatus,elgi_opportunitystatusname,
--statuscode,statuscodename,convert(date,createdon)createdon,estimatedclosedate,actualclosedate,ownerid,owneridname,elgi_dealer,elgi_dealername,
--elgi_dealerengineername,elgi_businessverticalname,customerid     
--from OPPORTUNITY 
--where statecodename = 'Won'
--and (convert(date,actualclosedate))>='2021-04-01'
--and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3' --- DUE TO SYSTEM INTEGRATION 
--)a)a
----group by elgi_opportunitystatusname,ownerid,opportunityid,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername)a
--inner join (
--select a.elgi_businessverticalname,a.elgi_revisedflagname,a.elgi_enquiry,b.*   From (
--select elgi_businessverticalname,elgi_revisedflagname,elgi_dealerofferid,elgi_enquiry  From ELGI_DEALEROFFER
--where elgi_revisedflagname<>'Yes' )a
--inner join (
--select elgi_existingproduct, elgi_producttplitemcode,elgi_priceperunit,elgi_quantity,elgi_existingproductname,
--elgi_dealeroffer,elgi_dealeroffername, createdon    From ELGI_DEALEROFFERPRODUCT)b 
--on a.elgi_dealerofferid=b.elgi_dealeroffer  )b
--on a.opportunityid =b.elgi_enquiry)a
--left join (
--select DISTINCT elgi_product,--,elgi_itemcode, --elgi_productgroupname,elgi_productsubgroupname,
--elgi_productcategoryname 
--From ELGI_DEALERPRICELISTMASTER where elgi_productgroupname is not null AND elgi_product IS NOT NULL)b
--on a.elgi_existingproduct =b.elgi_product
--)a
--where elgi_productcategoryname is not null
--group by ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername)a
--group by ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername

------------------- --------------------- end dealer offer

--union all

--------------- quote

--select ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername,SUM(VALUE)Value,SUM(Qty) AS Qty,sum(Distcustomer)Distcustomer From (
--select owneridname,elgi_dealername,elgi_dealerengineername,opportunityid,ownerid,elgi_productcategoryname,sum(quantity*priceperunit) as Value,sum(quantity) as qty,count(distinct customerid)Distcustomer From (
--select * From (
--select a.customerid,a.elgi_dealername,a.elgi_dealerengineername,a.elgi_opportunitystatusname,b.* From (
--select owneridname,elgi_dealername,elgi_dealerengineername,opportunityid,ownerid,elgi_opportunitystatusname,customerid From (
--select  opportunityid,elgi_enquiryid,name,elgi_enquirystatus,elgi_enquirystatusname,elgi_opportunitystatus,elgi_opportunitystatusname,
--statuscode,statuscodename,convert(date,createdon)createdon,estimatedclosedate,actualclosedate,ownerid,owneridname,elgi_dealer,elgi_dealername,
--elgi_dealerengineername,elgi_businessverticalname,customerid     
--from OPPORTUNITY 
--where convert(date,actualclosedate)>='2021-04-01'
--and ownerid<>'6B18D065-1C76-E811-A959-000D3AF288B3' --- DUE TO SYSTEM INTEGRATION
--)a)a
----group by elgi_opportunitystatusname,ownerid,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername)a
--inner join(
--select a.ownerid,a.owneridname,a.elgi_businessverticalname,a.statuscodename,a.opportunityid ,b.* From (
--select ownerid,owneridname,quoteid,elgi_businessverticalname,statuscodename, opportunityid
-- from QUOTE where statuscodename = 'Won' --and name like '%industrial%'
-- )a
--inner join (select productid, msdyn_linedescription,priceperunit,quantity,productidname,quoteid,quoteidname, createdon From quotedetails
----where elgi_salesofficename in ('SEPSAC - DIRECT','OFSAC - UNITS','ENCAP','VOLTAS','SEPSAC','LEPSAC','MEDICAL','SEPSAC- NSD','OFSAC-TURNKEY','CAC')
--)b
--on a.quoteid =b.quoteid )b
--on a.opportunityid =b.opportunityid)a
--left join (
--select DISTINCT elgi_product,--,elgi_itemcode, --elgi_productgroupname,elgi_productsubgroupname,
--elgi_productcategoryname 
--From ELGI_DEALERPRICELISTMASTER where elgi_productgroupname is not null AND elgi_product IS NOT NULL)b
--on a.productid =b.elgi_product)a
--where elgi_productcategoryname is not null
--group by ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername)a
--group by ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername

-------------- end quote
--)a
----where elgi_productcategoryname in ('s0','s1','s2','ENCAP','L0','L1','L2','o0','ot','o1','NSD SEP','CAC') --WW
--group by ownerid,elgi_productcategoryname,opportunityid,owneridname,elgi_dealername,elgi_dealerengineername)a
--left join (
--select * From (
--select a.*,b.opportunityid  From (
--select elgi_customervisitid,elgi_customertypesalesname,substring(requiredattendees,14,36)as customerid From APPOINTMENT 
--where elgi_customertypesalesname is not null and elgi_lineofbusinessname in ('040a','040b','952','953','954','955') --ww
--)a
--left join (select elgi_customervisitid,opportunityid,convert(varchar(100),customerid)customerid    From OPPORTUNITY)b 
--on a.customerid =b.customerid 
--and a.elgi_customervisitid =b.elgi_customervisitid )a
--where opportunityid is not null)b
--on a.opportunityid =b.opportunityid )a
--group by ownerid,owneridname,elgi_dealername,a.elgi_dealerengineername

-----------------
--union all

----------- order lost

--select 'Order Lost' as NAME,ownerid,owneridname,elgi_dealername,elgi_dealerengineername,
--case when type='Cold Calls' then count(distinct a.customerid) else 0 end as coldDistcustomer,
--case when type='Non ColdCalls' then count(distinct a.customerid)  else 0 end  as noncoldDistcustomer
--,0 as lastyearcold,0 as lastyearnoncold,
--sum(case when type='Cold Calls' then count else 0 end)as Coldcalls,
--sum(case when type='Non ColdCalls' then count else 0 end) as NonColdcalls from(
--select ownerid,owneridname,elgi_dealername,elgi_dealerengineername,
--case when b.elgi_customertypesalesname='Cold Calls' then 'Cold Calls' else 'Non ColdCalls' end as type,count,a.customerid
--From (
--select ownerid,owneridname,elgi_dealername,elgi_dealerengineername,customerid,elgi_customervisitid,sum(isnull(elgi_numbers,1)) as count from
--(select actualclosedate, elgi_losttoname, elgi_model,elgi_numbers, elgi_opportunitystatusname,convert(varchar(100),customerid)customerid,
--statuscodename, elgi_reasonname,elgi_remarks,ownerid,owneridname,elgi_dealerengineername,elgi_dealername,elgi_dealer,elgi_customervisitid from OPPORTUNITY
--where statuscodename = 'Order Lost' and convert(date,actualclosedate)>= '2021-04-01')a
--group by ownerid,owneridname,elgi_dealername,elgi_dealerengineername,customerid,elgi_customervisitid)a
--left join(select elgi_customervisitid,elgi_customertypesalesname,substring(requiredattendees,14,36)as customerid From APPOINTMENT 
--where elgi_customertypesalesname is not null and elgi_lineofbusinessname in ('040a','040b','952','953','954','955') --ww
--)b
--on a.customerid =b.customerid 
--and a.elgi_customervisitid =b.elgi_customervisitid)a
--group by ownerid,owneridname,elgi_dealername,elgi_dealerengineername,type

------------- end order lost

--)a
-------------------total code for orderwon
--group by NAME,ownerid,owneridname,elgi_dealername,elgi_dealerengineername
--)a 
----where 1=2

-------------- end funnel





--insert into crm_Funnel 
--select distinct L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.* 
--From tb3
--inner join (select * From funnel)a
--on tb3.l1_id=a.ownerid 


--insert into crm_Funnel 

--select distinct L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.*
-- From tb3
--inner join (select * From funnel)a
--on tb3.l2_id=a.ownerid 


--insert into crm_Funnel 
--select distinct L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.*
-- From tb3
--inner join (select * From funnel)a
--on tb3.l3_id=a.ownerid 


--insert into crm_Funnel 
--select distinct L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.*
-- From tb3
--inner join (select * From funnel)a
--on tb3.l4_id=a.ownerid 




--insert into crm_Funnel 
--select distinct L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--L5_ID,L5_POSNAME,L5_REGION,L5_BUNIT,L5_VERTICAL,L5_ADDRESS,L5_EMPID,L5_EMPNAME,L5_EMAIL,
--null,null,null,null,null,null,null,null,null,
--null,null,null,null,null,null,null,null,null,
--a.*
-- From tb3
--inner join (select * From Funnel)a
--on tb3.l5_id=a.ownerid 


--insert into crm_Funnel  
--select distinct L1_ID,L1_POSNAME,L1_REGION,L1_BUNIT,L1_VERTICAL,L1_ADDRESS,L1_EMPID,L1_EMPNAME,L1_EMAIL,
--L2_ID,L2_POSNAME,L2_REGION,L2_BUNIT,L2_VERTICAL,L2_ADDRESS,L2_EMPID,L2_EMPNAME,L2_EMAIL,
--L3_ID,L3_POSNAME,L3_REGION,L3_BUNIT,L3_VERTICAL,L3_ADDRESS,L3_EMPID,L3_EMPNAME,L3_EMAIL,
--L4_ID,L4_POSNAME,L4_REGION,L4_BUNIT,L4_VERTICAL,L4_ADDRESS,L4_EMPID,L4_EMPNAME,L4_EMAIL,
--L5_ID,L5_POSNAME,L5_REGION,L5_BUNIT,L5_VERTICAL,L5_ADDRESS,L5_EMPID,L5_EMPNAME,L5_EMAIL,
--L6_ID,L6_POSNAME,L6_REGION,L6_BUNIT,L6_VERTICAL,L6_ADDRESS,L6_EMPID,L6_EMPNAME,L6_EMAIL,
--null,null,null,null,null,null,null,null,null,
--a.*
-- From tb3
--inner join (select * From Funnel)a
--on tb3.l6_id=a.ownerid 


--insert into crm_Funnel  
--select * From tb3
--inner join (select * From Funnel)a
--on tb3.l7_id=a.ownerid 


-----------------------------------
---------------------------------------
----drop table crm_final_fact

----SELECT [L1_ID],[L1_POSNAME],[L1_REGION],[L1_BUNIT],[L1_VERTICAL],[L1_ADDRESS],[L1_EMPID],[L1_EMPNAME],[L1_EMAIL]
----      ,[L2_ID],[L2_POSNAME],[L2_REGION],[L2_BUNIT],[L2_VERTICAL],[L2_ADDRESS],[L2_EMPID],[L2_EMPNAME],[L2_EMAIL]
----      ,[L3_ID],[L3_POSNAME],[L3_REGION],[L3_BUNIT],[L3_VERTICAL],[L3_ADDRESS],[L3_EMPID],[L3_EMPNAME],[L3_EMAIL]
----      ,[L4_ID],[L4_POSNAME],[L4_REGION],[L4_BUNIT],[L4_VERTICAL],[L4_ADDRESS],[L4_EMPID],[L4_EMPNAME],[L4_EMAIL]
----      ,[L5_ID],[L5_POSNAME],[L5_REGION],[L5_BUNIT],[L5_VERTICAL],[L5_ADDRESS],[L5_EMPID],[L5_EMPNAME],[L5_EMAIL]
----      ,[L6_ID],[L6_POSNAME],[L6_REGION],[L6_BUNIT],[L6_VERTICAL],[L6_ADDRESS],[L6_EMPID],[L6_EMPNAME],[L6_EMAIL]
----      ,[L7_ID],[L7_POSNAME],[L7_REGION],[L7_BUNIT],[L7_VERTICAL],[L7_ADDRESS],[L7_EMPID],[L7_EMPNAME],[L7_EMAIL]
----      ,[elgi_dealer],[elgi_dealername],[elgi_dealerengineername],[owneridname],[ownerid] into crm_final_fact
----  FROM [dbo].[crm_plan_Actual] where 1=2

----  ---[crm_plan_Actual]
----alter table crm_final_fact add Typ varchar(100)
----alter table crm_final_fact add elgi_monthstartingdate date
----alter table crm_final_fact add elgi_weeklyplannumbername varchar(100)
----alter table crm_final_fact add elgi_latestvisitdate date
----alter table crm_final_fact add Actual int
----alter table crm_final_fact add pln int
----alter table crm_final_fact add elgi_customertypesalesname varchar(100)

----------------------[avg visits]
----alter table crm_final_fact add totalNoofVisits int
----alter table crm_final_fact add indvdl int
----alter table crm_final_fact add avgvisits int

------------------------------------[elgi_customerclassificationname]
----alter table crm_final_fact add elgi_customerclassificationname varchar(100)
----alter table crm_final_fact add elgi_description varchar(100)
----alter table crm_final_fact add coldcalls_cnt int
----alter table crm_final_fact add Non_coldcalls int

------------------------------------[offer_Active]
----alter table crm_final_fact add Year int
----alter table crm_final_fact add Month int
----alter table crm_final_fact add monthname varchar(30)
----alter table crm_final_fact add offer_Active_Count int


------------------------------------[offer_Active_next2months]
----alter table crm_final_fact add elgi_opportunitystatusname varchar(100)
----alter table crm_final_fact add Count_nxt2months int
----alter table crm_final_fact add Value_nxt2months float
----alter table crm_final_fact add estimatedclosedate date
----alter table crm_final_fact add customeridname varchar(1000)
----alter table crm_final_fact add elgi_existingproductname varchar(1000)
----alter table crm_final_fact add Segment varchar(1000)


------------------------------------[All_Active_eqnuiries]
----alter table crm_final_fact add elgi_productcategoryname varchar(100)
----alter table crm_final_fact add elgi_salesoffice varchar(100)
----alter table crm_final_fact add elgi_salesofficename varchar(100)
----alter table crm_final_fact add All_Active_eqnuiries_Value int
----alter table crm_final_fact add All_Active_eqnuiries_Count int


------------------------------------[orders_to_elgi]
----alter table crm_final_fact add [createdon] date
----alter table crm_final_fact add orders_to_elgi_count int
----alter table crm_final_fact add orders_to_elgi_value int

----alter table crm_final_fact add customeridname varchar(200)
----alter table crm_final_fact add elgi_existingproductname varchar(200)
----alter table crm_final_fact add [segment] varchar(200)

-----------------------------------[orders_to_dealer]
----alter table crm_final_fact add orders_to_dealer_Value int
----alter table crm_final_fact add orders_to_dealer_Count int

------------------------------------[elgi_reasonname]
----alter table crm_final_fact add actualclosedate date
----alter table crm_final_fact add elgi_reasonname varchar(100)
----alter table crm_final_fact add elgi_losttoname varchar(100)
----alter table crm_final_fact add elgi_reasonname_count int

------------------------------------[Funnel]
----alter table crm_final_fact add name varchar(100)
----alter table crm_final_fact add  coldDistcustomer int
----alter table crm_final_fact add  noncoldDistcustomer int
----alter table crm_final_fact add  lastyearcold int
----alter table crm_final_fact add  lastyearnoncold int
----alter table crm_final_fact add funnel_cold int
----alter table crm_final_fact add funnel_noncold int

-------------------------------------------[crm_final_fact]
----	alter table crm_final_fact add Dealr_code varchar(100)
----	alter table crm_final_fact add Eng_code VARCHAR(100)
----	alter table crm_final_fact add elgi_productcategoryname_New varchar(500)
----	alter table crm_final_fact add curDate varchar(500)
----	alter table crm_final_fact add last_week varchar(500)

----alter table crm_final_fact alter column  elgi_cityname nvarchar(500)
----alter table crm_final_fact alter column  elgi_statename nvarchar(500)
----alter table crm_final_fact alter column  elgi_locationofcustomer nvarchar(500)
----alter table crm_final_fact alter column  elgi_model nvarchar(500)
	
----	 delete from All_Active_eqnuiries where owneridname='Athar Ali' --- due to same ownerid but multiple name ownerid='9EC3F461-DC75-E811-A95E-000D3AF29FC0' -- have Athar Ali and Saurabh Virmani
	
--	insert into crm_final_fact 
--		(Typ,[L1_ID],[L1_POSNAME],[L1_REGION],[L1_BUNIT],[L1_VERTICAL],[L1_ADDRESS],[L1_EMPID],[L1_EMPNAME],[L1_EMAIL]
--      ,[L2_ID],[L2_POSNAME],[L2_REGION],[L2_BUNIT],[L2_VERTICAL],[L2_ADDRESS],[L2_EMPID],[L2_EMPNAME],[L2_EMAIL]
--      ,[L3_ID],[L3_POSNAME],[L3_REGION],[L3_BUNIT],[L3_VERTICAL],[L3_ADDRESS],[L3_EMPID],[L3_EMPNAME],[L3_EMAIL]
--      ,[L4_ID],[L4_POSNAME],[L4_REGION],[L4_BUNIT],[L4_VERTICAL],[L4_ADDRESS],[L4_EMPID],[L4_EMPNAME],[L4_EMAIL]
--      ,[L5_ID],[L5_POSNAME],[L5_REGION],[L5_BUNIT],[L5_VERTICAL],[L5_ADDRESS],[L5_EMPID],[L5_EMPNAME],[L5_EMAIL]
--      ,[L6_ID],[L6_POSNAME],[L6_REGION],[L6_BUNIT],[L6_VERTICAL],[L6_ADDRESS],[L6_EMPID],[L6_EMPNAME],[L6_EMAIL]
--      ,[L7_ID],[L7_POSNAME],[L7_REGION],[L7_BUNIT],[L7_VERTICAL],[L7_ADDRESS],[L7_EMPID],[L7_EMPNAME],[L7_EMAIL]
--      ,[elgi_dealer],[elgi_dealername],[elgi_dealerengineername],[elgi_monthstartingdate],[elgi_weeklyplannumbername]
-- ,[elgi_latestvisitdate],[owneridname],[ownerid],[elgi_customertypesalesname],[pln],[Actual])
--	SELECT 'crm_plan_Actual',[L1_ID],[L1_POSNAME],[L1_REGION],[L1_BUNIT],[L1_VERTICAL],[L1_ADDRESS],[L1_EMPID],[L1_EMPNAME],[L1_EMAIL]
--      ,[L2_ID],[L2_POSNAME],[L2_REGION],[L2_BUNIT],[L2_VERTICAL],[L2_ADDRESS],[L2_EMPID],[L2_EMPNAME],[L2_EMAIL]
--      ,[L3_ID],[L3_POSNAME],[L3_REGION],[L3_BUNIT],[L3_VERTICAL],[L3_ADDRESS],[L3_EMPID],[L3_EMPNAME],[L3_EMAIL]
--      ,[L4_ID],[L4_POSNAME],[L4_REGION],[L4_BUNIT],[L4_VERTICAL],[L4_ADDRESS],[L4_EMPID],[L4_EMPNAME],[L4_EMAIL]
--      ,[L5_ID],[L5_POSNAME],[L5_REGION],[L5_BUNIT],[L5_VERTICAL],[L5_ADDRESS],[L5_EMPID],[L5_EMPNAME],[L5_EMAIL]
--      ,[L6_ID],[L6_POSNAME],[L6_REGION],[L6_BUNIT],[L6_VERTICAL],[L6_ADDRESS],[L6_EMPID],[L6_EMPNAME],[L6_EMAIL]
--      ,[L7_ID],[L7_POSNAME],[L7_REGION],[L7_BUNIT],[L7_VERTICAL],[L7_ADDRESS],[L7_EMPID],[L7_EMPNAME],[L7_EMAIL]
--      ,[elgi_dealer],[elgi_dealername],[elgi_dealerengineername],[elgi_monthstartingdate],[elgi_weeklyplannumbername]
--      ,[elgi_latestvisitdate],[owneridname],[ownerid],[elgi_customertypesalesname],[plan],[Actual]
--  FROM [dbo].[crm_plan_Actual]


--  ------------------------[avg_visits]
--	insert into crm_final_fact 
--		(typ,[L1_ID],[L1_POSNAME],[L1_REGION],[L1_BUNIT],[L1_VERTICAL],[L1_ADDRESS],[L1_EMPID],[L1_EMPNAME],[L1_EMAIL]
--      ,[L2_ID],[L2_POSNAME],[L2_REGION],[L2_BUNIT],[L2_VERTICAL],[L2_ADDRESS],[L2_EMPID],[L2_EMPNAME],[L2_EMAIL]
--      ,[L3_ID],[L3_POSNAME],[L3_REGION],[L3_BUNIT],[L3_VERTICAL],[L3_ADDRESS],[L3_EMPID],[L3_EMPNAME],[L3_EMAIL]
--      ,[L4_ID],[L4_POSNAME],[L4_REGION],[L4_BUNIT],[L4_VERTICAL],[L4_ADDRESS],[L4_EMPID],[L4_EMPNAME],[L4_EMAIL]
--      ,[L5_ID],[L5_POSNAME],[L5_REGION],[L5_BUNIT],[L5_VERTICAL],[L5_ADDRESS],[L5_EMPID],[L5_EMPNAME],[L5_EMAIL]
--      ,[L6_ID],[L6_POSNAME],[L6_REGION],[L6_BUNIT],[L6_VERTICAL],[L6_ADDRESS],[L6_EMPID],[L6_EMPNAME],[L6_EMAIL]
--      ,[L7_ID],[L7_POSNAME],[L7_REGION],[L7_BUNIT],[L7_VERTICAL],[L7_ADDRESS],[L7_EMPID],[L7_EMPNAME],[L7_EMAIL]
--      ,[elgi_dealer],[elgi_dealername],[elgi_dealerengineername],[elgi_monthstartingdate],[elgi_weeklyplannumbername]
--      ,[owneridname],[ownerid],[totalNoofVisits],[indvdl],[avgvisits])
--	SELECT 'avg_visits',[L1_ID],[L1_POSNAME],[L1_REGION],[L1_BUNIT],[L1_VERTICAL],[L1_ADDRESS],[L1_EMPID],[L1_EMPNAME],[L1_EMAIL]
--      ,[L2_ID],[L2_POSNAME],[L2_REGION],[L2_BUNIT],[L2_VERTICAL],[L2_ADDRESS],[L2_EMPID],[L2_EMPNAME],[L2_EMAIL]
--      ,[L3_ID],[L3_POSNAME],[L3_REGION],[L3_BUNIT],[L3_VERTICAL],[L3_ADDRESS],[L3_EMPID],[L3_EMPNAME],[L3_EMAIL]
--      ,[L4_ID],[L4_POSNAME],[L4_REGION],[L4_BUNIT],[L4_VERTICAL],[L4_ADDRESS],[L4_EMPID],[L4_EMPNAME],[L4_EMAIL]
--      ,[L5_ID],[L5_POSNAME],[L5_REGION],[L5_BUNIT],[L5_VERTICAL],[L5_ADDRESS],[L5_EMPID],[L5_EMPNAME],[L5_EMAIL]
--      ,[L6_ID],[L6_POSNAME],[L6_REGION],[L6_BUNIT],[L6_VERTICAL],[L6_ADDRESS],[L6_EMPID],[L6_EMPNAME],[L6_EMAIL]
--      ,[L7_ID],[L7_POSNAME],[L7_REGION],[L7_BUNIT],[L7_VERTICAL],[L7_ADDRESS],[L7_EMPID],[L7_EMPNAME],[L7_EMAIL]
--      ,[elgi_dealer],[elgi_dealername],[elgi_dealerengineername],[elgi_monthstartingdate],[elgi_weeklyplannumbername]
--      ,[owneridname],[ownerid],[totalNoofVisits],[indvdl],[avgvisits]  FROM [dbo].[crm_avg_visits]

----------------------------------------[elgi_customerclassificationname]

--	  insert into crm_final_fact 
--		(typ,[L1_ID],[L1_POSNAME],[L1_REGION],[L1_BUNIT],[L1_VERTICAL],[L1_ADDRESS],[L1_EMPID],[L1_EMPNAME],[L1_EMAIL]
--      ,[L2_ID],[L2_POSNAME],[L2_REGION],[L2_BUNIT],[L2_VERTICAL],[L2_ADDRESS],[L2_EMPID],[L2_EMPNAME],[L2_EMAIL]
--      ,[L3_ID],[L3_POSNAME],[L3_REGION],[L3_BUNIT],[L3_VERTICAL],[L3_ADDRESS],[L3_EMPID],[L3_EMPNAME],[L3_EMAIL]
--      ,[L4_ID],[L4_POSNAME],[L4_REGION],[L4_BUNIT],[L4_VERTICAL],[L4_ADDRESS],[L4_EMPID],[L4_EMPNAME],[L4_EMAIL]
--      ,[L5_ID],[L5_POSNAME],[L5_REGION],[L5_BUNIT],[L5_VERTICAL],[L5_ADDRESS],[L5_EMPID],[L5_EMPNAME],[L5_EMAIL]
--      ,[L6_ID],[L6_POSNAME],[L6_REGION],[L6_BUNIT],[L6_VERTICAL],[L6_ADDRESS],[L6_EMPID],[L6_EMPNAME],[L6_EMAIL]
--      ,[L7_ID],[L7_POSNAME],[L7_REGION],[L7_BUNIT],[L7_VERTICAL],[L7_ADDRESS],[L7_EMPID],[L7_EMPNAME],[L7_EMAIL]
--      ,[elgi_dealer],[elgi_dealername],[elgi_dealerengineername],[elgi_monthstartingdate],[elgi_weeklyplannumbername]
--      ,[owneridname],[ownerid],[elgi_customerclassificationname],[elgi_description],[coldcalls_cnt],[Non_coldcalls])
--	SELECT 'elgi_customerclassificationname',[L1_ID],[L1_POSNAME],[L1_REGION],[L1_BUNIT],[L1_VERTICAL],[L1_ADDRESS],[L1_EMPID],[L1_EMPNAME],[L1_EMAIL]
--      ,[L2_ID],[L2_POSNAME],[L2_REGION],[L2_BUNIT],[L2_VERTICAL],[L2_ADDRESS],[L2_EMPID],[L2_EMPNAME],[L2_EMAIL]
--      ,[L3_ID],[L3_POSNAME],[L3_REGION],[L3_BUNIT],[L3_VERTICAL],[L3_ADDRESS],[L3_EMPID],[L3_EMPNAME],[L3_EMAIL]
--      ,[L4_ID],[L4_POSNAME],[L4_REGION],[L4_BUNIT],[L4_VERTICAL],[L4_ADDRESS],[L4_EMPID],[L4_EMPNAME],[L4_EMAIL]
--      ,[L5_ID],[L5_POSNAME],[L5_REGION],[L5_BUNIT],[L5_VERTICAL],[L5_ADDRESS],[L5_EMPID],[L5_EMPNAME],[L5_EMAIL]
--      ,[L6_ID],[L6_POSNAME],[L6_REGION],[L6_BUNIT],[L6_VERTICAL],[L6_ADDRESS],[L6_EMPID],[L6_EMPNAME],[L6_EMAIL]
--      ,[L7_ID],[L7_POSNAME],[L7_REGION],[L7_BUNIT],[L7_VERTICAL],[L7_ADDRESS],[L7_EMPID],[L7_EMPNAME],[L7_EMAIL]
--      ,[elgi_dealer],[elgi_dealername],[elgi_dealerengineername],[elgi_monthstartingdate],[elgi_weeklyplannumbername]
--      ,[owneridname],[ownerid],[elgi_customerclassificationname],[elgi_description],[coldcalls_cnt],[Non_coldcalls]  FROM [dbo].[elgi_customerclassificationname]
	  

----------------------------------------[offer_Active]
	
--		insert into crm_final_fact 
--		(Typ,[L1_ID],[L1_POSNAME],[L1_REGION],[L1_BUNIT],[L1_VERTICAL],[L1_ADDRESS],[L1_EMPID],[L1_EMPNAME],[L1_EMAIL]
--      ,[L2_ID],[L2_POSNAME],[L2_REGION],[L2_BUNIT],[L2_VERTICAL],[L2_ADDRESS],[L2_EMPID],[L2_EMPNAME],[L2_EMAIL]
--   ,[L3_ID],[L3_POSNAME],[L3_REGION],[L3_BUNIT],[L3_VERTICAL],[L3_ADDRESS],[L3_EMPID],[L3_EMPNAME],[L3_EMAIL]
--      ,[L4_ID],[L4_POSNAME],[L4_REGION],[L4_BUNIT],[L4_VERTICAL],[L4_ADDRESS],[L4_EMPID],[L4_EMPNAME],[L4_EMAIL]
--      ,[L5_ID],[L5_POSNAME],[L5_REGION],[L5_BUNIT],[L5_VERTICAL],[L5_ADDRESS],[L5_EMPID],[L5_EMPNAME],[L5_EMAIL]
--      ,[L6_ID],[L6_POSNAME],[L6_REGION],[L6_BUNIT],[L6_VERTICAL],[L6_ADDRESS],[L6_EMPID],[L6_EMPNAME],[L6_EMAIL]
--      ,[L7_ID],[L7_POSNAME],[L7_REGION],[L7_BUNIT],[L7_VERTICAL],[L7_ADDRESS],[L7_EMPID],[L7_EMPNAME],[L7_EMAIL]
--      ,[elgi_dealer],[elgi_dealername],[elgi_dealerengineername]
--      ,[owneridname],[ownerid],[Year],[Month],[monthname],[offer_Active_Count])
--		SELECT 'offer_Active',[L1_ID],[L1_POSNAME],[L1_REGION],[L1_BUNIT],[L1_VERTICAL],[L1_ADDRESS],[L1_EMPID],[L1_EMPNAME],[L1_EMAIL]
--      ,[L2_ID],[L2_POSNAME],[L2_REGION],[L2_BUNIT],[L2_VERTICAL],[L2_ADDRESS],[L2_EMPID],[L2_EMPNAME],[L2_EMAIL]
--      ,[L3_ID],[L3_POSNAME],[L3_REGION],[L3_BUNIT],[L3_VERTICAL],[L3_ADDRESS],[L3_EMPID],[L3_EMPNAME],[L3_EMAIL]
--      ,[L4_ID],[L4_POSNAME],[L4_REGION],[L4_BUNIT],[L4_VERTICAL],[L4_ADDRESS],[L4_EMPID],[L4_EMPNAME],[L4_EMAIL]
--      ,[L5_ID],[L5_POSNAME],[L5_REGION],[L5_BUNIT],[L5_VERTICAL],[L5_ADDRESS],[L5_EMPID],[L5_EMPNAME],[L5_EMAIL]
--      ,[L6_ID],[L6_POSNAME],[L6_REGION],[L6_BUNIT],[L6_VERTICAL],[L6_ADDRESS],[L6_EMPID],[L6_EMPNAME],[L6_EMAIL]
--      ,[L7_ID],[L7_POSNAME],[L7_REGION],[L7_BUNIT],[L7_VERTICAL],[L7_ADDRESS],[L7_EMPID],[L7_EMPNAME],[L7_EMAIL]
--      ,[elgi_dealer],[elgi_dealername],[elgi_dealerengineername]
--      ,[owneridname],[ownerid],[Year],[Month],[monthname],[Count]  FROM [dbo].[offer_Active]
	  
--	  	  --------------------------------------[offer_Active_next2months]
--	insert into crm_final_fact 
--		(Typ,[L1_ID],[L1_POSNAME],[L1_REGION],[L1_BUNIT],[L1_VERTICAL],[L1_ADDRESS],[L1_EMPID],[L1_EMPNAME],[L1_EMAIL]
--      ,[L2_ID],[L2_POSNAME],[L2_REGION],[L2_BUNIT],[L2_VERTICAL],[L2_ADDRESS],[L2_EMPID],[L2_EMPNAME],[L2_EMAIL]
--      ,[L3_ID],[L3_POSNAME],[L3_REGION],[L3_BUNIT],[L3_VERTICAL],[L3_ADDRESS],[L3_EMPID],[L3_EMPNAME],[L3_EMAIL]
--      ,[L4_ID],[L4_POSNAME],[L4_REGION],[L4_BUNIT],[L4_VERTICAL],[L4_ADDRESS],[L4_EMPID],[L4_EMPNAME],[L4_EMAIL]
--      ,[L5_ID],[L5_POSNAME],[L5_REGION],[L5_BUNIT],[L5_VERTICAL],[L5_ADDRESS],[L5_EMPID],[L5_EMPNAME],[L5_EMAIL]
--      ,[L6_ID],[L6_POSNAME],[L6_REGION],[L6_BUNIT],[L6_VERTICAL],[L6_ADDRESS],[L6_EMPID],[L6_EMPNAME],[L6_EMAIL]
--  ,[L7_ID],[L7_POSNAME],[L7_REGION],[L7_BUNIT],[L7_VERTICAL],[L7_ADDRESS],[L7_EMPID],[L7_EMPNAME],[L7_EMAIL]
--      ,[elgi_dealer],[elgi_dealername],[elgi_dealerengineername],estimatedclosedate,customeridname,elgi_existingproductname
--      ,[owneridname],[ownerid],[elgi_productcategoryname],[Count_nxt2months],[value_nxt2months],createdon,Segment,
--	  [elgi_cityname],[elgi_statename],[elgi_locationofcustomer])
--	SELECT 'offer_Active_next2months',[L1_ID],[L1_POSNAME],[L1_REGION],[L1_BUNIT],[L1_VERTICAL],[L1_ADDRESS],[L1_EMPID],[L1_EMPNAME],[L1_EMAIL]
--,[L2_ID],[L2_POSNAME],[L2_REGION],[L2_BUNIT],[L2_VERTICAL],[L2_ADDRESS],[L2_EMPID],[L2_EMPNAME],[L2_EMAIL]
--      ,[L3_ID],[L3_POSNAME],[L3_REGION],[L3_BUNIT],[L3_VERTICAL],[L3_ADDRESS],[L3_EMPID],[L3_EMPNAME],[L3_EMAIL]
--      ,[L4_ID],[L4_POSNAME],[L4_REGION],[L4_BUNIT],[L4_VERTICAL],[L4_ADDRESS],[L4_EMPID],[L4_EMPNAME],[L4_EMAIL]
--      ,[L5_ID],[L5_POSNAME],[L5_REGION],[L5_BUNIT],[L5_VERTICAL],[L5_ADDRESS],[L5_EMPID],[L5_EMPNAME],[L5_EMAIL]
--      ,[L6_ID],[L6_POSNAME],[L6_REGION],[L6_BUNIT],[L6_VERTICAL],[L6_ADDRESS],[L6_EMPID],[L6_EMPNAME],[L6_EMAIL]
--      ,[L7_ID],[L7_POSNAME],[L7_REGION],[L7_BUNIT],[L7_VERTICAL],[L7_ADDRESS],[L7_EMPID],[L7_EMPNAME],[L7_EMAIL]
--      ,[elgi_dealer],[elgi_dealername],[elgi_dealerengineername],estimatedclosedate,customeridname,elgi_existingproductname
--      ,[owneridname],[ownerid],[elgi_productcategoryname],[Count],[value],createdon,elgi_description,
--	   [elgi_cityname],[elgi_statename],[elgi_locationofcustomer]
--	  FROM [dbo].[offer_Active_next2months]
	  
	  
--	--------------------------------------[All_Active_eqnuiries]
--	insert into crm_final_fact 
--		(Typ,[L1_ID],[L1_POSNAME],[L1_REGION],[L1_BUNIT],[L1_VERTICAL],[L1_ADDRESS],[L1_EMPID],[L1_EMPNAME],[L1_EMAIL]
--      ,[L2_ID],[L2_POSNAME],[L2_REGION],[L2_BUNIT],[L2_VERTICAL],[L2_ADDRESS],[L2_EMPID],[L2_EMPNAME],[L2_EMAIL]
--      ,[L3_ID],[L3_POSNAME],[L3_REGION],[L3_BUNIT],[L3_VERTICAL],[L3_ADDRESS],[L3_EMPID],[L3_EMPNAME],[L3_EMAIL]
--      ,[L4_ID],[L4_POSNAME],[L4_REGION],[L4_BUNIT],[L4_VERTICAL],[L4_ADDRESS],[L4_EMPID],[L4_EMPNAME],[L4_EMAIL]
--      ,[L5_ID],[L5_POSNAME],[L5_REGION],[L5_BUNIT],[L5_VERTICAL],[L5_ADDRESS],[L5_EMPID],[L5_EMPNAME],[L5_EMAIL]
--      ,[L6_ID],[L6_POSNAME],[L6_REGION],[L6_BUNIT],[L6_VERTICAL],[L6_ADDRESS],[L6_EMPID],[L6_EMPNAME],[L6_EMAIL]
--      ,[L7_ID],[L7_POSNAME],[L7_REGION],[L7_BUNIT],[L7_VERTICAL],[L7_ADDRESS],[L7_EMPID],[L7_EMPNAME],[L7_EMAIL]
--      ,[elgi_dealer],[elgi_dealername],[elgi_dealerengineername],[createdon] 
--      ,[owneridname],[ownerid],[elgi_productcategoryname],[elgi_salesofficename],[elgi_salesoffice],[elgi_description],
--	  [All_Active_eqnuiries_Value],[All_Active_eqnuiries_Count])
--	SELECT 'All_Active_eqnuiries',[L1_ID],[L1_POSNAME],[L1_REGION],[L1_BUNIT],[L1_VERTICAL],[L1_ADDRESS],[L1_EMPID],[L1_EMPNAME],[L1_EMAIL]
--      ,[L2_ID],[L2_POSNAME],[L2_REGION],[L2_BUNIT],[L2_VERTICAL],[L2_ADDRESS],[L2_EMPID],[L2_EMPNAME],[L2_EMAIL]
--      ,[L3_ID],[L3_POSNAME],[L3_REGION],[L3_BUNIT],[L3_VERTICAL],[L3_ADDRESS],[L3_EMPID],[L3_EMPNAME],[L3_EMAIL]
--      ,[L4_ID],[L4_POSNAME],[L4_REGION],[L4_BUNIT],[L4_VERTICAL],[L4_ADDRESS],[L4_EMPID],[L4_EMPNAME],[L4_EMAIL]
--      ,[L5_ID],[L5_POSNAME],[L5_REGION],[L5_BUNIT],[L5_VERTICAL],[L5_ADDRESS],[L5_EMPID],[L5_EMPNAME],[L5_EMAIL]
--      ,[L6_ID],[L6_POSNAME],[L6_REGION],[L6_BUNIT],[L6_VERTICAL],[L6_ADDRESS],[L6_EMPID],[L6_EMPNAME],[L6_EMAIL]
--      ,[L7_ID],[L7_POSNAME],[L7_REGION],[L7_BUNIT],[L7_VERTICAL],[L7_ADDRESS],[L7_EMPID],[L7_EMPNAME],[L7_EMAIL]
--      ,[elgi_dealer],[elgi_dealername],[elgi_dealerengineername],[createdon] 
--      ,[owneridname],[ownerid],[elgi_productcategoryname],[elgi_salesofficename],[elgi_salesoffice],[elgi_description]
--	  ,[Value],[Count]  FROM [dbo].[All_Active_eqnuiries]

----------------------------------------[orders_to_elgi]

--insert into crm_final_fact 
--		(Typ,[L1_ID],[L1_POSNAME],[L1_REGION],[L1_BUNIT],[L1_VERTICAL],[L1_ADDRESS],[L1_EMPID],[L1_EMPNAME],[L1_EMAIL]
--      ,[L2_ID],[L2_POSNAME],[L2_REGION],[L2_BUNIT],[L2_VERTICAL],[L2_ADDRESS],[L2_EMPID],[L2_EMPNAME],[L2_EMAIL]
--      ,[L3_ID],[L3_POSNAME],[L3_REGION],[L3_BUNIT],[L3_VERTICAL],[L3_ADDRESS],[L3_EMPID],[L3_EMPNAME],[L3_EMAIL]
--      ,[L4_ID],[L4_POSNAME],[L4_REGION],[L4_BUNIT],[L4_VERTICAL],[L4_ADDRESS],[L4_EMPID],[L4_EMPNAME],[L4_EMAIL]
--      ,[L5_ID],[L5_POSNAME],[L5_REGION],[L5_BUNIT],[L5_VERTICAL],[L5_ADDRESS],[L5_EMPID],[L5_EMPNAME],[L5_EMAIL]
--      ,[L6_ID],[L6_POSNAME],[L6_REGION],[L6_BUNIT],[L6_VERTICAL],[L6_ADDRESS],[L6_EMPID],[L6_EMPNAME],[L6_EMAIL]
--      ,[L7_ID],[L7_POSNAME],[L7_REGION],[L7_BUNIT],[L7_VERTICAL],[L7_ADDRESS],[L7_EMPID],[L7_EMPNAME],[L7_EMAIL]
--      ,[elgi_dealer],[elgi_dealername],[elgi_dealerengineername],customeridname,elgi_existingproductname
--      ,[owneridname],[ownerid],[elgi_productcategoryname],[elgi_salesofficename],[elgi_salesoffice]
--	  ,[createdon],[orders_to_elgi_Value],[orders_to_elgi_Count],Segment
--	  ,[elgi_cityname],[elgi_statename],[elgi_locationofcustomer]
--	 )
--	SELECT 'orders_to_elgi',[L1_ID],[L1_POSNAME],[L1_REGION],[L1_BUNIT],[L1_VERTICAL],[L1_ADDRESS],[L1_EMPID],[L1_EMPNAME],[L1_EMAIL]
--      ,[L2_ID],[L2_POSNAME],[L2_REGION],[L2_BUNIT],[L2_VERTICAL],[L2_ADDRESS],[L2_EMPID],[L2_EMPNAME],[L2_EMAIL]
--,[L3_ID],[L3_POSNAME],[L3_REGION],[L3_BUNIT],[L3_VERTICAL],[L3_ADDRESS],[L3_EMPID],[L3_EMPNAME],[L3_EMAIL]
--      ,[L4_ID],[L4_POSNAME],[L4_REGION],[L4_BUNIT],[L4_VERTICAL],[L4_ADDRESS],[L4_EMPID],[L4_EMPNAME],[L4_EMAIL]
--  ,[L5_ID],[L5_POSNAME],[L5_REGION],[L5_BUNIT],[L5_VERTICAL],[L5_ADDRESS],[L5_EMPID],[L5_EMPNAME],[L5_EMAIL]
--      ,[L6_ID],[L6_POSNAME],[L6_REGION],[L6_BUNIT],[L6_VERTICAL],[L6_ADDRESS],[L6_EMPID],[L6_EMPNAME],[L6_EMAIL]
--      ,[L7_ID],[L7_POSNAME],[L7_REGION],[L7_BUNIT],[L7_VERTICAL],[L7_ADDRESS],[L7_EMPID],[L7_EMPNAME],[L7_EMAIL]
--      ,[elgi_dealer],[elgi_dealername],[elgi_dealerengineername],customeridname,elgi_existingproductname
--      ,[owneridname],[ownerid],[elgi_productcategoryname],[elgi_salesofficename],[elgi_salesoffice]
--	  ,[createdon],round([Value],0),[Count],[segment]
--	  ,[elgi_cityname],[elgi_statename],[elgi_locationofcustomer]
--	  FROM [dbo].[orders_to_elgi]
	  	
--	-------------------------------------[orders_to_dealer]
--	insert into crm_final_fact 
--		(Typ,[L1_ID],[L1_POSNAME],[L1_REGION],[L1_BUNIT],[L1_VERTICAL],[L1_ADDRESS],[L1_EMPID],[L1_EMPNAME],[L1_EMAIL]
--      ,[L2_ID],[L2_POSNAME],[L2_REGION],[L2_BUNIT],[L2_VERTICAL],[L2_ADDRESS],[L2_EMPID],[L2_EMPNAME],[L2_EMAIL]
--      ,[L3_ID],[L3_POSNAME],[L3_REGION],[L3_BUNIT],[L3_VERTICAL],[L3_ADDRESS],[L3_EMPID],[L3_EMPNAME],[L3_EMAIL]
--      ,[L4_ID],[L4_POSNAME],[L4_REGION],[L4_BUNIT],[L4_VERTICAL],[L4_ADDRESS],[L4_EMPID],[L4_EMPNAME],[L4_EMAIL]
--      ,[L5_ID],[L5_POSNAME],[L5_REGION],[L5_BUNIT],[L5_VERTICAL],[L5_ADDRESS],[L5_EMPID],[L5_EMPNAME],[L5_EMAIL]
--      ,[L6_ID],[L6_POSNAME],[L6_REGION],[L6_BUNIT],[L6_VERTICAL],[L6_ADDRESS],[L6_EMPID],[L6_EMPNAME],[L6_EMAIL]
--      ,[L7_ID],[L7_POSNAME],[L7_REGION],[L7_BUNIT],[L7_VERTICAL],[L7_ADDRESS],[L7_EMPID],[L7_EMPNAME],[L7_EMAIL]
--      ,[elgi_dealer],[elgi_dealername],[elgi_dealerengineername]
--      ,[owneridname],[ownerid],[elgi_productcategoryname],[elgi_salesofficename],[elgi_salesoffice],
--	  [createdon],[orders_to_dealer_Value],[orders_to_dealer_Count])
--	SELECT 'orders_to_dealer',[L1_ID],[L1_POSNAME],[L1_REGION],[L1_BUNIT],[L1_VERTICAL],[L1_ADDRESS],[L1_EMPID],[L1_EMPNAME],[L1_EMAIL]
--      ,[L2_ID],[L2_POSNAME],[L2_REGION],[L2_BUNIT],[L2_VERTICAL],[L2_ADDRESS],[L2_EMPID],[L2_EMPNAME],[L2_EMAIL]
--      ,[L3_ID],[L3_POSNAME],[L3_REGION],[L3_BUNIT],[L3_VERTICAL],[L3_ADDRESS],[L3_EMPID],[L3_EMPNAME],[L3_EMAIL]
--      ,[L4_ID],[L4_POSNAME],[L4_REGION],[L4_BUNIT],[L4_VERTICAL],[L4_ADDRESS],[L4_EMPID],[L4_EMPNAME],[L4_EMAIL]
--      ,[L5_ID],[L5_POSNAME],[L5_REGION],[L5_BUNIT],[L5_VERTICAL],[L5_ADDRESS],[L5_EMPID],[L5_EMPNAME],[L5_EMAIL]
--      ,[L6_ID],[L6_POSNAME],[L6_REGION],[L6_BUNIT],[L6_VERTICAL],[L6_ADDRESS],[L6_EMPID],[L6_EMPNAME],[L6_EMAIL]
--      ,[L7_ID],[L7_POSNAME],[L7_REGION],[L7_BUNIT],[L7_VERTICAL],[L7_ADDRESS],[L7_EMPID],[L7_EMPNAME],[L7_EMAIL]
--      ,[elgi_dealer],[elgi_dealername],[elgi_dealerengineername]
--      ,[owneridname],[ownerid],[elgi_productcategoryname],[elgi_salesofficename],[elgi_salesoffice],[createdon]
--	  ,[Value],[Count]  FROM [dbo].[orders_to_dealer]

----------------------------------------[elgi_reasonname]

--	insert into crm_final_fact 
--		(Typ,[L1_ID],[L1_POSNAME],[L1_REGION],[L1_BUNIT],[L1_VERTICAL],[L1_ADDRESS],[L1_EMPID],[L1_EMPNAME],[L1_EMAIL]
--      ,[L2_ID],[L2_POSNAME],[L2_REGION],[L2_BUNIT],[L2_VERTICAL],[L2_ADDRESS],[L2_EMPID],[L2_EMPNAME],[L2_EMAIL]
--      ,[L3_ID],[L3_POSNAME],[L3_REGION],[L3_BUNIT],[L3_VERTICAL],[L3_ADDRESS],[L3_EMPID],[L3_EMPNAME],[L3_EMAIL]
--      ,[L4_ID],[L4_POSNAME],[L4_REGION],[L4_BUNIT],[L4_VERTICAL],[L4_ADDRESS],[L4_EMPID],[L4_EMPNAME],[L4_EMAIL]
--      ,[L5_ID],[L5_POSNAME],[L5_REGION],[L5_BUNIT],[L5_VERTICAL],[L5_ADDRESS],[L5_EMPID],[L5_EMPNAME],[L5_EMAIL]
--      ,[L6_ID],[L6_POSNAME],[L6_REGION],[L6_BUNIT],[L6_VERTICAL],[L6_ADDRESS],[L6_EMPID],[L6_EMPNAME],[L6_EMAIL]
--      ,[L7_ID],[L7_POSNAME],[L7_REGION],[L7_BUNIT],[L7_VERTICAL],[L7_ADDRESS],[L7_EMPID],[L7_EMPNAME],[L7_EMAIL]
--      ,[elgi_dealer],[elgi_dealername],[elgi_dealerengineername]
--      ,[owneridname],[ownerid],[actualclosedate],[elgi_reasonname],[elgi_losttoname],[elgi_reasonname_count],Segment,
--	  elgi_existingproductname,[createdon],customeridname,[elgi_cityname],[elgi_statename],[elgi_locationofcustomer],elgi_model)
--	SELECT 'elgi_reasonname',[L1_ID],[L1_POSNAME],[L1_REGION],[L1_BUNIT],[L1_VERTICAL],[L1_ADDRESS],[L1_EMPID],[L1_EMPNAME],[L1_EMAIL]
--      ,[L2_ID],[L2_POSNAME],[L2_REGION],[L2_BUNIT],[L2_VERTICAL],[L2_ADDRESS],[L2_EMPID],[L2_EMPNAME],[L2_EMAIL]
--      ,[L3_ID],[L3_POSNAME],[L3_REGION],[L3_BUNIT],[L3_VERTICAL],[L3_ADDRESS],[L3_EMPID],[L3_EMPNAME],[L3_EMAIL]
--      ,[L4_ID],[L4_POSNAME],[L4_REGION],[L4_BUNIT],[L4_VERTICAL],[L4_ADDRESS],[L4_EMPID],[L4_EMPNAME],[L4_EMAIL]
--      ,[L5_ID],[L5_POSNAME],[L5_REGION],[L5_BUNIT],[L5_VERTICAL],[L5_ADDRESS],[L5_EMPID],[L5_EMPNAME],[L5_EMAIL]
--      ,[L6_ID],[L6_POSNAME],[L6_REGION],[L6_BUNIT],[L6_VERTICAL],[L6_ADDRESS],[L6_EMPID],[L6_EMPNAME],[L6_EMAIL]
--      ,[L7_ID],[L7_POSNAME],[L7_REGION],[L7_BUNIT],[L7_VERTICAL],[L7_ADDRESS],[L7_EMPID],[L7_EMPNAME],[L7_EMAIL]
--  ,[elgi_dealer],[elgi_dealername],[elgi_dealerengineername]
--      ,[owneridname],[ownerid],[actualclosedate],[elgi_reasonname],[elgi_losttoname],[count],[Segment],
--	  [elgi_model],[createdon],customeridname,[elgi_cityname],[elgi_statename],[elgi_locationofcustomer],elgi_model FROM [dbo].[elgi_reasonname]

--	  ------------------------------ funnel
--	  insert into crm_final_fact 
--	(Typ,[L1_ID],[L1_POSNAME],[L1_REGION],[L1_BUNIT],[L1_VERTICAL],[L1_ADDRESS],[L1_EMPID],[L1_EMPNAME],[L1_EMAIL]
--      ,[L2_ID],[L2_POSNAME],[L2_REGION],[L2_BUNIT],[L2_VERTICAL],[L2_ADDRESS],[L2_EMPID],[L2_EMPNAME],[L2_EMAIL]
--      ,[L3_ID],[L3_POSNAME],[L3_REGION],[L3_BUNIT],[L3_VERTICAL],[L3_ADDRESS],[L3_EMPID],[L3_EMPNAME],[L3_EMAIL]
--      ,[L4_ID],[L4_POSNAME],[L4_REGION],[L4_BUNIT],[L4_VERTICAL],[L4_ADDRESS],[L4_EMPID],[L4_EMPNAME],[L4_EMAIL]
--      ,[L5_ID],[L5_POSNAME],[L5_REGION],[L5_BUNIT],[L5_VERTICAL],[L5_ADDRESS],[L5_EMPID],[L5_EMPNAME],[L5_EMAIL]
--      ,[L6_ID],[L6_POSNAME],[L6_REGION],[L6_BUNIT],[L6_VERTICAL],[L6_ADDRESS],[L6_EMPID],[L6_EMPNAME],[L6_EMAIL]
--      ,[L7_ID],[L7_POSNAME],[L7_REGION],[L7_BUNIT],[L7_VERTICAL],[L7_ADDRESS],[L7_EMPID],[L7_EMPNAME],[L7_EMAIL]
--,[elgi_dealername],[elgi_dealerengineername],[owneridname],[ownerid],
--	 [name],coldDistcustomer,noncoldDistcustomer,lastyearcold,lastyearnoncold,[funnel_cold],[funnel_noncold])
--	SELECT 'Funnel',[L1_ID],[L1_POSNAME],[L1_REGION],[L1_BUNIT],[L1_VERTICAL],[L1_ADDRESS],[L1_EMPID],[L1_EMPNAME],[L1_EMAIL]
--      ,[L2_ID],[L2_POSNAME],[L2_REGION],[L2_BUNIT],[L2_VERTICAL],[L2_ADDRESS],[L2_EMPID],[L2_EMPNAME],[L2_EMAIL]
--      ,[L3_ID],[L3_POSNAME],[L3_REGION],[L3_BUNIT],[L3_VERTICAL],[L3_ADDRESS],[L3_EMPID],[L3_EMPNAME],[L3_EMAIL]
--      ,[L4_ID],[L4_POSNAME],[L4_REGION],[L4_BUNIT],[L4_VERTICAL],[L4_ADDRESS],[L4_EMPID],[L4_EMPNAME],[L4_EMAIL]
--      ,[L5_ID],[L5_POSNAME],[L5_REGION],[L5_BUNIT],[L5_VERTICAL],[L5_ADDRESS],[L5_EMPID],[L5_EMPNAME],[L5_EMAIL]
--      ,[L6_ID],[L6_POSNAME],[L6_REGION],[L6_BUNIT],[L6_VERTICAL],[L6_ADDRESS],[L6_EMPID],[L6_EMPNAME],[L6_EMAIL]
--      ,[L7_ID],[L7_POSNAME],[L7_REGION],[L7_BUNIT],[L7_VERTICAL],[L7_ADDRESS],[L7_EMPID],[L7_EMPNAME],[L7_EMAIL]
--      ,[elgi_dealername],[elgi_dealerengineername],[owneridname],[ownerid],
--	  [name],coldDistcustomer,noncoldDistcustomer,lastyearcold,lastyearnoncold,[coldcalls_cnt],[Non_coldcalls_cnt] FROM [dbo].[crm_Funnel]
	
	

--	   update crm_final_fact set Dealr_code=a.elgi_erpcustomercode from(select accountid ,elgi_erpcustomercode  From ACCOUNT)a
--	  where crm_final_fact.elgi_dealer=a.accountid

--	 update crm_final_fact set Eng_code=a.employeeid  from(select systemuserid,employeeid From USERS )a
--	  where crm_final_fact.ownerid =a.systemuserid 

--	  update crm_final_fact set elgi_productcategoryname_New=a.Target_Category  
--	  from(select ltrim(rtrim(SalesOffice_Name))SalesOffice_Name,ltrim(rtrim(crm_category))crm_category,Target_Category 
--	  from CRM_PRODUCT_GROUP)a
--	  where ltrim(rtrim(crm_final_fact.elgi_salesofficename))=a.SalesOffice_Name 
--	  and ltrim(rtrim(crm_final_fact.elgi_productcategoryname))=a.crm_category  

--	update crm_final_fact set last_week=(select distinct week From lastweek_number where convert(date,getdate()) between StartDate and Enddate )

--	update crm_final_fact set curDate= (select concat(year(getdate()-1),month(getdate()-1)))

----Commented on 28-Feb-2022	  
----delete from crm_final_fact where elgi_productcategoryname_New is null and typ in ('All_Active_eqnuiries','orders_to_dealer','orders_to_elgi') --ww

	 
--insert into crm_final_Actual
--select *,
--case when elgi_weeklyplannumbername =last_week then [pln] else 0 end as wk_plan,
--case when elgi_weeklyplannumbername =last_week then actual else 0 end as wk_actual,
--case when concat(year(elgi_monthstartingdate),month(elgi_monthstartingdate)) =curDate then [pln] else 0 end as Month_plan,
--case when concat(year(elgi_monthstartingdate),month(elgi_monthstartingdate)) =curDate then actual else 0 end as Month_Actual,
--case when elgi_weeklyplannumbername =last_week then totalNoofVisits else 0 end as wk_totalNoofVisits,
--case when elgi_weeklyplannumbername =last_week then indvdl else 0 end as wk_indvdl,
--case when concat(year(elgi_monthstartingdate),month(elgi_monthstartingdate)) =curDate then totalNoofVisits else 0 end as Month_totalNoofVisits,
--case when concat(year(elgi_monthstartingdate),month(elgi_monthstartingdate)) =curDate then indvdl else 0 end as Month_indvdl,
--case when elgi_weeklyplannumbername =last_week then coldcalls_cnt  else 0 end as wk_coldcalls_cnt,
--case when elgi_weeklyplannumbername =last_week then non_coldcalls else 0 end as wk_non_coldcalls_cnt,
--case when concat(year(elgi_monthstartingdate),month(elgi_monthstartingdate)) =curDate then coldcalls_cnt else 0 end as Month_coldcalls_cnt,
--case when concat(year(elgi_monthstartingdate),month(elgi_monthstartingdate)) =curDate then non_coldcalls else 0 end as Month_non_coldcalls_cnt,
--case when left(monthname,3) ='Apr' then 1 when left(monthname,3) ='May' then 2 when left(monthname,3) ='Jun' then 3 
--when left(monthname,3) ='Jul' then 4 when left(monthname,3) ='Aug' then 5 when left(monthname,3) ='Sep' then 6 
--when left(monthname,3) ='Oct' then 7 when left(monthname,3) ='Nov' then 8 when left(monthname,3) ='Dec' then 9 
--when left(monthname,3) ='Jan' then 10 when left(monthname,3) ='Feb' then 11 when left(monthname,3) ='Mar' then 12 end as ordr,
--case when  elgi_opportunitystatusname='Lead'then 1 
--when  elgi_opportunitystatusname='Enquiry'then 2 
--when  elgi_opportunitystatusname='Quotation'then 3 else 4 end as Next2months_ordr,
--case when concat(year(actualclosedate),month(actualclosedate))=curDate then elgi_reasonname_count  else 0 end as MonthCount_reasonname,
--case when concat(year(createdon),month(createdon))=curDate then orders_to_elgi_count  else 0 end as MonthCount_orders_to_elgi,
--case when concat(year(createdon),month(createdon))=curDate then orders_to_elgi_Value  else 0 end as MonthValue_orders_to_elgi,
--case when concat(year(createdon),month(createdon))=curDate then orders_to_dealer_count  else 0 end as MonthCount_orders_to_dealer,
--case when concat(year(createdon),month(createdon))=curDate then orders_to_dealer_Value  else 0 end as MonthValue_orders_to_dealer,
--case when concat(year(createdon),month(createdon))=curDate then All_Active_eqnuiries_Count  else 0 end as All_Active_eqnuiries_month_Count
---- drop table crm_final_Actual 
--  --into crm_final_Actual 
--from crm_final_fact 
--  --where 1=2



end

GO

