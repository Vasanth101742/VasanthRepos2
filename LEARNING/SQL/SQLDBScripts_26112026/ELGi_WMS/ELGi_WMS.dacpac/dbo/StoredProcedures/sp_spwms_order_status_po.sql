
--   exec sp_spwms_order_status_po
CREATE proc [dbo].[sp_spwms_order_status_po]
as
begin

--alter table header_po add parentitem varchar(100)
--alter table header_po add item_desc varchar(100)
--alter table header_po add qty float

--alter table line_po add parentitem varchar(100)
--alter table line_po add pitem_desc varchar(100)
--alter table line_po add parentqty float
--alter table line_po add item_desc varchar(100)
--alter table line_po add orderdate date


--alter table HEADER_po add VERTICAL varchar(100)
--alter table line_po add VERTICAL varchar(100)

truncate table LN_ORDER_STATUS
truncate table header_po
truncate table line_po

--Alter table header_po add hpkcompldate date

insert into header_po(ADDDATE,ADDWHO,EDITDATE,STATUS,ORDERKEY,SERIALKEY,WHSEID,
STORERKEY,EXTERNORDERKEY,ORDERDATE,DELIVERYDATE,PRIORITY,CONSIGNEEKEY,
C_CONTACT1,C_CONTACT2,C_COMPANY,C_ADDRESS1,C_ADDRESS2,C_ADDRESS3,C_ADDRESS4,
C_CITY,C_STATE,C_ZIP,C_COUNTRY,C_ISOCNTRYCODE,C_PHONE1,C_PHONE2,C_FAX1,
C_FAX2,C_VAT,BUYERPO,BILLTOKEY,B_CONTACT1,B_CONTACT2,B_COMPANY,B_ADDRESS1,
B_ADDRESS2,B_ADDRESS3,B_ADDRESS4,B_CITY,B_STATE,B_ZIP,B_COUNTRY,B_ISOCNTRYCODE,
B_PHONE1,B_PHONE2,B_FAX1,B_FAX2,B_VAT,INCOTERM,PMTTERM,DOOR,SORTATIONLOCATION,
BATCHFLAG,BULKCARTONGROUP,ROUTE,STOP,OPENQTY,DISCHARGEPLACE,DELIVERYPLACE,
INTERMODALVEHICLE,COUNTRYOFORIGIN,COUNTRYDESTINATION,UPDATESOURCE,TYPE,
ORDERGROUP,EFFECTIVEDATE,STAGE,DC_ID,WHSE_ID,SPLIT_ORDERS,APPT_STATUS,
CHEPPALLETINDICATOR,CONTAINERTYPE,CONTAINERQTY,BILLEDCONTAINERQTY,
TRANSPORTATIONMODE,TRANSPORTATIONSERVICE,EXTERNALORDERKEY2,C_EMAIL1,
C_EMAIL2,SUSR1,SUSR2,SUSR3,SUSR4,SUSR5,NOTES2,ITEM_NUMBER,FORTE_FLAG,
LOADID,SHIPTOGETHER,DELIVERYDATE2,REQUESTEDSHIPDATE,ACTUALSHIPDATE,
DELIVER_DATE,ORDERVALUE,OHTYPE,EXTERNALLOADID,DESTINATIONNESTID,
REFERENCENUM,INTRANSITKEY,RECEIPTKEY,CaseLabelType,LABELNAME,
STDSSCCLABELNAME,STDGTINLABELNAME,RFIDSSCCLABELNAME,RFIDGTINLABELNAME,
RFIDFLAG,CarrierCode,CarrierName,CarrierAddress1,CarrierAddress2,
CarrierCity,CarrierState,CarrierZip,CarrierCountry,CarrierPhone,
DriverName,TrailerNumber,TrailerOwner,TrailerType,DepDateTime,
ORDERBREAK,ALLOCATEDONERP,TRADINGPARTNER,PRONUMBER,ENABLEPACKING,
PACKINGLOCATION,ORDERSID,SUSPENDEDINDICATOR,PICKLISTREPORTID,
PACKINGLISTREPORTID,SOURCEVERSION,REFERENCETYPE,REFERENCEDOCUMENT,
REFERENCELOCATION,REFERENCEVERSION,FREIGHTCHARGEAMOUNT,FREIGHTCOSTAMOUNT,APPOINTMENTKEY,
AllowOverPick,TOTALQTY,TOTALGROSSWGT,TOTALCUBE,TOTALORDERLINES,ReferenceAccountingEntity,
POKEY,APPORTION,CONTAINERID,PROMISEDSHIPDATE,PLANNEDSHIPDATE,SCHEDULEDSHIPDATE,PROMISEDDELVDATE,
PLANNEDDELVDATE,SCHEDULEDDELVDATE,ACTUALDELVDATE,EARLIESTSHIPDATE,EARLIESTDELIVERYDATE,CARRIERROUTEDOCUMENT,
CARRIERROUTEACCOUNTINGENTITY,CARRIERROUTELOCATION,CARRIERROUTEVERSION,TMHOUSEAIRWAYBILLNUMBER,
TMMASTERAIRWAYBILLNUMBER,TMBOOKINGNUMBER,TMHOUSEOCEANBOLNUMBER,TMMASTEROCEANBOLNUMBER,
TMEQUIPMENTNUMBER,TMSEALNUMBER,TMLICENSEPLATENUMBER,TMEQUIPMENTTYPE,TMEQUIPMENTLENGTH,
TMEQUIPMENTATTRIBUTE,TMAIRSERVICELEVEL,TMOCEANSERVICELEVEL,TMOCEANTARIFFSERVICE,TMPORTOFLOADING,
TMPORTOFDISCHARGE,TMROUTEDVIA,TMSERVICEATTRIBUTE,TMFREIGHTCOSTCURRENCY,TMFREIGHTCHARGECURRENCY,
ACTUALARRIVALDATE,C_ADDRESS5,C_ADDRESS6,B_ADDRESS5,B_ADDRESS6,RETURNTOPARTY,TRAILERKEY,CARRIERROUTESTATUS,
SPLITSHIPMENTINDICATOR,SPLITSHIPMENTORIGINALORDERKEY,SPLITSHIPMENTFINALSHIPMENT,BODAPPLICATIONAREA,FREIGHTCOSTBASEAMOUNT,
FREIGHTCHARGEBASEAMOUNT,PACKINGVALTEMPLATE,PACKNOTES,TOTALROUTES,AUTODOORASSIGNED,AUTOSTAGEASSIGNED,AUTOPACKASSIGNED,
AUTODOCKASSIGNEDHOW,AUTODOCKASSIGNEDSET,AUTODOCKASSIGNEDSTEP,AUTODOCKASSIGNTIME,TOTALPALLETESTIMATE,REQUIREORDERCLOSE,
NOTES,SPSAPISTRATEGYKEY,BOLNUMBER,BOLPRINTED,SHIPTOGROUP,HOSTPROCESSREQUIRED,BATCHORDERNUMBER,
--RFPICKER,ORDERPICKTIME,ORDERCOST,PACKSTATUS,BDIORDER,hpkcompldate,              --Commeneted by Ravi
responsibility,status_desc,complete_Date,closing_date,lnordstatus,parentitem,item_desc,qty,VERTICAL)
select ADDDATE,ADDWHO,EDITDATE,STATUS,ORDERKEY,SERIALKEY,WHSEID,
STORERKEY,EXTERNORDERKEY,ORDERDATE,DELIVERYDATE,PRIORITY,CONSIGNEEKEY,
C_CONTACT1,C_CONTACT2,C_COMPANY,C_ADDRESS1,C_ADDRESS2,C_ADDRESS3,C_ADDRESS4,
C_CITY,C_STATE,C_ZIP,C_COUNTRY,C_ISOCNTRYCODE,C_PHONE1,C_PHONE2,C_FAX1,
C_FAX2,C_VAT,BUYERPO,BILLTOKEY,B_CONTACT1,B_CONTACT2,B_COMPANY,B_ADDRESS1,
B_ADDRESS2,B_ADDRESS3,B_ADDRESS4,B_CITY,B_STATE,B_ZIP,B_COUNTRY,B_ISOCNTRYCODE,
B_PHONE1,B_PHONE2,B_FAX1,B_FAX2,B_VAT,INCOTERM,PMTTERM,DOOR,SORTATIONLOCATION,
BATCHFLAG,BULKCARTONGROUP,ROUTE,STOP,OPENQTY,DISCHARGEPLACE,DELIVERYPLACE,
INTERMODALVEHICLE,COUNTRYOFORIGIN,COUNTRYDESTINATION,UPDATESOURCE,TYPE,
ORDERGROUP,EFFECTIVEDATE,STAGE,DC_ID,WHSE_ID,SPLIT_ORDERS,APPT_STATUS,
CHEPPALLETINDICATOR,CONTAINERTYPE,CONTAINERQTY,BILLEDCONTAINERQTY,
TRANSPORTATIONMODE,TRANSPORTATIONSERVICE,EXTERNALORDERKEY2,C_EMAIL1,
C_EMAIL2,SUSR1,SUSR2,SUSR3,SUSR4,SUSR5,NOTES2,ITEM_NUMBER,FORTE_FLAG,
LOADID,SHIPTOGETHER,DELIVERYDATE2,REQUESTEDSHIPDATE,ACTUALSHIPDATE,
DELIVER_DATE,ORDERVALUE,OHTYPE,EXTERNALLOADID,DESTINATIONNESTID,
REFERENCENUM,INTRANSITKEY,RECEIPTKEY,CaseLabelType,LABELNAME,
STDSSCCLABELNAME,STDGTINLABELNAME,RFIDSSCCLABELNAME,RFIDGTINLABELNAME,
RFIDFLAG,CarrierCode,CarrierName,CarrierAddress1,CarrierAddress2,
CarrierCity,CarrierState,CarrierZip,CarrierCountry,CarrierPhone,
DriverName,TrailerNumber,TrailerOwner,TrailerType,DepDateTime,
ORDERBREAK,ALLOCATEDONERP,TRADINGPARTNER,PRONUMBER,ENABLEPACKING,
PACKINGLOCATION,ORDERSID,SUSPENDEDINDICATOR,PICKLISTREPORTID,
PACKINGLISTREPORTID,SOURCEVERSION,REFERENCETYPE,REFERENCEDOCUMENT,
REFERENCELOCATION,REFERENCEVERSION,FREIGHTCHARGEAMOUNT,FREIGHTCOSTAMOUNT,APPOINTMENTKEY,
AllowOverPick,TOTALQTY,TOTALGROSSWGT,TOTALCUBE,TOTALORDERLINES,ReferenceAccountingEntity,
POKEY,APPORTION,CONTAINERID,PROMISEDSHIPDATE,PLANNEDSHIPDATE,SCHEDULEDSHIPDATE,PROMISEDDELVDATE,
PLANNEDDELVDATE,SCHEDULEDDELVDATE,ACTUALDELVDATE,EARLIESTSHIPDATE,EARLIESTDELIVERYDATE,CARRIERROUTEDOCUMENT,
CARRIERROUTEACCOUNTINGENTITY,CARRIERROUTELOCATION,CARRIERROUTEVERSION,TMHOUSEAIRWAYBILLNUMBER,
TMMASTERAIRWAYBILLNUMBER,TMBOOKINGNUMBER,TMHOUSEOCEANBOLNUMBER,TMMASTEROCEANBOLNUMBER,
TMEQUIPMENTNUMBER,TMSEALNUMBER,TMLICENSEPLATENUMBER,TMEQUIPMENTTYPE,TMEQUIPMENTLENGTH,
TMEQUIPMENTATTRIBUTE,TMAIRSERVICELEVEL,TMOCEANSERVICELEVEL,TMOCEANTARIFFSERVICE,TMPORTOFLOADING,
TMPORTOFDISCHARGE,TMROUTEDVIA,TMSERVICEATTRIBUTE,TMFREIGHTCOSTCURRENCY,TMFREIGHTCHARGECURRENCY,
ACTUALARRIVALDATE,C_ADDRESS5,C_ADDRESS6,B_ADDRESS5,B_ADDRESS6,RETURNTOPARTY,TRAILERKEY,CARRIERROUTESTATUS,
SPLITSHIPMENTINDICATOR,SPLITSHIPMENTORIGINALORDERKEY,SPLITSHIPMENTFINALSHIPMENT,BODAPPLICATIONAREA,FREIGHTCOSTBASEAMOUNT,
FREIGHTCHARGEBASEAMOUNT,PACKINGVALTEMPLATE,PACKNOTES,TOTALROUTES,AUTODOORASSIGNED,AUTOSTAGEASSIGNED,AUTOPACKASSIGNED,
AUTODOCKASSIGNEDHOW,AUTODOCKASSIGNEDSET,AUTODOCKASSIGNEDSTEP,AUTODOCKASSIGNTIME,TOTALPALLETESTIMATE,REQUIREORDERCLOSE,
NOTES,SPSAPISTRATEGYKEY,BOLNUMBER,BOLPRINTED,SHIPTOGROUP,HOSTPROCESSREQUIRED,BATCHORDERNUMBER,
--RFPICKER,ORDERPICKTIME,ORDERCOST,PACKSTATUS,BDIORDER,hpkcompldate,              -- Commeneted by Ravi
'','','','','','','',0,'NON RLY' from wmwhse1_ORDERS where referencetype ='ProductionOrder'

