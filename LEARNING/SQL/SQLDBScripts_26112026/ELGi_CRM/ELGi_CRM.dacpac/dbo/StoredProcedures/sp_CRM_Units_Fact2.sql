--exec sp_CRM_Units_Fact2
CREATE proc sp_CRM_Units_Fact2 as

begin

Declare @var1 int=(select case when month(getdate())-1 <4 then 4 else 3 end)

Declare @Finyear int=(select max(Fin_Year)-@var1 from CRM_Sales_Review_Deck_history where cal_year=year(getdate()-1))
Declare @StartDate date=datefromparts(@Finyear,4,1)
select @StartDate

Truncate table CRM_Units_Stage1
Truncate table CRM_Engineer 
Truncate table CRM_Dealer 


Insert into CRM_Units_Stage1(opportunityid,elgi_enquiryid,elgi_customervisitid,
elgi_dealer,elgi_dealername,elgi_dealerengineer,
elgi_dealerengineername,elgi_businessverticalname,
elgi_sourceofenquiryname,owneridname,elgi_opportunitystatusname,elgi_enquirystatusname,
statecodename,statuscodename,elgi_probabilityname,estimatedclosedate,actualclosedate,
createdon,createdbyname,customerid,RequiredAttendees,elgi_customertypesalesname,elgi_latestvisitdate,
elgi_monthstartingdate,elgi_statusofvisitsales,elgi_statusofvisitsalesname,ownerid,elgi_losttoname,
elgi_reasonname,elgi_buyingreasonname,elgi_remarks,
elgi_numbers,elgi_pricewelosttheorderat,elgi_model,elgi_lineofbusinessname,Enq_Desc,elgi_customervisit,
elgi_enquirystatus2name,createdby)
--select * into CRM_Units_Stage1 from (

select 
b.opportunityid,b.elgi_enquiryid,
isnull(b.elgi_customervisitid,a.elgi_customervisitid) elgi_customervisitid,
isnull(b.elgi_dealer,a.elgi_dealer) elgi_dealer,
isnull(b.elgi_dealername,a.elgi_dealername) elgi_dealername,
isnull(b.elgi_dealerengineer,a.elgi_dealerengineer) elgi_dealerengineer,
isnull(b.elgi_dealerengineername,a.elgi_dealerengineername) elgi_dealerengineername,
b.elgi_businessverticalname,
b.elgi_sourceofenquiryname,
isnull(b.owneridname,a.owneridname) owneridname,
b.elgi_opportunitystatusname,b.elgi_enquirystatusname,
b.statecodename,b.statuscodename,b.elgi_probabilityname,b.estimatedclosedate,
b.actualclosedate,b.createdon,b.createdbyname,b.customerid,
a.activityid as RequiredAttendees,
a.elgi_customertypesalesname,a.elgi_latestvisitdate,a.elgi_monthstartingdate,
a.elgi_statusofvisitsales,elgi_statusofvisitsalesname,
isnull(b.ownerid,a.ownerid) ownerid,
b.elgi_losttoname,b.elgi_reasonname,b.elgi_buyingreasonname,
b.elgi_remarks,b.elgi_numbers,b.elgi_pricewelosttheorderat,b.elgi_model,elgi_lineofbusinessname,
b.Enq_Desc,b.elgi_customervisit,b.elgi_enquirystatus2name,b.createdby
from 
(select distinct activityid,
--substring(requiredattendees,14,36) requiredattendees,  --old method, field not available from Source data
elgi_customervisitid,
elgi_customertypesalesname,elgi_latestvisitdate,
elgi_monthstartingdate,elgi_dealer,elgi_dealername,elgi_dealerengineer,
elgi_dealerengineername,elgi_statusofvisitsales,elgi_statusofvisitsalesname,owneridname,ownerid,
statuscodename ,elgi_lineofbusinessname
from appointment_CRM
where --len(requiredattendees)>2 and len(elgi_customertypesalesname)>2 and
elgi_latestvisitdate>=@StartDate
--'2018-10-01' --Old Date Condition
and ownerid in (select distinct systemuserid from systemuser_CRM)
and statecodename='Completed'
--and elgi_customervisitid='CV-707779'
)a
full outer join
(select elgi_customervisit,opportunityid,elgi_enquiryid,
elgi_businessverticalname,elgi_customervisitid,
elgi_sourceofenquiryname,elgi_dealer,elgi_dealername,elgi_dealerengineer,elgi_dealerengineername,
owneridname,ownerid,elgi_opportunitystatusname,elgi_enquirystatusname,
statecodename,statuscodename,elgi_probabilityname,estimatedclosedate,
actualclosedate,createdon,createdby,createdbyname,
customerid,elgi_losttoname,elgi_reasonname,elgi_buyingreasonname,
elgi_remarks,elgi_numbers,elgi_pricewelosttheorderat,elgi_model,name as Enq_Desc,
elgi_enquirystatus2name
from opportunity_CRM
where 
elgi_enquirystatusname<>'On Hold' 
and createdon>=@StartDate
--'2018-10-01' --Old Date Condition
and ownerid in (select distinct systemuserid from systemuser_CRM)
--and isnull(elgi_businessverticalname,'')='Industrial' 
--and isnull(elgi_sourceofenquiryname,'') not in ('Website')
)b
on a.activityid=b.elgi_customervisit
--)a



