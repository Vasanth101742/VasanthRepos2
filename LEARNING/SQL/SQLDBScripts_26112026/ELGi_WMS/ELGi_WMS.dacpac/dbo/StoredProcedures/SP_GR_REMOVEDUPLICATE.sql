CREATE proc [dbo].[SP_GR_REMOVEDUPLICATE]
as
begin

set nocount on 


delete wmwhse1_TASKDETAIL where SCHEMA_REFERENCE not in ('wmwhse1','wmwhse2')
delete [WMWHSE1_PICKDETAIL] where SCHEMA_REFERENCE not in ('wmwhse1','wmwhse2')
delete wmwhse1_AREADETAIL where SCHEMA_REFERENCE not in ('wmwhse1','wmwhse2')
delete wmwhse1_CODELKUP where SCHEMA_REFERENCE not in ('wmwhse1','wmwhse2')
delete wmwhse1_holdtrn where SCHEMA_REFERENCE not in ('wmwhse1','wmwhse2')
delete wmwhse1_INVENTORYHOLDCODE where SCHEMA_REFERENCE not in ('wmwhse1','wmwhse2')
delete wmwhse1_PUTAWAYZONE where SCHEMA_REFERENCE not in ('wmwhse1','wmwhse2')
delete wmwhse1_ORDERSTATUSSETUP where SCHEMA_REFERENCE not in ('wmwhse1','wmwhse2')
delete wmwhse1_ITRN where SCHEMA_REFERENCE not in ('wmwhse1','wmwhse2')
delete WMWHSE1_LOC where SCHEMA_REFERENCE not in ('wmwhse1','wmwhse2')
delete wmwhse1_LOTATTRIBUTE where SCHEMA_REFERENCE not in ('wmwhse1','wmwhse2')

delete   wmwhse1_RECEIPT
where CONCAT(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) not in 
(select concat(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) from (select SCHEMA_REFERENCE,SERIALKEY,max(dldocumentdate)dldocumentdate from [dbo].wmwhse1_RECEIPT group by SCHEMA_REFERENCE,SERIALKEY)a)

delete   wmwhse1_RECEIPTDETAIL
where CONCAT(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) not in 
(select concat(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) from (select SCHEMA_REFERENCE,SERIALKEY,max(dldocumentdate)dldocumentdate from [dbo].wmwhse1_RECEIPTDETAIL group by SCHEMA_REFERENCE,SERIALKEY)a)

 
--delete  [dbo].[WMWHSE1_ORDERS] 
--where CONCAT(ORDERKEY,dldocumentdate) not in 
--(select concat(ORDERKEY,dldocumentdate) from (select orderkey,max(dldocumentdate)dldocumentdate from [dbo].[WMWHSE1_ORDERS] group by orderkey)a)
  
--delete  [dbo].[WMWHSE1_PICKDETAIL] 
--where CONCAT(pickdetailkey,dldocumentdate) not in 
--(select concat(pickdetailkey,dldocumentdate) from (select pickdetailkey,max(dldocumentdate)dldocumentdate from [dbo].[WMWHSE1_PICKDETAIL] group by pickdetailkey)a)



--delete   wmwhse1_AREADETAIL
--where CONCAT(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) not in 
--(select concat(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) from (select SCHEMA_REFERENCE,SERIALKEY,max(dldocumentdate)dldocumentdate from [dbo].wmwhse1_AREADETAIL group by SCHEMA_REFERENCE,SERIALKEY)a)



--delete   wmwhse1_CODELKUP
--where CONCAT(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) not in 
--(select concat(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) from (select SCHEMA_REFERENCE,SERIALKEY,max(dldocumentdate)dldocumentdate from [dbo].wmwhse1_CODELKUP group by SCHEMA_REFERENCE,SERIALKEY)a)



--delete   wmwhse1_holdtrn
--where CONCAT(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) not in 
--(select concat(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) from (select SCHEMA_REFERENCE,SERIALKEY,max(dldocumentdate)dldocumentdate from [dbo].wmwhse1_holdtrn group by SCHEMA_REFERENCE,SERIALKEY)a)




--delete   wmwhse1_INVENTORYHOLDCODE
--where CONCAT(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) not in 
--(select concat(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) from (select SCHEMA_REFERENCE,SERIALKEY,max(dldocumentdate)dldocumentdate from [dbo].wmwhse1_INVENTORYHOLDCODE group by SCHEMA_REFERENCE,SERIALKEY)a)



