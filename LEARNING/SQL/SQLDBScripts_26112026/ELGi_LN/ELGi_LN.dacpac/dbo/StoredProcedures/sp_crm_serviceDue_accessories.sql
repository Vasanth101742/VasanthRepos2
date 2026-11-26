

--exec  [dbo].[sp_crm_serviceDue_accessories]

CREATE proc [dbo].[sp_crm_serviceDue_accessories]
as begin

update [elgi_crm].dbo.MSDYN_CUSTOMERASSET_crm set elgi_concernedelgiserviceengineername=a.[fullname]
 from [elgi_crm].dbo.systemuser_crm a
where [elgi_crm].dbo.MSDYN_CUSTOMERASSET_crm.[elgi_concernedelgiserviceengineer]=a.systemuserid 


update [elgi_crm].dbo.MSDYN_CUSTOMERASSET_crm set elgi_concernedelgisparesengineername=a.[fullname]
 from [elgi_crm].dbo.systemuser_crm a
where [elgi_crm].dbo.MSDYN_CUSTOMERASSET_crm.elgi_concernedelgisparesengineer=a.systemuserid 


--alter table ServiceDueAcc add msdyn_account uniqueidentifier
--alter table servicedueacc add TPL nvarchar(250)

--------------------STEP 1 : INSERTING DATA FROM CUSTOMER ASSET----------------------

truncate table ServiceDueAcc

insert into ServiceDueAcc
(Zone,FabNo,LockinDealername,ProductGroup, ProductSubGroup,WarrantyType,Model,accountid,CustomerName,Category,Segment
,ServiceEng,SparesEng,CommDate,InvDate,LatestServiceCall,MSDYN_CUSTOMERASSETid,elgi_lockindealer,msdyn_product,LatestServiceCallDate,msdyn_account)
select 
''Zone,msdyn_name as fabno,elgi_lockindealername,
elgi_productsubgroupname 'ProductGroup','' ProductSubGroup,elgi_warrantytypename,msdyn_productname 'Model',msdyn_account,
msdyn_accountname 'CustomerName',elgi_assetclustersparesname 'Category','' Segment,elgi_concernedelgiserviceengineername,elgi_concernedelgisparesengineername
,elgi_dateofcommissioning,elgi_dateofinvoice,'' calltrackingnumber,MSDYN_CUSTOMERASSETid,elgi_lockindealer,msdyn_product,elgi_hmrdate,msdyn_account

 From [elgi_crm].dbo.MSDYN_CUSTOMERASSET_crm
	where	
	--elgi_lockindealername in (select distinct * from service_dealer_list) and
	elgi_productsubgroupname in ('ACCESSORIES (RECIP)','ACCESSORIES (EPSAC)')
	and statuscodename='active'