update CRM_Units_Stage1 set elgi_dealerengineername=a.fullname
from (select distinct contactid,fullname  from Contact_CRM)a
where CRM_Units_Stage1.elgi_dealerengineer=a.contactid

update CRM_Units_Stage1 set owneridname=a.fullname
from (select distinct systemuserid ,fullname  from systemuser_CRM)a
where CRM_Units_Stage1.ownerid=a.systemuserid

update CRM_Units_Stage1 set createdbyname=a.fullname
from (select distinct systemuserid ,fullname  from systemuser_CRM)a
where CRM_Units_Stage1.createdby=a.systemuserid

update CRM_Units_Stage1 set requiredattendees=a.partyid
from (select distinct a.activityid,b.partyid from appointment_CRM a
left outer join activityparty_crm b
on a. activityid=b.activityid
where b.participationtypemask=5)a
where CRM_Units_Stage1.requiredattendees=a.activityid

--Select * from CRM_Units_Stage1 where requiredattendees= '50EC3D03-09B4-E911-B083-0003FF90C889'


update CRM_Units_Stage1 set elgi_businessverticalname=a.elgi_businessverticalname
from systemuser_CRM a
where CRM_Units_Stage1.ownerid=a.systemuserid
and CRM_Units_Stage1.elgi_businessverticalname is null

update CRM_Units_Stage1 set elgi_businessverticalname=a.elgi_businessverticalname
from systemuser_CRM a
where CRM_Units_Stage1.ownerid=a.systemuserid
and CRM_Units_Stage1.elgi_businessverticalname =''

--Commented on 6-Jan-2023
--delete from CRM_Units_Stage1 where elgi_businessverticalname not like '%Industrial%'


--Updating Customer Information
update crm_units_stage1 set name=c.name,
accountnumber=c.accountnumber,elgi_erpcustomercode=c.elgi_erpcustomercode,
elgi_customerclassificationname =c.elgi_customerclassificationname,
elgi_lineofbusiness=c.elgi_lineofbusiness,
elgi_lineofbusinessname=c.elgi_name,
elgi_cityname=c.elgi_cityname,
elgi_statename=c.elgi_statename,
elgi_customerclustersalesname=c.elgi_customerclustersalesname,
elgi_description=c.elgi_description,
pincode=c.address1_postalcode,
elgi_locationofcustomer=c.elgi_locationofcustomer
from (
select accountid,name,accountnumber,elgi_erpcustomercode,
b.elgi_name as elgi_cityname,
c.elgi_name as elgi_statename,
elgi_customerclustersalesname,a.address1_postalcode,
elgi_customerclassificationname,a.elgi_lineofbusiness,
a.elgi_lineofbusinessname,
elgi_locationofcustomer,
d.elgi_name,d.elgi_description
from Account_CRM a
left outer join elgi_city_CRM b
on a.elgi_city=b.elgi_cityid
left outer join elgi_state_CRM c
on a.elgi_state=c.elgi_stateid
left outer join elgi_lineofbusiness_CRM d
on a.elgi_lineofbusiness=d.elgi_lineofbusinessid
) c
where --isnull(requiredattendees,customerid)=c.accountid
case when len(requiredattendees)<=2 then customerid 
when requiredattendees is null then customerid else requiredattendees end=c.accountid
--customerid=c.accountid --New Condition Since 6-Nov-2023
--and elgi_enquiryid='ENQ-223906' --Testing

--Updating Dealer Information
update crm_units_stage1 set elgi_dealername=c.name,
Dealercode=c.elgi_erpcustomercode
from (select accountid,name,accountnumber,elgi_erpcustomercode,elgi_cityname,elgi_statename,
elgi_customerclustersalesname,address1_postalcode,
elgi_customerclassificationname,a.elgi_lineofbusinessname,elgi_locationofcustomer
from Account_CRM a) c
where crm_units_stage1.elgi_dealer=c.accountid


