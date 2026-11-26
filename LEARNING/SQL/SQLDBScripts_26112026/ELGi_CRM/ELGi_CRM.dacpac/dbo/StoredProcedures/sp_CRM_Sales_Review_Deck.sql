--Exec sp_CRM_Sales_Review_Deck
CREATE proc sp_CRM_Sales_Review_Deck as

begin

Declare @var1 int=(select case when month(getdate())-1 <4 then 4 else 3 end)

Declare @Finyear int=(select max(Fin_Year)-@var1 from CRM_Sales_Review_Deck where cal_year=year(getdate()-1))
Declare @MaxFinyear int=(select max(Fin_Year) from CRM_Sales_Review_Deck where cal_year=year(getdate()-1))
Declare @StartDate date=datefromparts(@Finyear,4,1)
--select @var1,@Finyear,@StartDate
--set @StartDate='2023-04-01'


Truncate table CRM_Sales_Review_Deck
Truncate table CRM_Sales_Review_Deck_Log
Truncate table crm_Enquiries_with_multiple_opportunityids
Truncate table CRM_orderlist_temp

update systemuser_CRM set systemuserid=replace(systemuserid,'{','')
update systemuser_CRM set systemuserid=replace(systemuserid,'}','')


--1.Budget Data

Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('Bud and Sales load',getdate())

insert into  CRM_Sales_Review_Deck(--SalesRepType,
SalesRepName,Zone,DealerCode,
DealerName,--AreaCode,AreaName,
DPST,--CRM_Division,Channel_Direct,
CRM_Productgroup,Cal_Year,Cal_Month,MonthName,
SalesBudQty,SalesBudValue,
--InflowBudQty,InflowBudValue,
--EnquiryBudQty,EnquiryBudValue,
SalesRepCode,--DealerEngineerCode,DealerEngineerName,
Remarks,EntryDate,
--No_of_Visits_Tgt,No_of_Enq_Tgt,No_of_Orders_Tgt,
District--,PinCode,CRM_Unit_Acc,
--custcode,CustName,BudgetRnk
)
select * from(
select owneridname,Region,elgi_erpcustomercode,elgi_dealernamename,elgi_salesofficecode,elgi_productcategoryname,
CalYear,CalMonth,Month_Name,infqty,infValue,SalesRepCode,'Budget' as Remarks,
Convert(DATE,concat(convert(varchar,CalYear),'-',RIGHT('00'+CAST(CalMonth AS VARCHAR(2)),2),'-01')) as EntryDate,
elgi_districtname
from CRM_Budget
where isnull(infqty,0)+isnull(infValue,0)<>0
)a
where EntryDate>=@StartDate


update CRM_Sales_Review_Deck set EnquiryBudQty=SalesBudQty *2 
update CRM_Sales_Review_Deck set EnquiryBudValue=SalesBudValue *2

update CRM_Sales_Review_Deck set InflowBudQty=SalesBudQty * 1.1
update CRM_Sales_Review_Deck set InflowBudValue=SalesBudValue * 1.1


insert into CRM_Sales_Review_Deck(EntryDate,ownerid,SalesRepName,
DealerName,No_of_Visits_Tgt,Remarks)
select elgi_monthstartingdatecopy,a.ownerid,b.fullname,
--a.elgi_dealer,
c.name,--elgi_numberofworkingdays,
elgi_plannedvisitscount,'Budget'
from elgi_monthlyplan_CRM a
left outer join systemuser_CRM b
on a.ownerid=b.systemuserid
left outer join Account_CRM c
on a.elgi_dealer=c.accountid
where elgi_monthstartingdatecopy >= @StartDate
--'2022-04-01'  --Old Date Condition


---------------------2. Sales data from LN----------------------------------------------------------
--delete from CRM_Sales_Review_Deck where remarks='Sales'

insert into CRM_Sales_Review_Deck(
--CRM_AssemblyLine,CRM_Unit_Acc,CRM_Productgroup,CRM_Division,
EntryDate,Invoice_Date,Invoice,dpst,dpstname,areacode,areaname,Zone,item,item_desc,
CustCode,CustName,SalesRepCode,SalesRepName,
cal_year,cal_Month,Monthname,DeliveryQty,Sales_amount,Remarks,Weekno,
LOBCode--,LineOfBusiness
)
--select  into CRM_Sales_Review_Deck from (
--select count(*) from(
select --CRM_AssemblyLine,CRM_Unit_Acc,CRM_Productgroup,CRM_Division,
invoice_date as EntryDate,invoice_date,Invoice,dpst,dpstname,areacode,areaname,Zone,
ltrim(rtrim(item)) item,item_desc,
custcode,custname,
SalesRepCode,SalesRep,
cal_year,cal_Month,Monthname,
sum(DeliveryQty) DeliveryQty,
sum(Sales_amount)/1000000.0  as Sales_amount,'Sales' as Remarks,Weekno,
LOBCode--,LineOfBusiness
from
(select *,
datepart(wk,invoice_date)-datepart(wk,dateadd(dd,1,dateadd(mm,-1,eomonth(invoice_date))))+1 as Weekno
from [ELGi_LN].dbo.ELGi_Sales_Details)a
where invoice_date>=@StartDate
--'2017-04-01' --Old Date Condition
and sales_category not in (1)
and dpst in (select distinct DPST from DPST_Vertical_Mapping_Master)
--and crm_assemblyline is not null
group by --CRM_AssemblyLine,CRM_Unit_Acc,CRM_Productgroup,CRM_Division,
invoice_date,Invoice,dpst,dpstname,areacode,areaname,Zone,
ltrim(rtrim(item)),item_desc,
custcode,custname,SalesRepCode,SalesRep,
cal_year,cal_Month,Monthname,Weekno,
LOBCode--,LineOfBusiness
--)a


------------------End 2. Sales data from LN-------------------------------------------------------
---------------------3.1 Inflow data from LN-------------------------------------------------------
--delete from CRM_Sales_Review_Deck where remarks= 'Inflow_LN'

insert into CRM_Sales_Review_Deck(
--CRM_AssemblyLine,CRM_Unit_Acc,CRM_Productgroup,CRM_Division,
EntryDate,dpst,dpstname,areacode,areaname,Zone,item,item_desc,
CustCode,CustName,SalesRepCode,SalesRepName,
cal_year,cal_Month,InflowQty_LN,Inflow_amount_LN,Remarks,Weekno,
LOBCode,LineOfBusiness)
--select  into CRM_Sales_Review_Deck from (
select --CRM_AssemblyLine,CRM_Unit_Acc,CRM_Productgroup,CRM_Division,
orderdate,dpst,dpstname,areacode,areaname,Zone,
ltrim(rtrim(ItemCode)) ItemCode,item_desc,
custcode,custname,
SalesRepCode,SalesRep,
cal_year,cal_Month,
sum(InflowQty) InflowQty,
sum(Inflow_amount) Inflow_amount,'Inflow_LN',Weekno,
LOBCode,LineOfBusiness
from (select OrderDate,dpst,dpstname,areacode,areaname,Zone,
ltrim(rtrim(ItemCode)) ItemCode,item_desc,
custcode,custname,SalesRepCode,SalesRep,
year(OrderDate) as cal_year,
month(OrderDate)cal_Month,
sum(qty) InflowQty,
sum(sales)/1000000.0 Inflow_amount,Weekno,
LOBCode,LineOfBusiness
from (select *,
datepart(wk,OrderDate)-datepart(wk,dateadd(dd,1,dateadd(mm,-1,eomonth(OrderDate))))+1 as Weekno
from [ELGi_LN].dbo.Sales_Inflow
where OrderDate>=@StartDate
--'2020-04-01' --Old Date Condition
and concat(company,ordertype) in (select concat(company,saleordertype) from saletype_master where Sales_Category not in (1) ) 
)a
group by OrderDate,dpst,dpstname,areacode,areaname,Zone,
ltrim(rtrim(ItemCode)),item_desc,
custcode,custname,SalesRepCode,SalesRep,OrderDate,Weekno,
LOBCode,LineOfBusiness
)a
group by OrderDate,dpst,dpstname,areacode,areaname,Zone,
ltrim(rtrim(ItemCode)),item_desc,
custcode,custname,SalesRepCode,SalesRep,cal_year,cal_Month,Weekno,
LOBCode,LineOfBusiness
--)a


update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='Bud and Sales load'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('Inflow Engineer load',getdate())



--------------------End 3.1 Inflow data from LN---------------------------------------------------
------------------------3.2 Inflow data from CRM---------------------------------------------------

--3.2.1 Engineer Inflow data from CRM

--delete from crm_sales_review_deck where remarks= 'Inflow_Engineer'
insert into crm_sales_review_deck(
opportunityid,Enquiryid,visitid,
quoteid,salesorderid,elgi_aonumber,productid,
ownerid,accountnumber,Remarks
)
select 
a.opportunityid,a.elgi_enquiryid,a.elgi_customervisitid,
a.quoteid,b.salesorderid,b.elgi_aonumber,--a.productid,
isnull(a.productid,b.productid) productid,
a.ownerid,a.accountnumber,'Inflow_Engineer' as Remarks
from 
(select 
a.opportunityid,a.elgi_enquiryid,a.elgi_customervisitid,
b.quoteid,b.productid,
a.ownerid,a.accountnumber
from (select distinct opportunityid,elgi_enquiryid,elgi_customervisitid,
ownerid,accountnumber,elgi_dealerengineername,statuscodename
from crm_units_stage1
where elgi_dealerengineername is null
and statuscodename='Order Won'
) a
left outer join (select distinct opportunityid,quoteid,
Quote_Name,productid,elgi_salesofficecode 
from crm_Engineer)b
on a.opportunityid=b.opportunityid
)a
left outer join (select a.quoteid,a.salesorderid,a.elgi_aonumber,b.productid from
(select distinct quoteid,salesorderid,elgi_aonumber from salesorder_CRM) a
left outer join (select distinct salesorderid,productid from salesorderdetail_CRM)b
on a.salesorderid=b.salesorderid
)b
on a.quoteid=b.quoteid
and a.productid=b.productid
--where b.elgi_aonumber in ('204020797-401')--,'204020790-401','204020798-401','204020793-401') --for testing


update crm_sales_review_deck set Quote_Name=a.Quote_Name,
productid=a.productid,
dpst=a.elgi_salesofficecode,dpstname=a.elgi_salesofficename
from (select distinct quoteid,productid,Quote_Name,elgi_salesofficecode,elgi_salesofficename from crm_Engineer)a
where ltrim(rtrim(isnull(crm_sales_review_deck.quoteid,'0')))=ltrim(rtrim(isnull(a.quoteid,'0')))
and ltrim(rtrim(isnull(crm_sales_review_deck.productid,'0')))=ltrim(rtrim(isnull(a.productid,'0')))
and crm_sales_review_deck.Remarks='Inflow_Engineer'

update crm_sales_review_deck set QuoteDate=c.QuoteDate,
--InflowDate=c.NegotiationDate,
--EntryDate=c.NegotiationDate,
areacode=c.AreaCode
from(select distinct b.opportunityid,a.quoteid,a.QuoteDate,b.NegotiationDate,b.elgi_aonumber,b.AreaCode from
(select Quoteid,max(createdon) QuoteDate from Quote_CRM group by Quoteid)a
left outer join (select quoteid,opportunityid,elgi_aonumber,elgi_areaname as AreaCode,
max(createdon) NegotiationDate --elgi_aodate
from salesorder_CRM group by quoteid,opportunityid,elgi_aonumber,elgi_areaname)b
on a.quoteid=b.quoteid
)c
where crm_sales_review_deck.opportunityid=c.opportunityid
and crm_sales_review_deck.quoteid=c.quoteid
and crm_sales_review_deck.elgi_aonumber=c.elgi_aonumber
and crm_sales_review_deck.Remarks='Inflow_Engineer'

--Method 2  order won and Loss to be considered based on actual close date of an Enquiry
update crm_sales_review_deck set InflowDate=c.actualclosedate,
EntryDate=c.actualclosedate
from(select distinct opportunityid,actualclosedate from CRM_Units_Stage1)c
where ltrim(rtrim(crm_sales_review_deck.opportunityid))=ltrim(rtrim(c.opportunityid))
--and ltrim(rtrim(crm_sales_review_deck.quoteid))=ltrim(rtrim(c.quoteid))
and crm_sales_review_deck.Remarks='Inflow_Engineer'

update CRM_Sales_Review_Deck set InflowQty=a.quantity,Inflow_amount=a.baseamount/1000000.0
from(select quoteid,productid,priceperunit,quantity,baseamount,productidname from CRM_Engineer)a
where CRM_Sales_Review_Deck.quoteid=a.quoteid
and CRM_Sales_Review_Deck.productid=a.productid
and crm_sales_review_deck.Remarks='Inflow_Engineer'


update crm_sales_review_deck set Enq_Desc=a.Enq_Desc,EnqDate=a.EnqDate,EnquiryStatus=a.EnquiryStatus
from (select distinct elgi_enquiryid,Enq_Desc,convert(date,createdon) as EnqDate,
--statecodename as EnquiryStatus 
elgi_enquirystatus2name as EnquiryStatus 
from crm_units_stage1)a
where crm_sales_review_deck.Enquiryid=a.elgi_enquiryid
and crm_sales_review_deck.remarks='Inflow_Engineer'

update crm_sales_review_deck set LatestVisitdate=a.elgi_latestvisitdate,visitstatus=a.elgi_statusofvisitsalesname
from(select distinct elgi_customervisitid,elgi_latestvisitdate,elgi_statusofvisitsalesname from crm_units_stage1)a
where crm_sales_review_deck.visitid=a.elgi_customervisitid
and crm_sales_review_deck.remarks='Inflow_Engineer'

update crm_sales_review_deck set LOBCode=a.elgi_lineofbusinessname,LineOfBusiness=a.elgi_description,pincode=a.pincode
from (select distinct opportunityid,elgi_lineofbusinessname,elgi_description,pincode from crm_units_stage1
where len(elgi_lineofbusinessname) <10
)a
where crm_sales_review_deck.opportunityid=a.opportunityid
and crm_sales_review_deck.remarks='Inflow_Engineer'

update crm_sales_review_deck set item=a.elgi_itemcode,
item_desc=a.name
from(select  distinct productid,elgi_itemcode,name from product_CRM)a
where crm_sales_review_deck.productid=a.productid
and crm_sales_review_deck.remarks='Inflow_Engineer'
--where ltrim(rtrim(crm_sales_review_deck.productid))=ltrim(rtrim(a.productid))




update crm_sales_review_deck set customerclassification=a.elgi_customerclassificationname,
visitid=a.elgi_customervisitid,
areaname=a.elgi_cityname,
salesrepname=a.owneridname,
DealerCode=ltrim(rtrim(a.DealerCode)),
Dealername=ltrim(rtrim(a.elgi_dealername)),
CustCode=ltrim(rtrim(a.elgi_erpcustomercode)),
CustName=ltrim(rtrim(a.name))
from CRM_Units_Stage1 a
where crm_sales_review_deck.opportunityid=a.opportunityid
and crm_sales_review_deck.remarks='Inflow_Engineer'