--Commeneted by Ravi

--insert into  line_po
----select *,'','','','','' from wmwhse1_ORDERDETAIL  where ORDERKEY in (select distinct ORDERKEY from header_po)
--select *,'','','','','','','',0,'','','NON RLY' from wmwhse1_ORDERDETAIL  where substring(referencedocument,3,40) in 
--(select distinct substring(referencedocument,3,40) from header_po)

--INSERT INTO  LN_ORDER_STATUS
--SELECT *  fROM (
--select 'LN Order Completion' AS NAME,'NON RLY'VERTICAL,0 AS FTD,0 AS MTD UNION ALL
--select 'LN Order Completion' AS NAME,'RLY'VERTICAL,0 AS FTD,0 AS MTD     UNION ALL
--select 'LN Order Closed' AS NAME,'NON RLY'VERTICAL,0 AS FTD,0 AS MTD UNION ALL
--select 'LN Order Closed' AS NAME,'RLY'VERTICAL,0 AS FTD,0 AS MTD)A

--Commeneted by Ravi

update  header_po set status_desc= 'Created Externally' where status=02
update  header_po set status_desc='Did Not allocated' where status=06
update  header_po set status_desc='Not Started' where status=09
update  header_po set status_desc='Part allocated' where status=14
update  header_po set status_desc='Allocated' where status=17
update  header_po set status_desc='Part released' where status=22
update  header_po set status_desc='Released' where status=29
update  header_po set status_desc='Part Picked' where status=52
update  header_po set status_desc='Picked Complete'where status=55
update  header_po set status_desc='Pack Complete' where status=68
update  header_po set status_desc='Part Shipped'where status=92
update  header_po set status_desc='Shipped complete'where status=95


