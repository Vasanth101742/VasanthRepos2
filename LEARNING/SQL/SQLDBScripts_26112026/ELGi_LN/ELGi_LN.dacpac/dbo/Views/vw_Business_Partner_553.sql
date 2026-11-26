
CREATE view [vw_Business_Partner_553] as
select  bpid as custcode,a.nama as custname1,b.creg as CustAreaCode,cfcg as FinCustGrp,
(ltrim(rtrim(d.nama))+' '+ltrim(rtrim(d.namb))+' '+ltrim(rtrim(d.namc))+' '+ltrim(rtrim(d.namd))+' '+ltrim(rtrim(d.namf))) as CustAddress  ,
c.ccur as Currency,a.CDF_CGRP,
coalesce(b.TELP,d.TELP) as Contact
from (select * from TTCCOM100ALL where company=553) a
left outer join (select * from TTCCOM110ALL where company=553) b
on a.bpid=b.OFBP
left outer join (select * from TTCCOM112ALL where company=553) c
on a.bpid=c.itbp
left outer join (select * from TTCCOM130ALL where company=553) d
on a.cadr=d.cadr

GO