--Commented on 6-Nov-2023
--update crm_units_stage1 set elgi_description=b.elgi_name
--from elgi_lineofbusiness_CRM b
--where crm_units_stage1.elgi_lineofbusinessname=b.elgi_name



--Commented on 21Aug2023
--update crm_units_stage1 set elgi_lineofbusinessname=a.elgi_lineofbusinessname
--from (select distinct elgi_lineofbusinessname,elgi_description from crm_units_stage1 where elgi_lineofbusinessname is not null)a
--where crm_units_stage1.elgi_description=a.elgi_description
--and crm_units_stage1.elgi_lineofbusinessname is null


Insert into CRM_Engineer  (opportunityid,quoteid,Quote_Name,productid,elgi_salesofficename)
--select * into CRM_Engineer  from (
select a.opportunityid,a.quoteid,a.name as Quote_Name,b.productid,c.elgi_name 
from Quote_CRM a
full outer join quotedetail_CRM b
on a.quoteid=b.quoteid
left outer join elgi_salesoffices_CRM c
on b.elgi_salesoffice=c.elgi_salesofficesid
where a.statuscodename<>'Revised'
--)a


update CRM_Engineer  set priceperunit=a.priceperunit,
quantity=a.quantity,
baseamount=a.baseamount,
productidname=a.name
from
(select a.quoteid,a.productid,a.priceperunit,a.quantity,a.baseamount,b.name from quotedetail_CRM a
left outer join (select distinct productid, name from product_CRM) b
on a.productid=b.productid
)a
where CRM_Engineer.quoteid=a.quoteid
and CRM_Engineer.productid=a.productid


update CRM_Engineer  set elgi_itemcode=d.elgi_itemcode
from (select distinct productid,elgi_itemcode from product_CRM) d
where CRM_Engineer.productid=d.productid


--Method 1: 
update CRM_Engineer  set elgi_salesofficecode=c.elgi_salesofficecode
from (select distinct elgi_salesofficecode,elgi_name from elgi_salesoffices_CRM) c
where ltrim(rtrim(CRM_Engineer.elgi_salesofficename))=ltrim(rtrim(c.elgi_name))

--Method 2: 
update CRM_Engineer  set elgi_salesofficecode=c.elgi_salesofficecode
from (select distinct elgi_itemcode,substring(b.name,1,5) as elgi_salesofficecode 
from elgi_dealerpricelistmaster_CRM a
left outer join pricelevel_CRM b
on a.elgi_pricetype=b.pricelevelid
) c
where ltrim(rtrim(CRM_Engineer.elgi_itemcode))=ltrim(rtrim(c.elgi_itemcode))

--Method 3:

update CRM_Engineer  set elgi_salesofficecode=c.elgi_salesofficecode
from (select distinct quoteid,productid,substring(b.name,1,5) as elgi_salesofficecode 
from quotedetail_CRM a
left outer join pricelevel_CRM b
on a.elgi_pricelist=b.pricelevelid
--where quoteid= '1FEC2608-C3A0-EB11-B1AC-000D3AC9D085'
) c
where ltrim(rtrim(CRM_Engineer.quoteid))=ltrim(rtrim(c.quoteid))
and ltrim(rtrim(CRM_Engineer.productid))=ltrim(rtrim(c.productid))

--Test Case data
--select * from CRM_Units_Stage1 where elgi_enquiryid='ENQ-145731'
--select * from CRM_Engineer where opportunityid='E80EE26A-EC6D-4CB4-BB69-88D2B9B44CCD'

--select quoteid,name,elgi_salesofficename,* from QUOTE where opportunityid='E80EE26A-EC6D-4CB4-BB69-88D2B9B44CCD'
--select elgi_salesofficename,* from QUOTEDETAILS where quoteid= '1FEC2608-C3A0-EB11-B1AC-000D3AC9D085'
--select elgi_salesofficename,* from ELGI_DEALERPRICELISTMASTER where elgi_itemcode='S015164'
--select * from CRM_Engineer where elgi_salesofficecode is not null and elgi_salesofficename is null
--select * from CRM_Engineer where Quote_Name='Industrial||||QUO-15537-P8T4C9'
--select elgi_salesofficecode,count(distinct elgi_salesofficename) from CRM_Engineer
--group by elgi_salesofficecode
--having count(distinct elgi_salesofficename)>1

update CRM_Engineer set elgi_salesofficename=a.elgi_salesofficename
from (select distinct elgi_salesofficecode,elgi_salesofficename from CRM_Engineer 
where elgi_salesofficename is not  null and elgi_salesofficecode is not null)a
where CRM_Engineer.elgi_salesofficecode=a.elgi_salesofficecode
and CRM_Engineer.elgi_salesofficename is null