--Commeneted by Ravi

--update  line_po set status_desc= 'Created Externally' where status=02
--update  line_po set status_desc='Did Not allocated' where status=06
--update  line_po set status_desc='Not Started' where status=09
--update  line_po set status_desc='Part allocated' where status=14
--update  line_po set status_desc='Allocated' where status=17
--update  line_po set status_desc='Part released' where status=22
--update  line_po set status_desc='Released' where status=29
--update  line_po set status_desc='Part Picked' where status=52
--update  line_po set status_desc='Picked Complete'where status=55
--update  line_po set status_desc='Pack Complete' where status=68
--update  line_po set status_desc='Part Shipped'where status=92
--update  line_po set status_desc='Shipped complete'where status=95

--Commeneted by Ravi

update header_po set responsibility='Planning' where status in (02,06,09,14,17)
update header_po set responsibility='Stores' where status in (22,29,52,55,68,92)
update header_po set responsibility='LN VS WMS' where status in (95)
update header_po set complete_Date=a.CMDT from (select distinct pdno,CMDT From TTISFC001490 )a
where a.PDNO =substring(header_po.referencedocument,3,40)
update header_po set closing_date=a.CLDT from (select distinct pdno,CLDT From TTISFC001490 )a
where a.PDNO =substring(header_po.referencedocument,3,40)

