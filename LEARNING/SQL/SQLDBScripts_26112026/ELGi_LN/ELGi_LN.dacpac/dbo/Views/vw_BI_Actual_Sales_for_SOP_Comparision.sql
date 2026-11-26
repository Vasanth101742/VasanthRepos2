

CREATE view vw_BI_Actual_Sales_for_SOP_Comparision as

select organ,MonthEndDate,item,Item_desc,
sum(DeliveryQty) DeliveryQty,
sum(ProdQty) ProdQty,
sum(sales_amount) sales_amount
,dpst,dpstname
from(
select 'Channel' as organ,
--invoice_date as EntryDate,
eomonth(invoice_date,0) as MonthEndDate,
ltrim(rtrim(item)) item,Item_desc,DeliveryQty,0 as ProdQty,
sales_amount,dpst,dpstname
from [ELGi_LN].dbo.elgi_sales_details 
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
and invoice_date<=(select eomonth(getdate()-1,-1))
and company ='401'
and sales_category not in (1)
and deliveryQty>0 
and Organ not in ('Subsidiary') 
and dpst in ('90072','90000','90014','90010','90020','90016','90074')

union all

select 'Direct' as organ,
--invoice_date as EntryDate,
eomonth(invoice_date,0) as MonthEndDate,
ltrim(rtrim(item)) item,Item_desc,DeliveryQty,0 as ProdQty,
sales_amount,dpst,dpstname
from [ELGi_LN].dbo.elgi_sales_details 
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
and invoice_date<=(select eomonth(getdate()-1,-1))
and company ='401'
and sales_category not in (1)
and deliveryQty>0 
and Organ not in ('Subsidiary') 
and dpst in ('90009','90032','90030','90094','90023','90022','90093','90008')

union all

select 'C&M' as organ,
--invoice_date as EntryDate,
eomonth(invoice_date,0) as MonthEndDate,
ltrim(rtrim(item)) item,Item_desc,DeliveryQty,0 as ProdQty,
sales_amount,dpst,dpstname
from [ELGi_LN].dbo.elgi_sales_details 
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
and invoice_date<=(select eomonth(getdate()-1,-1))
and company ='401'
and sales_category not in (1)
and deliveryQty>0 
and Organ not in ('Subsidiary') 
and dpst in ('90033','90037','90036')

union all

select 'WW' as organ,
--invoice_date as EntryDate,
eomonth(invoice_date,0) as MonthEndDate,
ltrim(rtrim(item)) item,Item_desc,DeliveryQty,0 as ProdQty,
sales_amount,dpst,dpstname
from [ELGi_LN].dbo.elgi_sales_details 
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
and invoice_date<=(select eomonth(getdate()-1,-1))
and company ='401'
and sales_category not in (1)
and deliveryQty>0 
and Organ not in ('Subsidiary') 
and dpst in ('90021','90035')

union all

select 'Railway Units' as organ,
--invoice_date as EntryDate,
eomonth(invoice_date,0) as MonthEndDate,
ltrim(rtrim(item)) item,Item_desc,DeliveryQty,0 as ProdQty,
sales_amount,dpst,dpstname
from [ELGi_LN].dbo.elgi_sales_details 
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
and invoice_date<=(select eomonth(getdate()-1,-1))
and company ='401'
and sales_category not in (1)
and deliveryQty>0 
and Organ not in ('Subsidiary') 
and dpst in ('90002','90091')

union all

select 'Railways Wiper' as organ,
--invoice_date as EntryDate,
eomonth(invoice_date,0) as MonthEndDate,
ltrim(rtrim(item)) item,Item_desc,DeliveryQty,0 as ProdQty,
sales_amount,dpst,dpstname
from [ELGi_LN].dbo.elgi_sales_details 
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
and invoice_date<=(select eomonth(getdate()-1,-1))
and company ='401'
and sales_category not in (1)
and deliveryQty>0 
and Organ not in ('Subsidiary') 
and dpst in ('90095')


union all

select 'HO-AFM-Railway' as organ,
--invoice_date as EntryDate,
eomonth(invoice_date,0) as MonthEndDate,
ltrim(rtrim(item)) item,Item_desc,DeliveryQty,0 as ProdQty,
sales_amount,dpst,dpstname
from [ELGi_LN].dbo.elgi_sales_details 
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
and invoice_date<=(select eomonth(getdate()-1,-1))
and company ='401'
and sales_category not in (1)
and deliveryQty>0 
and Organ not in ('Subsidiary') 
and dpst in ('90092','90073')

union all

select 'GSC-AFM-Railway' as organ,
--invoice_date as EntryDate,
eomonth(invoice_date,0) as MonthEndDate,
ltrim(rtrim(item)) item,Item_desc,DeliveryQty,0 as ProdQty,
sales_amount,dpst,dpstname
from [ELGi_LN].dbo.elgi_sales_details 
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
and invoice_date<=(select eomonth(getdate()-1,-1))
and company ='490'
and sales_category not in (1)
and deliveryQty>0 
and Organ not in ('Subsidiary') 
and dpst in ('90092','90073')

union all

select 'ACP-AFM-Railway' as organ,
--invoice_date as EntryDate,
eomonth(invoice_date,0) as MonthEndDate,
ltrim(rtrim(item)) item,Item_desc,DeliveryQty,0 as ProdQty,
sales_amount,dpst,dpstname
from [ELGi_LN].dbo.elgi_sales_details 
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
and invoice_date<=(select eomonth(getdate()-1,-1))
and company ='450'
and sales_category not in (1)
and deliveryQty>0 
and Organ not in ('Subsidiary') 
and dpst in ('90092','90073')

union all

select 'HO-AFM-Industrial' as organ,
--invoice_date as EntryDate,
eomonth(invoice_date,0) as MonthEndDate,
ltrim(rtrim(item)) item,Item_desc,DeliveryQty,0 as ProdQty,
sales_amount,dpst,dpstname
from [ELGi_LN].dbo.elgi_sales_details 
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
and invoice_date<=(select eomonth(getdate()-1,-1))
and company ='401'
and sales_category not in (1)
and deliveryQty>0 
and Organ not in ('Subsidiary') 
and dpst in ('90084','90083','90063','90079','90038','90028',
'90031','90085','90025','90082','90026','90075','90013',
'90029','90256','90015','90034')


union all

select 'GSC-AFM-Industrial' as organ,
--invoice_date as EntryDate,
eomonth(invoice_date,0) as MonthEndDate,
ltrim(rtrim(item)) item,Item_desc,DeliveryQty,0 as ProdQty,
sales_amount,dpst,dpstname
from [ELGi_LN].dbo.elgi_sales_details 
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
and invoice_date<=(select eomonth(getdate()-1,-1))
and company ='490'
and sales_category not in (1)
and deliveryQty>0 
and Organ not in ('Subsidiary') 
and dpst in ('90084','90083','90063','90079','90038','90028',
'90031','90085','90025','90082','90026','90075','90013',
'90029','90256','90015','90034')

union all

select 'ACP-AFM-Industrial' as organ,
--invoice_date as EntryDate,
eomonth(invoice_date,0) as MonthEndDate,
ltrim(rtrim(item)) item,Item_desc,DeliveryQty,0 as ProdQty,
sales_amount,dpst,dpstname
from [ELGi_LN].dbo.elgi_sales_details 
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
and invoice_date<=(select eomonth(getdate()-1,-1))
and company ='450'
and sales_category not in (1)
and deliveryQty>0 
and Organ not in ('Subsidiary') 
and dpst in ('90084','90083','90063','90079','90038','90028',
'90031','90085','90025','90082','90026','90075','90013',
'90029','90256','90015','90034')

union all

select 'HO-AFM-Portables' as organ,
--invoice_date as EntryDate,
eomonth(invoice_date,0) as MonthEndDate,
ltrim(rtrim(item)) item,Item_desc,DeliveryQty,0 as ProdQty,
sales_amount,dpst,dpstname
from [ELGi_LN].dbo.elgi_sales_details 
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
and invoice_date<=(select eomonth(getdate()-1,-1))
and company ='401'
and sales_category not in (1)
and deliveryQty>0 
and Organ not in ('Subsidiary') 
and dpst in ('90078','90077','90076','90302','90039')


union all

select 'GSC-AFM-Portables' as organ,
--invoice_date as EntryDate,
eomonth(invoice_date,0) as MonthEndDate,
ltrim(rtrim(item)) item,Item_desc,DeliveryQty,0 as ProdQty,
sales_amount,dpst,dpstname
from [ELGi_LN].dbo.elgi_sales_details 
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
and invoice_date<=(select eomonth(getdate()-1,-1))
and company ='490'
and sales_category not in (1)
and deliveryQty>0 
and Organ not in ('Subsidiary') 
and dpst in ('90078','90077','90076','90302','90039')

union all

select 'ACP-AFM-Portables' as organ,
--invoice_date as EntryDate,
eomonth(invoice_date,0) as MonthEndDate,
ltrim(rtrim(item)) item,Item_desc,DeliveryQty,0 as ProdQty,
sales_amount,dpst,dpstname
from [ELGi_LN].dbo.elgi_sales_details 
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
and invoice_date<=(select eomonth(getdate()-1,-1))
and company ='450'
and sales_category not in (1)
and deliveryQty>0 
and Organ not in ('Subsidiary') 
and dpst in ('90078','90077','90076','90302','90039')

union all

select 'South Asia' as organ,
--invoice_date as EntryDate,
eomonth(invoice_date,0) as MonthEndDate,
ltrim(rtrim(item)) item,Item_desc,DeliveryQty,0 as ProdQty,
sales_amount,'NA' as dpst,'NA' as dpstname
from [ELGi_LN].dbo.elgi_sales_details 
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
and invoice_date<=(select eomonth(getdate()-1,-1))
and company like '4%'
and sales_category not in (1)
and deliveryQty>0 
and Organ not in ('Subsidiary') 
and user_names in ('SA-Units', 'SA-Spares')

--union all

--select 'Africa' as organ,
----invoice_date as EntryDate,
--eomonth(invoice_date,0) as MonthEndDate,
--ltrim(rtrim(item)) item,Item_desc,DeliveryQty,0 as ProdQty,
--sales_amount,'NA' as dpst,'NA' as dpstname
--from [ELGi_LN].dbo.elgi_sales_details 
--where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
--and invoice_date<=(select eomonth(getdate()-1,-1))
----and company like '4%'
--and sales_category not in (1)
--and deliveryQty>0 
--and Organ not in ('Subsidiary') 
--and user_names in ('Africa-Units', 'Africa-Spares')

union all

select 'Africa' as organ,
--invoice_date as EntryDate,
eomonth(invoice_date,0) as MonthEndDate,
ltrim(rtrim(item)) item,Item_desc,DeliveryQty,0 as ProdQty,
sales_amount,'NA' as dpst,'NA' as dpstname
from [ELGi_LN].dbo.elgi_sales_details 
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
and invoice_date<=(select eomonth(getdate()-1,-1))
and company = '500'
and areacode in ('679','690','691','692','693','694','698')
and sales_category not in (1)
and deliveryQty>0 


--union all

--select 'ME' as organ,
----invoice_date as EntryDate,
--eomonth(invoice_date,0) as MonthEndDate,
--ltrim(rtrim(item)) item,Item_desc,DeliveryQty,0 as ProdQty,
--sales_amount,'NA' as dpst,'NA' as dpstname
--from [ELGi_LN].dbo.elgi_sales_details 
--where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
--and invoice_date<=(select eomonth(getdate()-1,-1))
--and company like '4%'
--and sales_category not in (1)
--and deliveryQty>0 
--and Organ not in ('Subsidiary') 
--and user_names in ('ME-Units', 'ME-Spares')

union all

select 'ME' as organ,
--invoice_date as EntryDate,
eomonth(invoice_date,0) as MonthEndDate,
ltrim(rtrim(item)) item,Item_desc,DeliveryQty,0 as ProdQty,
sales_amount,'NA' as dpst,'NA' as dpstname
from [ELGi_LN].dbo.elgi_sales_details 
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
and invoice_date<=(select eomonth(getdate()-1,-1))
and company = '500'
and areacode in ('671','672','674','675','676','677','683','684')
and sales_category not in (1)
and deliveryQty>0 


union all

select 'ID' as organ,
--invoice_date as EntryDate,
eomonth(invoice_date,0) as MonthEndDate,
ltrim(rtrim(item)) item,Item_desc,DeliveryQty,0 as ProdQty,
sales_amount,'NA' as dpst,'NA' as dpstname
from [ELGi_LN].dbo.elgi_sales_details 
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
and invoice_date<=(select eomonth(getdate()-1,-1))
and company like '4%'
and sales_category not in (1)
and deliveryQty>0 
and Organ ='ID'
--and user_names in ('ME-Units', 'ME-Spares')

union all

select case when Company=551 then 'Australia'
when Company=552 then 'Indonesia'
when Company=553 then 'Malaysia'
end as organ,
--invoice_date as EntryDate,
eomonth(invoice_date,0) as MonthEndDate,
ltrim(rtrim(item)) item,Item_desc,DeliveryQty,0 as ProdQty,
sales_amount,'NA' as dpst,'NA' as dpstname
from [ELGi_LN].dbo.elgi_sales_details 
where invoice_date>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
and invoice_date<=(select eomonth(getdate()-1,-1))
and company in ('551','552','553')
and sales_category not in (1)
and deliveryQty>0 
and Organ not in ('Subsidiary') 


)a
group by organ,MonthEndDate,item,Item_desc,dpst,dpstname


