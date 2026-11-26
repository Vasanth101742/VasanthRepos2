CREATE view vw_Existing_ELGi_Customers as 
select distinct a.elgi_fabricationnumber,
--a.msdyn_name,
a.elgi_lockindealer,b.accountid,b.accountnumber,
b.name,elgi_accounttypename,
elgi_productgroupname,elgi_productsubgroupname,msdyn_productname,
createdon,elgi_dateofcommissioning,
elgi_cityname,territoryidname,elgi_industrysize,elgi_industryname,
elgi_customerclassificationname,elgi_customergroupname,
elgi_isreferencename,elgi_keycustomername,elgi_oemcustomername,
--b.accountid,c.parentcustomerid,c.systemuserid,d.systemuserid,
--c.yomifullname as elgi_industrialsalesengineer,
--d.yomifullname  as elgi_portableaftermarketsparesengineer,
coalesce(c.yomifullname,d.yomifullname) as Engineer
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
left outer join (select distinct accountid,elgi_dealer,accountnumber,
name,elgi_accounttypename,elgi_cityname,territoryidname,elgi_industrysize,elgi_industryname,
elgi_customerclassificationname,elgi_customergroupname,elgi_isreferencename,elgi_keycustomername,elgi_oemcustomername
from Account_CRM)b
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

GO