--Commeneted by Ravi

--update line_po set responsibility='Planning' where status in (02,06,09,14,17)
--update line_po set responsibility='Stores' where status in (22,29,52,55,68,92)
--update line_po set responsibility='LN VS WMS' where status in (95)
--update line_po set complete_Date=a.CMDT from (select distinct pdno,CMDT From TTISFC001490 )a
--where a.PDNO =substring(line_po.referencedocument,3,40)
--update line_po set closing_date=a.CLDT from (select distinct pdno,CLDT From TTISFC001490 )a
--where a.PDNO =substring(line_po.referencedocument,3,40)

--Commeneted by Ravi

update header_po set lnordstatus=a.stat from (
select distinct pdno,osta,
		case when osta=1 then 'Planned' when osta=2 then 'Scheduled' when osta=3 then 'Documents Printed'
			when osta=4 then 'Released'when osta=6 then 'Active'when osta=7 then 'TO be Completed'
			when osta=8 then 'Completed'when osta=9 then 'Closed'when osta=10 then 'Archived' end as stat from TTISFC001490 )a
			where substring(header_po.referencedocument,3,40)=a.PDNO 

			--Commeneted by Ravi

--			update line_po set lnordstatus=a.stat from (
--select distinct pdno,osta,
--		case when osta=1 then 'Planned' when osta=2 then 'Scheduled' when osta=3 then 'Documents Printed'
--			when osta=4 then 'Released'when osta=6 then 'Active'when osta=7 then 'TO be Completed'
--			when osta=8 then 'Completed'when osta=9 then 'Closed'when osta=10 then 'Archived' end as stat from TTISFC001490 )a
--			where substring(line_po.referencedocument,3,40)=a.PDNO 
	
	--Commeneted by Ravi

		update header_po set parentitem =a.item from(select PDNO,ltrim(rtrim(mitm))as item from TTISFC001490)a
				where substring(header_po.referencedocument,3,40)=a.PDNO 

					update header_po set item_desc =a.item_desc 
					from(select ltrim(rtrim(item))as item,item_desc from [elgi_ln].dbo.vw_item_master where  company=490)a
				where parentitem=a.item 

				update header_po set qty =a.QNTL from(select PDNO,QNTL from TTISFC001490 where QNTL not like '%:%')a
				where substring(header_po.referencedocument,3,40)=a.PDNO

				--Commeneted by Ravi

				--	update line_po set parentitem =a.item from(select PDNO,ltrim(rtrim(mitm))as item from TTISFC001490)a
				--where substring(line_po.referencedocument,3,40)=a.PDNO 

				--	update line_po set pitem_desc =a.item_desc 
				--	from(select ltrim(rtrim(item))as item,item_desc from [elgi_ln].dbo.vw_item_master where  company=490)a
				--where parentitem=a.item 

				--		update line_po set item_desc =a.item_desc 
				--	from(select ltrim(rtrim(item))as item,item_desc from [elgi_ln].dbo.vw_item_master where  company=490)a
				--where ltrim(rtrim(sku))=a.item 

				--update line_po set parentqty =a.QNTL from(select PDNO,QNTL from TTISFC001490 where QNTL not like '%:%')a
				--where substring(line_po.referencedocument,3,40)=a.PDNO

				--	update line_po set orderdate =a.orderdate 
				--	from(select substring(referencedocument,3,40) pono,min(ORDERDATE)orderdate from header_po group by substring(referencedocument,3,40))a
				--where substring(line_po.referencedocument,3,40)=a.pono

				--Commeneted by Ravi

				UPDATE header_po SET VERTICAL='RLY' WHERE substring(referencedocument,3,40)LIKE '9%'
				--UPDATE line_po SET VERTICAL='RLY' WHERE substring(referencedocument,3,40)LIKE '9%'

				--Commeneted by Ravi

