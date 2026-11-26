CREATE view vw_combined_salesdetails

as
select distinct 'USA' as Region,
        case 
        when a.compnr = 3100 then 'ELGI NA'
        when a.compnr = 3110 then 'Industrial'
        when a.compnr = 3120 then 'Portables'
        when a.compnr = 3130 then 'Pattons Medical'
        when a.compnr = 3140 then 'Pattons INC'
        when a.compnr = 3150 then 'Michigan'
    end as CompDivision,
    (convert(datetime,c.idat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time' as InvDate,
    a.[tran],
    a.idoc as Invno,
    replace(a.item, ' ', '') as ItemCode,
    b.dsca as ItemDesc,
    a.orno,
    (convert(datetime,a.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time' as OrderDate,
    replace(c.itbp, ' ', '') as CusCode,
    isnull(d.nama, 'NA') as BPName,
    f.dsca as ProductLine,
    a.pono,
    a.dqua as DeliveryQty,
    a.cuqs,
    a.amti as InvCurrencyAmnt,
    a.amth_1 as HomeCurrencyAmnt
from LN_cisli310 a
left join LN_cisli305 c on c.idoc=a.idoc and c.[tran]=a.[tran] and c.compnr=a.compnr  and c.deleted='N'
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='3100'  and b.deleted='N'
left join LN_tccom100 d on replace(d.bpid,' ','')=replace(c.itbp,' ','') and d.compnr='3100'   and d.deleted='N'
left join LN_tcmcs023 f on replace(f.citg,' ','')=replace(b.citg,' ','') and d.compnr='3100'  and f.deleted='N'
where  a.compnr in  (3100,3110,3120,3130,3140,3150)  and a.deleted='N' and c.stat='80'
and convert(date,idat) Between '2025-04-01' and '2026-03-31'

Union ALL

select distinct 'Europe',case when a.compnr=1100 then'Rotair'
 when a.compnr=1700 then'Elgi Europe' end "compnr",dateadd(MINUTE ,-29,dateadd(hour,-3,c.idat2)) as idat,a.[tran],a.idoc,replace(a.item,' ','')"ItemCode",b.dsca,a.orno,
 dateadd(MINUTE ,-29,dateadd(hour,-3,a.odat2)) as odat
 ,replace(c.itbp,' ','')"CusCode",isnull(d.nama,'NA')"BPName",f.dsca as "ProductLine"
,a.pono,a.dqua,a.cuqs,cast(a.amti as decimal(19,2))"amti",a.amth_1
from LN_cisli310 a
left join LN_cisli305 c on c.idoc=a.idoc and c.[tran]=a.[tran] and c.compnr=a.compnr
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='1100'
left join LN_tccom100 d on replace(d.bpid,' ','')=replace(c.itbp,' ','') and d.compnr='1100' 
left join LN_tcmcs023 f on replace(f.citg,' ','')=replace(b.citg,' ','') and d.compnr='1100' 
where  a.compnr in  (1700)  and c.stat_kw='tcsli.stat.posted' and  c.fyer IN (2026) 

Union ALL


select 'Brazil','Brazil'as compnr,dateadd(MINUTE ,-29,dateadd(hour,-8,c.idat2)) as idat,a.[tran],a.idoc,replace(a.item,' ','')"ItemCode",b.dsca,a.orno,dateadd(MINUTE ,-29,dateadd(hour,-9,a.odat)) as odat
 ,replace(c.itbp,' ','')"CusCode",isnull(d.nama,'NA')"BPName",f.dsca as "ProductLine"
,a.pono,a.dqua,a.cuqs,a.amti,a.amth_1 from LN_cisli310 a
left join LN_cisli305 c on c.idoc=a.idoc and c.[tran]=a.[tran] and c.compnr=a.compnr  and c.deleted='N'
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='2000'  and b.deleted='N'
left join LN_tccom100 d on replace(d.bpid,' ','')=replace(c.itbp,' ','') and d.compnr='2000'   and d.deleted='N'
left join LN_tcmcs023 f on replace(f.citg,' ','')=replace(b.citg,' ','') and d.compnr='2000'   and f.deleted='N'
where  a.compnr =2000  and a.deleted='N' and  convert(date,idat) Between '2025-04-01' and '2026-03-31'

GO