--delete   wmwhse1_ITRN
--where CONCAT(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) not in 
--(select concat(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) from (select SCHEMA_REFERENCE,SERIALKEY,max(dldocumentdate)dldocumentdate from [dbo].wmwhse1_ITRN group by SCHEMA_REFERENCE,SERIALKEY)a)

--delete   wmwhse1_loc
--where CONCAT(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) not in 
--(select concat(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) from (select SCHEMA_REFERENCE,SERIALKEY,max(dldocumentdate)dldocumentdate from [dbo].wmwhse1_loc group by SCHEMA_REFERENCE,SERIALKEY)a)




--delete   wmwhse1_LOTATTRIBUTE
--where CONCAT(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) not in 
--(select concat(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) from (select SCHEMA_REFERENCE,SERIALKEY,max(dldocumentdate)dldocumentdate from [dbo].wmwhse1_LOTATTRIBUTE group by SCHEMA_REFERENCE,SERIALKEY)a)




--delete   wmwhse1_LOTXLOCXID
--where CONCAT(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) not in 
--(select concat(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) from (select SCHEMA_REFERENCE,SERIALKEY,max(dldocumentdate)dldocumentdate from [dbo].wmwhse1_LOTXLOCXID group by SCHEMA_REFERENCE,SERIALKEY)a)


--delete   wmwhse1_ORDERDETAIL
--where CONCAT(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) not in 
--(select concat(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) from (select SCHEMA_REFERENCE,SERIALKEY,max(dldocumentdate)dldocumentdate from [dbo].wmwhse1_ORDERDETAIL group by SCHEMA_REFERENCE,SERIALKEY)a)

--delete   wmwhse1_ORDERSTATUSSETUP
--where CONCAT(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) not in 
--(select concat(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) from (select SCHEMA_REFERENCE,SERIALKEY,max(dldocumentdate)dldocumentdate from [dbo].wmwhse1_ORDERSTATUSSETUP group by SCHEMA_REFERENCE,SERIALKEY)a)



--delete   wmwhse1_PHYSICALCOUNT
--where CONCAT(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) not in 
--(select concat(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) from (select SCHEMA_REFERENCE,SERIALKEY,max(dldocumentdate)dldocumentdate from [dbo].wmwhse1_PHYSICALCOUNT group by SCHEMA_REFERENCE,SERIALKEY)a)

--delete   wmwhse1_PICKDETAIL
--where CONCAT(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) not in 
--(select concat(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) from (select SCHEMA_REFERENCE,SERIALKEY,max(dldocumentdate)dldocumentdate from [dbo].wmwhse1_PICKDETAIL group by SCHEMA_REFERENCE,SERIALKEY)a)

--delete   wmwhse1_podetail
--where CONCAT(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) not in 
--(select concat(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) from (select SCHEMA_REFERENCE,SERIALKEY,max(dldocumentdate)dldocumentdate from [dbo].wmwhse1_podetail group by SCHEMA_REFERENCE,SERIALKEY)a)

--delete   wmwhse1_PUTAWAYZONE
--where CONCAT(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) not in 
--(select concat(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) from (select SCHEMA_REFERENCE,SERIALKEY,max(dldocumentdate)dldocumentdate from [dbo].wmwhse1_PUTAWAYZONE group by SCHEMA_REFERENCE,SERIALKEY)a)



--delete   wmwhse1_sku
--where CONCAT(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) not in 
--(select concat(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) from (select SCHEMA_REFERENCE,SERIALKEY,max(dldocumentdate)dldocumentdate from [dbo].wmwhse1_sku group by SCHEMA_REFERENCE,SERIALKEY)a)

--delete   wmwhse1_SKUXLOC
--where CONCAT(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) not in 
--(select concat(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) from (select SCHEMA_REFERENCE,SERIALKEY,max(dldocumentdate)dldocumentdate from [dbo].wmwhse1_SKUXLOC group by SCHEMA_REFERENCE,SERIALKEY)a)

--delete   wmwhse1_TASKDETAIL
--where CONCAT(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) not in 
--(select concat(SCHEMA_REFERENCE,SERIALKEY,dldocumentdate) from (select SCHEMA_REFERENCE,SERIALKEY,max(dldocumentdate)dldocumentdate from [dbo].wmwhse1_TASKDETAIL group by SCHEMA_REFERENCE,SERIALKEY)a)






end

GO