--				UPDATE LN_ORDER_STATUS SET FTD= (SELECT count(distinct  substring(referencedocument,3,40)) FROM line_po 
--where convert(date,complete_Date)=convert(date,getdate()) AND VERTICAL='NON RLY')
--WHERE LN_ORDER_STATUS.NAME='LN Order Completion' AND LN_ORDER_STATUS.VERTICAL='NON RLY'

--UPDATE LN_ORDER_STATUS SET FTD= (SELECT count(distinct  substring(referencedocument,3,40)) FROM line_po 
--where convert(date,complete_Date)=convert(date,getdate()) AND VERTICAL='RLY')
--WHERE LN_ORDER_STATUS.NAME='LN Order Completion' AND LN_ORDER_STATUS.VERTICAL='RLY'

--UPDATE LN_ORDER_STATUS SET MTD= (SELECT count(distinct  substring(referencedocument,3,40)) FROM line_po 
--where convert(date,complete_Date) BETWEEN  DATEADD(D,-DAY(GETDATE()-1),CONVERT(DATE,GETDATE())) AND convert(date,getdate())
-- AND VERTICAL='NON RLY')WHERE LN_ORDER_STATUS.NAME='LN Order Completion' AND LN_ORDER_STATUS.VERTICAL='NON RLY'

