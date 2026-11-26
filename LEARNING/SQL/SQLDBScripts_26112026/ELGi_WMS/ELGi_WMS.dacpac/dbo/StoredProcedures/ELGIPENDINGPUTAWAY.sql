

CREATE proc [dbo].[ELGIPENDINGPUTAWAY]
as
begin

truncate table [WMWHSE1_receiptaudit]
truncate table [WMWHSE1_ELGIPENDINGPUTAWAY]

insert into [WMWHSE1_receiptaudit]
select * from WMWHSE1_ITRN where EXT_UDF_STR1 like '%prepack%' and TRANTYPE='MV'

insert into [WMWHSE1_ELGIPENDINGPUTAWAY]

select *  from (
select LD.SKU, S.DESCR , LD.LOC AS FROMLOC, LD.ID as FROMID, LD.QTY , LD.EDITDATE AS DATE,
rd.referencetype,rd.RECEIPTKEY AS RECEIPTKEY, RD.SUSR1 AS DEMANDSKU, ld.loc AS TOLOC, rd.toid as TOID,l.locationcategory
from 
[WMWHSE1_RECEIPTDETAIL] rd,
[WMWHSE1_LOTXLOCXID] ld, 
[WMWHSE1_LOC] l, [WMWHSE1_SKU] s 
where rd.toid=ld.id  and rd.sku=s.sku AND LD.sku = S.SKU and rd.QCREQUIRED='0' 
and rd.QCSTATUS='N' and isnull(rd.ext_udf_lkup1,0)='0' and  isnull(rd.EXT_UDF_LKUP2,0)='0' and s.sku = ld.sku
and ld.qty > 0 and ld.loc=l.loc and l.locationcategory in ('INBSTAGE') 

union all

select LD.SKU, S.DESCR , LD.LOC AS FROMLOC, LD.ID as FROMID, LD.QTY , LD.EDITDATE AS DATE,
rd.referencetype,rd.RECEIPTKEY AS RECEIPTKEY, RD.SUSR1 AS DEMANDSKU, ld.loc AS TOLOC, rd.toid as TOID,l.locationcategory
from [WMWHSE1_RECEIPTDETAIL] rd,
[WMWHSE1_LOTXLOCXID] ld, 
[WMWHSE1_LOC] l, 
[WMWHSE1_SKU] s
where rd.toid=ld.id  and rd.sku=s.sku AND LD.sku = S.SKU and rd.QCREQUIRED='1' and rd.QCSTATUS='C' 
and isnull(rd.ext_udf_lkup1,0)='0' and  isnull(rd.EXT_UDF_LKUP2,0)='0' and s.sku = ld.sku
and ld.qty > 0 and ld.loc=l.loc and l.locationcategory in ('INBQC','PPUTWAY') 

union all

SELECT RA.SKU, S.DESCR , LD.LOC as FROMLOC, LD.ID as FROMID, LD.QTY,LD.EDITDATE AS DATE,
rd.referencetype,ra.receiptkey AS RECEIPTKEY, rd.susr1 AS DEMANDSKU, ld.loc AS TOLOC, rd.toid as TOID,l.locationcategory
FROM
[WMWHSE1_receiptaudit] ra,
[WMWHSE1_RECEIPTDETAIL] rd,
[WMWHSE1_LOTXLOCXID] ld,
[WMWHSE1_LOC] l, 
[WMWHSE1_SKU] s where rd.sku=s.sku AND LD.sku = S.SKU and ra.fromid=rd.toid 
and ra.toid=ld.id and ld.qty > 0 and s.sku = ld.sku
and ld.loc=l.loc and l.locationcategory in ( 'PREPACK') ) a

end

GO

