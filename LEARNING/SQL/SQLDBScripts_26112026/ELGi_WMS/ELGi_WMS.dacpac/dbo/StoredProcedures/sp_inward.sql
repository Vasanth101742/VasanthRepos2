
-- exec sp_inward
CREATE proc [dbo].[sp_inward]
as
begin

truncate table Inward
truncate table qc_breakup
truncate table prepack_breakup
 
--truncate table Inward_ver1
--truncate table Inward_ver2



insert into Inward
select distinct *,'','','',0,0,0,'',0,0,0,'','','','','','No',0,0
--into Inward 
from wmwhse1_RECEIPTDETAIL where TYPE <>1 
and convert(date,ADDDATE)>='2020-12-01'  and  RECEIPTKEY>'1000000012' 
and RECEIPTKEY NOT IN ('1000008296',
'1000006831',
'1000006837',
'1000006834',
'1000006833',
'1000007816',
'1000006830',
'1000004530',
'1000005070',
'1000005076',
'1000008334',
'1000008098',
'1000007288',
'1000016483',
'1000023228',
'1000027775',
'1000023222',
'1000023755',
'1000030802',
'1000018485',
'1000001503',
'1000020614',
'1000018004'
)


update inward set SUPPLIERNAME=''

update inward set SUPPLIERNAME=a.SUPPLIERNAME,SUPPLIERCODE=a.SUPPLIERCODE,
PACKINGSLIPNUMBER=a.PACKINGSLIPNUMBER,SHIPFROMCITY=a.SHIPFROMCITY,SHIPFROMSTATE=a.SHIPFROMSTATE,REFERENCEDOCUMENT=a.REFERENCEDOCUMENT,
REFERENCETYPE=a.REFERENCETYPE
From(select SUPPLIERNAME,SUPPLIERCODE,PACKINGSLIPNUMBER,SHIPFROMCITY,SHIPFROMSTATE,REFERENCETYPE,REFERENCEDOCUMENT,RECEIPTKEY   From wmwhse1_RECEIPT )a
where inward.RECEIPTKEY =a.RECEIPTKEY 


update inward set QTYRECEIVED =0
update inward set wmsreceiptheaderstatus='Open'

update Inward set QTYEXPECTED=a.QTYEXPECTED,QTYRECEIVED=a.QTYRECEIVED          -- receipt qty updated
from (select TYPE,RECEIPTKEY,externlineno,sum(QTYEXPECTED)QTYEXPECTED,sum(QTYRECEIVED)QTYRECEIVED
 From wmwhse1_RECEIPTDETAIL where RECEIPTKEY>'1000000012' group by TYPE, RECEIPTKEY,externlineno)a
where Inward.RECEIPTKEY=a.RECEIPTKEY
and Inward.externlineno=a.externlineno

--update Inward set QTYRECEIVED=a.QTYRECEIVED          -- receipt qty updated
--from (select RECEIPTKEY,externlineno,sum(QTYRECEIVED)QTYRECEIVED
-- From wmwhse1_RECEIPTDETAIL where TYPE =2 group by RECEIPTKEY,externlineno)a
--where Inward.RECEIPTKEY=a.RECEIPTKEY
--and Inward.externlineno=a.externlineno


update Inward set wmsreceiptstatus='Completed'
where QTYEXPECTED =QTYRECEIVED

update Inward set wmsreceiptstatus='Pending'
where QTYEXPECTED <>QTYRECEIVED

update Inward set wmsreceiptheaderstatus='Closed'
where RECEIPTKEY in (select distinct  RECEIPTKEY from wmwhse1_RECEIPT where status=11)

update inward set wmsdoctype =a.TYPE
from(select RECEIPTKEY, b.DESCRIPTION as  type  from wmwhse1_RECEIPT a 
 left join WMWHSE1_CODELKUP b on  b.WHSEID='wmwhse1' and b.CODE=a.TYPE and b.LISTNAME  like '%RECEIPTYPE%')a
where inward.RECEIPTKEY=a.RECEIPTKEY 


update Inward set qcnotrequiredqty =a.QTYRECEIVED          -- QC qty updated
from (select TYPE,RECEIPTKEY,externlineno,sum(QTYRECEIVED)QTYRECEIVED
 From wmwhse1_RECEIPTDETAIL where RECEIPTKEY>'1000000012' and QCREQUIRED=0
	group by RECEIPTKEY,externlineno,TYPE)a
where Inward.RECEIPTKEY=a.RECEIPTKEY
and Inward.externlineno=a.externlineno

update Inward set qccom_qty=a.QTYRECEIVED          -- QC qty updated
from (select type,RECEIPTKEY,externlineno,sum(QTYRECEIVED)QTYRECEIVED
 From wmwhse1_RECEIPTDETAIL where  RECEIPTKEY>'1000000012' and QCREQUIRED=1 and QCSTATUS ='c' 
	group by RECEIPTKEY,externlineno,TYPE)a
where Inward.RECEIPTKEY=a.RECEIPTKEY
and Inward.externlineno=a.externlineno

update Inward set qcpend_qty=a.QTYRECEIVED          -- QC qty updated
from (select TYPE,RECEIPTKEY,externlineno,sum(QTYRECEIVED)QTYRECEIVED
 From wmwhse1_RECEIPTDETAIL where RECEIPTKEY>'1000000012' and QCREQUIRED=1 and QCSTATUS ='n' 
	group by RECEIPTKEY,externlineno,TYPE)a