--	and (substring(elgi_assetclustersparesname,1,1)like '[a,b,c]%' 
--	or substring(elgi_assetclustersparesname,1,2)like 'p1%'
--	or substring(elgi_assetclustersparesname,1,2)like 'p2%'
--	or substring(elgi_assetclustersparesname,1,2)like 'p3'
--	or substring(elgi_assetclustersparesname,1,2)like 'p4%'
--or elgi_assetclustersparesname=	'Not in Budget'


--------------------STEP 2 : UPDATING SEGMENT----------------------

update ServiceDueAcc set Segment =Description from(select distinct elgi_lineofbusinessname,b.Description,accountid
 from [elgi_crm].dbo.ACCOUNT_crm left join (select * From LineOfBusiness)b
on [elgi_crm].dbo.ACCOUNT_crm.elgi_lineofbusinessname=b.LineOfBusiness)a
where ServiceDueAcc.accountid=a.accountid 

--------------------STEP 3 : UPDATING CUSTOMER NAME----------------------
--alter table ServiceDueAcc add AccountNumber nvarchar(100)

update ServiceDueAcc set CustomerName=[name],accountnumber=a.accountnumber
 from [elgi_crm].dbo.ACCOUNT_crm a
where ServiceDueAcc.accountid=a.accountid 

--------------------STEP 4 : LATEST SERVICE CALL AND COMMENTS----------------------

update ServiceDueAcc set latestServiceCall=msdyn_name,ServiceEngComments=elgi_serviceengineercomments
from(select * From (
select msdyn_name,MSDYN_CUSTOMERASSET,elgi_serviceengineercomments,createdon,
ROW_NUMBER()over (partition by MSDYN_CUSTOMERASSET order by createdon desc)rno  from [elgi_crm].dbo.msdyn_workorder_crm
)a where rno=1)a
where  ServiceDueAcc.MSDYN_CUSTOMERASSETid=a.MSDYN_CUSTOMERASSET


--------------------STEP 5 : ZONE ----------------------

---Dealer engineerwise

UPDATE ServiceDueAcc SET Zone=a.territoryidname FROM
(select accountid,territoryidname from [elgi_crm].dbo.ACCOUNT_crm where elgi_accounttypename='dealer' and territoryidname is not null)A
WHERE ServiceDueAcc.elgi_lockindealer=a.accountid

---Customerwise
UPDATE ServiceDueAcc SET Zone=a.territoryidname FROM
(select accountid,territoryidname from [elgi_crm].dbo.ACCOUNT_crm where 
--elgi_accounttypename='dealer' and 
territoryidname is not null)A
WHERE ServiceDueAcc.msdyn_account=a.accountid and zone=''

--------------------STEP 6 : WARRANTY ----------------------

UPDATE ServiceDueAcc set WarrantyType=null

UPDATE ServiceDueAcc set WarrantyType= isnull(Stats,'Out of warranty') from (

select *,
case when statuscodename='Active'and elgi_warrantytypename='In Standard Warranty' then 'In Standard Warranty'
when statuscodename='Active'and elgi_warrantytypename='In Uptime Warranty' then 'In Uptime Warranty'
else 'Out of warranty' end as Stats

 From (
select *,
row_number()over(partition by elgi_customerassetid order by statuscodename,elgi_warrantytypename )as rno
 From (
select distinct statuscodename,elgi_warrantytypename,elgi_customerassetid From elgi_crm.dbo.msdyn_agreement_crm
where statuscodename in ('Active','Expired')
and elgi_warrantytypename in ('In Uptime Warranty','In Standard Warranty')
and elgi_customerassetid is not null
--and elgi_customerassetid in ('5C0AE896-04D1-E811-A8EB-0003FF906C33')
)a
)a
where rno=1
)a
where ServiceDueAcc.MSDYN_CUSTOMERASSETid=a.elgi_customerassetid


--------------------STEP 7 :UPDATING TPL  ----------------------

UPDATE ServiceDueAcc set TPL=ltrim(rtrim(a.elgi_itemcode)) from ELGI_CRM.DBO.PRODUCT_CRm a where serviceDueAcc.msdyn_product=a.productid

--------------------STEP 8 :UPDATING SUB GROUP  ----------------------

--alter table servicedueacc alter column  KitsDescr 

UPDATE ServiceDueAcc set ProductSubGroup=A.ProductSubGroup,kitsDescr=a.DueLogic FROM ServiceDueAcc_Master a WHERE a.Item=ServiceDueAcc.TPL

--------------------STEP 9 :UPDATING ONE YEAR,TWO YEAR,THREE YEAR  ----------------------

UPDATE ServiceDueAcc set OneYearKit= DATEADD(DAY,365,CommDate) WHERE ProductSubGroup ='HLD'

UPDATE ServiceDueAcc set TwoYearKit= DATEADD(DAY,730,CommDate) WHERE ProductSubGroup ='HLD'

UPDATE ServiceDueAcc set ThreeYearKit= DATEADD(DAY,1095,CommDate) WHERE ProductSubGroup ='HLD'

UPDATE ServiceDueAcc set OthersTwoYearKit= DATEADD(DAY,730,CommDate) WHERE ProductSubGroup <>'HLD'

--------------------STEP 10 : TYPE OF CALL  ----------------------

Update a Set a.TypeOfCall = b.msdyn_name  from ServiceDueAcc a
LEFT JOIN (
Select DISTINCT b.msdyn_name,a.elgi_callautonumber from ELGI_CRM.[dbo].[msdyn_workorder_CRM] a
INNER JOIN ELGI_CRM.[dbo].[msdyn_workordertype_CRM] b on a.msdyn_workordertype = b.msdyn_workordertypeid
Where a.elgi_callautonumber IS NOT NULL
) b on a.LatestServiceCall = b.elgi_callautonumber


--------------------STEP 11 : Highligting Overdue  ----------------------

UPDATE ServiceDueAcc set DaysAfterComm = datediff(d,convert(date,commdate),convert(date,getdate()-1))


--alter table ServiceDueAcc add OthersTwoYearKit_Clr nvarchar(10)

--This colours only for Commdate within 1 year
UPDATE ServiceDueAcc set OneYearKit_Clr =

case 
--Red colour for less than Current Month starting

when DaysAfterComm<=365 and  convert(date,OneYearKit)<dateadd(d,-day(getdate()),convert(Date,getdate()+1)) then 'Red'

--yellow color for within the  Current month 
	 when DaysAfterComm<=365 and convert(date,OneYearKit) between dateadd(d,-day(getdate())+1,convert(date,getdate())) and
            dateadd(d,-1,dateadd(m,1,dateadd(d,-day(getdate())+1,convert(date,getdate())))) then 'Yellow'

--Green colour for Next month
     when DaysAfterComm<=365 and convert(date,OneYearKit) between dateadd(m,1,dateadd(d,-day(getdate())+1,convert(date,getdate()))) and
            dateadd(d,-1,dateadd(m,2,dateadd(d,-day(getdate())+1,convert(date,getdate())))) then 'Green'
--No colour for blank and nextmonth +1 dates

	WHEN OneYearKit IS NULL THEN 'No colour'
	when DaysAfterComm<=365 and convert(date,OneYearKit)> dateadd(d,-1,dateadd(m,2,dateadd(d,-day(getdate())+1,convert(date,getdate())))) 
	then 'No colour'end 

UPDATE ServiceDueAcc set TwoYearKit_Clr =

case 
--Red colour for less than Current Month starting

when DaysAfterComm between 365 and 730 and convert(date,TwoYearKit)<dateadd(d,-day(getdate()),convert(Date,getdate()+1)) then 'Red'

--yellow color for within the  Current month 
	 when DaysAfterComm between 365 and 730  and convert(date,TwoYearKit) between dateadd(d,-day(getdate())+1,convert(date,getdate())) and
            dateadd(d,-1,dateadd(m,1,dateadd(d,-day(getdate())+1,convert(date,getdate())))) then 'Yellow'

--Green colour for Next month
     when DaysAfterComm between 365 and 730 and convert(date,TwoYearKit) between dateadd(m,1,dateadd(d,-day(getdate())+1,convert(date,getdate()))) and
            dateadd(d,-1,dateadd(m,2,dateadd(d,-day(getdate())+1,convert(date,getdate())))) then 'Green'
--No colour for blank and nextmonth +1 dates

	WHEN TwoYearKit IS NULL THEN 'No colour'
	when DaysAfterComm between 365 and 730  and convert(date,TwoYearKit)> dateadd(d,-1,dateadd(m,2,dateadd(d,-day(getdate())+1,convert(date,getdate())))) 
	then 'No colour'end 


UPDATE ServiceDueAcc set ThreeYearKit_Clr =

case 
--Red colour for less than Current Month starting

when DaysAfterComm between 730 and 1095 and convert(date,ThreeYearKit)<dateadd(d,-day(getdate()),convert(Date,getdate()+1)) then 'Red'

--yellow color for within the  Current month 
	 when DaysAfterComm between 730 and 1095  and convert(date,ThreeYearKit) between dateadd(d,-day(getdate())+1,convert(date,getdate())) and
            dateadd(d,-1,dateadd(m,1,dateadd(d,-day(getdate())+1,convert(date,getdate())))) then 'Yellow'

--Green colour for Next month
     when DaysAfterComm between 730 and 1095 and convert(date,ThreeYearKit) between dateadd(m,1,dateadd(d,-day(getdate())+1,convert(date,getdate()))) and
            dateadd(d,-1,dateadd(m,2,dateadd(d,-day(getdate())+1,convert(date,getdate())))) then 'Green'
--No colour for blank and nextmonth +1 dates

	WHEN ThreeYearKit IS NULL THEN 'No colour'
	when DaysAfterComm between 730 and 1095  and convert(date,ThreeYearKit)> dateadd(d,-1,dateadd(m,2,dateadd(d,-day(getdate())+1,convert(date,getdate())))) 
	then 'No colour'end 



--This colours only for Commdate within 1 year
UPDATE ServiceDueAcc set OthersTwoYearKit_Clr =

case 
--Red colour for less than Current Month starting

when convert(date,OthersTwoYearKit)<dateadd(d,-day(getdate()),convert(Date,getdate()+1)) then 'Red'

--yellow color for within the  Current month 
	 when  convert(date,OthersTwoYearKit) between dateadd(d,-day(getdate())+1,convert(date,getdate())) and
            dateadd(d,-1,dateadd(m,1,dateadd(d,-day(getdate())+1,convert(date,getdate())))) then 'Yellow'

--Green colour for Next month
     when  convert(date,OthersTwoYearKit) between dateadd(m,1,dateadd(d,-day(getdate())+1,convert(date,getdate()))) and
            dateadd(d,-1,dateadd(m,2,dateadd(d,-day(getdate())+1,convert(date,getdate())))) then 'Green'
--No colour for blank and nextmonth +1 dates

	WHEN OthersTwoYearKit IS NULL THEN 'No colour'
	when convert(date,OthersTwoYearKit)> dateadd(d,-1,dateadd(m,2,dateadd(d,-day(getdate())+1,convert(date,getdate())))) 
	then 'No colour'end 



--------------------STEP 12 : Updating DPST  ----------------------

----alter table ServiceDueAcc add DPST nvarchar(50)

update ServiceDueAcc set DPST =a.t$cofc from TZZSLS310All a WHERE ServiceDueAcc.FabNo=a.T$CSER


end



--select * from ServiceDueAcc

----select * from ServiceDueAcc_Master


--select    dateadd(d,-1,dateadd(m,2,dateadd(d,-day(getdate())+1,convert(date,getdate())))) 

GO

