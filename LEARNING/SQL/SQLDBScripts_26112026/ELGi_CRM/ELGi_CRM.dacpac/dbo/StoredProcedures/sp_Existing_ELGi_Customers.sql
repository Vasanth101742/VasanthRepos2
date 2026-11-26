--exec sp_Existing_ELGi_Customers

CREATE proc sp_Existing_ELGi_Customers as
begin

Truncate table Existing_ELGi_Customers

--Alter table Existing_ELGi_Customers add Rowno int
--Alter table Existing_ELGi_Customers alter column elgi_industrysize varchar(50)
--Alter table Existing_ELGi_Customers add elgi_erpcustomercode nvarchar(100)

Insert into Existing_ELGi_Customers(elgi_fabricationnumber,elgi_lockindealer,accountid,
accountnumber,name,elgi_accounttypename,elgi_productgroupname,elgi_productsubgroupname,
msdyn_productname,createdon,elgi_dateofcommissioning,elgi_cityname,territoryidname,
elgi_industrysize,elgi_industryname,elgi_customerclassificationname,elgi_customergroupname,
elgi_isreferencename,elgi_keycustomername,elgi_oemcustomername,Engineer,Rowno,elgi_erpcustomercode)
--select * into Existing_ELGi_Customers from (
select distinct a.elgi_fabricationnumber,
--a.msdyn_name,
a.elgi_lockindealer,b.accountid,b.accountnumber,
b.name,elgi_accounttypename,
elgi_productgroupname,elgi_productsubgroupname,msdyn_productname,
createdon,elgi_dateofcommissioning,
elgi_cityname,territoryidname,elgi_industrysizename,elgi_industryname,
elgi_customerclassificationname,elgi_customergroupname,
elgi_isreferencename,elgi_keycustomername,elgi_oemcustomername,
--b.accountid,c.parentcustomerid,c.systemuserid,d.systemuserid,
--c.yomifullname as elgi_industrialsalesengineer,
--d.yomifullname  as elgi_portableaftermarketsparesengineer,
coalesce(c.yomifullname,d.yomifullname) as Engineer,
row_number() over( order by elgi_fabricationnumber,accountnumber),
b.elgi_erpcustomercode
from 
(select msdyn_name,elgi_fabricationnumber,elgi_lockindealer,
elgi_productgroupname,elgi_productsubgroupname,msdyn_productname,
createdon,elgi_dateofcommissioning
from msdyn_customerasset_CRM
--where elgi_fabricationnumber like 'BXJD164108'
--'CXJE552179'
--'DXJL310401'
--'BWID231670'
)a
left outer join (select distinct accountid,elgi_dealer,accountnumber,a.elgi_erpcustomercode,
name,elgi_accounttypename,b.elgi_name as elgi_cityname,territoryidname,elgi_industrysizename,
d.elgi_description as elgi_industryname,
elgi_customerclassificationname,elgi_customergroupname,elgi_isreferencename,elgi_keycustomername,elgi_oemcustomername
from Account_CRM a
left outer join elgi_city_CRM b
on a.elgi_city=b.elgi_cityid
left outer join elgi_state_CRM c
on a.elgi_state=c.elgi_stateid
left outer join elgi_lineofbusiness_CRM d
on a.elgi_lineofbusiness=d.elgi_lineofbusinessid
)b
on a.elgi_lockindealer=b.accountid
left outer join (select distinct parentcustomerid,
elgi_industrialsalesengineer,elgi_portableaftermarketsparesengineer,
systemuserid,b.yomifullname,
ownerid from Contact_CRM a
left outer join (select distinct systemuserid,yomifullname from systemuser_CRM) b
on a.elgi_industrialsalesengineer=b.systemuserid 
where elgi_industrialsalesengineer is not null
)c
on b.accountid=c.parentcustomerid
left outer join (select distinct parentcustomerid,
elgi_industrialsalesengineer,elgi_portableaftermarketsparesengineer,
systemuserid,b.yomifullname,
ownerid from Contact_CRM a
left outer join (select distinct systemuserid,yomifullname from systemuser_CRM) b
on a.elgi_portableaftermarketsparesengineer=b.systemuserid 
where elgi_portableaftermarketsparesengineer is not null
)d
on b.accountid=d.parentcustomerid
where a.msdyn_name is not null 
and a.elgi_fabricationnumber is not null
--)a



update Existing_ELGi_Customers set BusinessVertical='Portables'
where elgi_productgroupname in ('Portables - C&M','Portables - WW')

update Existing_ELGi_Customers set BusinessVertical='Industrials'
where elgi_productgroupname not in ('Portables - C&M','Portables - WW')
and (elgi_productgroupname is not null or ltrim(rtrim(elgi_productgroupname)) >2)

update Existing_ELGi_Customers set elgi_rsmname=a.yomifullname
from (select distinct --positionidname,elgi_rsmname,
territoryidname,
case when elgi_businessverticalname like '%Portables%' then 'Portables'
else 'Industrials' end as elgi_businessverticalname,
yomifullname,positionidname from systemuser_CRM
where --territoryidname is not null
--and elgi_businessverticalname is not null
--and 
positionidname in ('RSM')
and isdisabledname='Enabled'
)a
where Existing_ELGi_Customers.territoryidname=a.territoryidname
and Existing_ELGi_Customers.BusinessVertical=a.elgi_businessverticalname


update Existing_ELGi_Customers set elgi_lineofbusinessname=a.elgi_description
from (select * from 
(select distinct elgi_lineofbusiness,accountnumber from account_crm where elgi_lineofbusiness is not null)a
left outer join 
(select distinct elgi_lineofbusinessid,elgi_name,elgi_description from elgi_lineofbusiness_crm)b
on a.elgi_lineofbusiness=b.elgi_lineofbusinessid)a
where Existing_ELGi_Customers.accountnumber=a.accountnumber

end



--select distinct territoryidname from Existing_ELGi_Customers

--Alter table Existing_ELGi_Customers add elgi_lineofbusinessname varchar(100)

GO