update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='Inflow Engineer load'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('Inflow Dealer load',getdate())



--3.2.2 Dealer Inflow data from CRM
--delete from crm_sales_review_deck where remarks='Inflow_Dealer'

insert into crm_sales_review_deck(--EntryDate,
opportunityid,Enquiryid,visitid,
elgi_dealerofferid,elgi_aonumber,productid,ownerid,accountnumber,
DealerEngineerCode,DealerEngineerName,Remarks)
select --a.EnqDate as Date1,
a.opportunityid,a.elgi_enquiryid,a.elgi_customervisitid,
a.elgi_dealerofferid,b.elgi_aonumber,
isnull(a.productid,b.productid) productid,
a.ownerid,accountnumber,
a.elgi_dealerengineer,a.elgi_dealerengineername,
'Inflow_Dealer' as Remarks
from 
(select a.opportunityid,a.elgi_enquiryid,a.elgi_customervisitid,
a.ownerid,b.elgi_dealerofferid,b.productid,
accountnumber,
a.elgi_dealerengineer,a.elgi_dealerengineername
from 
(select distinct opportunityid,elgi_enquiryid,elgi_customervisitid,
ownerid,statuscodename,accountnumber,
elgi_dealerengineer,elgi_dealerengineername
from crm_units_stage1
where elgi_dealerengineername is not null
and statuscodename='Order Won'
) a
left outer join (select distinct elgi_enquiry,elgi_dealerofferid,elgi_salesofficecode
,elgi_existingproduct as productid
from crm_Dealer
where elgi_salesofficecode in (select distinct DPST from DPST_Vertical_Mapping_Master)
)b
on a.opportunityid=b.elgi_enquiry
)a
--Below code added on 23-05-2025
left outer join (select a.opportunityid,a.quoteid,a.salesorderid,a.elgi_aonumber,b.productid from
(select distinct opportunityid,quoteid,salesorderid,elgi_aonumber from salesorder_CRM) a
left outer join (select distinct salesorderid,productid from salesorderdetail_CRM)b
on a.salesorderid=b.salesorderid
)b
on a.opportunityid=b.opportunityid
--where a.opportunityid='EDDBC02D-8B42-EE11-A81C-000D3AF286E4'


--Method 2  order won and Loss to be considered based on actual close date of an Enquiry
update crm_sales_review_deck set InflowDate=c.actualclosedate,
EntryDate=c.actualclosedate
from(select distinct opportunityid,actualclosedate from CRM_Units_Stage1)c
where ltrim(rtrim(crm_sales_review_deck.opportunityid))=ltrim(rtrim(c.opportunityid))
--and ltrim(rtrim(crm_sales_review_deck.quoteid))=ltrim(rtrim(c.quoteid))
and crm_sales_review_deck.Remarks='Inflow_Dealer'



insert into CRM_orderlist_temp 
select distinct elgi_aonumber from CRM_Sales_Review_Deck where elgi_aonumber is not null


--Commented on 23-Nov-2022
update CRM_Sales_Review_Deck set elgi_dispatchreadinessdateatelgiho=a.elgi_dispatchreadinessdateatelgiho,
Invoice_Date=a.Invoice_Date
from (select distinct elgi_aonumber,createdon,elgi_salesofficename,owneridname,
elgi_areaname,elgi_dispatchreadinessdateatelgiho,Invoice_Date,Invoice
from salesorder_CRM a
Inner join (select distinct company,SaleOrderType,OrderNo,OrderDate,
trantype,Invoice,Invoice_Date,Item,Item_desc from [ELGi_LN].dbo.ELGi_Sales_Details 
where sales_category not in (1)
and Fin_year>=(select max(Fin_year)-2 from [ELGi_LN].dbo.ELGi_Sales_Details)
)b
on substring(a.elgi_aonumber,11,3)=b.company
and substring(a.elgi_aonumber,1,9)=b.OrderNo
where elgi_aonumber in (select * from CRM_orderlist_temp)
--and createdon='2022-04-01'
)a
where CRM_Sales_Review_Deck.elgi_aonumber=a.elgi_aonumber
and isnull(CRM_Sales_Review_Deck.Invoice,0)=a.invoice


--Commented On 23-05-2025
--insert into CRM_Sales_Review_Deck(--Remarks,opportunityid,elgi_aonumber,EntryDate,InflowDate,
----dpstname,item,item_desc,
----ownerid,
--SalesRepName,areacode,elgi_dispatchreadinessdateatelgiho,Invoice_Date,Invoice)
--select 'Inflow_Dealer',
----substring(a.elgi_aonumber,11,3) as company,substring(a.elgi_aonumber,1,9) as elgi_aonumber,
--a.opportunityid,a.elgi_aonumber,a.createdon,a.createdon,
--a.elgi_name,
----b.elgi_tplcode, --Method1
----c.elgi_invoicetype,c.invoicenumber,c.msdyn_invoicedate --Method1
--b.item,b.Item_desc,
--a.ownerid,a.fullname,a.elgi_areaname,
--a.elgi_dispatchreadinessdateatelgiho,
----b.company,b.OrderNo,b.OrderDate,b.Invoice,
--b.Invoice_Date,b.Invoice
----select top 10  
--from (select distinct opportunityid,elgi_aonumber,a.createdon,c.elgi_name,
--a.ownerid,b.fullname,
--elgi_areaname,elgi_dispatchreadinessdateatelgiho
--from salesorder_CRM a
--left outer join systemuser_CRM b
--on a.ownerid=b.systemuserid
--left outer join elgi_salesoffices_CRM c
--on a.elgi_salesoffice=c.elgi_salesofficesid
--where a.elgi_aonumber not in (select * from CRM_orderlist_temp)

----and createdon='2022-04-01'
--) a
--Inner join
----Method1
----[192.168.221.130].[LN_DEMO].dbo.invoicedetail b
----on a.elgi_aonumber=b.elgi_aonumber
----left outer join [192.168.221.130].[LN_DEMO].dbo.invoice c
----on b.invoiceid=c.invoiceid
----Method2
--(select distinct company,SaleOrderType,OrderNo,OrderDate,
--trantype,Invoice,Invoice_Date,Item,Item_desc from [ELGi_LN].dbo.ELGi_Sales_Details
--where sales_category not in (1)
--and Fin_year>=(select max(Fin_year)-2 from [ELGi_LN].dbo.ELGi_Sales_Details)
--)b
--on substring(a.elgi_aonumber,11,3)=b.company
--and substring(a.elgi_aonumber,1,9)=b.OrderNo



update CRM_Sales_Review_Deck set Commit_to_Invoice_Days= datediff(dd,elgi_dispatchreadinessdateatelgiho,Invoice_Date)


update CRM_Sales_Review_Deck set Commit_to_Inv_Days_Category='-7' where Commit_to_Invoice_Days between -7 and -1
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_Category='-14' where Commit_to_Invoice_Days between -14 and -8
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_Category='-21' where Commit_to_Invoice_Days between -21 and -15
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_Category='-28' where Commit_to_Invoice_Days between -28 and -22
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_Category='-35' where Commit_to_Invoice_Days between -35 and -29
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_Category='-42' where Commit_to_Invoice_Days between -42 and -36
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_Category='-49' where Commit_to_Invoice_Days between -49 and -43
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_Category='-56' where Commit_to_Invoice_Days between -56 and -50
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_Category='-63' where Commit_to_Invoice_Days between -63 and -57
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_Category='-70' where Commit_to_Invoice_Days between -70 and -64
--update CRM_Sales_Review_Deck set Commit_to_Inv_Days_Category='Before 70' where Commit_to_Invoice_Days -70
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_Category=0 where Commit_to_Invoice_Days=0
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_Category='7' where Commit_to_Invoice_Days between 1 and 7
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_Category='14' where Commit_to_Invoice_Days between 8 and 14
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_Category='21' where Commit_to_Invoice_Days between 15 and 21
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_Category='28' where Commit_to_Invoice_Days between 22 and 28
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_Category='35' where Commit_to_Invoice_Days between 29 and 35
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_Category='42' where Commit_to_Invoice_Days between 36 and 42
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_Category='49' where Commit_to_Invoice_Days between 43 and 49
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_Category='56' where Commit_to_Invoice_Days between 50 and 56
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_Category='63' where Commit_to_Invoice_Days between 57 and 63
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_Category='70' where Commit_to_Invoice_Days between 64 and 70
--update CRM_Sales_Review_Deck set Commit_to_Inv_Days_Category='After 70' where Commit_to_Invoice_Days 70



--update CRM_Sales_Review_Deck set Commit_to_Inv_Days_ordr=1 where Commit_to_Inv_Days_Category='Before 70'
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_ordr=2 where Commit_to_Inv_Days_Category='-70'
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_ordr=3 where Commit_to_Inv_Days_Category='-63'
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_ordr=4 where Commit_to_Inv_Days_Category='-56'
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_ordr=5 where Commit_to_Inv_Days_Category='-49'
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_ordr=6 where Commit_to_Inv_Days_Category='-42'
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_ordr=7 where Commit_to_Inv_Days_Category='-35'
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_ordr=8 where Commit_to_Inv_Days_Category='-28'
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_ordr=9 where Commit_to_Inv_Days_Category='-21'
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_ordr=10 where Commit_to_Inv_Days_Category='-14'
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_ordr=11 where Commit_to_Inv_Days_Category='-7'
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_ordr=12 where Commit_to_Inv_Days_Category='0'
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_ordr=13 where Commit_to_Inv_Days_Category='7'
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_ordr=14 where Commit_to_Inv_Days_Category='14'
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_ordr=15 where Commit_to_Inv_Days_Category='21'
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_ordr=16 where Commit_to_Inv_Days_Category='28'
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_ordr=17 where Commit_to_Inv_Days_Category='35'
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_ordr=18 where Commit_to_Inv_Days_Category='42'
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_ordr=19 where Commit_to_Inv_Days_Category='49'
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_ordr=20 where Commit_to_Inv_Days_Category='56'
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_ordr=21 where Commit_to_Inv_Days_Category='63'
update CRM_Sales_Review_Deck set Commit_to_Inv_Days_ordr=22 where Commit_to_Inv_Days_Category='70'
--update CRM_Sales_Review_Deck set Commit_to_Inv_Days_ordr=23 where Commit_to_Inv_Days_Category='After 70'


update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='Inflow Dealer load'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('Inflow Dealer Update1',getdate())

update crm_sales_review_deck set elgi_dealeroffername=a.elgi_dealeroffername,
dpst=a.elgi_salesofficecode,dpstname=a.elgi_salesofficename,
item=a.elgi_itemcode,item_desc=a.elgi_existingproductname,
InflowQty=a.elgi_quantity,Inflow_amount=a.elgi_amount/1000000.0
--lineofbusiness,pincode
from(select distinct elgi_enquiry,elgi_dealerofferid,elgi_dealeroffername,
elgi_salesofficecode,elgi_salesofficename,
elgi_existingproduct as productid,
elgi_itemcode,elgi_existingproductname,
elgi_quantity,elgi_amount  
from crm_Dealer
--where quoteid='47F04538-4149-EA11-A812-000D3AF29100'
)a
where crm_sales_review_deck.opportunityid=a.elgi_enquiry
and crm_sales_review_deck.elgi_dealerofferid=a.elgi_dealerofferid
and crm_sales_review_deck.productid=a.productid
and crm_sales_review_deck.Remarks= 'Inflow_Dealer'


update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='Inflow Dealer Update1'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('Inflow Dealer Update2',getdate())

--Commented on 21-Nov-2021
update crm_sales_review_deck set InflowDate=convert(date,a.OfferDate),OfferDate=convert(date,a.OfferDate),
EntryDate=convert(date,a.OfferDate)
from (
select --convert(varchar(100),elgi_enquiry) elgi_enquiry,
elgi_enquiry,
elgi_dealerofferid,max(createdon) OfferDate from elgi_dealeroffer_CRM
where elgi_enquiry is not null
group by --convert(varchar(100),elgi_enquiry),
elgi_enquiry,elgi_dealerofferid 
)a
where crm_sales_review_deck.opportunityid=a.elgi_enquiry
--and crm_sales_review_deck.elgi_dealerofferid=a.elgi_dealerofferid
and crm_sales_review_deck.Remarks= 'Inflow_Dealer'


update crm_sales_review_deck set InflowDate=convert(date,a.actualclosedate),
EntryDate=convert(date,a.actualclosedate)
from (
select distinct opportunityid,actualclosedate from CRM_Units_Stage1)a
where crm_sales_review_deck.opportunityid=a.opportunityid
--and crm_sales_review_deck.elgi_dealerofferid=a.elgi_dealerofferid
and crm_sales_review_deck.Remarks= 'Inflow_Dealer'



----where ltrim(rtrim(convert(varchar(100),crm_sales_review_deck.opportunityid)))=convert(varchar(100),ltrim(rtrim(a.elgi_enquiry)))
--where convert(nvarchar(200),crm_sales_review_deck.elgi_dealerofferid)=convert(nvarchar(200),a.elgi_dealerofferid)
--and crm_sales_review_deck.remarks='Inflow_Dealer'


update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='Inflow Dealer Update2'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('Inflow Dealer Update3',getdate())


update crm_sales_review_deck set Enq_Desc=a.Enq_Desc,EnqDate=a.EnqDate,EnquiryStatus=a.EnquiryStatus
from (select distinct opportunityid,elgi_enquiryid,Enq_Desc,convert(date,createdon) as EnqDate,
--statecodename as EnquiryStatus 
elgi_enquirystatus2name as EnquiryStatus 
from crm_units_stage1)a
where isnull(crm_sales_review_deck.Enquiryid,'0')=a.elgi_enquiryid
and isnull(crm_sales_review_deck.opportunityid,'0')=a.opportunityid
and crm_sales_review_deck.remarks='Inflow_Dealer'


update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='Inflow Dealer Update3'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('Inflow Dealer Update4',getdate())

update crm_sales_review_deck set LatestVisitdate=a.elgi_latestvisitdate,visitstatus=a.elgi_statusofvisitsalesname
from(select distinct elgi_customervisitid,elgi_latestvisitdate,elgi_statusofvisitsalesname from crm_units_stage1)a
where isnull(crm_sales_review_deck.visitid,'0')=a.elgi_customervisitid
and crm_sales_review_deck.visitid is not null
and crm_sales_review_deck.remarks='Inflow_Dealer'


update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='Inflow Dealer Update4'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('Inflow Dealer Update5',getdate())



