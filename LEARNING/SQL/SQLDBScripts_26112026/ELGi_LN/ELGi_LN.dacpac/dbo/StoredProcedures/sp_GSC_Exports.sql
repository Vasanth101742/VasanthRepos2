--exec sp_GSC_Exports
CREATE proc [dbo].[sp_GSC_Exports] as
begin

Truncate table GSC_Exports

insert into GSC_Exports(CUST,SPNO,WORN,WPON,WSEQ,ITEM,Company,Trantype,invnum,Warehouse)
select a.CUST,a.SPNO,b.WORN,	b.WPON,	b.WSEQ,b.ITEM,
f.Company,f.Trantype,f.invnum,b.Warehouse
from	
(select DCNO,DCDT,CUST,SPNO,SHDT,GTDT  from TZZSLS136490)a
left outer join 
(select distinct SHPM,ITEM,QSHP,WORN,WPON,WSEQ,CWAR'Warehouse' from TWHINH431ALL where COMPANY=490)b
on a.SPNO=b.SHPM
left outer join (select Company,Trantype,invnum,t_shpm,t_item from CI_Lines where company=490)f
on isnull(b.SHPM,'0')=isnull(f.t_shpm,'0')
and ltrim(rtrim(b.ITEM))=ltrim(rtrim(f.t_item))
--where spno='SHO315265'

--Alter table GSC_Exports
--Add Warehouse varchar(10)

update GSC_Exports set DCDT=a.DCDT,DCNO=a.DCNO,SHDT=a.SHDT,GTDT=a.GTDT
from	(select DCNO,DCDT,CUST,SPNO,SHDT,GTDT  from TZZSLS136490)a
where GSC_Exports.SPNO=a.SPNO

update GSC_Exports set QSHP=b.QSHP
from (select distinct SHPM,ITEM,QSHP,WORN,WPON,WSEQ,CWAR from TWHINH431ALL where COMPANY=490)b
where GSC_Exports.SPNO=b.SHPM
and GSC_Exports.WORN=b.WORN
and GSC_Exports.WPON=b.WPON
and GSC_Exports.WSEQ=b.WSEQ
and GSC_Exports.Warehouse=b.CWAR

update GSC_Exports set t_pric=c.t_pric
from (select t_orno,t_pono,t_sqnb,t_pric,t_cwar from TTDSLS401ALL where company=490)c
where GSC_Exports.WORN=c.t_orno
and GSC_Exports.WPON=c.t_pono
and GSC_Exports.WSEQ=c.t_sqnb
and GSC_Exports.Warehouse=c.t_cwar

update GSC_Exports set STCO=d.STCO,SHST=d.SHST,CDAT=d.CDAT
from (select SHPM,STCO,SHST,CDAT
from TWHINH430ALL where company=490)d
where GSC_Exports.SPNO=d.SHPM
and ltrim(rtrim(GSC_Exports.CUST))=ltrim(rtrim(d.STCO))

update GSC_Exports set Invoice_date=Sales.Invoice_date
from (select distinct company,trantype,Invoice,Invoice_Date,warehouse from ELGi_Sales_Details
where company=490
)sales
where GSC_Exports.Company=sales.company
and GSC_Exports.Trantype=Sales.trantype
and GSC_Exports.invnum=sales.Invoice
and GSC_Exports.Warehouse=sales.warehouse

update GSC_Exports set ShipmentDesc=e.ShipmentDesc
from vw_ShipMentStatus e
where GSC_Exports.shst=e.ShipmentCode


update GSC_Exports set AgeingDays=null where GTDT='1970-01-01 00:00:00.000'
update GSC_Exports set AgeingDays=datediff(dd,gtdt,getdate()-1) 
where GTDT<>'1970-01-01 00:00:00.000' and Invoice_date is null

update GSC_Exports set AgeingDays=datediff(dd,gtdt,Invoice_date) 
where GTDT<>'1970-01-01 00:00:00.000' and Invoice_date is not null
--alter table GSC_Exports add Invoice_date date

update GSC_Exports set CustName=a.custname1
from vw_Business_Partner a
where ltrim(rtrim(GSC_Exports.CUST))=ltrim(rtrim(a.custcode))

--Alter table GSC_Exports add ccur nvarchar(6)
--Alter table GSC_Exports add Rate float
--Alter table GSC_Exports add Amnt_FCurr float
--Alter table GSC_Exports add Amnt_INR float

update GSC_Exports set ccur=a.t_ccur,Rate=a.t_rats_1
from (select distinct Company,t_orno,t_ccur,t_rats_1 from TTDSLS400all where company=490  
--and t_orno='292056295'
)a
where 
--GSC_Exports.company=a.company and 
GSC_Exports.worn=a.t_orno
--and GSC_Exports.worn='292056295'

update GSC_Exports set Amnt_FCurr=QSHP*t_pric
update GSC_Exports set Amnt_INR=QSHP*t_pric*Rate


--Alter table GSC_Exports add Data_Load_Date date

update GSC_Exports set Data_Load_Date=getdate()-1

end

select * from GSC_Exports

--select top 10 t_ccur,t_rats_1,* from ttdsls400all where t_ccur<> 'IND'

--select * from ttdsls400all where company=490 and t_orno='292056295'
--select * from GSC_Exports where spno='SHO315265' --and WORN='292056295'

--select distinct ShipmentDesc from GSC_Exports


--select DCNO,DCDT,CUST,SPNO,SHDT,GTDT  from TZZSLS136490 where spno='SHO315265'
--select distinct SHPM,ITEM,QSHP,WORN,WPON,WSEQ from TWHINH431ALL where COMPANY=490 and WORN='292056295'
--select Company,Trantype,invnum,t_shpm,t_item from CI_Lines where company=490 and t_shpm='SHO315265'

--select distinct SHPM,ITEM,QSHP,WORN,WPON,WSEQ from TWHINH431ALL where COMPANY=490 and WORN='292056295'

GO

