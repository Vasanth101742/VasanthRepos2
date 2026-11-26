CREATE view vw_Sales_with_Fabno as
select a.compnr,c.CompName,c.SubCompName,a.fldc,a.fldv,a.[tran],a.idoc,a.line,
a.sequencenumber seqn_a,b.lssn,b.sequencenumber as seqn_b,b.seqn,b.sern,deleted from
(select distinct compnr,[tran],idoc,line,fldc,fldv,sfcp,sequencenumber,deleted from LN_CISLI311
where fldc='LSST'
--and fldv like '%PK/K8jwdRmyw/VPXJ60lyg%'
)a
left outer join
(select distinct case when compnr='3100' then '3110'
when compnr='1100' then '1700'
else compnr end as compnr,lssn,seqn,sern,sequencenumber from LN_TCIBD411 
--where lssn like 'SPb45wWATzydI/P1NG3unA'
--where --sern='UXHC374824'
)b
on --a.compnr=b.compnr and 
ltrim(rtrim(a.fldv))=ltrim(rtrim(b.lssn))
left outer join vw_ELGi_offshore_Companies c
on a.compnr=c.Company
where a.deleted<>'Y'
--where lssn like 'SPb45wWATzydI/P1NG3unA'
--'nqulfP1oTOGYt1yhOcln3w'

GO

