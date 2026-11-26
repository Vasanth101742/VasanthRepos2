
create view vw_subsidiary_sales as 
select 'Brazil' 'Company',year(idat) 'Idat-year',month(idat) 'Idat-Month',itemcode,Item_description,sum(dqua) 'Sum of Delieverd qty' from 
(
select a.compnr,convert(date,dateadd(MINUTE ,-29,dateadd(hour,-8,c.idat2))) as idat,a.[tran],a.idoc,replace(a.item,' ','')"ItemCode",b.dsca 'Item_description',a.orno,dateadd(MINUTE ,-29,dateadd(hour,-9,a.odat)) as odat
 ,replace(c.itbp,' ','')"CusCode",isnull(d.nama,'NA')"BPName",f.dsca as "ProductLine"
,a.pono,a.dqua,a.cuqs,a.amti,a.amth_1,a.invt_KW

from LN_cisli310 a
left join LN_cisli305 c on c.idoc=a.idoc and c.[tran]=a.[tran] and c.compnr=a.compnr  and c.deleted='N'
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='2000'  and b.deleted='N'
left join LN_tccom100 d on replace(d.bpid,' ','')=replace(c.itbp,' ','') and d.compnr='2000'   and d.deleted='N'
left join LN_tcmcs023 f on replace(f.citg,' ','')=replace(b.citg,' ','') and d.compnr='2000'   and f.deleted='N'
where  a.compnr =2000  and a.deleted='N' 
and convert(date,dateadd(MINUTE ,-29,dateadd(hour,-8,c.idat2))) between '20241101' and '20251031'

)a 
group by year(idat),month(idat),ItemCode,Item_description

union all 

select 'Europe' 'Company',year(idat) 'idat-Year', month(idat) 'Idat-Month',ItemCode,Item_desc,sum(dqua) 'Sum_of_Delivered_Qty' from 
(
select distinct c.stat_kw,c.fyer'FYear',c.fper'Fmonth',a.line,case when a.compnr=1100 then'Rotair'
 when a.compnr=1700 then'Elgi Europe' end "compnr",convert(date,dateadd(MINUTE ,-29,dateadd(hour,-3,c.idat2))) as idat,a.[tran],a.idoc,replace(a.item,' ','')"ItemCode",b.dsca 'Item_desc',a.orno,
 dateadd(MINUTE ,-29,dateadd(hour,-3,a.odat2)) as odat
 ,replace(c.itbp,' ','')"CusCode",isnull(d.nama,'NA')"BPName",f.dsca as "ProductLine"
,a.pono,a.dqua,a.cuqs,cast(a.amti as decimal(19,2))"amti",a.amth_1,replace(a.invt_KW,'tcinvt.','')invt_KW
,a.slah_1"Home Currency",a.ldah_1"HomeDisc",cast(a.amth_1 as decimal(19,2)) "HomeNet",a.leac
from LN_cisli310 a
left join LN_cisli305 c on c.idoc=a.idoc and c.[tran]=a.[tran] and c.compnr=a.compnr
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='1100'
left join LN_tccom100 d on replace(d.bpid,' ','')=replace(c.itbp,' ','') and d.compnr='1100' 
left join LN_tcmcs023 f on replace(f.citg,' ','')=replace(b.citg,' ','') and d.compnr='1100' 
where c.stat_kw='tcsli.stat.posted' and a.compnr=1700  
and convert(date,dateadd(MINUTE ,-29,dateadd(hour,-8,c.idat2))) between '20241101' and '20251031'
)a 

group by year(idat),month(idat),ItemCode,Item_desc

union all 

select 'Industrial' 'Company',year(idat) 'idat-Year', month(idat) 'Idat-Month',ItemCode,Item_desc,sum(dqua) 'Sum_of_Delivered_Qty' from (
select distinct 
    a.line,    case 
        when a.compnr = 3100 then 'ELGI NA'
        when a.compnr = 3110 then 'Industrial'
        when a.compnr = 3120 then 'Portables'
        when a.compnr = 3130 then 'Pattons Medical'
        when a.compnr = 3140 then 'Pattons INC'
        when a.compnr = 3150 then 'Michigan'
    end as CompDivision,c.idat2,
    convert(date,(convert(datetime,c.idat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time') as idat,
    a.[tran],
    a.idoc,
    replace(a.item, ' ', '') as ItemCode,
    b.dsca 'Item_Desc',
    a.orno,
    (convert(datetime,a.odat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time' as odat,
    replace(c.itbp, ' ', '') as CusCode,
    isnull(d.nama, 'NA') as BPName,
    f.dsca as ProductLine,
    a.pono,
    a.dqua,
    a.cuqs,
    a.amti,
    a.amth_1,
    a.invt_KW,
    c.stat_kw,
	a.txai
from LN_cisli310 a
left join LN_cisli305 c on c.idoc=a.idoc and c.[tran]=a.[tran] and c.compnr=a.compnr  and c.deleted='N'
left join LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='3100'  and b.deleted='N'
left join LN_tccom100 d on replace(d.bpid,' ','')=replace(c.itbp,' ','') and d.compnr='3100'   and d.deleted='N'
left join LN_tcmcs023 f on replace(f.citg,' ','')=replace(b.citg,' ','') and d.compnr='3100'  and f.deleted='N'
where  a.compnr in  (3110)  and a.deleted='N' and c.stat='80'
and  convert(date,(convert(datetime,c.idat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time') between '20241101' and '20251031'


) a 

group by year(idat),month(idat),ItemCode,Item_desc

GO