union all

--USA

select Organ,MonthEndDate,ItemCode,dsca,
sum(dqua) dqua,null,sum(amth_1) amth_1,'NA','NA'
from (
select 'USA' as Organ,eomonth(idat,0) as MonthEndDate,
ItemCode,dsca,dqua,amth_1 
from(
--Source : Power BI Report : USA Sales & Inflow ; Dataset: Query1
select distinct 
    a.line,    case 
        when a.compnr = 3100 then 'ELGI NA'
        when a.compnr = 3110 then 'Industrial'
        when a.compnr = 3120 then 'Portables'
        when a.compnr = 3130 then 'Pattons Medical'
        when a.compnr = 3140 then 'Pattons INC'
        when a.compnr = 3150 then 'Michigan'
    end as CompDivision,c.idat2,
    (convert(datetime,c.idat2) AT TIME ZONE 'India Standard Time') AT TIME ZONE 'Eastern Standard Time' as idat,
    a.[tran],
    a.idoc,
    replace(a.item, ' ', '') as ItemCode,
    b.dsca,
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
from [ELGI_US].dbo.LN_cisli310 a
left join [ELGI_US].dbo.LN_cisli305 c on c.idoc=a.idoc and c.[tran]=a.[tran] and c.compnr=a.compnr  and c.deleted='N'
left join [ELGI_US].dbo.LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='3100'  and b.deleted='N'
left join [ELGI_US].dbo.LN_tccom100 d on replace(d.bpid,' ','')=replace(c.itbp,' ','') and d.compnr='3100'   and d.deleted='N'
left join [ELGI_US].dbo.LN_tcmcs023 f on replace(f.citg,' ','')=replace(b.citg,' ','') and d.compnr='3100'  and f.deleted='N'
where  a.compnr in  (3100,3110,3120,3130,3140,3150)  and a.deleted='N' and c.stat='80'
--End : Source : Power BI Report : USA Sales & Inflow ; Dataset: Query1
and a.compnr='3110'
)a
)b
where MonthEndDate>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
and MonthEndDate<=(select eomonth(getdate()-1,-1))
group by Organ,MonthEndDate,ItemCode,dsca

