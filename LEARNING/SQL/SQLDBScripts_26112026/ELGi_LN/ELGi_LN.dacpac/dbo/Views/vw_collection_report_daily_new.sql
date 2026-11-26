CREATE VIEW [dbo].[vw_collection_report_daily_new] as 
select * from

(

select b.company,b.trantyp,b.invno,b.custno,custname1,b.docdt,-1 *(b.amnthome) as collection,
dpstcode,dpstname,c.description,ltrim(rtrim(a.area)) as areacode, areaname,zone,
region,global,b.anptrantyp,anpdocno,b.cdocno,b.ctrantyp,b.doctyp,0 as refr
from
(
select a.company,a.trantyp,a.invno,a.[lineno],a.custno,a.docdt,
case when len(ltrim(rtrim(a.area)))=  2 then '0' + ltrim(rtrim(a.area)) else a.area end as area,
a.purno,a.duedt,a.currate,
b.AreaCode as area_head,
b.DPST
from Collection_stage2 a (nolock) 
left outer join CI_Header b on
b.company = a.company and
b.ordernum = a.purno and
b.custcode = a.custno

where cdocno = 0 and a.company in (select company from ELGI_Companies_Master where CompanyGroup='ELGi')
group by  a.company,a.trantyp,a.invno,a.[lineno],a.custno,
a.docdt,a.area,a.purno,a.duedt,a.currate,b.AreaCode,b.dpst,proj
)a

inner join
(
select company,trantyp,invno,custno,docdt,sum(amnthome)  as amnthome, anptrantyp,
max(anpdocno) as anpdocno,max(cdocno) as cdocno,max(ctrantyp) as ctrantyp,2 as doctyp,[lineno] 
from Collection_stage2 (nolock)  
where docdt >= dateadd(mm,-2,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))
and company in (select company from ELGI_Companies_Master where CompanyGroup='ELGi')
-- and ctrantyp not like '%B28%' and ctrantyp not like '%B23%' and ctrantyp not like '%B45%' 
and doctyp in (2,8)
group by company,trantyp,invno,custno,docdt,anptrantyp,[lineno] 
--having sum(amnthome) <= 0  

--union

--select  company,trantyp,invno,custno,docdt,sum(amnthome)  as amnthome, anptrantyp,
--max(anpdocno) as anpdocno,max(cdocno) as cdocno,max(ctrantyp) as ctrantyp,2 as doctyp ,[lineno] 
--from Collection_stage2 (nolock)  
--where docdt >= dateadd(mm,-2,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))  
--and company  in (select company from ELGI_Companies_Master where CompanyGroup='ELGi')
--and trantyp like '%R28%' and ctrantyp like '%B28%'  
--and doctyp in (2,8)
--group by company,trantyp,invno,custno,docdt,anptrantyp,[lineno] 
--having sum(amnthome) <= 0 
) b
on b.company = a.company and
b.invno = a.invno and
b.custno = a.custno and
b.trantyp = a.trantyp and
b.[lineno] = a.[lineno] 


left outer join vw_dpst_master c   on ltrim(rtrim(c.dpstcode)) = ltrim(rtrim(dpst))
left outer join vw_area_master d   on ltrim(rtrim(d.areacode)) = ltrim(rtrim(a.area))
inner join (select distinct t_bpid as custcode,t_nama as custname1 from TTCCOM100400 ) e  on e.custcode  = a.custno


where 

b.trantyp not like '%ccj%' 
and b.trantyp not like '%ccn%' 
and b.trantyp not like '%cdj%' 
and ltrim(rtrim(b.trantyp)) not between '251' and  '264'
and ltrim(rtrim(b.trantyp)) not between '351' and '364'
and ltrim(rtrim(b.trantyp)) not between '451' and '464'
and ltrim(rtrim(b.trantyp)) not between '551' and '564'
and ltrim(rtrim(b.trantyp)) not between '651' and '664'
and ltrim(rtrim(b.trantyp)) not between '751' and '764'
and ltrim(rtrim(b.trantyp)) not between '2A1' and '2C6'
and ltrim(rtrim(b.trantyp)) not between '3A1' and '3C6'
and ltrim(rtrim(b.trantyp)) not between '4A1' and '4C6'
and ltrim(rtrim(b.trantyp)) not between '5A1' and '5C6'
and ltrim(rtrim(b.trantyp)) not between '7A1' and '7C6'
and ltrim(rtrim(b.trantyp)) not between '8A1' and '8C6'
and ltrim(rtrim(b.trantyp)) not between '9A1' and '9C6'
and ltrim(rtrim(b.trantyp)) not like 'F%' 
and ltrim(rtrim(b.trantyp)) not in ('BCC','CBD')
and ltrim(rtrim(b.trantyp)) not in ('271','272','371','372','471','472','571','572','671','672','771','772','871','872','971','972','A52')
)test
where docdt >= '03/01/2009' 
--and dpstcode not in (90003,90004) 
--and collection >= 0
and collection not between -1 and 1




--union all





