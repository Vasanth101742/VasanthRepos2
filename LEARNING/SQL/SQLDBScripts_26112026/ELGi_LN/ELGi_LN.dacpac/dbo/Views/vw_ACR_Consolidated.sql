CREATE view [dbo].[vw_ACR_Consolidated]
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
dpstname,
--,ACR.Indent
case when row_number() over (partition by ACR.CustNo order by ACR.CustNo)=1 then b.CreditLimit else 0 end as CreditLimit,
v.cdf_cgrp,v2.FinCustGrpName
FROM 
(select distinct a.*
--,case when h.t_corn=' ' then h.RefA else h.t_corn end as Indent 
from ACR a
where a.company in (select company from ELGI_Companies_Master where CompanyGroup='ELGi')
and Trantyp not in ('8C2','822','221','321','422','226')
)	ACR
left outer JOIN (select distinct bpid as CustCode,nama as CustName1 from TTCCOM100ALL where company=400) a 
ON ACR.CustNo = a.CustCode 
left outer join (select distinct itbp as CustCode,cfcg as FinCustGrp,CRLR as CreditLimit from TTCCOM112ALL where company=400) b
ON ACR.CustNo =b.CustCode
left outer join vw_Business_Partner v
on ACR.CustNo=v.custcode
left outer JOIN vw_Area_Master(nolock) 
ON ACR.Area = vw_Area_Master.AreaCode 
left outer JOIN vw_DPST_Master(nolock) 
ON ltrim(rtrim(vw_DPST_Master.dpstcode)) = ltrim(rtrim(ACR.productgrp))
left outer join vw_FinCustGrp v2
on v.cdf_cgrp=v2.FinCustGrpCode
WHERE	substring(trantyp,2,1) not in ('5','6')

	)a

where filt_typ <> 1

GO

