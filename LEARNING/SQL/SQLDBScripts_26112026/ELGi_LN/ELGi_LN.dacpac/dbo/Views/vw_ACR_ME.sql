
CREATE VIEW [dbo].[vw_ACR_ME] as 
select * from (
select *,case when delays between 0 and 30 then balance else 0 end del_00_30,
case when delays between 31 and 60 then balance else 0 end del_31_60,
case when delays between 61 and 90 then balance else 0 end del_61_90,
case when delays between 91 and 120 then balance else 0 end del_91_120,
case when delays between 121 and 180 then balance else 0 end del_121_180,
case when delays > 180 then balance else 0 end del_gt_180,case when custno = 'E00625' and trantyp = 'CDJ' then 1 else 0 end as filt_typ
from (
select company,trantyp,invno,custno,invamntinhomecur as inv_value ,
(recamnthomecur+curdiffamnt) as coll_value,
balamnthomecur as balance,
docdt,duedt,
datediff(dd,docdt,getdate()) as delays,productgrp,area 
from (
select * from ACR 
where company  not in (101,712)  
and area in (select areacode from vw_AREA_MASTER where region = 'Middle East & West Asia       ') 
and productgrp not in (select dpstcode from vw_DPST_MASTER where division  in ('ats'))
)a
)ar_me
)ar_me 
where filt_typ <> 1
--order by custno

GO

