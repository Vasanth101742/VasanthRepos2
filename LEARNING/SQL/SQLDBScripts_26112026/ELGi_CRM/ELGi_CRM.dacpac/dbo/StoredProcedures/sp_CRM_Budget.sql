--exec sp_CRM_Budget

CREATE proc sp_CRM_Budget as 
Begin

Truncate table CRM_Budget

--Alter table CRM_Budget add elgi_dealername uniqueidentifier
--Alter table CRM_Budget add elgi_productcategory uniqueidentifier


insert into CRM_Budget(elgi_elgigoalid,elgi_dealername,elgi_dealernamename,elgi_districtname,elgi_financialyearname,elgi_name,
ownerid,owneridname,elgi_elgigoal,elgi_elgigoalname,elgi_productcategory,elgi_salesoffice,infqty,
Category1,infValue,Category2)
select elgi_elgigoalid,elgi_dealername,elgi_dealernamename,elgi_districtname,elgi_financialyearname,elgi_name,
ownerid,owneridname,elgi_elgigoal,elgi_elgigoalname,elgi_productcategory,elgi_salesoffice,infqty,
Category1,infValue,Category2 
from (
--select * into CRM_Budget from (
select distinct 
elgi_elgigoalid,elgi_dealername,elgi_dealernamename,elgi_districtname,elgi_financialyearname,elgi_name,ownerid,owneridname,
elgi_elgigoal,elgi_elgigoalname,elgi_productcategory,elgi_salesoffice,
infqty,
case when Col1 ='elgi_infqtyapr' then 1 
when Col1='elgi_infqtymay' then 2
when Col1='elgi_infqtyjun' then 3
when Col1='elgi_infqtyjul' then 4
when Col1='elgi_infqtyaug' then 5
when Col1='elgi_infqtysep' then 6
when Col1='elgi_infqtyoct' then 7
when Col1='elgi_infqtynov' then 8
when Col1='elgi_infqtydec' then 9
when Col1='elgi_infqtyjan' then 10
when Col1='elgi_infqtyfeb' then 11
when Col1='elgi_infqtymar' then 12 end as Category1,
infValue,
case when Col2 ='elgi_infvalueapr' then 1 
when Col2='elgi_infvaluemay' then 2
when Col2='elgi_infvaluejun' then 3
when Col2='elgi_infvaluejul' then 4
when Col2='elgi_infvalueaug' then 5
when Col2='elgi_infvaluesep' then 6
when Col2='elgi_infvalueoct' then 7
when Col2='elgi_infvaluenov' then 8
when Col2='elgi_infvaluedec' then 9
when Col2='elgi_infvaluejan' then 10
when Col2='elgi_infvaluefeb' then 11
when Col2='elgi_infvaluemar' then 12 end as Category2
from (
select * from 
(select distinct elgi_elgigoalid,elgi_dealername,elgi_dealernamename,
b.elgi_name as elgi_districtname,c.elgi_name as elgi_financialyearname,
a.elgi_name,a.ownerid,a.owneridname from elgi_elgigoal_CRM a 
left outer join  elgi_district_CRM b
on a.elgi_district=b.elgi_districtid
left outer join elgi_goalfinancialyr_CRM c
on a.elgi_financialyear=c.elgi_goalfinancialyrid
where a.statuscodename='Active')a
left outer join 
(select elgi_elgigoal,elgi_elgigoalname,elgi_productcategory,elgi_salesoffice,
isnull(elgi_infqtyapr,0) elgi_infqtyapr,isnull(elgi_infqtymay,0) elgi_infqtymay,
isnull(elgi_infqtyjun,0) elgi_infqtyjun,isnull(elgi_infqtyjul,0) elgi_infqtyjul,
isnull(elgi_infqtyaug,0) elgi_infqtyaug,isnull(elgi_infqtysep,0) elgi_infqtysep,
isnull(elgi_infqtyoct,0) elgi_infqtyoct,isnull(elgi_infqtynov,0) elgi_infqtynov,
isnull(elgi_infqtydec,0) elgi_infqtydec,isnull(elgi_infqtyjan,0) elgi_infqtyjan,
isnull(elgi_infqtyfeb,0) elgi_infqtyfeb,isnull(elgi_infqtymar,0) elgi_infqtymar,
isnull(elgi_infvalueapr,0) elgi_infvalueapr,isnull(elgi_infvaluemay,0) elgi_infvaluemay,
isnull(elgi_infvaluejun,0) elgi_infvaluejun,isnull(elgi_infvaluejul,0) elgi_infvaluejul,
isnull(elgi_infvalueaug,0) elgi_infvalueaug,isnull(elgi_infvaluesep,0) elgi_infvaluesep,
isnull(elgi_infvalueoct,0) elgi_infvalueoct,isnull(elgi_infvaluenov,0) elgi_infvaluenov,
isnull(elgi_infvaluedec,0) elgi_infvaluedec,isnull(elgi_infvaluejan,0) elgi_infvaluejan,
isnull(elgi_infvaluefeb,0) elgi_infvaluefeb,isnull(elgi_infvaluemar,0) elgi_infvaluemar
from elgi_goalline_CRM
where statuscodename='Active')b
on a.elgi_elgigoalid=b.elgi_elgigoal
)complete
unpivot(
infqty for Col1 in (elgi_infqtyapr,elgi_infqtymay,elgi_infqtyjun,elgi_infqtyjul,elgi_infqtyaug,elgi_infqtysep,
elgi_infqtyoct,elgi_infqtynov,elgi_infqtydec,elgi_infqtyjan,elgi_infqtyfeb,elgi_infqtymar)) as K1
unpivot(
infValue for Col2 in(elgi_infvalueapr,elgi_infvaluemay,elgi_infvaluejun,elgi_infvaluejul,elgi_infvalueaug,elgi_infvaluesep,
elgi_infvalueoct,elgi_infvaluenov,elgi_infvaluedec,elgi_infvaluejan,elgi_infvaluefeb,elgi_infvaluemar)) as k2

)a
where Category1=Category2 
--and elgi_name='Darshit Shah-AHMEDABAD-2022-23' --Testing Purpose
--and elgi_productcategoryname='S2' --Testing Purpose
order by elgi_financialyearname,Category1,Category2

update CRM_Budget set elgi_dealernamename=a.name
from(select distinct accountid,name from Account_CRM)a
where CRM_Budget.elgi_dealername=a.accountid

update CRM_Budget set elgi_elgigoalname=a.elgi_name
from(select distinct elgi_elgigoalid,elgi_name from elgi_elgigoal_CRM)a
where CRM_Budget.elgi_elgigoalid=a.elgi_elgigoalid

update CRM_Budget set elgi_productcategoryname=a.elgi_name
from(select distinct elgi_categoryid,elgi_name from elgi_category_CRM)a
where CRM_Budget.elgi_productcategory=a.elgi_categoryid


update CRM_Budget set FinYear=substring(elgi_financialyearname,1,4)
update CRM_Budget set FinMonth=Category1

update CRM_Budget set CalYear=FinYear where FinMonth<=9
update CRM_Budget set CalYear=FinYear+1  where FinMonth>9 

update CRM_Budget set CalMonth=FinMonth+3 where FinMonth<=9
update CRM_Budget set CalMonth=FinMonth-9  where FinMonth>9 

update CRM_Budget set Month_Name=substring(Datename(mm,dateadd(mm,CalMonth,-1)),1,3)


update CRM_Budget set elgi_salesofficecode=a.elgi_salesofficecode
from (select distinct elgi_salesofficesid,elgi_salesofficecode from elgi_salesoffices_CRM)a
where CRM_Budget.elgi_salesoffice=a.elgi_salesofficesid

--Alter table CRM_Budget add SalesRepcode int

update CRM_Budget set SalesRepcode=a.employeeid,Region=a.name,owneridname=a.fullname
from (select systemuserid,employeeid,b.name,a.fullname from systemuser_CRM a
left outer join territory_CRM b
on a.territoryid=b.territoryid
)a
where CRM_Budget.ownerid= a.systemuserid

--Alter table CRM_Budget add Region varchar(20)
--Alter table CRM_Budget add elgi_erpcustomercode nvarchar(100)

update CRM_Budget set elgi_erpcustomercode=a.elgi_erpcustomercode
from(select distinct accountid,elgi_erpcustomercode,name,elgi_accounttype from Account_CRM
where elgi_erpcustomercode is not null)a
where CRM_Budget.elgi_dealername=a.accountid

end

select * from CRM_Budget

GO