union all

--Europe

select Organ,MonthEndDate,ItemCode,dsca,
sum(dqua) dqua,null,sum(amth_1) amth_1,'NA','NA'
from (
select 'Europe' as Organ,compnr,idat,idat2,eomonth(idat,0) as MonthEndDate,
ItemCode,dsca,dqua,amth_1 
from (
--Europe Sales & Inflow Query ; Dataset: Query1
select distinct c.stat_kw,c.fyer'FYear',c.fper'Fmonth',a.line,case when a.compnr=1100 then'Rotair'
 when a.compnr=1700 then'Elgi Europe' end "compnr",dateadd(MINUTE ,-29,dateadd(hour,-3,c.idat2)) as idat,
 idat2,
 a.[tran],a.idoc,replace(a.item,' ','')"ItemCode",b.dsca,a.orno,
 dateadd(MINUTE ,-29,dateadd(hour,-3,a.odat2)) as odat
 ,replace(c.itbp,' ','')"CusCode",isnull(d.nama,'NA')"BPName",f.dsca as "ProductLine"
,a.pono,a.dqua,a.cuqs,cast(a.amti as decimal(19,2))"amti",a.amth_1,replace(a.invt_KW,'tcinvt.','')invt_KW
,a.slah_1"Home Currency",a.ldah_1"HomeDisc",cast(a.amth_1 as decimal(19,2)) "HomeNet",a.leac
from [ELGI_US].dbo.LN_cisli310 a
left join [ELGI_US].dbo.LN_cisli305 c on c.idoc=a.idoc and c.[tran]=a.[tran] and c.compnr=a.compnr
left join [ELGI_US].dbo.LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='1100'
left join [ELGI_US].dbo.LN_tccom100 d on replace(d.bpid,' ','')=replace(c.itbp,' ','') and d.compnr='1100' 
left join [ELGI_US].dbo.LN_tcmcs023 f on replace(f.citg,' ','')=replace(b.citg,' ','') and d.compnr='1100' 
where  a.compnr in  (1100,1700)  and c.stat_kw='tcsli.stat.posted'
--End : Europe Sales & Inflow Query ; Dataset: Query1
and a.koor<>61
and a.srtp not in ('70','120','43','64')
)a
--where ItemCode='00897902N'
--and eomonth(idat,0)='2024-05-31'
)b
where MonthEndDate>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
and MonthEndDate<=(select eomonth(getdate()-1,-1))
--and ItemCode='00897902N'
--and Item='B005700730003'
--and MonthEndDate='2024-05-31'
group by Organ,MonthEndDate,ItemCode,dsca

