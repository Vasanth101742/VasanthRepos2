--exec sp_employee_hierarchy2 
CREATE proc sp_employee_hierarchy2 
as 

Truncate table employee_hierarchy2_CRM;

with crm_hierarchy as
(
select parentsystemuserid,systemuserid,fullname,employeeid,positionidname,isdisabledname,1 as level,territoryidname,businessunitidname,
  elgi_businessverticalname,address1_city,internalemailaddress 
   from systemuser_CRM where parentsystemuserid is null and isdisabledname='Enabled' 
   and employeeid='200323' --Added as a Temporary Fix on 01-July-2022

union all

select e.parentsystemuserid,e.systemuserid,e.fullname,e.employeeid,e.positionidname,e.isdisabledname,b.Level+1,
e.territoryidname,e.businessunitidname,e.elgi_businessverticalname,e.address1_city,e.internalemailaddress
 from systemuser_CRM e 
inner join (select * From crm_hierarchy)b
on e.parentsystemuserid =b.systemuserid
)
insert into employee_hierarchy2_CRM(employeeid,fullname,level,internalemailaddress,parentsystemuserid,systemuserid)
select distinct employeeid,fullname,level,internalemailaddress,parentsystemuserid,systemuserid  from crm_hierarchy 
where employeeid is not null
order by level,parentsystemuserid,systemuserid 


--Alter table employee_hierarchy2_CRM add p_employeeid nvarchar(100)
--Alter table employee_hierarchy2_CRM add p_fullname nvarchar(200)
--Alter table employee_hierarchy2_CRM add p_level int
--Alter table employee_hierarchy2_CRM add p_internalemailaddress nvarchar(100)
--Alter table employee_hierarchy2_CRM alter column parentsystemuserid nvarchar(100)
--Alter table employee_hierarchy2_CRM alter column systemuserid nvarchar(100)

update employee_hierarchy2_CRM set p_employeeid=a.employeeid,p_fullname=a.fullname,
p_level=a.level,p_internalemailaddress=a.internalemailaddress
from (select * from employee_hierarchy2_CRM) a
where employee_hierarchy2_CRM.parentsystemuserid=a.systemuserid


update employee_hierarchy2_CRM set p_employeeid=employeeid,p_fullname=fullname,
p_level=level,p_internalemailaddress=internalemailaddress
where employee_hierarchy2_CRM.p_employeeid is null


delete from employee_hierarchy2_CRM where employeeid ='101765' and internalemailaddress='soumend@elgi.com'
delete from employee_hierarchy2_CRM where employeeid ='101476' and p_internalemailaddress='ffd9f533f7bb49e19172a3ed6f258e0crajeshpremchandran@elgi.com'
delete from employee_hierarchy2_CRM where employeeid ='102592' and internalemailaddress in 
('a66de48e0dd648d69eb9cfe8deb3b06asharma.gajanand@elgi.com','76ee9687ca944f4994f23f04f8323965gajanandsharma@elgi.com')


update employee_hierarchy2_CRM set parentsystemuserid='FD28CFE0-BB7A-E811-A95F-000D3AF29E21',
p_employeeid='200323',p_fullname='Ramesh Ponnuswami',p_level=1,p_internalemailaddress='ramesh.ponnuswami@elgi.com'
where employeeid ='101243' and internalemailaddress='krishnamoorthym@elgi.com'

--delete from employee_hierarchy2_CRM where employeeid='200323'
--insert into employee_hierarchy2_CRM values
--('200323','Ramesh Ponnuswami',1,'ramesh.ponnuswami@elgi.com',null,null,'102837','RAGURAMAN V',2,'raguraman.vivekanandhan@elgi.com'),
--('102837','RAGURAMAN V',2,'raguraman.vivekanandhan@elgi.com',null,null,'102662','MUTHAMILSELVAN S',2,'MUTHAMILSELVAN@ELGI.COM')


delete from employee_hierarchy2_CRM where employeeid='102662' and p_employeeid<>'200323'
update employee_hierarchy2_CRM set employeeid='102991' where fullname='Afzaan Aneez Imamsha'

delete from employee_hierarchy2_CRM where employeeid='NA'


update employee_hierarchy2_CRM set parentsystemuserid='C9B78C3A-957A-E811-A95E-000D3AF29FC0',
p_employeeid='100504',p_fullname='Sandip Seth',p_level=4,p_internalemailaddress='sandipseth@elgi.com'
where p_employeeid='102682' and p_fullname='Tapsi Vidyarthi'



update employee_hierarchy2_CRM set parentsystemuserid='3A581382-957A-E811-A95E-000D3AF29FC0',
p_employeeid='100522',p_fullname='Sushanta Mukherjee',p_level=4,p_internalemailaddress='sushanta@elgi.com'
where employeeid='100521' and fullname='Pranabesh Kunti'


select * from employee_hierarchy2_CRM
--where employeeid='101243'
--where internalemailaddress like '%yjsrak%'
--where employeeid in ('100472','101235','100264','102089','200323')
--order by level

GO

