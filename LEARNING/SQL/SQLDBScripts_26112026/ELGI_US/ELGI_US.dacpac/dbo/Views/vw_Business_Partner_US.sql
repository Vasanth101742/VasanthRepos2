


CREATE view [dbo].[vw_Business_Partner_US] as

select  a.compnr,a.bpid as custcode,a.NAMA as custname1,
case when prst=2 then 'Active' when prst=3 then 'InActive' end as status ,
b.creg as CustAreaCode,cfcg as FinCustGrp,
(ltrim(rtrim(d.nama))+' '+ltrim(rtrim(d.namb))+' '+ltrim(rtrim(d.namc))+' '+ltrim(rtrim(d.BLDG))+' '+ltrim(rtrim(d.BLFL))+''+ltrim(rtrim(d.BLFL))
+' '+ltrim(rtrim(d.BLUN))) as CustAddress,c.ccur as Currency ,
--a.cdf_cgrp,
null as cdf_cgrp,
e.fuln as ContactPerson,
coalesce(--a.cdf_cpho,
a.telp,b.telp,d.telp) as Contact,
--a.cdf_cmil as email,
e.info as email
--b.crep as SalesPerson
from (select * from LN_TCCOM100) a
left outer join (select * from LN_TCCOM110) b
on a.compnr=b.compnr
and a.bpid=b.ofbp
left outer join (select distinct compnr,itbp,cfcg,ccur from LN_TCCOM112)  c
on a.compnr=c.compnr
and a.bpid=c.itbp
left outer join (select * from LN_TCCOM130) d
on a.compnr=c.compnr
and a.cadr=d.cadr
left outer join (
select * from (
select  a.compnr,a.bpid,a.ccnt,b.fuln,b.info,
row_number() over(partition by a.compnr,a.bpid order by a.ccnt desc) as Rnk1
from (select distinct compnr,bpid,ccnt from LN_TCCOM145  where deleted ='N')a
left outer join (select distinct compnr,bpid,ccnt,fuln,info from LN_TCCOM140  where deleted ='N') b
on a.compnr=b.compnr
and a.bpid=b.bpid
and a.ccnt=b.ccnt
where b.compnr is not null
--and a.bpid='20-00200'
)a
where Rnk1=1
) e
on a.compnr=e.compnr
and a.bpid=e.bpid

GO