union all


select Organ,MonthEndDate,ItemCode,dsca,
sum(dqua) dqua,null,sum(amth_1) amth_1,'NA','NA'
from (
select 'Brazil' as Organ,
eomonth(idat,0) as MonthEndDate,
--idat  as MonthEndDate,
ItemCode,dsca,dqua,amth_1 
from (
select a.compnr,c.idat2,
dateadd(MINUTE ,-29,dateadd(hour,-8,c.idat2)) as idat,
a.[tran],a.idoc,
replace(a.item,' ','')"ItemCode",b.dsca,a.orno,dateadd(MINUTE ,-29,dateadd(hour,-9,a.odat)) as odat
,replace(c.itbp,' ','')"CusCode",isnull(d.nama,'NA')"BPName",f.dsca as "ProductLine"
,a.pono,a.dqua,a.cuqs,a.amti,a.amth_1,a.invt_KW from [ELGI_US].dbo.LN_cisli310 a
left join [ELGI_US].dbo.LN_cisli305 c on c.idoc=a.idoc and c.[tran]=a.[tran] and c.compnr=a.compnr  and c.deleted='N'
left join [ELGI_US].dbo.LN_tcibd001 b on replace(b.item, ' ','')=replace(a.item,' ','') and b.compnr='2000'  and b.deleted='N'
left join [ELGI_US].dbo.LN_tccom100 d on replace(d.bpid,' ','')=replace(c.itbp,' ','') and d.compnr='2000'   and d.deleted='N'
left join [ELGI_US].dbo.LN_tcmcs023 f on replace(f.citg,' ','')=replace(b.citg,' ','') and d.compnr='2000'   and f.deleted='N'
where  a.compnr =2000  and a.deleted='N'
--and replace(a.item,' ','')='B005700730003'
--order by c.idat2
)a
)b
where MonthEndDate>=(select dateadd(dd,1,eomonth(getdate()-1,-25))) 
and MonthEndDate<=(select eomonth(getdate()-1,-1))
--and ItemCode='B005700730003'
--and year(MonthEndDate)='2025'
--and month(MonthEndDate) in ('1','2')
--='2025-02-28'
group by Organ,MonthEndDate,ItemCode,dsca

GO