update crm_sales_review_deck set LOBCode=a.elgi_lineofbusinessname,LineOfBusiness=a.elgi_description,pincode=a.pincode
from (select distinct opportunityid,elgi_lineofbusinessname,elgi_description,pincode from crm_units_stage1
)a
where isnull(crm_sales_review_deck.opportunityid,'0')=a.opportunityid
and crm_sales_review_deck.remarks='Inflow_Dealer'


update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='Inflow Dealer Update5'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('Inflow Dealer Update6',getdate())


update crm_sales_review_deck set item=a.elgi_itemcode,
item_desc=a.name
from(select  distinct productid,elgi_itemcode,name from product_CRM)a
where isnull(convert(varchar(100),crm_sales_review_deck.productid),'0')=convert(varchar(100),a.productid)
and crm_sales_review_deck.remarks='Inflow_Dealer'
--where ltrim(rtrim(crm_sales_review_deck.productid))=ltrim(rtrim(a.productid))

update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='Inflow Dealer Update6'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('Inflow Dealer Update7.1',getdate())


--update crm_sales_review_deck set customerclassification=a.elgi_customerclassificationname,
--visitid=a.elgi_customervisitid,
--areaname=a.elgi_cityname
--from (
--select elgi_customerclassificationname,elgi_customervisitid,elgi_cityname,opportunityid,elgi_enquiryid
--from CRM_Units_Stage1  where opportunityid is not null) a
--where --crm_sales_review_deck.opportunityid=a.opportunityid and 
--crm_sales_review_deck.Enquiryid=a.elgi_enquiryid
----and crm_sales_review_deck.opportunityid is not null
----and crm_sales_review_deck.Enquiryid is not null
--and crm_sales_review_deck.remarks='Inflow_Dealer'


update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='Inflow Dealer Update7.1'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('Inflow Dealer Update7.2',getdate())

--update crm_sales_review_deck set 
--salesrepname=a.owneridname,
--Dealername=ltrim(rtrim(a.elgi_dealername)),
--CustName=ltrim(rtrim(a.name))
--from (
--select owneridname,elgi_dealername,name,opportunityid,elgi_enquiryid
--from CRM_Units_Stage1  where opportunityid is not null) a
--where crm_sales_review_deck.opportunityid=a.opportunityid
--and crm_sales_review_deck.Enquiryid=a.elgi_enquiryid
--and crm_sales_review_deck.opportunityid is not null
--and crm_sales_review_deck.remarks='Inflow_Dealer'

update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='Inflow Dealer Update7.2'
update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='Inflow Dealer load'

Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('Enquiry Engineer load',getdate())


------------------------------------------------------------------------------------------------------------

--4.1 Enquiry data from CRM --Engineer Related



insert into crm_sales_review_deck(EntryDate,EnqDate,
opportunityid,Enquiryid,visitid,
elgi_dealerofferid,productid,ownerid,accountnumber,Remarks,EnquiryStatus)
select a.createdon,a.createdon,
a.opportunityid,a.elgi_enquiryid,a.elgi_customervisitid,
a.quoteid,
a.productid,a.ownerid,accountnumber,'Enquiry_Engineer' as Remarks,
EnquiryStatus 
from 
(select a.createdon,a.opportunityid,a.elgi_enquiryid,a.elgi_customervisitid,
a.ownerid,b.quoteid,b.productid,accountnumber,a.EnquiryStatus
from (select distinct createdon,opportunityid,elgi_enquiryid,elgi_customervisitid,
ownerid,elgi_dealerengineername,statuscodename,accountnumber,
--statecodename as EnquiryStatus 
elgi_enquirystatus2name as EnquiryStatus 
from crm_units_stage1) a
left outer join (select distinct opportunityid,quoteid,elgi_salesofficecode,productid
from CRM_Engineer
--where b.elgi_salesofficecode in ('90008','90016','90022','90093','90020')
where elgi_salesofficecode in (select distinct DPST from DPST_Vertical_Mapping_Master)
--where quoteid='47F04538-4149-EA11-A812-000D3AF29100'
)b
on a.opportunityid=b.opportunityid
where a.elgi_dealerengineername is null
)a
where a.elgi_enquiryid is not null
--and a.elgi_enquiryid='ENQ-196103'


update crm_sales_review_deck set EntryDate=convert(date,a.actualclosedate)
from (
select distinct opportunityid,actualclosedate from CRM_Units_Stage1
where --statuscodename= 'Order Lost'
elgi_enquirystatus2name='Lost'
)a
where crm_sales_review_deck.opportunityid=a.opportunityid
--and crm_sales_review_deck.elgi_dealerofferid=a.elgi_dealerofferid
and crm_sales_review_deck.Remarks= 'Enquiry_Engineer'



--Order lost Information to be displayed in corresponding months keeping the actual Enquiry as such
insert into crm_sales_review_deck(EntryDate,EnqDate,
opportunityid,Enquiryid,visitid,
elgi_dealerofferid,productid,ownerid,accountnumber,Remarks,EnquiryStatus)
select a.createdon,a.createdon,
a.opportunityid,a.elgi_enquiryid,a.elgi_customervisitid,
a.quoteid,
a.productid,a.ownerid,accountnumber,'Enquiry_Engineer' as Remarks,
EnquiryStatus 
from 
(select a.createdon,a.opportunityid,a.elgi_enquiryid,a.elgi_customervisitid,
a.ownerid,b.quoteid,b.productid,accountnumber,a.EnquiryStatus
from (select distinct createdon,opportunityid,elgi_enquiryid,elgi_customervisitid,
ownerid,elgi_dealerengineername,statuscodename,accountnumber,
'Active' as EnquiryStatus  --creating a old entry with WIP Status.
--elgi_enquirystatus2name as EnquiryStatus  --creating a old entry with WIP Status.
from crm_units_stage1
where --statuscodename= 'Order Lost'
elgi_enquirystatus2name='Lost'
) a
left outer join (select distinct opportunityid,quoteid,elgi_salesofficecode,productid
from CRM_Engineer
--where b.elgi_salesofficecode in ('90008','90016','90022','90093','90020')
where elgi_salesofficecode in (select distinct DPST from DPST_Vertical_Mapping_Master)
--where quoteid='47F04538-4149-EA11-A812-000D3AF29100'
)b
on a.opportunityid=b.opportunityid
where a.elgi_dealerengineername is null
)a
where a.elgi_enquiryid is not null
--and a.elgi_enquiryid='ENQ-196103'



Update CRM_Sales_Review_Deck set dpst=elgi_salesofficecode,dpstname=elgi_salesofficename,
item=a.elgi_itemcode,item_desc=a.productidname,
EnquiryQty=a.quantity,EnquiryValue=a.baseamount
from (select distinct opportunityid,productid,
elgi_salesofficecode,elgi_salesofficename,elgi_itemcode,productidname,
quantity,baseamount/1000000 as baseamount
from CRM_Engineer)a
where CRM_Sales_Review_Deck.opportunityid=a.opportunityid
and crm_sales_review_deck.productid=a.productid
and CRM_Sales_Review_Deck.Remarks= 'Enquiry_Engineer'


Update CRM_Sales_Review_Deck set SalesRepName=a.SalesRepName,
DealerCode=ltrim(rtrim(a.DealerCode)),
DealerName=a.DealerName,
CustCode=ltrim(rtrim(a.elgi_erpcustomercode)),
CustName=a.CustName
from (select distinct opportunityid,elgi_enquiryid,
convert(nvarchar,Enq_Desc) Enq_Desc,statecodename,
convert(date,createdon) as EnqDate,
elgi_cityname,isnull(owneridname,createdbyname) as SalesRepName,
elgi_erpcustomercode,DealerCode,
ltrim(rtrim(elgi_dealername)) as DealerName,ltrim(rtrim(name)) as CustName,
elgi_customerclassificationname,
elgi_description,pincode
from crm_units_stage1) a
where CRM_Sales_Review_Deck.opportunityid=a.opportunityid
and CRM_Sales_Review_Deck.enquiryid=a.elgi_enquiryid
and CRM_Sales_Review_Deck.Remarks= 'Enquiry_Engineer'




Update CRM_Sales_Review_Deck set 
Enq_Desc=a.Enq_Desc,customerclassification=a.elgi_customerclassificationname,
LOBCode=a.elgi_lineofbusinessname,
lineofbusiness=a.elgi_description,pincode=a.pincode,
Areaname=a.elgi_cityname
from (select distinct opportunityid,elgi_enquiryid,
convert(nvarchar,Enq_Desc) Enq_Desc,statecodename,
convert(date,createdon) as EnqDate,
elgi_cityname,isnull(owneridname,createdbyname) as SalesRepName,
ltrim(rtrim(elgi_dealername)) as DealerName,ltrim(rtrim(name)) as CustName,
elgi_customerclassificationname,elgi_lineofbusinessname,
elgi_description,pincode
from crm_units_stage1
) a
where CRM_Sales_Review_Deck.opportunityid=a.opportunityid
and CRM_Sales_Review_Deck.enquiryid=a.elgi_enquiryid
and CRM_Sales_Review_Deck.Remarks= 'Enquiry_Engineer'


update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='Enquiry Engineer load'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('Enquiry Dealer load',getdate())


--4.2 Enquiry data from CRM --Dealer Related


insert into crm_sales_review_deck(EntryDate,EnqDate,
opportunityid,Enquiryid,visitid,
elgi_dealerofferid,productid,ownerid,accountnumber,Remarks,EnquiryStatus,
DealerEngineerCode,DealerEngineerName)
select a.createdon,a.createdon,
a.opportunityid,a.elgi_enquiryid,a.elgi_customervisitid,
a.elgi_dealerofferid,
a.productid,a.ownerid,accountnumber,'Enquiry_Dealer' as Remarks,
a.EnquiryStatus,a.elgi_dealerengineer,a.elgi_dealerengineername
from 
(select a.createdon,a.opportunityid,a.elgi_enquiryid,a.elgi_customervisitid,
a.ownerid,b.elgi_dealerofferid,b.productid,accountnumber,a.EnquiryStatus,
a.elgi_dealerengineer,a.elgi_dealerengineername
from (select distinct createdon,opportunityid,elgi_enquiryid,elgi_customervisitid,
ownerid,statuscodename,accountnumber,
--statecodename as EnquiryStatus,
elgi_enquirystatus2name as EnquiryStatus,
elgi_dealerengineer,elgi_dealerengineername
from crm_units_stage1) a
left outer join (select distinct elgi_enquiry,elgi_dealerofferid,elgi_salesofficecode,
elgi_existingproduct as productid
from crm_Dealer
--where b.elgi_salesofficecode in ('90008','90016','90022','90093','90020')
where elgi_salesofficecode in (select distinct DPST from DPST_Vertical_Mapping_Master)
--where quoteid='47F04538-4149-EA11-A812-000D3AF29100'
)b
on a.opportunityid=b.elgi_enquiry
where a.elgi_dealerengineername is not null
)a
where a.elgi_enquiryid is not null
--and a.elgi_enquiryid='ENQ-196103'

update crm_sales_review_deck set EntryDate=convert(date,a.actualclosedate)
from (
select distinct opportunityid,actualclosedate from CRM_Units_Stage1
where --statuscodename= 'Order Lost'
elgi_enquirystatus2name='Lost'
)a
where crm_sales_review_deck.opportunityid=a.opportunityid
--and crm_sales_review_deck.elgi_dealerofferid=a.elgi_dealerofferid
and crm_sales_review_deck.Remarks= 'Enquiry_Dealer'


--Order lost Information to be displayed in corresponding months keeping the actual Enquiry as such
insert into crm_sales_review_deck(EntryDate,EnqDate,
opportunityid,Enquiryid,visitid,
elgi_dealerofferid,productid,ownerid,accountnumber,Remarks,EnquiryStatus,
DealerEngineerCode,DealerEngineerName)
select a.createdon,a.createdon,
a.opportunityid,a.elgi_enquiryid,a.elgi_customervisitid,
a.elgi_dealerofferid,
a.productid,a.ownerid,accountnumber,'Enquiry_Dealer' as Remarks,a.EnquiryStatus,
a.elgi_dealerengineer,a.elgi_dealerengineername
from 
(select a.createdon,a.opportunityid,a.elgi_enquiryid,a.elgi_customervisitid,
a.ownerid,b.elgi_dealerofferid,b.productid,accountnumber,a.EnquiryStatus,
a.elgi_dealerengineer,a.elgi_dealerengineername
from (select distinct createdon,opportunityid,elgi_enquiryid,elgi_customervisitid,
ownerid,statuscodename,accountnumber,
elgi_dealerengineer,elgi_dealerengineername,
'Active' as EnquiryStatus --creating a old entry with WIP Status.
--elgi_enquirystatus2name as EnquiryStatus --creating a old entry with WIP Status.
from crm_units_stage1
where --statuscodename= 'Order Lost'
elgi_enquirystatus2name='Lost'
) a
left outer join (select distinct elgi_enquiry,elgi_dealerofferid,elgi_salesofficecode,
elgi_existingproduct as productid
from crm_Dealer
--where b.elgi_salesofficecode in ('90008','90016','90022','90093','90020')
where elgi_salesofficecode in (select distinct DPST from DPST_Vertical_Mapping_Master)
--where quoteid='47F04538-4149-EA11-A812-000D3AF29100'
)b
on a.opportunityid=b.elgi_enquiry
where a.elgi_dealerengineername is not null
)a
where a.elgi_enquiryid is not null
--and a.elgi_enquiryid='ENQ-196103'




Update CRM_Sales_Review_Deck set dpst=elgi_salesofficecode,dpstname=elgi_salesofficename,
item=a.elgi_itemcode,item_desc=a.elgi_existingproductname,
EnquiryQty=a.elgi_quantity,EnquiryValue=a.elgi_amount
from (select distinct elgi_enquiry,elgi_dealerofferid,elgi_existingproduct,
elgi_salesofficecode,elgi_salesofficename,elgi_itemcode,elgi_existingproductname,
elgi_quantity,elgi_amount/1000000.0 elgi_amount
from CRM_Dealer)a
where CRM_Sales_Review_Deck.opportunityid=a.elgi_enquiry
and CRM_Sales_Review_Deck.elgi_dealerofferid=a.elgi_dealerofferid
and crm_sales_review_deck.productid=a.elgi_existingproduct
and CRM_Sales_Review_Deck.Remarks='Enquiry_Dealer'



Update CRM_Sales_Review_Deck set SalesRepName=a.SalesRepName,
DealerCode=a.DealerCode,
DealerName=a.DealerName,
CustCode=ltrim(rtrim(a.elgi_erpcustomercode)),
CustName=a.CustName
from (select distinct opportunityid,elgi_enquiryid,
convert(nvarchar,Enq_Desc) Enq_Desc,statecodename,
convert(date,createdon) as EnqDate,
elgi_cityname,isnull(owneridname,createdbyname) as SalesRepName,
elgi_erpcustomercode,DealerCode,
ltrim(rtrim(elgi_dealername)) as DealerName,ltrim(rtrim(name)) as CustName,
elgi_customerclassificationname,
elgi_description,pincode
from crm_units_stage1) a
where CRM_Sales_Review_Deck.opportunityid=a.opportunityid
and CRM_Sales_Review_Deck.enquiryid=a.elgi_enquiryid
and CRM_Sales_Review_Deck.Remarks= 'Enquiry_Dealer'