--select company,trantyp,invno,custno,custname1,docdt,collection,dpst,c.dpstname,c.description,areacode, areaname,zone,region,global,anptrantyp,anpdocno,cdocno,ctrantyp,doctyp,refr
-- from (
--select * from
--(
--select b.company,b.trantyp,b.invno,b.custno,custname1,b.docdt,-1 *(b.amnthome) as collection,dpstcode,
--dpstname,c.description,ltrim(rtrim(a.area)) as areacode, areaname,zone,region,global,b.anptrantyp,anpdocno,
--b.cdocno,b.ctrantyp,b.doctyp,0 as refr
--from
--(select a.company,a.trantyp,a.invno,a.[lineno],a.custno,a.docdt,
--case when len(ltrim(rtrim(a.area)))=  2 then '0' + ltrim(rtrim(a.area)) else a.area end as area,
--a.purno,a.duedt,a.currate,b.AreaCode as area_head,
--b.DPST

--from Collection_Stage2 a
--left outer join CI_Header b on
--b.company = a.company and
--b.ordernum = a.purno and
--b.custcode = a.custno
--where cdocno = 0 and a.company in (select company from ELGI_Companies_Master where CompanyGroup='ELGi')
--and custno in ('E00622','E00625','E00701')
--group by  a.company,a.trantyp,a.invno,a.[lineno],a.custno,
--a.docdt,a.area,a.purno,a.duedt,a.currate,b.AreaCode,b.dpst,proj
--)a
--inner join
--(
--select  company,trantyp,invno,custno,docdt,sum(amnthome)  as amnthome, anptrantyp,max(anpdocno) as anpdocno,
--max(cdocno) as cdocno,max(ctrantyp) as ctrantyp,2 as doctyp,[lineno] 
--from Collection_Stage2 (nolock)  
--where docdt >= dateadd(mm,-2,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))
--and company  in (select company from ELGI_Companies_Master where CompanyGroup='ELGi')
---- and ctrantyp not like '%B28%' and ctrantyp not like '%B23%' and ctrantyp not like '%B45%' 
--and doctyp in (2,8) and custno in ('E00622','E00625','E00701')
--group by company,trantyp,invno,custno,docdt,anptrantyp,[lineno] 
----having sum(amnthome) <= 0 

----union

----select  company,trantyp,invno,custno,docdt,sum(amnthome)  as amnthome, anptrantyp,
----max(anpdocno) as anpdocno,max(cdocno) as cdocno,max(ctrantyp) as ctrantyp,2 as doctyp ,[lineno] 
----from Collection_Stage2
----where docdt >= dateadd(mm,-2,convert(varchar,datepart(mm,getdate())) + '/01/' + datename(yy,getdate()))  
----and company  in (select company from ELGI_Companies_Master where CompanyGroup='ELGi')
------and trantyp like '%R28%' and ctrantyp like '%B28%'  
----and doctyp in (2,8)
----and custno in ('E00622','E00625','E00701')
----group by company,trantyp,invno,custno,docdt,anptrantyp,[lineno] 
------having sum(amnthome) <= 0 
--) b
--on b.company = a.company and
--b.invno = a.invno and
--b.custno = a.custno and
--b.trantyp = a.trantyp and
--b.[lineno] = a.[lineno] 

--left outer join vw_dpst_master c (nolock)  on ltrim(rtrim(c.dpstcode)) = ltrim(rtrim(dpst))
--left outer join vw_area_master d  (nolock)  on ltrim(rtrim(d.areacode)) = ltrim(rtrim(a.area))
--inner join (select distinct t_bpid as custcode,t_nama as custname1 from TTCCOM100400 ) e  on e.custcode  = a.custno
--where dpstcode is null and 
--b.trantyp not like '%ccj%' and b.trantyp not like '%ccn%' and b.trantyp not like '%cdj%' and
--ltrim(rtrim(b.trantyp)) not between '251' and  '264'
--and ltrim(rtrim(b.trantyp)) not between '351' and '364'
--and ltrim(rtrim(b.trantyp)) not between '451' and '464'
--and ltrim(rtrim(b.trantyp)) not between '551' and '564'
--and ltrim(rtrim(b.trantyp)) not between '651' and '664'
--and ltrim(rtrim(b.trantyp)) not between '751' and '764'
--and ltrim(rtrim(b.trantyp)) not between '2A1' and '2C6'
--and ltrim(rtrim(b.trantyp)) not between '3A1' and '3C6'
--and ltrim(rtrim(b.trantyp)) not between '4A1' and '4C6'
--and ltrim(rtrim(b.trantyp)) not between '5A1' and '5C6'
--and ltrim(rtrim(b.trantyp)) not between '7A1' and '7C6'
--and ltrim(rtrim(b.trantyp)) not between '8A1' and '8C6'
--and ltrim(rtrim(b.trantyp)) not between '9A1' and '9C6'
--and ltrim(rtrim(b.trantyp)) not like 'F%' 
--and ltrim(rtrim(b.trantyp)) not in ('BCC','CBD')
--and ltrim(rtrim(b.trantyp)) not in ('271','272','371','372','471','472','571','572','671','672','771','772','871','872','971','972','A52'))test
--where docdt >= '03/01/2009' 
----and dpstcode not in (90003,90004) 
--and collection >= 0)a
--inner join 
--(select custcode,trantype,Invoice as invoicenum,max(dpst) as dpst from LN_sales_details_ver2 (nolock)
--where custcode in ('E00622','E00625','E00701')
--group by custcode,trantype,Invoice) b
--on a.custno = b.custcode and a.trantyp= b.trantype and a.invno = b.invoicenum
--left outer join vw_DPST_MASTER c (nolock)  on ltrim(rtrim(c.dpstcode)) = ltrim(rtrim(b.dpst))

GO