--Product Category Update:
----Method 1:
--update CRM_Engineer  set elgi_productcategoryname=e.elgi_productcategoryname
--from (
--select * from(
--select elgi_itemcode,elgi_productcategoryname,
--ROW_NUMBER() over (partition by elgi_productcategoryname,elgi_itemcode order by elgi_productcategoryname) as Rnk
--from ELGI_DEALERPRICELISTMASTER)a
--where Rnk=1
--) e
--where ltrim(rtrim(CRM_Engineer.elgi_itemcode))=ltrim(rtrim(e.elgi_itemcode))

--Method 2:
update CRM_Engineer  set elgi_productcategoryname=e.elgi_name
from (
select distinct a.elgi_productcategory,a.elgi_itemcode,
b.elgi_name,substring(c.name,1,5) as SalesOfficeCode
from elgi_dealerpricelistmaster_CRM a
inner join elgi_category_CRM b 
on a.elgi_productcategory=b.elgi_categoryid
inner join  pricelevel_CRM c
on a.elgi_pricetype=c.pricelevelid
--where elgi_itemcode='S015164'
) e
where CRM_Engineer.elgi_salesofficecode=e.SalesOfficeCode 
and ltrim(rtrim(CRM_Engineer.elgi_itemcode))=ltrim(rtrim(e.elgi_itemcode))



Insert into CRM_Dealer (elgi_enquiry,elgi_dealerofferid,elgi_dealeroffername,elgi_existingproduct,elgi_existingproductname,
elgi_salesofficename)
--select * into CRM_Dealer  from(
select elgi_enquiry,elgi_dealerofferid,isnull(b.elgi_dealeroffername,a.elgi_offerid) elgi_dealeroffername,
elgi_existingproduct,b.elgi_existingproductname,c.elgi_name from elgi_dealeroffer_CRM a
full outer join elgi_dealerofferproduct_CRM b
on a.elgi_dealerofferid=b.elgi_dealeroffer
left outer join elgi_salesoffices_CRM c
on b.elgi_salesoffice=c.elgi_salesofficesid
where a.elgi_revisedflagname<>'Yes'
--)a

update CRM_Dealer  set elgi_itemcode=d.elgi_itemcode
from (select distinct productid,elgi_itemcode from product_CRM) d
where CRM_Dealer.elgi_existingproduct=d.productid


update CRM_Dealer  set elgi_priceperunit=a.elgi_priceperunit,
elgi_quantity=a.elgi_quantity,
elgi_amount=a.elgi_amount,
elgi_existingproductname=a.name
from (select elgi_dealeroffer,elgi_priceperunit,elgi_quantity,elgi_amount,
elgi_existingproduct,b.name from elgi_dealerofferproduct_CRM a
left outer join (select distinct productid, name from product_CRM) b
on a.elgi_existingproduct=b.productid
)a
where CRM_Dealer.elgi_dealerofferid=a.elgi_dealeroffer
and CRM_Dealer.elgi_existingproduct=a.elgi_existingproduct

--Method 1:
update CRM_Dealer  set elgi_salesofficecode=c.elgi_salesofficecode
from (select distinct elgi_salesofficecode,elgi_name from elgi_salesoffices_CRM ) c
where ltrim(rtrim(CRM_Dealer.elgi_salesofficename))=ltrim(rtrim(c.elgi_name))

----Method 2:  Not Applicable For Dealer Data
--update CRM_Dealer  set elgi_salesofficecode=c.elgi_salesofficecode
--from (select distinct elgi_itemcode,substring(elgi_pricetypename,1,5) as elgi_salesofficecode from ELGI_DEALERPRICELISTMASTER
----where elgi_salesofficecode in ('90008','90009','90016','90020','90022','90030','90032','90093','90094') 
--)c
--where ltrim(rtrim(CRM_Dealer.elgi_itemcode))=ltrim(rtrim(c.elgi_itemcode))


--Method 3:
--Select * from CRM_Dealer 
--where elgi_dealeroffername='DO -186280' and elgi_existingproduct='5E1E15BC-707B-E811-A95D-000D3AF257B1'

