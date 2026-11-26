CREATE PROC [dbo].[SP_US_Revenue] AS
begin 

truncate table US_Revenue
insert into US_Revenue

select case when compn='3140' then 'PATTONS' when compn='3150' then 'MICHIGAN' end as COMPN,a.idoc,a.line,
case when a.srtp_kw='tcsli.srtp.service.order' then 'Service' when a.srtp_kw='tcsli.srtp.sales.order' then 'Sales' when a.srtp_kw='tcsli.srtp.manual.sales' then 'Sales' else 'Others' end 'Order Type',
case when a.invt_kw in ('tcinvt.manual.sales','tcinvt.sales.order') then 'Sales' when a.invt_kw='tcinvt.material' then 'Material' 
			when a.invt_kw='tcinvt.travel' then 'Travel' when a.invt_kw='tcinvt.other' then 'Others' when a.invt_kw='tcinvt.labor' then 'Labor' 
			when a.invt_kw='tcinvt.not.app' then 'NA'else 'Others' end  'Invt_KW'
,convert(date,b.idat)'idat',convert(nvarchar,month(convert(date,b.idat))) +'-'+convert(nvarchar,Year(convert(date,b.idat)))'Inv Date',(convert(float,a.amti))'amti'
,isnull(c.nama,'NA')'EngName',replace(replace(isnull(d.dsca,'NA'),'Service Office - ',''),'Sales Office - ','')'Branch',isnull(f.dsca,'NA')'ProductLine',
isnull(g.nama,'NA')'BPName',isnull(e.dsca,'NA')'ItemName',e1.dscait_it
from usln_cisli310 a
left outer join usln_cisli305 b on b.compnr=a.compn  and b.idoc=a.idoc and b.[tran]=a.[tran]
left outer join usln_tccom001 c on c.emno=a.crep 
left outer join usln_tcmcs065 d on d.cwoc=a.cofc
left join usLN_tcibd001 e on replace(e.item,' ','')=replace(a.item,' ','')
left join usln_tcmcs015 e1 on e1.ctyp=e.ctyp
left join usLN_tcmcs023 f on replace(f.citg,' ','')=replace(e.citg,' ','')
left join usLN_TCCom100 g on replace(g.bpid,' ','')=replace(b.itbp,' ','')
where compn in ('3140','3150')

end

GO

