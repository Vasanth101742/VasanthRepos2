--Select * from vw_ACR_Consolidated_AME where ACR.area,

CREATE view [dbo].[vw_ACR_Consolidated_AME]
as
select * from
(
SELECT	ACR.cur,
ACR.company,
ACR.CurRate,
ACR.InvAmntInInvCur as invval_fc, 
ACR.CustNo, 
a.CustName1, 
b.FinCustGrp,
vw_Area_Master.AreaName,
ACR.area,
vw_Area_Master.Zone, 
vw_Area_Master.region, 
vw_Area_Master.global, 
ACR.Trantyp, 
ACR.InvNo, 
ACR.[LineNo], 
ACR.Refrence,
ACR.DocDt,
ACR.DueDt,
--CONVERT(varchar, ACR.DocDt, 101) AS DocDt, 
--CONVERT(varchar, ACR.DueDt, 101) AS DueDt, 
datediff(dd, Docdt, Duedt) AS noofdays, 
ACR.InvAmntInHomeCur, 
ACR.RecAmntHomeCur, 
ACR.BalAmntHomeCur, 
ACR.DueAmt, 
ACR.UnDueAmt, 
ACR.DueAmtHC30, 
ACR.DueAmtHC31_60, 
ACR.DueAmtHC61_90, 
ACR.DueAmtHC91_180, 
ACR.DueAmtHCGT180, 
ACR.ProductGrp, 
ACR.Division ,
vw_DPST_Master.Description as  [description],
''ardivision,
'' ardivisiondesc,
case 	when custno = 'E00625' and trantyp = 'CDJ' then 1  
	when trantyp like '%c1%' then 1 else 0 end  as filt_typ,
dpstname
,ACR.Indent

FROM 
(select distinct a.*
,case when h.t_corn=' ' then h.RefA else h.t_corn end as Indent 
from ACR a
left outer join (select distinct Company,Trantype,invnum,OrderNum,CustCode from ci_lines) b
on a.company=b.Company
and a.Trantyp=b.Trantype
and a.InvNo=b.invnum
and ltrim(rtrim(a.CustNo))=ltrim(rtrim(b.CustCode))
left outer join 
(select distinct company,OrderNum,CustCode,t_corn,RefA From Sales_Header where dpst not like '%[a-z]%') h
on b.Company =h.Company 
and b.OrderNum =h.OrderNum 
and ltrim(rtrim(b.CustCode))=ltrim(rtrim(h.CustCode))
where a.company in (select company from ELGI_Companies_Master where CompanyGroup='ELGi')
)	ACR
left outer JOIN (select distinct t_bpid as CustCode,t_nama as CustName1 from TTCCOM100400) a 
ON ACR.CustNo = a.CustCode 
left outer join (select distinct itbp as CustCode,cfcg as FinCustGrp from TTCCOM112ALL where company=400) b
ON ACR.CustNo =b.CustCode
left outer JOIN vw_Area_Master(nolock) 
ON ACR.Area = vw_Area_Master.AreaCode 
left outer JOIN vw_DPST_Master(nolock) 
ON ltrim(rtrim(vw_DPST_Master.dpstcode)) = ltrim(rtrim(ACR.productgrp))

WHERE	substring(trantyp,2,1) not in ('5','6')

	)a

where filt_typ <> 1

GO