update CRM_Dealer  set elgi_salesofficecode=c.elgi_salesofficecode
from (select distinct DO.elgi_dealerofferid,DO.elgi_uniqueoffernumber as elgi_dealeroffername,
a.elgi_existingproduct,substring(b.name,1,5) as elgi_salesofficecode 
from elgi_dealeroffer_CRM DO
left outer join elgi_dealerofferproduct_CRM a
on DO.elgi_dealerofferid=a.elgi_dealeroffer
left outer join pricelevel_CRM b
on a.elgi_pricetype=b.pricelevelid
where a.elgi_existingproduct is not null and elgi_uniqueoffernumber is not null
--where --convert(varchar,a.elgi_name)='DO -186280' and 
--convert(varchar,elgi_existingproduct)='5E1E15BC-707B-E811-A95D-000D3AF257B1'
--where elgi_salesofficecode in ('90008','90009','90016','90020','90022','90030','90032','90093','90094') 
) c
where ltrim(rtrim(CRM_Dealer.elgi_dealeroffername))=ltrim(rtrim(c.elgi_dealeroffername))
and ltrim(rtrim(CRM_Dealer.elgi_existingproduct))=ltrim(rtrim(c.elgi_existingproduct))


--Test Case data
--select * from CRM_Dealer where elgi_salesofficecode is  null and elgi_itemcode is not null
--select * from CRM_Dealer where elgi_salesofficecode is not null and elgi_salesofficename is null
--select * from CRM_Dealer where Quote_Name='Industrial||||QUO-15537-P8T4C9'
--select elgi_salesofficecode,count(distinct elgi_salesofficename) from CRM_Dealer
--group by elgi_salesofficecode
--having count(distinct elgi_salesofficename)>1
--select distinct elgi_salesofficecode,elgi_salesofficename,elgi_itemcode from CRM_Dealer where elgi_salesofficecode='90008'


update CRM_Dealer set elgi_salesofficename=a.elgi_salesofficename
from (select distinct elgi_salesofficecode,elgi_salesofficename from CRM_Dealer 
where elgi_salesofficename is not  null and elgi_salesofficecode is not null)a
where CRM_Dealer.elgi_salesofficecode=a.elgi_salesofficecode
and CRM_Dealer.elgi_salesofficename is null


--ProductCategory Update:

--Method 1:
--update CRM_Dealer  set elgi_productcategoryname=e.elgi_productcategoryname
--from (
--select * from(
--select elgi_itemcode,elgi_productcategoryname,
--ROW_NUMBER() over (partition by elgi_productcategoryname,elgi_itemcode order by elgi_productcategoryname) as Rnk
--from ELGI_DEALERPRICELISTMASTER)a
--where Rnk=1
--) e
--where ltrim(rtrim(CRM_Dealer.elgi_itemcode))=ltrim(rtrim(e.elgi_itemcode))


--Method 2:
update CRM_Dealer  set elgi_productcategoryname=e.elgi_name
from (
select distinct a.elgi_productcategory,a.elgi_itemcode,
b.elgi_name,substring(c.name,1,5) as SalesOfficeCode
from elgi_dealerpricelistmaster_CRM a
inner join elgi_category_CRM b 
on a.elgi_productcategory=b.elgi_categoryid
inner join  pricelevel_CRM c
on a.elgi_pricetype=c.pricelevelid
) e
where CRM_Dealer.elgi_salesofficecode=e.SalesOfficeCode 
and ltrim(rtrim(CRM_Dealer.elgi_itemcode))=ltrim(rtrim(e.elgi_itemcode))

--delete from CRM_Engineer  where opportunityid in 
--(select distinct  opportunityid from opportunity
--where --elgi_enquirystatusname<>'On Hold' and
--isnull(elgi_businessverticalname,'')='Industrial'
--and isnull(elgi_sourceofenquiryname,'') not in ('Website'))


Update CRM_Units_Stage1 set elgi_dealerengineer_Code=a.adx_identity_username,
elgi_dealerengineer_Mobile=a.mobilephone
from (
select contactid,parentcustomeridname,adx_identity_username,
fullname,mobilephone,emailaddress1 
from Contact_CRM 
where adx_identity_username is not null
--and ltrim(rtrim(parentcustomeridname))='INDUSTRIAL AIR SOLUTIONS LLP - CU1I00910'
)a
where ltrim(rtrim(CRM_Units_Stage1.elgi_dealerengineer))=ltrim(rtrim(contactid))


update CRM_Units_Stage1 set elgi_dealerengineer_Code=a.adx_identity_username,
elgi_dealerengineer_Mobile=a.mobilephone
from Contact_CRM a
where elgi_dealerengineer=a.contactid

update crm_units_stage1 set District= elgi_districtname 
from(select distinct a.elgi_name,elgi_district,b.elgi_name as elgi_districtname 
From elgi_pincodelist_CRM a 
left outer join elgi_district_CRM b
on a.elgi_district=b.elgi_districtid
)a
where ltrim(rtrim(crm_units_stage1.pincode))=ltrim(rtrim(a.elgi_name))


end

GO