--UPDATE LN_ORDER_STATUS SET MTD= (SELECT count(distinct  substring(referencedocument,3,40)) FROM line_po 
--where convert(date,complete_Date) BETWEEN  DATEADD(D,-DAY(GETDATE()-1),CONVERT(DATE,GETDATE())) AND convert(date,getdate())
-- AND VERTICAL='RLY')WHERE LN_ORDER_STATUS.NAME='LN Order Completion' AND LN_ORDER_STATUS.VERTICAL='RLY'


--	UPDATE LN_ORDER_STATUS SET FTD= (SELECT count(distinct  substring(referencedocument,3,40)) FROM line_po 
--where convert(date,closing_date)=convert(date,getdate()) AND VERTICAL='NON RLY')
--WHERE LN_ORDER_STATUS.NAME='LN Order Closed' AND LN_ORDER_STATUS.VERTICAL='NON RLY'

--UPDATE LN_ORDER_STATUS SET FTD= (SELECT count(distinct  substring(referencedocument,3,40)) FROM line_po 
--where convert(date,closing_date)=convert(date,getdate()) AND VERTICAL='RLY')
--WHERE LN_ORDER_STATUS.NAME='LN Order Closed' AND LN_ORDER_STATUS.VERTICAL='RLY'

--UPDATE LN_ORDER_STATUS SET MTD= (SELECT count(distinct  substring(referencedocument,3,40)) FROM line_po 
--where convert(date,closing_date) BETWEEN  DATEADD(D,-DAY(GETDATE()-1),CONVERT(DATE,GETDATE())) AND convert(date,getdate())
-- AND VERTICAL='NON RLY')WHERE LN_ORDER_STATUS.NAME='LN Order Closed' AND LN_ORDER_STATUS.VERTICAL='NON RLY'

--UPDATE LN_ORDER_STATUS SET MTD= (SELECT count(distinct  substring(referencedocument,3,40)) FROM line_po 
--where convert(date,closing_date) BETWEEN  DATEADD(D,-DAY(GETDATE()-1),CONVERT(DATE,GETDATE())) AND convert(date,getdate())
-- AND VERTICAL='RLY')WHERE LN_ORDER_STATUS.NAME='LN Order Closed' AND LN_ORDER_STATUS.VERTICAL='RLY'

--Commeneted by Ravi

	end




--select * from TTISFC001490 

--select referencedocument from wmwhse1_ORDERS where referencetype ='ProductionOrder'

--pdno sfc001 status -- osta

GO

