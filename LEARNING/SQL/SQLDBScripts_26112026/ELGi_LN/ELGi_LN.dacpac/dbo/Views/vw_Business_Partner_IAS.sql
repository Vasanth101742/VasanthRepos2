CREATE view [dbo].[vw_Business_Partner_IAS] as
select  bpid as custcode,a.NAMA as custname1,b.creg as CustAreaCode,cfcg as FinCustGrp,
(ltrim(rtrim(d.nama))+' '+ltrim(rtrim(d.namb))+' '+ltrim(rtrim(d.namc))+' '+ltrim(rtrim(d.namd))+' '+ltrim(rtrim(d.namf))) as CustAddress  ,
c.ccur as Currency,a.CDF_CGRP,
coalesce(b.TELP,d.TELP) as Contact
from (select * from TTCCOM100ALL where company=951) a
left outer join (select * from TTCCOM110ALL where company=951) b
on a.bpid=b.ofbp
left outer join (select * from TTCCOM112ALL where company=951) c
on a.bpid=c.itbp
left outer join (select * from TTCCOM130ALL where company=951) d
on a.cadr=d.cadr

GO