where Inward.RECEIPTKEY=a.RECEIPTKEY
and Inward.externlineno=a.externlineno

update inward set wmsqcstatus='Not Required' where qcnotrequiredqty=QTYRECEIVED
update inward set wmsqcstatus='Completed' where qccom_qty=QTYRECEIVED
update inward set wmsqcstatus='Pending' where qcpend_qty>0


update Inward set prepacknotrequiredqty =a.QTYRECEIVED          -- prepacking qty updated
from (select TYPE,RECEIPTKEY,externlineno,sum(QTYRECEIVED)QTYRECEIVED
 From wmwhse1_RECEIPTDETAIL where  RECEIPTKEY>'1000000012' and EXT_UDF_LKUP1=0
	group by RECEIPTKEY,externlineno,TYPE)a
where Inward.RECEIPTKEY=a.RECEIPTKEY
and Inward.externlineno=a.externlineno

--update Inward set qcnotcom_qty=QTYRECEIVED-qccom_qty from Inward where QCREQUIRED=1


update Inward set prepackcom_qty=a.QTYRECEIVED          -- prepack qty updated
from (select type,RECEIPTKEY,externlineno,sum(QTYRECEIVED)QTYRECEIVED
 From wmwhse1_RECEIPTDETAIL where  RECEIPTKEY>'1000000012' and ext_udf_lkup1=1 and EXT_UDF_LKUP2 =1 group by TYPE,RECEIPTKEY,externlineno)a
where Inward.RECEIPTKEY=a.RECEIPTKEY
and Inward.externlineno=a.externlineno

update Inward set prepackpend_qty=a.QTYRECEIVED          -- receipt qty updated
from (select type,RECEIPTKEY,externlineno,sum(QTYRECEIVED)QTYRECEIVED
 From wmwhse1_RECEIPTDETAIL where  RECEIPTKEY>'1000000012' and ext_udf_lkup1=1 and EXT_UDF_LKUP2=0 group by type,RECEIPTKEY,externlineno)a
where Inward.RECEIPTKEY=a.RECEIPTKEY
and Inward.externlineno=a.externlineno

update Inward set Audit_qty=a.QTY          -- audit receipt qty updated
from (select EXT_UDF_STR2,sku,sum(Qty)QTY  From wmwhse1_RECEIPTAUDIT 	group by EXT_UDF_STR2,SKU)a
where Inward.RECEIPTKEY=a.EXT_UDF_STR2
and ltrim(rtrim(inward.sku))= ltrim(rtrim(a.sku))
and prepackpend_qty>0


update Inward set Audit_tbl_status='Yes'
where prepackpend_qty=Audit_qty
and prepackpend_qty>0


update inward set wmsprepackstatus='Not Required' where prepacknotrequiredqty=QTYRECEIVED
update inward set wmsprepackstatus='Completed' where prepackcom_qty=QTYRECEIVED
update inward set wmsprepackstatus='Pending' where prepackpend_qty>0


update inward set toloc =a.TOLOC from (select RECEIPTKEY,EXTERNLINENO,toloc From wmwhse1_RECEIPTDETAIL where type=0)a
where inward.RECEIPTKEY=a.RECEIPTKEY
and inward.EXTERNLINENO=a.EXTERNLINENO


update inward set toid =a.toid from (select ext_udf_lkup1,sku,toid From wmwhse1_ITRN)a
where inward.RECEIPTKEY=a.ext_udf_lkup1
and ltrim(rtrim(inward.SKU))=ltrim(rtrim(a.SKU))


insert into qc_breakup 
select * from(
select *,datediff(d,convert(date,ADDDATE),convert(date,getdate()))as Age from(
select distinct x.EDITDATE,l.LOCATIONCATEGORY,x.QTY,x.SKU,x.ADDDATE,x.loc,x.STATUS  from wmwhse1_LOTXLOCXID x , wmwhse1_loc l  where 
x.qty > 0 
and ltrim(rtrim(x.sku))in(select distinct ltrim(rtrim(sku)) From 	Inward where wmsqcstatus ='pending')
and l.loc = x.loc 
and l.LOCATIONCATEGORY in ('INBSTAGE')) a)a



insert  into prepack_breakup 
select * From (
select *,datediff(d,convert(date,ADDDATE),convert(date,getdate()))as Age from(
select distinct  x.EDITDATE,l.LOCATIONCATEGORY,x.QTY,x.SKU,x.ADDDATE,x.loc,x.STATUS  from wmwhse1_LOTXLOCXID x , wmwhse1_loc l  where 
x.qty > 0 and x.sku
in(select distinct (rtrim(sku)) From 	Inward where wmsreceiptstatus ='Completed' and wmsqcstatus ='Not Required')
 and l.loc = x.loc 
and l.LOCATIONCATEGORY in ('INBSTAGE')) a

union all

select distinct *,datediff(d,convert(date,ADDDATE),convert(date,getdate()))as Age from(
select x.EDITDATE,l.LOCATIONCATEGORY,x.QTY,x.SKU,x.ADDDATE,x.loc,x.STATUS  from wmwhse1_LOTXLOCXID x , wmwhse1_loc l  where 
x.qty > 0 and x.sku
in(select distinct (rtrim(sku)) From 	Inward where wmsqcstatus ='Completed')
 and l.loc = x.loc 
	and l.LOCATIONCATEGORY in ('INBQC'))a)a


end

GO