Update CRM_Sales_Review_Deck set 
Enq_Desc=a.Enq_Desc,customerclassification=a.elgi_customerclassificationname,
LOBCode=a.elgi_lineofbusinessname,lineofbusiness=a.elgi_description,pincode=a.pincode,
Areaname=a.elgi_cityname
from (select distinct opportunityid,elgi_enquiryid,
convert(nvarchar,Enq_Desc) Enq_Desc,statecodename,
convert(date,createdon) as EnqDate,
elgi_cityname,isnull(owneridname,createdbyname) as SalesRepName,
ltrim(rtrim(elgi_dealername)) as DealerName,ltrim(rtrim(name)) as CustName,
elgi_customerclassificationname,
elgi_lineofbusinessname,elgi_description,pincode
from crm_units_stage1) a
where CRM_Sales_Review_Deck.opportunityid=a.opportunityid
and CRM_Sales_Review_Deck.enquiryid=a.elgi_enquiryid
and CRM_Sales_Review_Deck.Remarks= 'Enquiry_Dealer' 

update CRM_Sales_Review_Deck set EnquiryQty=a.elgi_numbers,EnquiryValue=a.elgi_pricewelosttheorderat/1000000
from (select opportunityid,elgi_enquiryid,
sum(convert(float,elgi_numbers)) elgi_numbers,
sum(convert(float,elgi_pricewelosttheorderat)) elgi_pricewelosttheorderat
from crm_units_stage1
where --statecodename='Lost'
elgi_enquirystatus2name='Lost'
--and isnull(opportunityid,'0') not in (select distinct isnull(elgi_enquiry,'0') from CRM_Dealer) 
--and isnull(opportunityid,'0') not in (select distinct isnull(opportunityid,'0') from CRM_Engineer) 
group by opportunityid,elgi_enquiryid
)a
where CRM_Sales_Review_Deck.opportunityid=a.opportunityid
and CRM_Sales_Review_Deck.enquiryid=a.elgi_enquiryid
and remarks like 'Enqu%'
and EnquiryStatus='lost'
and quoteid is null
and elgi_dealerofferid is null

--Test Query
--select Enquiryid,EnquiryStatus,EnquiryQty,EnquiryValue from CRM_Sales_Review_Deck
--where remarks like 'Enqu%'
--and EnquiryStatus='lost'
--and quoteid is null
--and elgi_dealerofferid is null



update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='Enquiry Dealer load'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('Visits Engineer load',getdate())


---------------------------------

----5.1 Visits data from CRM --Engineer Related

insert into CRM_Sales_Review_Deck(
opportunityid,visitid,
--areacode,--SalesRepCode,DealerCode,CustCode,
ownerid,accountnumber,Remarks
)
select 
a.opportunityid,a.elgi_customervisitid,
ownerid,accountnumber,'Visits_Engineer'
--ltrim(rtrim(b.territoryidname)) as Zone,
from (
select a.owneridname,a.createdbyname,a.elgi_dealername,
a.elgi_customervisitid,a.ownerid,a.opportunityid,accountnumber,
a.elgi_latestvisitdate
from crm_units_stage1  a
left outer join (select * from crm_Engineer 
--where elgi_salesofficecode in ('90008','90016','90022','90093','90020')
where elgi_salesofficecode in (select distinct DPST from DPST_Vertical_Mapping_Master))b
on a.opportunityid=b.opportunityid
where a.elgi_dealerengineername is null
)a
left outer join 
(select distinct systemuserid--territoryidname,
--,yomifullname as SalesRep,--elgi_businessverticalname,businessunitidname 
from systemuser_CRM )b
on a.ownerid=b.systemuserid
left outer join (
select distinct opportunityid,QuoteDate,NegotiationDate from
(select Quoteid,max(createdon) QuoteDate from Quote_CRM  group by Quoteid)a
left outer join (select quoteid,opportunityid,max(createdon) NegotiationDate 
from salesorder_CRM  group by quoteid,opportunityid)b
on a.quoteid=b.quoteid
)c
on ltrim(rtrim(a.opportunityid))=ltrim(rtrim(c.opportunityid))
where a.elgi_customervisitid is not null
--and a.elgi_latestvisitdate is not null
--and a.elgi_latestvisitdate='2021-04-01'



----5.2 Visits data from CRM --Dealer Related

insert into CRM_Sales_Review_Deck(
EntryDate,opportunityid,dpst,dpstname,--areacode,
areaname,Zone,
item,item_desc,
cal_year,cal_Month,Monthname,
SalesRepName,DealerName,
--EnquiryQty,EnquiryValue, --Commented on 12-Dec-2021
--SalesRepCode,DealerCode,CustCode,
CustName,
visitid,visitstatus,Remarks,customerclassification,Weekno,
LatestVisitdate,ownerid,accountnumber,LOBCode,lineofbusiness,pincode,
DealerEngineerCode,DealerEngineerName
)
select 
convert(date,elgi_latestvisitdate) date1,
a.opportunityid,a.elgi_salesofficecode as DPST,a.elgi_salesofficename as DPSTName,
a.elgi_cityname as Areaname,ltrim(rtrim(b.territoryidname)) as Zone,
ltrim(rtrim(a.elgi_itemcode)) as Itemcode,ltrim(rtrim(a.elgi_existingproductname)) as item_desc,
year(a.elgi_latestvisitdate) as cal_year,month(a.elgi_latestvisitdate) as cal_Month,
datename(mm,dateadd(mm,month(a.elgi_latestvisitdate),-1)) as Monthname,
isnull(a.owneridname,a.createdbyname) as SalesRep ,ltrim(rtrim(a.elgi_dealername)) as DealerName,
--a.elgi_quantity as EnquiryQty,a.elgi_amount1000000 as EnquiryValue, --Commented on 12-Dec-2021
ltrim(rtrim(a.name)) as CustName,
a.elgi_customervisitid,a.elgi_statusofvisitsalesname as VisitStatus,'Visits_Dealer',elgi_customerclassificationname,
datepart(wk,elgi_latestvisitdate)-datepart(wk,dateadd(dd,1,dateadd(mm,-1,eomonth(elgi_latestvisitdate))))+1 as Weekno,
convert(date,elgi_latestvisitdate) elgi_latestvisitdate,ownerid,accountnumber,elgi_lineofbusinessname,elgi_description,pincode,
elgi_dealerengineer,elgi_dealerengineername
from (
select * from crm_units_stage1  a
left outer join (select * from crm_Dealer 
--where elgi_salesofficecode in ('90008','90016','90022','90093','90020')
where elgi_salesofficecode in (select distinct DPST from DPST_Vertical_Mapping_Master)) b
on a.opportunityid=b.elgi_enquiry
where a.elgi_dealerengineername is not null

)a
left outer join 
(select distinct territoryidname,systemuserid,--yomifullname as SalesRep,
elgi_businessverticalname from systemuser_CRM )b
on a.ownerid=b.systemuserid
left outer join (select elgi_enquiry,max(createdon) QuoteDate from elgi_dealeroffer_CRM  group by elgi_enquiry)c
on ltrim(rtrim(a.opportunityid))=ltrim(rtrim(c.elgi_enquiry))
where a.elgi_customervisitid is not null
--and a.elgi_latestvisitdate is not null
--and a.elgi_latestvisitdate='2017-04-01'


update CRM_Sales_Review_Deck set EntryDate=a.date1,LatestVisitdate=a.date1,
LOBCode=a.elgi_lineofbusinessname,
lineofbusiness=a.elgi_description,pincode=a.pincode,
SalesRepName=a.SalesRepName,
areaname=a.elgi_cityname,
DealerCode=ltrim(rtrim(a.DealerCode)),
DealerName=a.DealerName,
CustCode=ltrim(rtrim(a.elgi_erpcustomercode)),
CustName=a.CustName,
visitstatus=a.elgi_statusofvisitsalesname,
customerclassification=a.elgi_customerclassificationname
from (select distinct elgi_customervisitid,convert(date,elgi_latestvisitdate) date1, 
elgi_lineofbusinessname,elgi_description,pincode,
isnull(owneridname,createdbyname) as SalesRepName,
ltrim(rtrim(name)) as CustName,
elgi_cityname,elgi_erpcustomercode,DealerCode,
ltrim(rtrim(elgi_dealername)) as DealerName,
elgi_statusofvisitsalesname,elgi_customerclassificationname
from crm_units_stage1 )a
where CRM_Sales_Review_Deck.visitid=a.elgi_customervisitid
and CRM_Sales_Review_Deck.Remarks like 'Visits%'

update CRM_Sales_Review_Deck set dpst=a.elgi_salesofficecode,dpstname=a.elgi_salesofficename,
item=a.elgi_itemcode,item_desc=a.productidname
--,EnquiryQty=a.quantity,EnquiryValue=a.baseamount --Commented on 12-Dec-2021
from (select distinct opportunityid,elgi_salesofficecode,elgi_salesofficename,
ltrim(rtrim(elgi_itemcode)) elgi_itemcode,productidname,
quantity,baseamount/1000000 as baseamount
from crm_Engineer )a
where CRM_Sales_Review_Deck.opportunityid=a.opportunityid
and CRM_Sales_Review_Deck.Remarks like 'Visits%'


Update CRM_Sales_Review_Deck set Zone=a.name
from (select distinct systemuserid,b.name from systemuser_CRM a
left outer join (select distinct territoryid,name from territory_CRM)b
on a.territoryid=b.territoryid

)a
where CRM_Sales_Review_Deck.ownerid=a.systemuserid





update crm_sales_review_deck set cal_year=year(Entrydate)
update crm_sales_review_deck set cal_Month=month(Entrydate)
update crm_sales_review_deck set Monthname=datename(mm,dateadd(mm,month(EntryDate),-1))
update crm_sales_review_deck set WeekNo=datepart(wk,EntryDate)-datepart(wk,dateadd(dd,1,dateadd(mm,-1,eomonth(EntryDate))))+1

--Fiscal Week Calculation
update CRM_Sales_Review_Deck set FiscalWeek=datepart(wk,EntryDate)-(datepart(wk,convert(varchar,year(EntryDate))+'-04-01')-1)
where datepart(wk,EntryDate)-(datepart(wk,convert(varchar,year(EntryDate))+'-04-01')-1)>0 

update CRM_Sales_Review_Deck set FiscalWeek=a.MaxFiscalWeek
from (select Fin_Year, max(FiscalWeek) MaxFiscalWeek from CRM_Sales_Review_Deck group by Fin_Year)a
where CRM_Sales_Review_Deck.Fin_Year=a.Fin_Year
and datepart(wk,EntryDate)-(datepart(wk,convert(varchar,year(EntryDate))+'-04-01')-1)<=0 

update CRM_Sales_Review_Deck set FiscalWeek=FiscalWeek + datepart(wk,EntryDate)
--where month(EntryDate)=3
where datepart(wk,EntryDate)-(datepart(wk,convert(varchar,year(EntryDate))+'-04-01')-1)<=0 
--End Fiscal Week Calculation


update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='Visits Engineer load'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('Updates load',getdate())


--Update statement related to Inflow is pasted here since opportunityid link is taking more time.
--hence after updating the Enquiry and Visits , Attempting to update based on enquiryid

update crm_sales_review_deck set customerclassification=a.elgi_customerclassificationname,
visitid=a.elgi_customervisitid,
areaname=a.elgi_cityname
from (
select * from CRM_Units_Stage1  where opportunityid is not null) a
where --crm_sales_review_deck.opportunityid=a.opportunityid and 
isnull(crm_sales_review_deck.Enquiryid,'0')=a.elgi_enquiryid
--and crm_sales_review_deck.opportunityid is not null
--and crm_sales_review_deck.remarks='Inflow_Dealer'

update crm_sales_review_deck set 
salesrepname=a.owneridname,
DealerCode=ltrim(rtrim(a.DealerCode)),
Dealername=ltrim(rtrim(a.elgi_dealername)),
CustCode=ltrim(rtrim(a.elgi_erpcustomercode)),
CustName=ltrim(rtrim(a.name))
from (
select * from CRM_Units_Stage1  where opportunityid is not null) a
where isnull(crm_sales_review_deck.Enquiryid,'0')=a.elgi_enquiryid

--Special Case one enquiry contains multiple opportunity ids --Added on 23-08-2022

insert into crm_Enquiries_with_multiple_opportunityids
--select  into crm_Enquiries_with_multiple_opportunityids from(
select elgi_enquiryid from CRM_Units_Stage1 
group by elgi_enquiryid
having count(distinct opportunityid)>1
--)a

update crm_sales_review_deck set 
salesrepname=a.owneridname,
DealerCode=ltrim(rtrim(a.DealerCode)),
Dealername=ltrim(rtrim(a.elgi_dealername)),
CustCode=ltrim(rtrim(a.elgi_erpcustomercode)),
CustName=ltrim(rtrim(a.name))
from (
select * from CRM_Units_Stage1  where opportunityid is not null) a
where crm_sales_review_deck.opportunityid=a.opportunityid 
and crm_sales_review_deck.Enquiryid=a.elgi_enquiryid
and crm_sales_review_deck.Enquiryid in 
(select distinct Enquiryid from crm_Enquiries_with_multiple_opportunityids)

update CRM_Sales_Review_Deck set --EntryDate=a.date1,
LatestVisitdate=a.date1
from (select distinct elgi_customervisitid,
elgi_latestvisitdate as date1
--below logic not required because empty latest date indicates visit is not made.
--convert(date,isnull(elgi_latestvisitdate,createdon)) as date1 
from crm_units_stage1 )a
where isnull(CRM_Sales_Review_Deck.visitid,'0')=a.elgi_customervisitid

--select  from CRM_Sales_Review_Deck where remarks='Visits' and LatestVisitdate is null

--Alter table CRM_Sales_Review_Deck alter column ownerid uniqueidentifier

update crm_sales_review_deck set Zone=a.name,salesrepcode=a.employeeid,SalesRepName=a.SalesRep
from (select distinct employeeid,territoryidname,systemuserid,yomifullname as SalesRep,
elgi_businessverticalname,name 
from systemuser_CRM a
left outer join (select distinct territoryid,name from territory_CRM)b
on a.territoryid=b.territoryid
where employeeid not in ('-','--','___','NA','Nil','#')
and employeeid not like '%@%'
)a
where crm_sales_review_deck.ownerid=a.systemuserid
--where convert(varchar(100),isnull(crm_sales_review_deck.ownerid,'0'))=convert(varchar(100),a.systemuserid)

--update crm_sales_review_deck set areacode=
--from (select distinct area)

