CREATE view [vw_Business_Partner] as

select  bpid as custcode,a.NAMA as custname1,
case when prst=2 then 'Acitve' when prst=3 then 'In Acitve' end as status ,
b.creg as CustAreaCode,cfcg as FinCustGrp,
(ltrim(rtrim(d.nama))+' '+ltrim(rtrim(d.namb))+' '+ltrim(rtrim(d.namc))+' '+ltrim(rtrim(d.BLDG))+' '+ltrim(rtrim(d.BLFL))+''+ltrim(rtrim(d.BLFL))
+' '+ltrim(rtrim(d.BLUN))) as CustAddress,c.ccur as Currency ,a.cdf_cgrp,
coalesce(a.cdf_cpho,a.telp,b.telp,d.telp) as Contact,
a.cdf_cmil as email,b.crep as SalesPerson
from (select * from TTCCOM100ALL where company=400) a
left outer join (select * from TTCCOM110ALL where company=400) b
on a.bpid=b.ofbp
left outer join (select distinct itbp,cfcg,ccur from TTCCOM112ALL where company=400)  c
on a.bpid=c.itbp
left outer join (select * from TTCCOM130ALL where company=400) d
on a.cadr=d.cadr

GO