update crm_sales_review_deck set district=a.elgi_districtname
from (select distinct a.elgi_name,b.elgi_name as elgi_districtname from elgi_pincodelist_CRM a
left outer join  elgi_district_CRM b
on a.elgi_district=b.elgi_districtid
)a
where isnull(crm_sales_review_deck.pincode,'0')=a.elgi_name

update crm_sales_review_deck set DistrictCategory='P2 Districts' where district in 
('AGRA','AHMEDABAD','AHMED NAGAR','AURANGABAD','BENGALURU','BHILWARA','Bhopal','CHENNAI',
'COIMBATORE','Cuttack','ERNAKULAM','FARIDABAD','GANDHINAGAR','GAUTAM BUDDHA NAGAR','GHAZIABAD','GURGAON',
'Howrah','HYDERABAD','Indore','JAIPUR','JALANDHAR','KANCHIPURAM','KHORDA','KOLHAPUR',
'Kolkata','KRISHNA','LUCKNOW','LUDHIANA','MAHENDRAGARH','MEERUT','MUMBAI','NAGPUR',
'NASHIK','North 24 Parganas','PUNE','Raigad(MH)','Raipur','RAJKOT','RANGAREDDY','SURAT',
'THANE','TIRUPPUR','TIRUVALLUR','VADODARA','VISAKHAPATNAM')


update crm_sales_review_deck set DistrictCategory='P2 Districts' where district like '%del%'
update crm_sales_review_deck set DistrictCategory='P2 Districts' where district in
('KANPUR NAGAR'
--'KANPUR DEHAT'
)


update crm_sales_review_deck set DistrictCategory='BAU Districts' where DistrictCategory is null
and district is not null

update crm_sales_review_deck set elgi_losttoname=a.elgi_losttoname,
elgi_reasonname=a.elgi_reasonname
from (select * from crm_order_Wonlost where statuscodename='Order Lost') a
where isnull(convert(varchar(50),crm_sales_review_deck.opportunityid),'0')=convert(varchar(50),a.opportunityid)
and isnull(convert(varchar(50),crm_sales_review_deck.enquiryid),'0')=convert(varchar(50),a.elgi_enquiryid)
--and crm_sales_review_deck.EnquiryStatus=a.statuscodename


update crm_sales_review_deck set elgi_reasonname=a.elgi_buyingreasonname
from (select * from crm_order_Wonlost where statuscodename='Order Won') a
where isnull(convert(varchar(50),crm_sales_review_deck.opportunityid),'0')=convert(varchar(50),a.opportunityid)
and isnull(convert(varchar(50),crm_sales_review_deck.enquiryid),'0')=convert(varchar(50),a.elgi_enquiryid)


--Manual Master Data
--update CRM_Sales_Review_Deck set CRM_AssemblyLine=a.AssemblyLine,
--CRM_Unit_Acc=a.Unit_Acc
--from (select distinct dpst,Division,Productgroup,AssemblyLine,Unit_Acc from [MSCRM].dbo.CRM_TPL_Master)a
--where CRM_Sales_Review_Deck.dpst=a.DPST
--and CRM_Sales_Review_Deck.crm_division=a.Division
--and CRM_Sales_Review_Deck.CRM_Productgroup=a.Productgroup
--and CRM_AssemblyLine is null


update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='Updates load'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('Master Data load',getdate())


Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('a.Productgroup Update',getdate())
---Master Data--------------------------------
--ProductGroup  Method1
--update CRM_Sales_Review_Deck set CRM_Productgroup=null
--update CRM_Sales_Review_Deck set CRM_Productgroup=a.elgi_categoryname
--from (select distinct elgi_itemcode,elgi_categoryname from Product where elgi_categoryname is not null)a
--where ltrim(rtrim(CRM_Sales_Review_Deck.item))=ltrim(rtrim(a.elgi_itemcode))

--ProductGroup  Method2
--update CRM_Sales_Review_Deck set CRM_Productgroup=a.[PG-Review Deck]
--from [MSCRM].dbo.CRM_DPST_based_Prdgrp_Master a
--where CRM_Sales_Review_Deck.dpst=a.dpst
--and CRM_Sales_Review_Deck.CRM_Productgroup=a.CRM_Productgroup
--and CRM_Sales_Review_Deck.CRM_Productgroup is null


--ProductGroup  Method3
--update CRM_Sales_Review_Deck set CRM_Productgroup=a1.PRODUCTLINE
--from 
--(select a.ITEMCODE,a.PRODUCTLINE,a.DateA from 
--(select distinct ITEMCODE,DATE as DateA,PRODUCTLINE from OTA_TPL_MASTER where PRODUCTLINE is not null)a
--inner join
--(select ITEMCODE,max(DATE) as DateB from OTA_TPL_MASTER where PRODUCTLINE is not null
--group by ITEMCODE)b
--on a.ITEMCODE=b.ITEMCODE
--and a.DATEA=b.DATEB
----where a.ITEMCODE='S011000'
--)a1
--where ltrim(rtrim(CRM_Sales_Review_Deck.item))=ltrim(rtrim(a1.ITEMCODE))
--and CRM_Productgroup is null

--ProductGroup  Method4
update CRM_Sales_Review_Deck set CRM_Productgroup=a.elgi_productcategoryname
from (select distinct elgi_enquiry,elgi_itemcode,elgi_productcategoryname from CRM_Dealer 
where elgi_productcategoryname is not null)a
where ltrim(rtrim(CRM_Sales_Review_Deck.opportunityid))=ltrim(rtrim(a.elgi_enquiry))
and ltrim(rtrim(CRM_Sales_Review_Deck.item))=ltrim(rtrim(a.elgi_itemcode))


update CRM_Sales_Review_Deck set CRM_Productgroup=a.elgi_productcategoryname
from (select distinct opportunityid,elgi_itemcode,elgi_productcategoryname from CRM_Engineer 
where elgi_productcategoryname is not null)a
where ltrim(rtrim(CRM_Sales_Review_Deck.opportunityid))=ltrim(rtrim(a.opportunityid))
and ltrim(rtrim(CRM_Sales_Review_Deck.item))=ltrim(rtrim(a.elgi_itemcode))

--Added on 10-03-2022 as Borewell category is not available from CRM Master

update CRM_Sales_Review_Deck set CRM_Productgroup='BoreWell' where dpst='90014'

--OFSAC Productgroup Master --Manual data provided by OFSAC Team Udit Gupta 

update CRM_Sales_Review_Deck set CRM_Productgroup=a.Productgroup,CRM_Unit_Acc=a.Units_Acc
from (select * from vw_OFSAC_Prdgrp_Master)a
where CRM_Sales_Review_Deck.dpst=a.dpst
and CRM_Sales_Review_Deck.item=ltrim(rtrim(a.itemcode))

update CRM_Sales_Review_Deck set CRM_Unit_Acc ='ACCESSORIES' where CRM_Productgroup like '%Accessories%'
and dpst in (select distinct dpst from vw_OFSAC_Prdgrp_Master)
and CRM_Unit_Acc is null

--select CRM_Productgroup,CRM_Unit_Acc, from CRM_Sales_Review_Deck where 
--dpst in (select distinct dpst from vw_OFSAC_Prdgrp_Master)
--and CRM_Unit_Acc is null
--and CRM_Productgroup like '%Accessories%'



--Since this productcategory is not available for LN, updating it based on Itemcode and DPSTCODE
update CRM_Sales_Review_Deck set CRM_Productgroup=a.CRM_Productgroup
from (select distinct dpst,item,CRM_Productgroup from CRM_Sales_Review_Deck where CRM_Productgroup is not null)a
where CRM_Sales_Review_Deck.dpst=a.dpst
and CRM_Sales_Review_Deck.item=a.item


--Since there are alternate itemcodes updated while generating AO, Based on Item mapping Master 
--from Intranet Team updating, the product group for rest of the Sales Items.


--Alter table CRM_Sales_Review_Deck add CRM_TPL nvarchar(50)
update CRM_Sales_Review_Deck set CRM_TPL=  a.tplcode
from (
select * from
(select distinct dpst,item,CRM_Productgroup from CRM_Sales_Review_Deck where CRM_Productgroup is null)a
left outer join [ELGi_Intranet].dbo.Domestic_UTNDetails_Mapping b
on ltrim(rtrim(a.item))=ltrim(rtrim(b.equal_tpl))
where b.tplcode is not null
)a  
where ltrim(rtrim(CRM_Sales_Review_Deck.item))=ltrim(rtrim(a.equal_tpl))

update CRM_Sales_Review_Deck set CRM_Productgroup=a.CRM_Productgroup
from (select distinct dpst,item,CRM_Productgroup from CRM_Sales_Review_Deck where CRM_Productgroup is not null)a
where CRM_Sales_Review_Deck.dpst=a.dpst
and ltrim(rtrim(CRM_Sales_Review_Deck.CRM_TPL))=ltrim(rtrim(a.item))
and CRM_Sales_Review_Deck.CRM_Productgroup is null


update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='a.Productgroup Update'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('b.CRM_Division Update',getdate())



--select  from CRM_Sales_Review_Deck where CRM_TPL is not null


----User wants the Visit Transactions should not have the product category eventhough it succeeds to Order Won.
--update CRM_Sales_Review_Deck set CRM_Productgroup=null
--where remarks='Visits'

--select distinct remarks,opportunityid,Enquiryid,productid,item,CRM_PRODUCTGROUP from CRM_Sales_Review_Deck
--where item is not null
--and CRM_PRODUCTGROUP is not null
--and item='000200040'
--order by item

--select distinct opportunityid,elgi_itemcode,elgi_productcategoryname, from CRM_Engineer 
--where opportunityid=''--'D372E5D8-46CA-E911-A811-000D3AF2F5FA' 
----elgi_productcategoryname is not null
--and elgi_itemcode='000200040'




update CRM_Sales_Review_Deck set CRM_AssemblyLine='SEPSAC' where dpst='90008'
update CRM_Sales_Review_Deck set CRM_AssemblyLine='ENCAP' where dpst='90016'
update CRM_Sales_Review_Deck set CRM_AssemblyLine='SEPSAC' where dpst='90020'
update CRM_Sales_Review_Deck set CRM_AssemblyLine='LEPSAC' where dpst='90022'
update CRM_Sales_Review_Deck set CRM_AssemblyLine='SEPSAC NSD' where dpst='90093'


--Alter table systemuser_CRM  alter column systemuserid nvarchar(255)
--Truncate table systemuser_CRM 

--Method 1 As Discussed in CRM Status Review Meeting on 16-Dec-2021 --Commented on 12-Jul-2022
--update CRM_Sales_Review_Deck set CRM_Division=a.elgi_businessverticalname
--from (select distinct systemuserid,elgi_businessverticalname 
--from systemuser_CRM 
--where elgi_businessverticalname is not null) a
--where CRM_Sales_Review_Deck.ownerid=a.systemuserid

--Method 2 as per initial requirement discussion --Commented on 5-Oct-2022
update CRM_Sales_Review_Deck set CRM_Division='Direct' where dpst='90008' --and CRM_Division is null
update CRM_Sales_Review_Deck set CRM_Division='Channel' where dpst='90016' --and CRM_Division is null
update CRM_Sales_Review_Deck set CRM_Division='Channel' where dpst='90020' --and CRM_Division is null
update CRM_Sales_Review_Deck set CRM_Division='Direct' where dpst='90022' --and CRM_Division is null
update CRM_Sales_Review_Deck set CRM_Division='Direct' where dpst='90093' --and CRM_Division is null

--Method 3 as per the discussion held on status review meeting (18-Nov-2021)  --Commented on 5-Oct-2022
update CRM_Sales_Review_Deck set CRM_Division=convert(varchar,a.Broad_Vertical)
from(select distinct * from DPST_Vertical_Mapping_Master)a
where CRM_Sales_Review_Deck.dpst=a.DPST
and CRM_Sales_Review_Deck.dpst is not null
--and CRM_Sales_Review_Deck.CRM_Division is null



--Method 5as per the discussion held on OFSAC review meeting (12-Jul-2022)

--OFSAC

update CRM_Sales_Review_Deck set CRM_division='OFSAC'
from(select distinct systemuserid,employeeid,fullname,a.businessunitid, 
b.name
from (select * from systemuser_CRM where employeeid not in ('-','--','___','NA','Nil','#'))  a
left outer join businessunit_CRM b
on a.businessunitid=b.businessunitid
where b.name like '%ofsac%'
)a
where crm_sales_review_deck.SalesRepCode=a.employeeid
--where CRM_Sales_Review_Deck.systemuserid=a.systemuserid
--and CRM_division is null

--WW
update CRM_Sales_Review_Deck set CRM_division='WW'
from(select distinct systemuserid,employeeid,fullname,a.businessunitid,b.name
from (select * from systemuser_CRM where employeeid not in ('-','--','___','NA','Nil','#'))  a
left outer join businessunit_CRM b
on a.businessunitid=b.businessunitid
where b.name like '%ww%'
)a
where crm_sales_review_deck.SalesRepCode=a.employeeid
--where CRM_Sales_Review_Deck.systemuserid=a.systemuserid
and CRM_division is null

update CRM_Sales_Review_Deck set CRM_division='WW'
from(select distinct systemuserid,employeeid,fullname,a.businessunitid,b.name
from (select * from systemuser_CRM where employeeid not in ('-','--','___','NA','Nil','#'))  a
left outer join businessunit_CRM b
on a.businessunitid=b.businessunitid
where b.name like '%water%'
)a
where crm_sales_review_deck.SalesRepCode=a.employeeid
--where CRM_Sales_Review_Deck.systemuserid=a.systemuserid
and CRM_division is null

--C&M
update CRM_Sales_Review_Deck set CRM_division='C&M'
from(select distinct systemuserid,employeeid,fullname,a.businessunitid,b.name 
from (select * from systemuser_CRM where employeeid not in ('-','--','___','NA','Nil','#'))  a
left outer join businessunit_CRM b
on a.businessunitid=b.businessunitid
where b.name like '%C&M%'
)a
where crm_sales_review_deck.SalesRepCode=a.employeeid
--where CRM_Sales_Review_Deck.systemuserid=a.systemuserid
and CRM_division is null



update CRM_Sales_Review_Deck set CRM_division='Channel'
from(select distinct systemuserid,employeeid,fullname,a.businessunitid,b.name 
from (select * from systemuser_CRM where employeeid not in ('-','--','___','NA','Nil','#'))  a
left outer join businessunit_CRM b
on a.businessunitid=b.businessunitid
where b.name like '%Channel%'
)a
where crm_sales_review_deck.SalesRepCode=a.employeeid
and CRM_Division is null --Method1
--and CRM_Division not in ('OFSAC') --Method2

update CRM_Sales_Review_Deck set CRM_division='Direct'
from(select distinct systemuserid,employeeid,fullname,a.businessunitid,b.name 
from (select * from systemuser_CRM where employeeid not in ('-','--','___','NA','Nil','#'))  a
left outer join businessunit_CRM b
on a.businessunitid=b.businessunitid
where b.name like '%Direct%'
)a
where crm_sales_review_deck.SalesRepCode=a.employeeid
and CRM_Division is null --Method1
--and CRM_Division not in ('OFSAC') --Method2


update CRM_Sales_Review_Deck set CRM_division='Industrial'
from(select distinct systemuserid,employeeid,fullname,a.businessunitid,b.name 
from (select * from systemuser_CRM where employeeid not in ('-','--','___','NA','Nil','#'))  a
left outer join businessunit_CRM b
on a.businessunitid=b.businessunitid
where b.name like '%Industrial%'
)a
where crm_sales_review_deck.SalesRepCode=a.employeeid
and CRM_Division is null --Method1
--and CRM_Division not in ('OFSAC') --Method2



--Special Case
update CRM_Sales_Review_Deck set CRM_Division='Channel' where dealerengineername is not null and CRM_Division='Direct'
update CRM_Sales_Review_Deck set CRM_Division='Recip'
where dpst in ('90000','90010','90072','90074','90014') 


update CRM_Sales_Review_Deck set [Zone]='West' where CRM_Division in ('C&M','WW') and areaname like '%Bhopal%'
update CRM_Sales_Review_Deck set [Zone]='West' where CRM_Division in ('C&M','WW') and areaname like '%Nagpur%'



update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='b.CRM_Division Update'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('c.LOB_visitCategory Update',getdate())



----Account Number Uniformity update
--update CRM_Sales_Review_Deck set accountnumber=a.accountnumber
--from (select distinct accountnumber,dealername,CustCode,custname from  crm_sales_review_deck
--where custname is not null)a
--where ltrim(rtrim(CRM_Sales_Review_Deck.dealername))=ltrim(rtrim(a.dealername))
--and CRM_Sales_Review_Deck.accountnumber is null

update CRM_Sales_Review_Deck set LOBCode=a.elgi_name
from (select distinct a.accountnumber,b.elgi_name from Account_CRM a
left outer join (select distinct elgi_lineofbusinessid,elgi_name from elgi_lineofbusiness_CRM 
where len(elgi_name) <10)b
on a.elgi_lineofbusiness=b.elgi_lineofbusinessid
)a
where CRM_Sales_Review_Deck.accountnumber=a.accountnumber
and CRM_Sales_Review_Deck.LOBCode is null

update CRM_Sales_Review_Deck set LOBCode=null,Lineofbusiness=null
where CRM_Sales_Review_Deck.Remarks in ('Sales','Inflow_LN')

update CRM_Sales_Review_Deck set LOBCode=a.elgi_name
from (select distinct a.accountnumber,a.elgi_erpcustomercode,b.elgi_name from Account_CRM a 
left outer join (select distinct elgi_lineofbusinessid,elgi_name from elgi_lineofbusiness_CRM 
where len(elgi_name) <10)b
on a.elgi_lineofbusiness=b.elgi_lineofbusinessid
)a
where CRM_Sales_Review_Deck.CustCode=a.elgi_erpcustomercode
and CRM_Sales_Review_Deck.Remarks in ('Sales','Inflow_LN')


--Segment Uniformity Update
update CRM_Sales_Review_Deck set Lineofbusiness=a.LineOfBusiness
from(select distinct Remarks,LOBCode,LineOfBusiness from CRM_Sales_Review_Deck where LineOfBusiness is not null)a
where CRM_Sales_Review_Deck.LOBCode=a.LOBCode
and CRM_Sales_Review_Deck.LineOfBusiness is null

update CRM_Sales_Review_Deck set Lineofbusiness=a.LineOfBusiness
from (select distinct LOBCode,LineOfBusiness from [ELGi_LN].dbo.ELGi_Sales_Details)a
where CRM_Sales_Review_Deck.LOBCode=a.LOBCode
and CRM_Sales_Review_Deck.LineOfBusiness is null

--District Uniformity Update
update CRM_Sales_Review_Deck set district=a.district,DistrictCategory=a.DistrictCategory
from(select distinct CustCode,district,DistrictCategory from CRM_Sales_Review_Deck where district is not null)a
where CRM_Sales_Review_Deck.CustCode=a.CustCode
and CRM_Sales_Review_Deck.district is null

--CustomerClassification Uniformity Update
update CRM_Sales_Review_Deck set customerclassification=a.customerclassification
from (select distinct custname,custcode,customerclassification,Remarks from crm_sales_review_deck
where customerclassification is not null
)a
where ltrim(rtrim(isnull(CRM_Sales_Review_Deck.custcode,'0')))=ltrim(rtrim(isnull(a.custcode,'0')))
and CRM_Sales_Review_Deck.customerclassification is null


update CRM_Sales_Review_Deck set ZoneOrder=1 where Zone='North'
update CRM_Sales_Review_Deck set ZoneOrder=2 where Zone='East'
update CRM_Sales_Review_Deck set ZoneOrder=3 where Zone='West'
update CRM_Sales_Review_Deck set ZoneOrder=4 where Zone='South'

--delete from CRM_Sales_Review_Deck where zone in ('OTHERS','Middle East','WestAfrica','S. Asia')
delete  from CRM_Sales_Review_Deck where zone is not null and Zone not in ('North','East','West','South')



update CRM_Sales_Review_Deck set customerclassification='ELGi Customers' where  customerclassification in 
('Multi Brand Last Purchase ELGi','Favoring ELGi','Dedicated ELGi Customer')

update CRM_Sales_Review_Deck set customerclassification='Competition Customers' where  customerclassification in 
('Not favoring ELGi','Multi Brand Last Purchase Competition','Dedicated ELGi Customer, Lost to Competition',
'Competiton Customer - Gives Enquiries','Competition Customer - Does Not give Enquiry')


update CRM_Sales_Review_Deck set customerclassification=a.elgi_customersourcename
from (select distinct accountnumber,elgi_customersourcename from Account_CRM  
where elgi_customersourcename in ('External Source','New Customer'))a
where CRM_Sales_Review_Deck.accountnumber=a.accountnumber


--Alter table CRM_Sales_Review_Deck add EnqCategory varchar(50)
update CRM_Sales_Review_Deck set visitstatus=a.visitstatus
from (select distinct visitid,visitstatus from CRM_Sales_Review_Deck)a
where CRM_Sales_Review_Deck.visitid=a.visitid
and CRM_Sales_Review_Deck.visitstatus is null


update CRM_Sales_Review_Deck set VisitCategory=a.VisitCategory
from vw_CRM_VisitCategory a
where CRM_Sales_Review_Deck.visitstatus=a.visitstatus



--update CRM_Sales_Review_Deck set VisitCategory='Productive' where VisitCategory='Other productive visits'
update CRM_Sales_Review_Deck set VisitCategory='Productive with Enquiries' where VisitCategory='Non-Productive'
and Enquiryid is not null
update CRM_Sales_Review_Deck set VisitCategory='Productive with Enquiries' where visitid is not null 
and Enquiryid is not null --and VisitCategory is null
update CRM_Sales_Review_Deck set VisitCategory='Productive with Enquiries' where VisitCategory='Other productive visits'
and enquiryid is not null

update CRM_Sales_Review_Deck set VisitCategory=a.VisitCategory
from (select distinct visitid,VisitCategory
from CRM_Sales_Review_Deck where VisitCategory='Productive with Enquiries')a
where CRM_Sales_Review_Deck.visitid=a.visitid
and CRM_Sales_Review_Deck.VisitCategory<>'Productive with Enquiries'

--select  from CRM_Sales_Review_Deck where visitid is not null and VisitCategory is null
--and Enquiryid is not null


update CRM_Sales_Review_Deck set EnqCategory ='From Visits'
where Enquiryid is not null and visitid is not null

update CRM_Sales_Review_Deck set EnqCategory ='Direct Enquiries'
where Enquiryid is not null and visitid is null


update CRM_Sales_Review_Deck set VisitCategoryorder=1 where VisitCategory='Productive with Enquiries'
update CRM_Sales_Review_Deck set VisitCategoryorder=2 where VisitCategory='Productive for future 12 months'
update CRM_Sales_Review_Deck set VisitCategoryorder=3 where VisitCategory='Other productive visits'
update CRM_Sales_Review_Deck set VisitCategoryorder=4 where VisitCategory='Non-Productive'
update CRM_Sales_Review_Deck set VisitCategoryorder=5 where VisitCategory is null


update CRM_Sales_Review_Deck set EnqCategoryorder=1 where EnqCategory='From Visits'
update CRM_Sales_Review_Deck set EnqCategoryorder=2 where EnqCategory='Direct Enquiries'
update CRM_Sales_Review_Deck set EnqCategoryorder=3 where EnqCategory is null

--update CRM_Sales_Review_Deck set EnquiryStatus='WIP' where EnquiryStatus='Open'
update CRM_Sales_Review_Deck set EnqStatusorder=1 where EnquiryStatus='Won'
update CRM_Sales_Review_Deck set EnqStatusorder=2 where EnquiryStatus='Lost'
update CRM_Sales_Review_Deck set EnqStatusorder=3 where EnquiryStatus='WIP'
update CRM_Sales_Review_Deck set EnqStatusorder=3 where EnquiryStatus='Active'
update CRM_Sales_Review_Deck set EnqStatusorder=4 where EnquiryStatus is null



update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='c.LOB_visitCategory Update'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('d.InflowDesc Update',getdate())

update CRM_Sales_Review_Deck set Inflow_Desc=null

update CRM_Sales_Review_Deck set Inflow_Desc=a.Quote_Name
from (select distinct Enquiryid,EnquiryStatus,Quote_Name from CRM_Sales_Review_Deck
where Quote_Name is not null
)a
where CRM_Sales_Review_Deck.Enquiryid=a.Enquiryid
and CRM_Sales_Review_Deck.Quote_Name=a.Quote_Name
and CRM_Sales_Review_Deck.EnquiryStatus='won'
and CRM_Sales_Review_Deck.Quote_Name is not null



update CRM_Sales_Review_Deck set Inflow_Desc=a.elgi_dealeroffername
from (select distinct Enquiryid,EnquiryStatus,elgi_dealeroffername from CRM_Sales_Review_Deck
where elgi_dealeroffername is not null 
--and elgi_dealeroffername='DO -183273'  --Testing
)a
where CRM_Sales_Review_Deck.Enquiryid=a.Enquiryid
and CRM_Sales_Review_Deck.EnquiryStatus='won'
and CRM_Sales_Review_Deck.elgi_dealeroffername=a.elgi_dealeroffername
and CRM_Sales_Review_Deck.elgi_dealeroffername is not null
and CRM_Sales_Review_Deck.Inflow_Desc is null

--Alter table crm_sales_review_deck add InflowFlag int

update CRM_Sales_Review_Deck set InflowFlag=1
from (select distinct opportunityid,Enquiryid,EnquiryStatus,Quote_Name,elgi_dealeroffername,Inflow_Desc from CRM_Sales_Review_Deck
where Inflow_Desc is not null
and EnquiryStatus='won'
)a
where CRM_Sales_Review_Deck.Enquiryid=a.Enquiryid
and CRM_Sales_Review_Deck.opportunityid=a.opportunityid
and CRM_Sales_Review_Deck.EnquiryStatus='won'

--Enquiry Status is WON but no data from Quote as well as DealerOffer
update CRM_Sales_Review_Deck set Inflow_Desc=a.Enquiryid
from (select distinct Enquiryid,EnquiryStatus,Quote_Name,elgi_dealeroffername,Inflow_Desc from CRM_Sales_Review_Deck
where --Inflow_Desc is not null and 
EnquiryStatus='won'
)a
where CRM_Sales_Review_Deck.Enquiryid=a.Enquiryid
and CRM_Sales_Review_Deck.EnquiryStatus='won'
and CRM_Sales_Review_Deck.InflowFlag is null

update CRM_Sales_Review_Deck set Inflow_Desc=Enquiryid
where CRM_Sales_Review_Deck.EnquiryStatus in ('WIP','Lost')
and CRM_Sales_Review_Deck.InflowFlag is null


update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='d.InflowDesc Update'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('e.CustomerDealer Update',getdate())



--update CRM_Sales_Review_Deck set CustName=a.custname1
--from vw_Business_Partner a
--where ltrim(rtrim(CRM_Sales_Review_Deck.CustCode))=ltrim(rtrim(a.custcode))

--Since for few transactions , customer -Dealer relationship is not matching with that of Account table data
update CRM_Sales_Review_Deck set DealerCode=a.elgi_erpcustomercode
from(select distinct name,elgi_dealername,elgi_erpcustomercode,elgi_accounttypename from Account_CRM 
--where elgi_erpcustomercode is not null
where elgi_accounttypename='Dealer'
--and name='E3E PNEUMATICS'
)a
where CRM_Sales_Review_Deck.DealerName=a.name

update CRM_Sales_Review_Deck set DealerCode=a.elgi_erpcustomercode
from (select distinct elgi_erpcustomercode from crm_dealer_master 
where elgi_accounttypename='Dealer')a
where convert(varchar,CRM_Sales_Review_Deck.custcode)=convert(varchar,a.elgi_erpcustomercode)
and CRM_Sales_Review_Deck.DealerCode is null


update CRM_Sales_Review_Deck set DealerCode=a.DealerCode
from (select distinct elgi_erpcustomercode ,dealercode from CRM_Units_Stage1  where dealercode is not null)a
where convert(varchar,CRM_Sales_Review_Deck.custcode)=convert(varchar,a.elgi_erpcustomercode)
and CRM_Sales_Review_Deck.DealerCode is null


update CRM_Sales_Review_Deck set DealerName=a.DealerName
from (select distinct DealerCode,DealerName from CRM_Sales_Review_Deck 
where DealerName is not null
and Dealercode is not null
and DealerName in (select name from CRM_Dealer_Master) --Additional condition to overwrite the wrong tagging of customer in place of dealer in crm 
)a
where CRM_Sales_Review_Deck.DealerCode=a.DealerCode
and CRM_Sales_Review_Deck.DealerName is null --Commented on 28-Nov-2022


--Since Dealername is wrongly updated with Branch Name for Some transactions in CRM (Eg ENQ-69090,ENQ-95269), 
--Reconciling the Dealername based on DealerCode

update CRM_Sales_Review_Deck set DealerName=a.name
from (select distinct elgi_erpcustomercode,name from crm_dealer_master 
where elgi_accounttypename='Dealer'
)a
where CRM_Sales_Review_Deck.DealerCode=a.elgi_erpcustomercode
and DealerName like '%ELGI%'



--Since erp customer code is not updated for few cases in CRM, the below update is commented
--update CRM_Sales_Review_Deck set CRM_Division='Channel' where DealerCode is not null
--and CRM_Division='Direct'


update CRM_Sales_Review_Deck set CRM_Division='Channel' where DealerName is not null and CRM_Division='Direct'


--Since for Sales Transactions , Dealer engineer name is not available , this logic is preferred

--old Method different names between LN and CRM while analyzing the consolidated data
--update CRM_Sales_Review_Deck set DealerName=a.CustName
--from (select distinct custcode,custname from CRM_Sales_Review_Deck where custcode is not null)a
--where convert(varchar,CRM_Sales_Review_Deck.DealerCode)=convert(varchar,a.CustCode)
--and CRM_Sales_Review_Deck.DealerName is null

--Commented on 4-Oct-2022
--update CRM_Sales_Review_Deck set DealerName=a.elgi_dealername
--from (select distinct elgi_erpcustomercode,elgi_dealername,name from CRM_Units_Stage1 
----where elgi_dealername is not null
--)a
--where convert(varchar(50),CRM_Sales_Review_Deck.DealerCode)=convert(varchar(50),a.elgi_erpcustomercode)



update CRM_Sales_Review_Deck set Salesrepname=ltrim(rtrim(a.fullname))
from (
select distinct convert(int,employeeid) employeeid,fullname from (
select distinct employeeid,fullname from systemuser_CRM  where employeeid is not null
and employeeid not in ('-','--','___','NA','Nil','#','N/A')
and employeeid not like '%@%'
)a)a
where CRM_Sales_Review_Deck.salesrepcode=a.employeeid


update CRM_Sales_Review_Deck set dpstname=a.DPSTName
from vw_DPST_MASTER a
where CRM_Sales_Review_Deck.dpst=a.DPSTcode

update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='e.CustomerDealer Update'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('f.Dates Update',getdate())


update CRM_Sales_Review_Deck set Monthname=substring(datename(mm,dateadd(mm,cal_Month,-1)),1,3)
update CRM_Sales_Review_Deck set Period=concat(Monthname,'-',substring(convert(varchar,cal_year),3,2))

update CRM_Sales_Review_Deck set Fin_Year=cal_year-1 where cal_Month<4
update CRM_Sales_Review_Deck set Fin_Year=cal_year where cal_Month>=4

update CRM_Sales_Review_Deck set Fin_Month=cal_Month+9 where cal_Month<4
update CRM_Sales_Review_Deck set Fin_Month=cal_Month-3 where cal_Month>=4

--delete from CRM_Sales_Review_Deck where Fin_Year is null

update CRM_Sales_Review_Deck set Fin_Year2=concat(convert(varchar,Fin_Year),'-',substring(convert(varchar,fin_year+1),3,2))

--Alter table CRM_Sales_Review_Deck alter column PeriodRnk varchar(10)

update CRM_Sales_Review_Deck set PeriodRnk=a.PeriodRnk
from (
select Fin_Year,Fin_Month,row_number() over(order by Fin_Year,Fin_Month) as PeriodRnk
--concat('M',row_number() over(order by Fin_Year,Fin_Month)) as PeriodRnk
from (select distinct Fin_Year,Fin_Month from  CRM_Sales_Review_Deck)a
)a
where CRM_Sales_Review_Deck.Fin_Year=a.Fin_Year
and CRM_Sales_Review_Deck.Fin_Month=a.Fin_Month


update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='f.Dates Update'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('g.Enq to OrderDays Update',getdate())

--Old Method
--update CRM_Sales_Review_Deck set Enq_to_Order_Days=datediff(dd,EnqDate,isnull(QuoteDate,OfferDate))
--where remarks like 'Inf%'

update CRM_Sales_Review_Deck set Enq_to_Order_Days=datediff(dd,EnqDate,coalesce(inflowdate,QuoteDate,OfferDate))


update CRM_Sales_Review_Deck set Enq_to_Order_Days=20 where Enq_to_Order_Days between 1 and 20
update CRM_Sales_Review_Deck set Enq_to_Order_Days=40 where Enq_to_Order_Days between 21 and 40
update CRM_Sales_Review_Deck set Enq_to_Order_Days=60 where Enq_to_Order_Days between 41 and 60
update CRM_Sales_Review_Deck set Enq_to_Order_Days=80 where Enq_to_Order_Days between 61 and 80
update CRM_Sales_Review_Deck set Enq_to_Order_Days=100 where Enq_to_Order_Days between 81 and 100
update CRM_Sales_Review_Deck set Enq_to_Order_Days=120 where Enq_to_Order_Days between 101 and 120
update CRM_Sales_Review_Deck set Enq_to_Order_Days=140 where Enq_to_Order_Days between 121 and 140
update CRM_Sales_Review_Deck set Enq_to_Order_Days=160 where Enq_to_Order_Days between 141 and 160
update CRM_Sales_Review_Deck set Enq_to_Order_Days=180 where Enq_to_Order_Days between 161 and 180
update CRM_Sales_Review_Deck set Enq_to_Order_Days=200 where Enq_to_Order_Days between 181 and 200
update CRM_Sales_Review_Deck set Enq_to_Order_Days=250 where Enq_to_Order_Days between 200 and 250
update CRM_Sales_Review_Deck set Enq_to_Order_Days=300 where Enq_to_Order_Days between 250 and 300
update CRM_Sales_Review_Deck set Enq_to_Order_Days=350 where Enq_to_Order_Days between 300 and 350
update CRM_Sales_Review_Deck set Enq_to_Order_Days=400 where Enq_to_Order_Days between 350 and 400
update CRM_Sales_Review_Deck set Enq_to_Order_Days=450 where Enq_to_Order_Days between 400 and 450
update CRM_Sales_Review_Deck set Enq_to_Order_Days=500 where Enq_to_Order_Days between 450 and 500
update CRM_Sales_Review_Deck set Enq_to_Order_Days=600 where Enq_to_Order_Days between 500 and 600
update CRM_Sales_Review_Deck set Enq_to_Order_Days=700 where Enq_to_Order_Days between 600 and 700
update CRM_Sales_Review_Deck set Enq_to_Order_Days=800 where Enq_to_Order_Days between 700 and 800
update CRM_Sales_Review_Deck set Enq_to_Order_Days=900 where Enq_to_Order_Days between 800 and 900
update CRM_Sales_Review_Deck set Enq_to_Order_Days=1000 where Enq_to_Order_Days between 900 and 1000
update CRM_Sales_Review_Deck set Enq_to_Order_Days=2000 where Enq_to_Order_Days > 1000


--Alter table CRM_Sales_Review_Deck add Enq_to_Order_Days_Order int

update CRM_Sales_Review_Deck set Enq_to_Order_Days_Order=0 where Enq_to_Order_Days=null
update CRM_Sales_Review_Deck set Enq_to_Order_Days_Order=1 where Enq_to_Order_Days=0
update CRM_Sales_Review_Deck set Enq_to_Order_Days_Order=2 where Enq_to_Order_Days=20
update CRM_Sales_Review_Deck set Enq_to_Order_Days_Order=3 where Enq_to_Order_Days=40
update CRM_Sales_Review_Deck set Enq_to_Order_Days_Order=4 where Enq_to_Order_Days=60
update CRM_Sales_Review_Deck set Enq_to_Order_Days_Order=5 where Enq_to_Order_Days=80
update CRM_Sales_Review_Deck set Enq_to_Order_Days_Order=6 where Enq_to_Order_Days=100
update CRM_Sales_Review_Deck set Enq_to_Order_Days_Order=7 where Enq_to_Order_Days=120
update CRM_Sales_Review_Deck set Enq_to_Order_Days_Order=8 where Enq_to_Order_Days=140
update CRM_Sales_Review_Deck set Enq_to_Order_Days_Order=9 where Enq_to_Order_Days=160
update CRM_Sales_Review_Deck set Enq_to_Order_Days_Order=10 where Enq_to_Order_Days=180
update CRM_Sales_Review_Deck set Enq_to_Order_Days_Order=11 where Enq_to_Order_Days=200
update CRM_Sales_Review_Deck set Enq_to_Order_Days_Order=12 where Enq_to_Order_Days=250
update CRM_Sales_Review_Deck set Enq_to_Order_Days_Order=13 where Enq_to_Order_Days=300
update CRM_Sales_Review_Deck set Enq_to_Order_Days_Order=14 where Enq_to_Order_Days=350
update CRM_Sales_Review_Deck set Enq_to_Order_Days_Order=15 where Enq_to_Order_Days=400
update CRM_Sales_Review_Deck set Enq_to_Order_Days_Order=16 where Enq_to_Order_Days=450
update CRM_Sales_Review_Deck set Enq_to_Order_Days_Order=17 where Enq_to_Order_Days=500
update CRM_Sales_Review_Deck set Enq_to_Order_Days_Order=18 where Enq_to_Order_Days=600
update CRM_Sales_Review_Deck set Enq_to_Order_Days_Order=19 where Enq_to_Order_Days=700
update CRM_Sales_Review_Deck set Enq_to_Order_Days_Order=20 where Enq_to_Order_Days=800
update CRM_Sales_Review_Deck set Enq_to_Order_Days_Order=21 where Enq_to_Order_Days=900
update CRM_Sales_Review_Deck set Enq_to_Order_Days_Order=21 where Enq_to_Order_Days=1000

update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='g.Enq to OrderDays Update'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('h.Visit_to_Enq_Days Update',getdate())


--Alter table CRM_Sales_Review_Deck add Visit_to_Enq_Days int
update CRM_Sales_Review_Deck set Visit_to_Enq_Days=datediff(dd,LatestVisitdate,EnqDate)
--where remarks like 'Enq%'

update CRM_Sales_Review_Deck set Visit_to_Enq_Days=20 where Visit_to_Enq_Days between 1 and 20
update CRM_Sales_Review_Deck set Visit_to_Enq_Days=40 where Visit_to_Enq_Days between 21 and 40
update CRM_Sales_Review_Deck set Visit_to_Enq_Days=60 where Visit_to_Enq_Days between 41 and 60
update CRM_Sales_Review_Deck set Visit_to_Enq_Days=80 where Visit_to_Enq_Days between 61 and 80
update CRM_Sales_Review_Deck set Visit_to_Enq_Days=100 where Visit_to_Enq_Days between 81 and 100
update CRM_Sales_Review_Deck set Visit_to_Enq_Days=120 where Visit_to_Enq_Days between 101 and 120
update CRM_Sales_Review_Deck set Visit_to_Enq_Days=140 where Visit_to_Enq_Days between 121 and 140
update CRM_Sales_Review_Deck set Visit_to_Enq_Days=160 where Visit_to_Enq_Days between 141 and 160
update CRM_Sales_Review_Deck set Visit_to_Enq_Days=180 where Visit_to_Enq_Days between 161 and 180
update CRM_Sales_Review_Deck set Visit_to_Enq_Days=200 where Visit_to_Enq_Days between 181 and 200
update CRM_Sales_Review_Deck set Visit_to_Enq_Days=250 where Visit_to_Enq_Days between 200 and 250
update CRM_Sales_Review_Deck set Visit_to_Enq_Days=300 where Visit_to_Enq_Days between 250 and 300
update CRM_Sales_Review_Deck set Visit_to_Enq_Days=350 where Visit_to_Enq_Days between 300 and 350
update CRM_Sales_Review_Deck set Visit_to_Enq_Days=400 where Visit_to_Enq_Days between 350 and 400
update CRM_Sales_Review_Deck set Visit_to_Enq_Days=450 where Visit_to_Enq_Days between 400 and 450
update CRM_Sales_Review_Deck set Visit_to_Enq_Days=500 where Visit_to_Enq_Days between 450 and 500
update CRM_Sales_Review_Deck set Visit_to_Enq_Days=600 where Visit_to_Enq_Days between 500 and 600
update CRM_Sales_Review_Deck set Visit_to_Enq_Days=700 where Visit_to_Enq_Days between 600 and 700
update CRM_Sales_Review_Deck set Visit_to_Enq_Days=800 where Visit_to_Enq_Days between 700 and 800
update CRM_Sales_Review_Deck set Visit_to_Enq_Days=900 where Visit_to_Enq_Days between 800 and 900
update CRM_Sales_Review_Deck set Visit_to_Enq_Days=1000 where Visit_to_Enq_Days between 900 and 1000
update CRM_Sales_Review_Deck set Visit_to_Enq_Days=2000 where Visit_to_Enq_Days > 1000

update CRM_Sales_Review_Deck set Running_12Months='True'
where PeriodRnk between (select max(periodrnk)-12 from(
select distinct periodrnk from CRM_Sales_Review_Deck
where Enquiryid is not null)a)
and
(select max(periodrnk) from(
select distinct periodrnk from CRM_Sales_Review_Deck
where Enquiryid is not null)a)


update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='h.Visit_to_Enq_Days Update'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('i.productcategory Update',getdate())


--update CRM_Sales_Review_Deck set WeekNo=datepart(wk,getdate()-1)-datepart(wk,dateadd(mm,-1,eomonth(getdate()-1)))+1

update CRM_Sales_Review_Deck set SalesReptype='Engineer' where len(salesrepcode)>3


--alter table CRM_Sales_Review_Deck add elgi_productsubgroupname nvarchar(100)


update CRM_Sales_Review_Deck set elgi_productsubgroupname=a.elgi_segmentname
from(
select distinct elgi_productsubgroupid,a.elgi_name as elgi_productsubgroupname,
elgi_productsubgroup as elgi_segment,b.elgi_name as elgi_segmentname,
c.elgi_lineofbusinessid,c.elgi_name as elgi_LOBCode
from elgi_productsubgroup_CRM a
left outer join elgi_segmentgroup_CRM b
on a.elgi_productsubgroupid=b.elgi_productsubgroup
left outer join elgi_lineofbusiness_CRM c
on b.elgi_segment=c.elgi_lineofbusinessid 
)a
where CRM_Sales_Review_Deck.CRM_Division=a.elgi_productsubgroupname
and CRM_Sales_Review_Deck.LOBCode=a.elgi_LOBCode

--Alter table CRM_Sales_Review_Deck add CRM_ProductgroupCategory nvarchar(100)

update CRM_Sales_Review_Deck set CRM_ProductgroupCategory=a.CRM_ProductgroupCategory
from (select distinct a.elgi_name as elgi_productcategoryname,
b.elgi_name as CRM_ProductgroupCategory from elgi_productcategory_CRM a
left outer join elgi_segmentgroup_CRM b
on a.elgi_categoryid=b.elgi_productcategory
)a
where CRM_Sales_Review_Deck.CRM_Productgroup=a.elgi_productcategoryname

--update crm_sales_review_deck set salesrepname=a.salesrepname
--from (select  from (
--select ,row_number() over(partition by salesrepcode order by salesrepname ) as Rnk from 
--(select distinct salesrepcode,salesrepname from crm_sales_review_deck
--where salesrepcode is not null and SalesRepCode' '
--)a
--)b
--where rnk=1)a
--where crm_sales_review_deck.SalesRepCode=a.SalesRepCode

--update crm_sales_review_deck set salesrepname=a.emp_name
--from Employee_Details a
--where crm_sales_review_deck.salesrepcode= a.emp_code


update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='i.productcategory Update'
update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='Master Data load'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('Hierarchy Data load',getdate())


--End Master Data----------------------------

---Employee Hierarchy

delete from employee_hierarchy2_CRM where employeeid='101765' and fullname= 'Soumen Dey Krishna Pada Dey'
delete from employee_hierarchy2_CRM where employeeid='101476' and p_employeeid='102089'
delete from employee_hierarchy2_CRM where employeeid='102592' and internalemailaddress<>'sharma.gajanand@elgi.com'
--delete from Employee_Hierarchy2 where internalemailaddress in ('vikram@elgi.com','sankarasubbu@elgi.com')


update crm_sales_review_deck set 
L1_POSNAME=a.L1_POSNAME,L1_EMPID=a.L1_EMPID,L1_EMPNAME=a.L1_EMPNAME,L1_EMAIL=a.L1_EMAIL,
L2_POSNAME=a.L2_POSNAME,L2_EMPID=a.L2_EMPID,L2_EMPNAME=a.L2_EMPNAME,L2_EMAIL=a.L2_EMAIL,
L3_POSNAME=a.L3_POSNAME,L3_EMPID=a.L3_EMPID,L3_EMPNAME=a.L3_EMPNAME,L3_EMAIL=a.L3_EMAIL,
L4_POSNAME=a.L4_POSNAME,L4_EMPID=a.L4_EMPID,L4_EMPNAME=a.L4_EMPNAME,L4_EMAIL=a.L4_EMAIL,
L5_POSNAME=a.L5_POSNAME,L5_EMPID=a.L5_EMPID,L5_EMPNAME=a.L5_EMPNAME,L5_EMAIL=a.L5_EMAIL,
L6_POSNAME=a.L6_POSNAME,L6_EMPID=a.L6_EMPID,L6_EMPNAME=a.L6_EMPNAME,L6_EMAIL=a.L6_EMAIL,
L7_POSNAME=a.L7_POSNAME,L7_EMPID=a.L7_EMPID,L7_EMPNAME=a.L7_EMPNAME,L7_EMAIL=a.L7_EMAIL
from 
(select distinct L1_POSNAME,L1_EMPID,L1_EMPNAME,L1_EMAIL,
L2_POSNAME,L2_EMPID,L2_EMPNAME,L2_EMAIL,
L3_POSNAME,L3_EMPID,L3_EMPNAME,L3_EMAIL,
L4_POSNAME,L4_EMPID,L4_EMPNAME,L4_EMAIL,
L5_POSNAME,L5_EMPID,L5_EMPNAME,L5_EMAIL,
L6_POSNAME,L6_EMPID,L6_EMPNAME,L6_EMAIL,
L7_POSNAME,L7_EMPID,L7_EMPNAME,L7_EMAIL
from employee_hierarchy_CRM)a
where crm_sales_review_deck.salesrepcode=a.L7_EMPID



update crm_sales_review_deck set 
L1_POSNAME=a.L1_POSNAME,L1_EMPID=a.L1_EMPID,L1_EMPNAME=a.L1_EMPNAME,L1_EMAIL=a.L1_EMAIL,
L2_POSNAME=a.L2_POSNAME,L2_EMPID=a.L2_EMPID,L2_EMPNAME=a.L2_EMPNAME,L2_EMAIL=a.L2_EMAIL,
L3_POSNAME=a.L3_POSNAME,L3_EMPID=a.L3_EMPID,L3_EMPNAME=a.L3_EMPNAME,L3_EMAIL=a.L3_EMAIL,
L4_POSNAME=a.L4_POSNAME,L4_EMPID=a.L4_EMPID,L4_EMPNAME=a.L4_EMPNAME,L4_EMAIL=a.L4_EMAIL,
L5_POSNAME=a.L5_POSNAME,L5_EMPID=a.L5_EMPID,L5_EMPNAME=a.L5_EMPNAME,L5_EMAIL=a.L5_EMAIL,
L6_POSNAME=a.L6_POSNAME,L6_EMPID=a.L6_EMPID,L6_EMPNAME=a.L6_EMPNAME,L6_EMAIL=a.L6_EMAIL
from 
(select distinct L1_POSNAME,L1_EMPID,L1_EMPNAME,L1_EMAIL,
L2_POSNAME,L2_EMPID,L2_EMPNAME,L2_EMAIL,
L3_POSNAME,L3_EMPID,L3_EMPNAME,L3_EMAIL,
L4_POSNAME,L4_EMPID,L4_EMPNAME,L4_EMAIL,
L5_POSNAME,L5_EMPID,L5_EMPNAME,L5_EMAIL,
L6_POSNAME,L6_EMPID,L6_EMPNAME,L6_EMAIL
from employee_hierarchy_CRM)a
where crm_sales_review_deck.salesrepcode=a.L6_EMPID



update crm_sales_review_deck set 
L1_POSNAME=a.L1_POSNAME,L1_EMPID=a.L1_EMPID,L1_EMPNAME=a.L1_EMPNAME,L1_EMAIL=a.L1_EMAIL,
L2_POSNAME=a.L2_POSNAME,L2_EMPID=a.L2_EMPID,L2_EMPNAME=a.L2_EMPNAME,L2_EMAIL=a.L2_EMAIL,
L3_POSNAME=a.L3_POSNAME,L3_EMPID=a.L3_EMPID,L3_EMPNAME=a.L3_EMPNAME,L3_EMAIL=a.L3_EMAIL,
L4_POSNAME=a.L4_POSNAME,L4_EMPID=a.L4_EMPID,L4_EMPNAME=a.L4_EMPNAME,L4_EMAIL=a.L4_EMAIL,
L5_POSNAME=a.L5_POSNAME,L5_EMPID=a.L5_EMPID,L5_EMPNAME=a.L5_EMPNAME,L5_EMAIL=a.L5_EMAIL
from 
(select distinct L1_POSNAME,L1_EMPID,L1_EMPNAME,L1_EMAIL,
L2_POSNAME,L2_EMPID,L2_EMPNAME,L2_EMAIL,
L3_POSNAME,L3_EMPID,L3_EMPNAME,L3_EMAIL,
L4_POSNAME,L4_EMPID,L4_EMPNAME,L4_EMAIL,
L5_POSNAME,L5_EMPID,L5_EMPNAME,L5_EMAIL
from employee_hierarchy_CRM)a
where crm_sales_review_deck.salesrepcode=a.L5_EMPID


update crm_sales_review_deck set 
L1_POSNAME=a.L1_POSNAME,L1_EMPID=a.L1_EMPID,L1_EMPNAME=a.L1_EMPNAME,L1_EMAIL=a.L1_EMAIL,
L2_POSNAME=a.L2_POSNAME,L2_EMPID=a.L2_EMPID,L2_EMPNAME=a.L2_EMPNAME,L2_EMAIL=a.L2_EMAIL,
L3_POSNAME=a.L3_POSNAME,L3_EMPID=a.L3_EMPID,L3_EMPNAME=a.L3_EMPNAME,L3_EMAIL=a.L3_EMAIL,
L4_POSNAME=a.L4_POSNAME,L4_EMPID=a.L4_EMPID,L4_EMPNAME=a.L4_EMPNAME,L4_EMAIL=a.L4_EMAIL
from 
(select distinct L1_POSNAME,L1_EMPID,L1_EMPNAME,L1_EMAIL,
L2_POSNAME,L2_EMPID,L2_EMPNAME,L2_EMAIL,
L3_POSNAME,L3_EMPID,L3_EMPNAME,L3_EMAIL,
L4_POSNAME,L4_EMPID,L4_EMPNAME,L4_EMAIL
from employee_hierarchy_CRM)a
where crm_sales_review_deck.salesrepcode=a.L4_EMPID


update crm_sales_review_deck set 
L1_POSNAME=a.L1_POSNAME,L1_EMPID=a.L1_EMPID,L1_EMPNAME=a.L1_EMPNAME,L1_EMAIL=a.L1_EMAIL,
L2_POSNAME=a.L2_POSNAME,L2_EMPID=a.L2_EMPID,L2_EMPNAME=a.L2_EMPNAME,L2_EMAIL=a.L2_EMAIL,
L3_POSNAME=a.L3_POSNAME,L3_EMPID=a.L3_EMPID,L3_EMPNAME=a.L3_EMPNAME,L3_EMAIL=a.L3_EMAIL
from 
(select distinct L1_POSNAME,L1_EMPID,L1_EMPNAME,L1_EMAIL,
L2_POSNAME,L2_EMPID,L2_EMPNAME,L2_EMAIL,
L3_POSNAME,L3_EMPID,L3_EMPNAME,L3_EMAIL
from employee_hierarchy_CRM)a
where crm_sales_review_deck.salesrepcode=a.L3_EMPID


update crm_sales_review_deck set 
L1_POSNAME=a.L1_POSNAME,L1_EMPID=a.L1_EMPID,L1_EMPNAME=a.L1_EMPNAME,L1_EMAIL=a.L1_EMAIL,
L2_POSNAME=a.L2_POSNAME,L2_EMPID=a.L2_EMPID,L2_EMPNAME=a.L2_EMPNAME,L2_EMAIL=a.L2_EMAIL
from 
(select distinct L1_POSNAME,L1_EMPID,L1_EMPNAME,L1_EMAIL,
L2_POSNAME,L2_EMPID,L2_EMPNAME,L2_EMAIL
from employee_hierarchy_CRM)a
where crm_sales_review_deck.salesrepcode=a.L2_EMPID


update crm_sales_review_deck set 
L1_POSNAME=a.L1_POSNAME,L1_EMPID=a.L1_EMPID,L1_EMPNAME=a.L1_EMPNAME,L1_EMAIL=a.L1_EMAIL
from 
(select distinct L1_POSNAME,L1_EMPID,L1_EMPNAME,L1_EMAIL
from employee_hierarchy_CRM)a
where crm_sales_review_deck.salesrepcode=a.L1_EMPID



update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='Hierarchy Data load'
Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
('login access load',getdate())

---End Employee Hierarchy

--Alter table crm_sales_review_deck add systemuserid nvarchar(255)

--delete from employee_hierarchy_CRM2
--where employeeid='101765' and internalemailaddress='soumend@elgi.com' --Duplicate employee code 

--delete from employee_hierarchy_CRM2
--where internalemailaddress in ('yjsrakesh@elgi.com','krishnamoorthym@elgi.com')

update crm_sales_review_deck set systemuserid=a.systemuserid,level=a.level
from employee_hierarchy2_CRM a
where crm_sales_review_deck.SalesRepCode=a.employeeid



update crm_sales_review_deck set p_employeeid=a.p_employeeid
from (select * from employee_hierarchy2_CRM)a
where crm_sales_review_deck.SalesRepCode=a.employeeid

delete from CRM_Login_Access
insert into CRM_Login_Access 
--from (
select distinct internalemailaddress as p_internalemailaddress,internalemailaddress from employee_hierarchy2_CRM
--where p_internalemailaddress='sathishn@elgi.com'
--)a

--select  from CRM_Login_Access where internalemailaddress='ramesh.ponnuswami@elgi.com'
--select  from CRM_Login_Access where internalemailaddress like 'alagappan%'

insert into CRM_Login_Access values
('vasanthk@elgi.com','ramesh.ponnuswami@elgi.com')
--('muthamilselvan@elgi.com','ramesh.ponnuswami@elgi.com'),
--('raguraman.vivekanandhan@elgi.com','ramesh.ponnuswami@elgi.com')



--delete from CRM_Login_Access where internalemailaddress in
--('vikram@elgi.com','sankarasubbu@elgi.com','krishnamoorthym@elgi.com')

--insert into CRM_Login_Access values
--('krishnamoorthym@elgi.com','krishnamoorthym@elgi.com')



--insert into employee_hierarchy_CRM2
--select employeeid,fullname,level,internalemailaddress,parentsystemuserid,systemuserid,
--101742  as p_employeeid,'Vasanth kumar' as p_fullname,1 as p_level,'vasanthk@elgi.com' as p_internalemailaddress 
--from employee_hierarchy_CRM2
----where employeeid='200323' --ramesh.ponnuswami@elgi.com
----where employeeid='101065' --sajishk@elgi.com


update CRM_Sales_Review_Deck_Log set EndTime=getdate() where Remarks='login access load'
--Insert into CRM_Sales_Review_Deck_Log(Remarks,StartTime) values
--('login access load',getdate())

-- Deleting the Enquiries with Won Status but contains no Quotes Dealer Offers
delete from CRM_Sales_Review_Deck
where enquiryid in (
select Enquiryid
--,count(distinct Remarks)
----Inflow_Desc 
from CRM_Sales_Review_Deck
where EnquiryStatus='Won'
--and enquiryid='ENQ-100003'
group by Enquiryid--,EnquiryStatus
having count(distinct Remarks)=1
)


update CRM_Sales_Review_Deck set CRM_Unit_Acc=a.Units_Acc
from (select distinct elgi_productcategoryname,Units_Acc from CRM_Units_Acc_Master)a
where CRM_Sales_Review_Deck.CRM_Productgroup=a.elgi_productcategoryname
and CRM_Division not in ('OFSAC')


update CRM_Sales_Review_Deck set CRM_Unit_Acc=a.elgi_unitaccessoriesname 
from (select distinct b.elgi_name as elgi_salesofficename,elgi_itemcode,elgi_unitaccessoriesname
from elgi_dealerpricelistmaster_CRM a
left outer join elgi_salesoffices_CRM b
on a.elgi_salesoffice=b.elgi_salesofficesid
--where elgi_unitaccessoriesname is not null  
)a
where CRM_Sales_Review_Deck.dpstname=a.elgi_salesofficename
and ltrim(rtrim(CRM_Sales_Review_Deck.item))=ltrim(rtrim(a.elgi_itemcode))
and CRM_Division not in ('OFSAC')
and CRM_Unit_Acc is null

-- Qty of the accessories items not to be considered for BudAct Analysis.
update CRM_Sales_Review_Deck set DeliveryQty=null,InflowQty=null,EnquiryQty=null,inflowqty_LN=null
where CRM_Unit_Acc<>'UNITS'

--Declare @Finyear int=(select max(Fin_Year)-1 from CRM_Sales_Review_Deck where cal_year=year(getdate()-1))
--select @Finyear

delete from CRM_Sales_Review_Deck where cal_year>year(getdate()-1)+1


delete from CRM_Sales_Review_Deck_History where Fin_Year>=@Finyear
insert into CRM_Sales_Review_Deck_History
select * from CRM_Sales_Review_Deck where Fin_Year>=@Finyear



end

--select Remarks,Fin_Year,* from CRM_Sales_Review_Deck 
--where Fin_Year=(select max(Fin_Year) from CRM_Sales_Review_Deck)
--where cal_year>year(getdate()-1)+1
--order by cal_year,cal_month

--and fin_year=2023

GO

